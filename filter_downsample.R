require(tidyverse)

# filter_data: filter data based on %valid minutes per day threshold and minimum number of days that pass this threshold

#example usage: Filter dataset to at least 3 days of 95% wear
#data_3_95 <- filter_data(data, wear_data, 0.95, 3)

#note: "wear_data" argument takes a dataframe for input and refers to "valid_wear.csv", included in our processed data downloads

filter_data <- function(acc_data, wear_data, percent_wear, minimum_days) {
  
  wearSummary <- wear_data %>%
    group_by(ID) %>%
    summarise(day = length(day),
              wear = mean(minute_wear))
  
  #number of subjects in the original dataset
  print(paste0('Input data includes ', length(unique(wearSummary$ID)), ' subjects, ', 
         'averaging ', round(mean(wearSummary$day), 2), ' days per subject and ',
         round(mean(wearSummary$wear), 2), ' minutes of valid wear per day.'))
  
  #keep only days that have greater than percent_wear threshold
  wear_data <- wear_data  %>%
    filter(minute_wear > percent_wear * 1440)
  
  wearSummary <- wear_data %>%
    group_by(ID) %>%
    summarise(day = length(day),
              wear = mean(minute_wear))
  
  #number of subjects in the dataset after filtering by minutes per day
  print(paste0('Data that passed [>', percent_wear*100, '% valid wear per day] threshold includes ', length(unique(wearSummary$ID)), ' subjects, ', 
         'averaging ', round(mean(wearSummary$day), 2), ' days per subject and ',
         round(mean(wearSummary$wear), 2), ' minutes of valid wear per day.'))
  
  #keep only subjects with greater than minimum_days days of data after applying percent_wear threshold
  validIDs <- filter(wearSummary, day > minimum_days)
  validIDs <- unique(validIDs$ID)
  
  wear_data <- wear_data %>% filter(ID %in% validIDs)
  
  wearSummary <- wear_data %>%
    group_by(ID) %>%
    summarise(day = length(day),
              wear = mean(minute_wear))
  
  #number of subjects in the dataset after filtering by minutes per day
  print(paste0('Data that passed [>', minimum_days, ' days] of [>', percent_wear*100, '% valid wear per day] threshold includes ', length(unique(wearSummary$ID)), ' subjects, ', 
         'averaging ', round(mean(wearSummary$day), 2), ' days per subject and ',
         round(mean(wearSummary$wear), 2), ' minutes of valid wear per day.'))
  
  
  validID_days <- paste0(wear_data$ID, '-', wear_data$day)
  
  filtered_data <- acc_data %>% 
    mutate(ID_days = paste0(ID, '-', day)) %>%
    filter(ID_days %in% validID_days) %>%
    select(-ID_days)
  
  return(filtered_data)
  
}


# downsample: downsample 1 minute epoch dataset into longer epochs by taking the mean over each epoch

#example usage: Downsample the 1 minute epoch dataset to 30 minute epochs

#data_30minute <- downsample(data_1minute, 30)

downsample <- function(dataset, epoch) {
  
  print(paste0('Downsampling 60s epoch data into ', epoch, ' minute epochs.'))
  
  dataset <- dataset %>% 
    mutate(
      minute = minute - 1,
      minute = floor(minute/epoch)) %>%
    group_by(ID, day, minute) %>%
    summarise(timestamp = timestamp[1],
              ENMO = mean(ENMO, na.rm = T),
              wear = min(wear)) %>%
              # Takes the minimum value of the binary 'wear' variable and assigns it 
              # to the entire epoch. This means that if any minute in the epoch contains 
              # nonwear, the entire epoch will be scored as nonwear. Conversely, the 
              # only epochs that are scored with wear=1 are those with 100% wear time.
    mutate(minute = (minute + 1) * epoch)
  
  return(dataset)
  
}

