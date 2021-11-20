library(jsonlite)

read_bcrp <- function(cseries = "",periodo_ini="",periodo_fin=""){
    if(!is.character(cseries)||!is.character(periodo_ini)||!is.character(periodo_fin))
    {stop("Los argumentos de la función deben ser de tipo character")}
    if(periodo_fin==""){stop("Debe proporcionar un periodo inicial")}
    if(periodo_fin==""){stop("Debe proporcionar un periodo final")}
    #----------------------*
    api.bcrp    <- paste0("https://estadisticas.bcrp.gob.pe/estadisticas/series/api/",
                          cseries,"/json/",
                          periodo_ini,"/",
                          periodo_fin) 
    url.bcrp    <- url(api.bcrp)
    json.temp   <- fromJSON(readLines(url.bcrp, warn="F"))
    datos       <- as.data.frame(lapply(json.temp$periods, function(y) gsub("n.d.", "-99999.99", y))) 
    names(datos) <- c("name",paste("",cseries,"",sep=""))
    return(datos)
}

mis_datos <- read_bcrp(cseries = "PM05055AA",periodo_ini = "1940-01-01",periodo_fin = "2021-01-01")

#========================================================*









