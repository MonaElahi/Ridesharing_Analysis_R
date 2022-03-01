# Import Library
library(dplyr)
library(readr)

# View CSVs
View(ride_data)
View(city_data)

# null values in city_data
is.na(city_data)

# Unique types
unique(city_data['type'], incomparables = FALSE)

# Summarize to get sum of types
city_data%>%
  group_by(type)%>%
  summarize(n=n())
# Merge city and Ride data CSV's 
new_data <- merge(city_data,ride_data,by='city')

# create dfs for Urban, Suburban and Rural types
urban <- subset(new_data, type == 'Urban')
rural <- subset(new_data, type == 'Rural')
suburban <- subset(new_data, type == 'Suburban')

# Ride count by city & type
rural_ride_count <- aggregate(rural$ride_id, by=list(rural$city),FUN=length)
suburban_ride_count <- aggregate(suburban$ride_id, by=list(suburban$city),FUN=length)
urban_ride_count <- aggregate(urban$ride_id, by=list(urban$city),FUN=length)

# Get average fare for each city
urban_avg_fare <- urban%>% group_by(city)%>% summarize(mean(fare), .groups= 'keep')
rural_avg_fare <- rural%>% group_by(city)%>% summarize(mean(fare), .groups= 'keep')
suburban_avg_fare <- suburban%>% group_by(city)%>% summarize(mean(fare), .groups= 'keep')

# Average number of drivers in each city
rural_driver_count <- rural%>% group_by(city)%>% summarize(mean(driver_count), .groups = 'keep')
urban_driver_count <- urban%>% group_by(city)%>% summarize(mean(driver_count), .groups = 'keep')
suburban_driver_count <- suburban%>% group_by(city)%>% summarize(mean(driver_count), .groups = 'keep')