
library(shiny)
library(leaflet)
library(ggplot2)
library(dplyr)
library(geosphere)
library(sf)
library(tidyr)
library(shinydashboard)
library(shinythemes)



# Load the data
facilities <- read.csv("data/facilities_mod.csv")
business <- read.csv("data/Business_License_Final.csv")


business$year <- as.character(business$year)
business$zip_code <- as.character(business$zip_code)

# Define colors for facility types
facility_colors <- colorFactor(c("#564787", "#9A031E", "#FF6666", "#E36414", "#3943B7"), 
                               domain = facilities$category)


# Generate a color for business categories
category_colors <- colorFactor(c("Arborist" = "#5F7367", "Automotive Repair" = "#FBBA72", "Charitable Solicitation" = "#CA5310",
                                 "Food Vending Machine" = "#BB4D00", "Hotel and Motel" = "#8F250C", "Laundry" = "#691E06", "Massage" = "#691E06",
                                 "Mobile Food Vendor" = "#DDDBF1", "Open Air Business" = "#3C4F76", "Pool Hall" = "#D1BEB0", "Precious Metal Dealer" = "#AB9F9D",
                                 "Public Parking Facility" = "#DBF9F4", "Restaurant" = "#B07BAC", "Rubbish/Garbage Removal" = "#BDFFFD",
                                 "Scrap Metal Dealer" = "#6ABEA7", "Secondhand Store" = "#E9B872", "Solicitor" = "#6494AA", "Tattoo and Piercing" = "#F4A698",
                                 "Taxi Service" = "#AA4465", "Towing and Recovery" = "#DEFFF2", "Alarm Agent" = "#BB6B00"
), domain = business$category)


# Creat a function to calculate distance between pairs of selected business and facility points
haversine <- function(lat1, lon1, lat2, lon2) {
  R <- 6371 # Earth's radius in kilometers
  delta_lat <- (lat2 - lat1) * pi / 180
  delta_lon <- (lon2 - lon1) * pi / 180
  a <- sin(delta_lat / 2)^2 + cos(lat1 * pi / 180) * cos(lat2 * pi / 180) * sin(delta_lon / 2)^2
  c <- 2 * atan2(sqrt(a), sqrt(1 - a))
  d <- R * c
  return(d)
}


ui <- navbarPage(theme = shinytheme("cerulean"),
                 title = "Welcome to the South Bend Civic Data Dashboard",
                 
                 # Create navigation tabs for different sections
                 tabPanel("Introduction", 
                          h3("Exploring South Bend for Smarter Decision-Making"),
                          img(src = "southbend.png", width = '100%', height = '800px'),
                          br(),
                          h1("Meet the Designer"),
                          h4("Cristian Thirteen"),
                          fluidRow(
                            column(width = 6, 
                                   h4("Purpose:"),
                                   tags$ul(
                                     tags$li("To provide the Mayor of South Bend with an interactive tool to explore and understand how various civic datasets interact, offering clear and actionable insights across city domains such as business-community facility relationships. The goal is to support decision-making on resource allocation, urban planning, and community development."),
                                     tags$li("Images courtesy of South Bend Chamber of Commerce, Tripadvisor, Indiana Destination, South Bend Heritage Foundation, and Jack Gardner. All rights reserved."),
                                   )
                            ),
                            column(width = 6, 
                                   h4("Data Sources:"),
                                   tags$ul(
                                     tags$li("Business licenses"),
                                     tags$li("Public facilities"),
                                     tags$li("Churches included through manual data curation")
                                   )
                            ))
                          ),
                          
                 tabPanel("Business and Facility Proximity", 
                          h3("Business and Facility Proximity Dashboard"),
                          
                          # How to Use This Dashboard
                          fluidRow(
                            column(
                              width = 12,
                              h4("How to Use This Dashboard"),
                              p("Filters: You can filter data by year, business category, and facility type. Choose the criteria you are interested in from the dropdown menus on the left side of the dashboard. Multiple categories can be selected. The business categories are derived from the types of licenses companies or individuals applied for, ensuring the filters reflect the specific licensing information associated with each business."),
                              br(),
                              p("Map: The map will automatically update based on your selected filters, displaying business and facility locations. Hover over the markers for additional information, such as business names, facility names, and addresses."),
                              br(),
                              p("Popups and Labels: When you click on a marker on the map, a popup will appear displaying detailed information about the selected business or facility, such as its name, type, address, and other relevant details."),
                              br(),
                              p("Nearest Facility Table: Once you've selected your filters, the table will show each business's nearest facilities. It will display the facility type, name, and the distance to the business (in miles)."),
                              br(),
                              p("Distribution Plot: A distribution plot will be displayed as you select various business categories. This plot visualizes the frequency of businesses in each selected category to show how businesses are distributed across the different categories.")
                            )
                          ),
                          
                          # Top section with filters and map
                          fluidRow(
                            # Filters on the left
                            column(
                              width = 4,  # 4 units for the filters
                              h3("Filters"),
                              selectizeInput(
                                "year_filter", 
                                "Select Year:",
                                choices = c("Select year" = "", unique(business$year)), 
                                selected = "",
                                multiple = FALSE,
                                options = list(placeholder = 'Select year')
                              ),
                              selectizeInput(
                                "category_filter", 
                                "Filter by Business Category:", 
                                choices = unique(business$category), 
                                selected = NULL,
                                multiple = TRUE, 
                                options = list(placeholder = 'Select categories', plugins = list('remove_button'))
                              ),
                              selectizeInput(
                                "facility_filter", 
                                "Filter by Facility Type:", 
                                choices = unique(facilities$category), 
                                selected = NULL,
                                multiple = TRUE, 
                                options = list(placeholder = 'Select categories', plugins = list('remove_button'))
                              )
                            ),
                            
                            # Map on the right
                            column(
                              width = 8,  # 8 units for the map
                              leafletOutput("mapCristian", height = "600px") 
                            )
                          ),
                          
                          # Bottom section with plots and table
                          fluidRow(
                            # Plots on the left
                            column(
                              width = 6,  # 8 units for the plots
                              h3("Business Categories by Count"),
                              plotOutput("dist_plot", height = "300px"),
                              plotOutput("business_plot", height = "300px")
                            ),
                            
                            # Table on the right
                            column(
                              width = 4,  # 4 units for the table
                              h3("Nearest Facility Table"),
                              tableOutput("nearest_table")
                            )
                          )
                 ),
                 
                 )



