#### Carga y limpieza de datos####

install.packages(c("read.csv","dplyr","janitor","lubridate", "tidyverse","stringr","knitr","naniar"))

library(readcsv)
library(dplyr)
library(janitor)
library(lubridate)
library(tidyverse)
library(stringr)
library(knitr)
library(naniar)
library(ggplot2)
library(plotly)
library(scales)
library(corrplot)
library(RColorBrewer)
library(viridis)

#Importamos data
data_twitch <- read_csv("datasetV2.csv")


#Vemos la data
head(data_twitch, 20)


#Vemos los títulos de las variables
names(data_twitch)


#Creamos tabla descripcón de variables
tabla_descripcion <- data.frame(
  Variable = c("RANK", "NAME", "LANGUAGE", "TYPE", "MOST_STREAMED_GAME", 
               "2ND_MOST_STREAMED_GAME", "AVERAGE_STREAM_DURATION", 
               "FOLLOWERS_GAINED_PER_STREAM", "AVG_VIEWERS_PER_STREAM",
               "AVG_GAMES_PER_STREAM","TOTAL_TIME_STREAMED","TOTAL_FOLLOWERS",
               "TOTAL_VIEWS", "TOTAL_GAMES_STREAMED", "ACTIVE_DAYS_PER_WEEK",
               "MOST_ACTIVE_DAY", "DAY_WITH_MOST_FOLLOWERS_GAINED"),
  Descripcion = c("Ranking del streamer", "Nickname del streamer", 
                  "Idioma del stream", "Tipo de stream", 
                  "Juego más streameado", "Segundo juego más streameado", 
                  "Duración del stream en horas", "Seguidores ganados por stream", 
                  "Cantidad de viewers por stream", "Cantidad de juegos por stream",
                  "Tiempo total stremeado en horas", "Cantidad total de seguidores",
                  "Cantidad total de vistas", "Cantidad total de juegos streameados",
                  "Cantidad de días activo por semana","Día más activo", 
                  "Día con más seguidores conseguidos"))

#Analizamos la data en general
glimpse(data_twitch)
summary(data_twitch)
miss_var_summary(data_twitch)


#Cambio variable 2ND_MOST_STREAMED_GAME a letras
data_twitch <- rename(data_twitch, SECOND_MOST_STREAMED_GAME = `2ND_MOST_STREAMED_GAME`)
names(data_twitch) <- str_to_lower(names(data_twitch))

colnames(data_twitch)


#Cambio de etiqueta NA's por "Sin juego":

data_twitch <- data_twitch %>%
  mutate(second_most_streamed_game = replace_na(second_most_streamed_game, "Sin juego"))

data_twitch %>% 
  filter(second_most_streamed_game == "Sin juego") %>% 
  group_by(second_most_streamed_game) %>% 
  summarize(count = n())