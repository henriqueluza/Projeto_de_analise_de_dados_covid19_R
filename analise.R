#Instala os pacotes necessários para o projeto

install.packages(c("jsonlite", "curl","dplyr", "httr", "rvest"))

library(jsonlite)
library(curl)
library(dplyr)
library(httr)
library(rvest)

wikipedia_url <- "https://en.wikipedia.org/wiki/COVID-19_testing#Testing_statistics_by_country"
resposta <- GET(wikipedia_url)
 
print(status_code(resposta))

