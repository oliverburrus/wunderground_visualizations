wunder_historical <- function(days_back = 30, Station_ID, Api_key){
  date <- seq(as.Date(Sys.Date())-days_back+1, as.Date(Sys.Date()), length.out = days_back)%>%
    format("%Y%m%d")
  for(x in 0:days_back+1){
    resp <- httr::GET(paste("https://api.weather.com/v2/pws/history/hourly?stationId=", Station_ID, "&format=json&units=e&date=", date[x], "&apiKey=", Api_key, sep = ""))
    parsed <- httr::content(resp, as = "parsed")
    modJSON <- parsed$observations 
    modJSON <- rlist::list.select(modJSON, obsTimeLocal, solarRadiationHigh, uvHigh, winddirAvg, humidityAvg, qcStatus, imperial$tempAvg, imperial$windspeedAvg, imperial$windgustAvg, imperial$dewptAvg, imperial$windchillAvg, imperial$pressureMax, imperial$precipRate, imperial$precipTotal)
    if(x == 1){
      dataset <- rlist::list.stack(modJSON)
    }else{
      datasetz <- rlist::list.stack(modJSON)
      dataset <- rbind(dataset, datasetz)
    }
  }
    dataset <- dplyr::filter(dataset, qcStatus==-1)
    dataset$obsTimeLocal <- lubridate::ymd_hms(dataset$obsTimeLocal)
    dataset$Month <- lubridate::month(dataset$obsTimeLocal)
    dataset$Day <- lubridate::ymd(as.Date(dataset$obsTimeLocal))
    colnames(dataset) <- c("Time", "Solar_Radiation", "UV", "Wind_Direction", "Humidity", "qc", "Temperature", "Wind_Speed", "Wind Gust", "Dew_Point", "Wind_Chill", "Pressure", "Precip_Rate", "Precip_Total", "Month", "Day")
    dataset
}