# Define server logic 
server <- function(input, output, session) {
  

  # Filter business data
  filtered_business <- reactive({
    req(input$year_filter, input$category_filter)
    business %>%
      filter(year == input$year_filter, category %in% input$category_filter) %>%
      group_by(name) %>%
      mutate(first_year = min(year)) %>%
      distinct(name, street_address, category, .keep_all = TRUE) %>%
      ungroup()
  })
  
  
  # Filter facility data
  filtered_facilities <- reactive({
    req(input$facility_filter)
    facilities %>%
      filter(category %in% input$facility_filter) %>% 
      # as.data.frame() %>% 
      distinct(facility_name, .keep_all = TRUE)
  })
  
  # Reactive expression for filtered businesses
  selected_businesses <- reactive({
    req(input$category_filter, input$year_filter) 
    business %>%
      filter(year == input$year_filter, category %in% input$category_filter) 
  })
  
  # Reactive expression for filtered facilities
  selected_facilities <- reactive({
    req(input$facility_filter)
    facilities %>%
      filter(category %in% input$facility_filter)
  })
  
  
  # Calculate and display nearest facility
  output$nearest_table <- renderTable({
    req(nrow(selected_businesses()) > 0, nrow(selected_facilities()) > 0)
    
    # Create spatial data frames for businesses and facilities
    businesses_sf <- st_as_sf(selected_businesses(), coords = c("lon", "lat"), crs = 4326)
    facilities_sf <- st_as_sf(selected_facilities(), coords = c("lon", "lat"), crs = 4326)
    
    # Calculate distances between businesses and facilities
    distances <- st_distance(businesses_sf, facilities_sf)
    
    # Create an empty data frame to store results
    results_df <- data.frame()
    
    # Loop over each business to find the closest facility
    for (i in 1:nrow(businesses_sf)) {
      dist_row <- distances[i, ]
      facility_categories <- selected_facilities()$category
      facility_names <- selected_facilities()$facility_name 
      
      # Loop through each unique category to find the closest facility
      for (category in unique(facility_categories)) {
        # Get indices for the facilities in this category
        category_indices <- which(facility_categories == category)
        
        # Find the closest facility within this category
        min_dist <- min(dist_row[category_indices], na.rm = TRUE)
        closest_facility_name <- facility_names[category_indices[which.min(dist_row[category_indices])]]
        
        # Store the result in the data frame
        new_row <- data.frame(
          Business = selected_businesses()$name[i],
          FacilityCategory = category,
          FacilityName = closest_facility_name,
          Distance = min_dist * 0.000621371  # Convert from meters to miles
        )
        
        results_df <- rbind(results_df, new_row)
      }
    }
    
    # Pivot the results wider to display the closest facility for each category
    # Combine Facility Name and Distance
    results_df <- results_df %>%
      mutate(Combined = paste(FacilityName, "(", round(Distance, 2),"", "mi)", sep = " ")) %>%
      select(Business, FacilityCategory, Combined) %>%
      distinct()
    results_df_wide <- results_df %>%
      pivot_wider(names_from = FacilityCategory, values_from = Combined, values_fn = list)
    
    # Unnest to avoid list-columns in the final result
    results_df_wide <- results_df_wide %>%
      unnest(cols = everything())
    
    
    # Return the wide table as the output
    results_df_wide
  })
  
  # Render a Leaflet map
  output$mapCristian <- renderLeaflet({
    leaflet() %>%
      setView(lng = -86.2520, lat = 41.6764, zoom = 12) %>%
      addTiles(urlTemplate = "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png")
  })
  
  # Observe and update map for business changes
  observeEvent(filtered_business(), {
    req(filtered_business())
    leafletProxy("mapCristian") %>%
      clearGroup("business") %>% 
      # Add business markers, labels, and popups
      addCircleMarkers(
        data = filtered_business(),
        ~lon, ~lat,
        radius = 3,
        color = ~category_colors(category),
        opacity = 2,
        label = ~name,  # Display the business info on hover
        popup = ~paste0(
          "<b>Name:</b> ", business_name, "<br>",
          "<b>Address:</b> ", street_address, "<br>",
          "<b>Business Category:</b> ", category, "<br>",
          "<b>Business License Active Since:</b> ", first_year
        ), 
        group = "business"
      )
  })
  
  # Observe and update map for facility changes
  observeEvent(filtered_facilities(), {
    req(filtered_facilities())
    
    # Create a popup column
    facilities_with_popup <- filtered_facilities() %>%
      dplyr::mutate(
        popup_content = ifelse(
          category == "Church" & !is.na(denomination) & nzchar(denomination),
          paste("<strong>", facility_name, "</strong><br>",
                "Address: ", address, "<br>",
                "Denomination: ", denomination),
          paste("<strong>", facility_name, "</strong><br>",
                "Address: ", address)
        )
      )
    
    # Update the map 
    leafletProxy("map") %>%
      clearGroup("facilities") %>%
      addCircleMarkers(
        data = facilities_with_popup, 
        ~lon, ~lat, 
        radius = 3, 
        color = ~facility_colors(category), 
        opacity = 1, 
        label = ~facility_name,
        popup = ~popup_content,
        group = "facilities" 
      )
  })
  
  # Handle cases when both filters are cleared, keeping the map empty
  observe({
    # Check if no business category is selected
    if (is.null(input$category_filter)) {
      leafletProxy("map") %>%
        clearGroup("business")  
    }
    
    # Check if no facility type is selected,  clear only facility markers
    if (is.null(input$facility_filter)) {
      leafletProxy("map") %>%
        clearGroup("facilities") 
    }
    
    # Clear all markers if both filters are empty
    if (is.null(input$category_filter) && is.null(input$facility_filter)) {
      leafletProxy("map") %>%
        clearMarkers() 
    }
  })
  
  # Distribution plot
  output$dist_plot <- renderPlot({
    ggplot(data = filtered_business(), aes(x = category)) +
      geom_bar(stat = "count", fill = "#2FA4E7") +
      coord_flip() +
      theme_minimal(base_family = "Arial", base_size = 14) + 
      labs(
        title = NULL, 
        x = NULL, 
        y = NULL  
      ) +
      theme(
        axis.title = element_text(size = 14), 
        axis.text = element_text(size = 12),  
        plot.title = element_text(size = 16, face = "bold", hjust = 0),  
        panel.grid.major = element_blank(),  
        panel.grid.minor = element_blank(),
        plot.margin = margin(t = 10, r = 30, b = 10, l = 50) 
      )
  })
  
  
 }
  

# Run the application 
shinyApp(ui = ui, server = server)



