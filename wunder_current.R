wunder_current <- function(Station_ID, Api_key){
  resp <- httr::GET(paste("https://api.weather.com/v2/pws/observations/current?stationId=", Station_ID, "&format=json&units=e&apiKey=", Api_key, sep = ""))
  parsed <- httr::content(resp, as = "parsed")
  modJSON <- parsed$observations 
  modJSON <- rlist::list.select(modJSON, obsTimeLocal, solarRadiation, uv, winddir, humidity, qcStatus, imperial$temp, imperial$dewpt, imperial$windChill, imperial$windSpeed, imperial$windGust, imperial$pressure, imperial$precipRate, imperial$precipTotal)
  dataset_cur <- rlist::list.stack(modJSON)
  colnames(dataset_cur) <- c("Time", "Solar_Radiation", "UV", "Wind_Direction", "Humidity", "qc", "Temperature", "Dew_Point", "Wind_Chill", "Wind_Speed", "Wind Gust", "Pressure", "Precip_Rate", "Precip_Total")
  dataset_cur
}
