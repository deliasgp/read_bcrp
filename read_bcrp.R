library(jsonlite)
library(curl)
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
    url.bcrp    <- curl(api.bcrp)
    json.temp   <- fromJSON(readLines(url.bcrp, warn="F",encoding = "UTF-8"))
    datos       <- as.data.frame(lapply(json.temp$periods, function(y) gsub("n.d.", "-99999.99", y)))
    print(json.temp$config$title)
    names(datos) <- c("name",paste("",cseries,"",sep=""))
    close(url.bcrp)
    return(datos)
}





