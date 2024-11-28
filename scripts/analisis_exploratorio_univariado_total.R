#### Análisis exploratorio univariado#####

#Análisis de la variable idioma

#Paso 1: Vemos la proporción por idioma

data_proporciones <- data_twitch %>%
  count(language) %>%                          
  mutate(percentage = n / sum(n) * 100)           

#Paso2: Creamos gráfico de la data total

ggplot(data_proporciones, aes(x = reorder(language, -n), y = n)) +
  geom_bar(stat = "identity", fill = "purple", color = "black") +
  geom_text(aes(label = paste0(round(percentage, 1), "%")), 
            vjust = -0.5,  
            size = 3.5) + 
  labs(title = "Distribución de Idiomas (Top 1000)",
       x = "Idioma",
       y = "Frecuencia") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


#También podemos tomar una muestra aleatoria de 200 observaciones (20% data) y ver como se comporta

muestra <- data_twitch %>% 
  sample_n(200) %>% 
  count(language) %>%                          
  mutate(percentage = n / sum(n) * 100)


ggplot(muestra, aes(x = reorder(language, -n), y = n)) +  # Reordenamos por frecuencia
  geom_bar(stat = "identity", fill = "purple", color = "black") +  # Usamos barras con geom_bar
  geom_text(aes(label = paste0(round(percentage, 1), "%")), 
            vjust = -0.5,  # Coloca las etiquetas un poco por encima de las barras
            size = 3.5) +  # Ajustamos el tamaño del texto
  labs(title = "Distribución de Idiomas (Muestra aleatoria de 200)",
       x = "Idioma",
       y = "Frecuencia") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))



#Ahora analizamos la variable "most_streamed_game" para ver cuales son los juegos de mayor interés

top_veinte_juegos <- data_twitch %>% 
  count(most_streamed_game) %>% 
  mutate(percentage = n / sum(n) * 100) %>% 
  arrange(desc(n)) %>% 
  head(20)

ggplot(top_veinte_juegos, aes(x = reorder(most_streamed_game, -n), y = n)) +
  geom_bar(stat = "identity", fill = "purple", color = "black") +
  geom_text(aes(label = paste0(round(percentage, 1), "%")), 
            vjust = -0.5,  
            size = 3.5) + 
  labs(title = "Juegos más stremeados",
       x = "Juego",
       y = "Frecuencia") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


#Ahora analizamos most_active_day

dias_mas_activos <- data_twitch %>% 
  count(most_active_day) %>% 
  mutate(percentage = n / sum(n) * 100) %>% 
  arrange(desc(n))

ggplot(dias_mas_activos, aes(x = reorder(most_active_day, -n), y = n)) +
  geom_bar(stat = "identity", fill = "purple", color = "black") +
  geom_text(aes(label = paste0(round(percentage, 1), "%")), 
            vjust = -0.5,  
            size = 3.5) + 
  labs(title = "Días más activos",
       x = "Día",
       y = "Cantidad de streamers") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


#Analizamos variable AVERAGE_STREAM_DURATION 

summary(data_twitch$average_stream_duration)

#Histograma
ggplot(data_twitch, aes(x = average_stream_duration)) +
  geom_histogram(bins = 30, fill = "purple", color = "black") +
  labs(title = "Distribución de la Duración Promedio de los Streams",
       x = "Duración Promedio del Stream (Horas)",
       y = "Frecuencia")

# Boxplot de los seguidores ganados por stream
ggplot(data_twitch, aes(x = "", y = average_stream_duration)) +
  geom_boxplot(fill = "purple", color = "black") +
  labs(title = "Boxplot del tiempo promedio stremeado",
       y = "Tiempo promedio stremeado") +
  theme(axis.title.x = element_blank(), axis.text.x = element_blank())


#Analizamos variable FOLLOWERS_GAINED_PER_STREAM

summary(data_twitch$followers_gained_per_stream)

# Histograma de los seguidores ganados por stream
ggplot(data_twitch, aes(x = followers_gained_per_stream)) +
  geom_histogram(bins = 30, fill = "purple", color = "black") +
  scale_x_continuous(breaks = seq(-5000, 20000, by = 2500)) +
  labs(title = "Distribución de Seguidores Ganados por Stream",
       x = "Seguidores Ganados por Stream",
       y = "Frecuencia")


# Boxplot de los seguidores ganados por stream
ggplot(data_twitch, aes(x = "", y = followers_gained_per_stream)) +
  geom_boxplot(fill = "purple", color = "black") +
  labs(title = "Boxplot de los Seguidores Ganados por Stream",
       y = "Seguidores Ganados por Stream") +
  theme(axis.title.x = element_blank(), axis.text.x = element_blank())


#Analizamos variable DAYS_ACTIVE_PER_WEEK

summary(data_twitch$active_days_per_week)

days_active_per_week_plot <- ggplot(data_twitch, aes(x = active_days_per_week)) +
  geom_histogram(binwidth = 1, fill = "purple", color = "black") +
  scale_x_continuous(breaks = seq(0, 7, by = 1)) +
  labs(title = "Distribución de días activos por semana (Redondeado)",
       x = "Promedio de días activos",
       y = "Cantidad de streamers") 

ggplotly(days_active_per_week_plot)


#Analizamos variable TOTAL_TIME_STREAMED

summary(data_twitch$total_time_streamed)