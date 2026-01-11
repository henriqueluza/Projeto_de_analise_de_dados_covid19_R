#Instala os pacotes necessários para o projeto

install.packages(c("jsonlite", "curl","dplyr", "httr", "rvest"))

library(jsonlite)
library(curl)
library(dplyr)
library(httr)
library(rvest)

# TASK 1

wikipedia_url <- "https://en.wikipedia.org/wiki/COVID-19_testing#Testing_statistics_by_country"
resposta <- GET(wikipedia_url)
print(status_code(resposta)) #Teste para verificar se está funcionando

html_content <- read_html(resposta)
tabelas <- html_content %>% html_table(fill = TRUE)

# TASK 2

print(paste("Total de tabelas encontradas:", length(tabelas))) #Verificar quantas tabelas tinham ali

print("=== TAMANHO DE CADA TABELA ===")
for (i in 1:length(tabelas)) {
  tabela <- tabelas[[i]]
  linhas <- nrow(tabela)
  colunas <- ncol(tabela)
  print(paste("Tabela", i, ":", linhas, "linhas x", colunas, "colunas"))
}

df <- tabelas[[3]]
print(head(df))

# TASK 3

str(df)

# Converter todas as tabelas, exceto Units[b] para numeric. Antes de converter o Confirmed(cases) para numeric, tirar a vírgula

colnames(df)

covid_data <- df |> 
  select(-Ref.) |>
  rename(
    Country = `Country or region`,
    Date = `Date[a]`,
    Tested = Tested,
    Units = `Units[b]`,
    Confirmed = `Confirmed(cases)`,
    Confirmed_Tested_Pct = `Confirmed /tested,%`,
    Tested_Population_Pct = `Tested /population,%`,
    Confirmed_Population_Pct = `Confirmed /population,%`
  ) |>
  mutate(
    Date = substr(Date, 1, 11),
    # Remover espaços extras
    Date = trimws(Date),
    # Converter para Date
    Date = as.Date(Date, format = "%d %b %Y"),
    Tested = as.numeric(gsub(",", "", Tested)),
    Confirmed = as.numeric(gsub(",", "", Confirmed)),
    Confirmed_Tested_Pct = as.numeric(Confirmed_Tested_Pct),
    Tested_Population_Pct = as.numeric(Tested_Population_Pct),
    Confirmed_Population_Pct = as.numeric(Confirmed_Population_Pct)
    
  )

str(covid_data)
write.csv(covid_data, "covid_testing_data.csv", row.names = FALSE)
print("Dados exportados com sucesso")

# TASK 4

covid_data_subset <- covid_data |>
  select(Country, Tested, Confirmed)

head(covid_data_subset)
dim(covid_data_subset)

# TASK 5

total_tested <- sum(covid_data$Tested, na.rm = TRUE)
total_confirmed <- sum(covid_data$Confirmed, na.rm = TRUE)

ratio <- (total_confirmed/total_tested) * 100
print(paste("Testing positive ratio:", round(ratio, 2), "%"))

# TASK 6

countries <- covid_data$Country
sorted_countries <- sort(countries)

print(sorted_countries)

# TASK 7

united_countries <- grep("^United", covid_data$Country, value = TRUE)
print(united_countries)

land_countries <- grep("land$", covid_data$Country, value = TRUE)
print(land_countries)

# TASK 8

country1 <- "Brazil"
country2 <- "United States"

selected_countries <- covid_data |>
  filter(Country %in% c(country1, country2))

print(selected_countries)

for (country in c(country1, country2)) {
  data <- covid_data |> filter (Country == country)
  print(paste("--- Dados de", country, "---"))
  print(paste("Testes realizados:", data$Tested))
  print(paste("Casos confirmados:", data$Confirmed))
  print("")
}

# TASK 9

selected_countries <- selected_countries |>
  mutate(confirmed_ratio = (Confirmed / Tested) * 100)

max_ratio_country <- selected_countries |>
  filter(confirmed_ratio == max(confirmed_ratio))

print(paste("País com maior ratio: ", max_ratio_country$Country))
print(paste("Razão: ", round(max_ratio_country$confirmed_ratio, 4), "%"))

# TASK 10

limite <- 1

covid_data_with_ratio <- covid_data |> 
  mutate(confirmed_ratio = (Confirmed / Tested) * 100)

low_ratio_countries <- covid_data_with_ratio |>
  filter(confirmed_ratio < limite) |>
  select(Country, confirmed_ratio) |>
  arrange(confirmed_ratio)

print(paste("Países com razão casos/população menor que", limite, "%:"))
print(low_ratio_countries)
print(paste("Total:", nrow(low_ratio_countries), "países"))
  