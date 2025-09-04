# Alumni Network Map – Proof of Concept
This project is a proof-of-concept Shiny application designed to help University alumni locate fellow alumni near specific locations, such as conferences or events. The app displays alumni on an interactive map, allows searches by city and state, filters results based on a selected radius, and provides a detailed alumni table including distance, email, and phone information. The goal is to facilitate networking and engagement among alumni at events. [View Alumni Network Map](https://github.com/cthr13en/Data-Science-Projects/tree/main/Assessment)

## Key Features

- Interactive Map: Displays alumni locations with popups containing name, city, state, phone, and email.
- Search by City & State: Fuzzy matching helps find the closest city even if there are minor spelling variations.
- Distance Filtering: Allows filtering alumni within a selectable radius (10, 25, 50, 100 miles) of the search location.
- Alumni Table: Provides a sortable and searchable table of results including distance from the search location.
- Dynamic Notifications: Alerts users when searches yield no results or when a search is successfully completed.
- Scalable Data Collection: Integrates with Google Forms for opt-in alumni data collection, with potential for automated geocoding.

## R Packages Used
- `shiny`
- `bslib`
- `dplyr`
- `leaflet`
- `DT`
- `stringdist`



# Nonresident Doctorate Recipient Analysis
This project involves analyzing the trends in nonresident doctorate recipients at the University of Notre Dame compared to its peers in the Association of American Universities (AAU) private institutions. Using data from the Integrated Postsecondary Education Data System (IPEDS) from 2011–2013 and 2021–2023, this analysis focuses on the percentage of doctorates awarded to nonresident students, exploring growth patterns, institutional variations, and demographic distributions across different fields of study. The goal is to understand how Notre Dame has evolved in attracting international doctoral talent and how it compares to its peers within the AAU private research university cohort. [View ND Skills Assessment Analysis](https://github.com/cthr13en/Data-Science-Projects/tree/main/Assessment)

## R Packages Used
- `tidyverse`
- `ggplot2`
- `dplyr`
- `plotly`
- `janitor`
- `stringr`
- `viridis`


# Idaho Department of Education
This project involves analyzing the proficiency rates of Special Education students in Idaho, specifically focusing on the percentage of students scoring at or above Proficient on the Idaho Standards Achievement Test (ISAT). The goal is to examine proficiency trends over time (2014–2017) and identify key insights, including performance improvements, school-level variations, and potential data anomalies, such as outliers. The findings aim to support data-driven decisions and strategic planning for improving education outcomes. [View Idaho Department of Education Analysis](https://github.com/cthr13en/Data-Science-Projects/tree/main/Idaho%20Department%20of%20Education)

## R Packages Used
- `tidyverse`
- `ggplot2`
- `dplyr`
- `lubridate`
- `skimr`
- `tidyr`


# Civic Dashboard Project
This project involves designing an interactive dashboard using Shiny (R) to support the Mayor in understanding relationships within civic datasets. The dashboard visualizes key metrics and trends to provide actionable insights, enabling strategic planning and data-driven decision-making on critical city issues. [View Civic Dashboard Project](https://github.com/cthr13en/Data-Science-Projects/tree/main/Civic_Dashboard_Project). The finished visualization can be seen at https://cristianthirteen.shinyapps.io/Final_Cristian/

## R Packages Used
- `shiny`
- `leaflet`
- `ggplot2`
- `dplyr`
- `geosphere`
- `sf`
- `tidyr`
- `shinydashboard`
- `shinythemes`

# Customer Satisfaction Analysis
This project analyzes customer satisfaction survey data to gain insights into various aspects of the customer experience. The goal is to understand how customer satisfaction can be broken down into different attributes and how these attributes vary across demographic groups such as age, gender, and household income. [View Customer Satisfaction Analysis](https://github.com/cthr13en/Data-Science-Projects/tree/main/Customer%20Satisfaction%20Analysis)

## R Packages Used
- `tidyverse`
- `skimr`
- `lavaan`
- `sentimentr`
- `caret`
- `semPlot`
- `reshape2`

# Customer Survey Analysis
Customer Survey Analysis contains the code and data for analyzing customer satisfaction survey responses. The analysis aims to uncover common themes and concerns expressed by customers, segmented by their likelihood of recommending "The Company." By examining text responses, we identify key factors driving satisfaction and dissatisfaction, which can inform targeted improvements to services and customer experience. [View Customer Survey Analysis](https://github.com/cthr13en/Data-Science-Projects/tree/main/Customer%20Survey%20Analysis)

## R Packages Used
- `tidyverse`
- `tidytext`
- `ggplot2`
- `dplyr`
- `tidyr`
- `purrr`

# Home Value Analysis
This project involves predicting property values using machine learning, specifically employing the K-Nearest Neighbors (KNN) regression algorithm. The aim is to estimate the value of new single-family homes based on comparable sales data. By analyzing recent sales of similar properties, the KNN algorithm determines the nearest neighbors' average price to predict the new property's valuation. [View Home Value Analysis](https://github.com/cthr13en/Data-Science-Projects/tree/main/Home%20Value%20Analysis)

## Python Packages Used
- `pandas`
- `numpy`
- `scikit-learn`
- `matplotlib`
- `seaborn`

# Python Machine Learning with Spark
This databricks project aims to classify the quality of red wine based on its physicochemical properties using machine learning models. The dataset used is the Red Wine Quality dataset from the Vinho Verde region in northwestern Portugal. The goal is to predict whether a wine is of low, medium, or high quality by analyzing features such as acidity, sugar content, and alcohol level. [View Machine Learning with Spark Analysis](https://github.com/cthr13en/Data-Science-Projects/tree/main/Machine%20Learning%20with%20Spark%20using%20Delta%20Lake%20and%20MLFlow)

## Packages Used
- `PySpark`
- `MLflow`
- `scikit-learn`
- `mlflow`
- `seaborn` and `matplotlib`

# R NLSY79 Part A 
This project aims to analyze and clean height data from the National Longitudinal Surveys of Youth (NLSY) datasets, explicitly focusing on the years 1980-2004 for NLSY79 and 1997-2017 for NLSY97. The goal is to tidy and visualize the height data to ensure accuracy and gain insights into height distributions by sex. The project involves transforming the data from a wide format to a tidy format, addressing missing values and outliers, and performing exploratory data analysis (EDA) to visualize height distributions. [View NLSY79 Part A ](https://github.com/cthr13en/Data-Science-Projects/tree/main/NLSY79%20Part%20A)

## Packages Used
- `tidyverse`
- `dplyr`
- `tibble`

# R NLSY79 Part B
This project explores the relationship between income and various physical attributes, focusing primarily on hair color, education level, and gender. The aim is to understand how these factors interact and influence income levels. The analysis includes summarizing income distributions by hair color, examining the effects of education on income, and investigating gender-based income disparities. [View NLSY79 Part A ](https://github.com/cthr13en/Data-Science-Projects/tree/main/NLSY79%20Part%20B)

## Packages Used
- `ggplot2`
- `dplyr`
- `tidyr`

# R Predictive Modeling of Cancer Death Rates
This project aims to analyze and predict cancer outcomes using a dataset of cancer-related features. The primary objective is to develop and evaluate machine learning models that can accurately classify cancer types or predict cancer progression based on various clinical and biological features. This can help in understanding cancer patterns and potentially assist in early diagnosis and personalized treatment planning. [View Predictive Modeling of Cancer Death Rates](https://github.com/cthr13en/Data-Science-Projects/tree/main/Predictive%20Modeling%20Cancer)

## Packages Used
- `tidyverse`
- `dplyr`
- `MASS`
- `faraway`
- `rms` and `skimr`





