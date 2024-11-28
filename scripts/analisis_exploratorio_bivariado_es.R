#### Análisis exploratorio multivariable#####

#Matriz de correlación variables numéricas

variables_numericas <- data_twitch %>%
  select_if(is.numeric)

correlation_matrix <- cor(variables_numericas, use = "complete.obs")

corrplot(correlation_matrix, 
         method = "color",          # Método de visualización
         col = colorRampPalette(c("red", "white", "purple"))(200),  # Paleta de colores
         type = "lower",            # Muestra solo la parte inferior de la matriz
         order = "hclust",          # Ordena las variables según jerarquía
         tl.cex = 0.8,              # Tamaño de las etiquetas de las variables
         tl.col = "black",          # Color de las etiquetas
         cl.cex = 0.8,              # Tamaño de la leyenda
         title = "Matriz de Correlación", # Título del gráfico
         mar = c(0, 0, 1, 0),       # Ajuste de márgenes
         addCoef.col = "black",     # Agregar los valores de correlación en negro
         number.cex = 0.7,          # Ajusta el tamaño del texto de los números
         diag = FALSE) 

#Análisis idioma español filtrado

data_twitch_es <- data_twitch %>%
  filter(language == "Spanish")


#Juegos más jugados en español
most_streamed_games_es <- data_twitch_es %>%
  group_by(most_streamed_game) %>%
  summarise(count = n()) %>%
  arrange(desc(count)) %>%
  mutate(percentage = (count / sum(count)) * 100)

ggplot(most_streamed_games_es, aes(x = reorder(most_streamed_game, -count), 
                                   y = count, fill = most_streamed_game)) +
  geom_bar(stat = "identity", alpha = 0.8, color = "black") +
  geom_text(aes(label = paste0(round(percentage, 1), "%")), vjust = -0.5, size = 3.5) +
  labs(title = "Juegos más streameados en español",
       x = "Juego",
       y = "Cantidad de streamers") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme(legend.position = "none")


#Juegos con más seguidores (engagment) en español
followers_per_game_es <- data_twitch_es %>%
  group_by(most_streamed_game) %>%
  summarise(mean_followers = mean(followers_gained_per_stream, na.rm = TRUE),
            count = n()) %>%
  arrange(desc(mean_followers))

print(followers_per_game_es)

#Gráfico con paleta de colores morados

colors_purples <- rep(brewer.pal(9, "Purples"), length.out = nrow(followers_per_game_es))

ggplot(followers_per_game_es, aes(x = reorder(most_streamed_game, -mean_followers), 
                                  y = mean_followers, fill = most_streamed_game)) +
  geom_bar(stat = "identity", alpha = 0.8, color = "black") +
  labs(title = "Media de seguidores ganados por juego en español",
       x = "Juego más streameado",
       y = "Media de seguidores ganados por stream") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme(legend.position = "none") +
  scale_fill_manual(values = colors_purples)

#Opción de colores con libreria vridis

ggplot(followers_per_game_es, aes(x = reorder(most_streamed_game, -mean_followers), 
                                  y = mean_followers, fill = most_streamed_game)) +
  geom_bar(stat = "identity", alpha = 0.8, color = "black") +
  labs(title = "Media de seguidores ganados por juego en español",
       x = "Juego más streameado",
       y = "Media de seguidores ganados por stream") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme(legend.position = "none") +
  scale_fill_viridis_d(option = "plasma")

#Opción con paleta de colores manual en gradientes
ggplot(followers_per_game_es, aes(x = reorder(most_streamed_game, -mean_followers), 
                                  y = mean_followers, fill = mean_followers)) +
  geom_bar(stat = "identity", alpha = 0.8, color = "black") +
  labs(title = "Media de seguidores ganados por juego en español",
       x = "Juego más streameado",
       y = "Media de seguidores ganados por stream") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme(legend.position = "none") +
  scale_fill_gradient(low = "#E0E0F7", high = "#4A148C")

#Boxpplot de seguidores ganados por juego (español) (mediana)

followers_per_game_es_full <- data_twitch %>%
  filter(language == "Spanish") %>%
  select(most_streamed_game, followers_gained_per_stream)

ggplot(followers_per_game_es_full, aes(x = reorder(most_streamed_game, -followers_gained_per_stream, FUN = median), 
                                       y = followers_gained_per_stream)) +
  geom_boxplot(fill = "purple") +
  labs(title = "Distribución de seguidores ganados por juego en español",
       x = "Juego más streameado",
       y = "Seguidores ganados por stream") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


#Días más activos para la comunidad habla hispana

dias_mas_activos_es <- data_twitch_es %>%
  count(most_active_day) %>%  # Contamos los streams por día
  arrange(desc(n)) %>% 
  mutate(percentage = n / sum(n) * 100)


ggplot(dias_mas_activos_es, aes(x = reorder(most_active_day, -n), y = n)) +
  geom_bar(stat = "identity", fill = "purple", color = "black") +
  geom_text(aes(label = paste0(round(percentage, 1), "%")), 
            vjust = -0.5,  
            size = 3.5) + 
  labs(title = "Días más activos en la comunidad hispana",
       x = "Día",
       y = "Cantidad de Streamers") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

#Días con mayor cantidad de viewers 

views_por_dia <- data_twitch_es %>%
  group_by(most_active_day) %>%  # Agrupamos por el día más activo
  summarise(total_views = sum(total_views, na.rm = TRUE)) %>%
  arrange(desc(total_views))

ggplot(views_por_dia, aes(x = reorder(most_active_day, -total_views), 
                          y = total_views)) +
  geom_bar(stat = "identity", fill = "purple", color = "black") +
  geom_text(aes(label = total_views), 
            vjust = -0.5, 
            size = 3.5) + 
  labs(title = "Días con Más Views (Comunidad Hispana)",
       x = "Día",
       y = "Total de Views") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#Días con mayores seguidores ganados para la comunidad hispana

dias_mas_seguidores_es <- data_twitch_es %>%
  count(day_with_most_followers_gained) %>%
  arrange(desc(n))

ggplot(dias_mas_seguidores_es, aes(x = reorder(day_with_most_followers_gained, -n), 
                                   y = n)) +
  geom_bar(stat = "identity", fill = "purple", color = "black") +
  geom_text(aes(label = n), 
            vjust = -0.5, 
            size = 3.5) + 
  labs(title = "Días con Mayores Seguidores Ganados (Comunidad Hispana)",
       x = "Día",
       y = "Número de Streams") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


#Analisis comparativo: Días mas activos de streamers, viewers y maximo de seguidores:

merged_data <- views_por_dia %>%
  left_join(dias_mas_activos_es, by = c("most_active_day" = "most_active_day")) %>%
  left_join(dias_mas_seguidores_es, by = c("most_active_day" = "day_with_most_followers_gained"))

merged_data <- merged_data %>%
  rename(total_views = total_views,  # Total de views
         streamers = n.x,           # Total de streamers
         followers_gained = n.y)    # Total de followers

head(merged_data)

merged_data_filtered <- merged_data %>%
  select(most_active_day, total_views, streamers, followers_gained)

merged_data_long <- merged_data_filtered %>%
  pivot_longer(cols = c(total_views, streamers, followers_gained), 
               names_to = "metric", 
               values_to = "value")

merged_data_long <- merged_data_long %>%
  group_by(metric) %>%
  mutate(value_normalized = (value - min(value)) / (max(value) - min(value))) %>%
  ungroup()

head(merged_data_long)

ggplot(merged_data_long, aes(x = most_active_day, y = value_normalized, fill = metric)) +
  geom_bar(stat = "identity", position = "dodge") +  # Se usa dodge para separar las barras
  labs(title = "Análisis Comparativo: Días Más Activos, Views y Seguidores",
       x = "Día de la Semana",
       y = "Valor Normalizado",
       fill = "Métrica") +
  scale_fill_manual(values = c("total_views" = "#051126", "streamers" = "purple", "followers_gained" = "#c6bed8")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

##Total views vs Avg viewers per stream (correlación 0.57)

ggplot(data_twitch_es, aes(x = total_views, y = avg_viewers_per_stream)) +
  geom_point(aes(color = avg_viewers_per_stream), size = 3, alpha = 0.7) + # Puntos con color y transparencia
  scale_color_viridis_c(option = "magma") + # Escala de colores atractiva
  geom_smooth(method = "lm", color = "blue", linetype = "dashed", size = 1) + # Línea de tendencia (ajuste lineal)
  labs(title = "Relación entre Vistas Totales y Promedio de Espectadores por Stream",
       x = "Total Views",
       y = "Promedio de Espectadores por Stream") +
  theme_minimal() +
  theme(plot.title = element_text(size = 15, face = "bold", hjust = 0.5), # Título en negrita
        plot.caption = element_text(size = 8, hjust = 1), # Subtítulo más pequeño
        axis.title.x = element_text(margin = margin(t = 20)),  # Separación del título X
        axis.title.y = element_text(margin = margin(r = 20)))

#Total views vs Total followers (correlación 0.65)

ggplot(data_twitch_es, aes(x = total_views, y = total_followers)) +
  geom_point(aes(color = total_followers), size = 3, alpha = 0.7) +
  scale_color_viridis_c(option = "magma") +
  geom_smooth(method = "lm", color = "blue", linetype = "dashed", size = 1) +
  labs(title = "Relación entre Vistas Totales y Seguidores Totales",
       x = "Vistas Totales",
       y = "Seguidores Totales") +
  theme_minimal() + # Tema minimalista
  theme(plot.title = element_text(size = 15, face = "bold", hjust = 0.5), 
        plot.caption = element_text(size = 8, hjust = 1), 
        axis.title.x = element_text(margin = margin(t = 20)), 
        axis.title.y = element_text(margin = margin(r = 20)))


#Active days per week vs Total time streamed (correlación 0.57)
ggplot(data_twitch_es, aes(x = active_days_per_week, y = total_time_streamed)) +
  geom_point(aes(color = total_time_streamed), size = 3, alpha = 0.7) +
  scale_color_viridis_c(option = "magma") + 
  geom_smooth(method = "lm", color = "blue", linetype = "dashed", size = 1) + 
  labs(title = "Relación entre Días Activos por Semana y Tiempo Total de Stream",
       x = "Días Activos por Semana",
       y = "Tiempo Total de Stream") +
  theme_minimal() + 
  theme(plot.title = element_text(size = 15, face = "bold", hjust = 0.5), 
        plot.caption = element_text(size = 8, hjust = 1), 
        axis.title.x = element_text(margin = margin(t = 20)), 
        axis.title.y = element_text(margin = margin(r = 20)))


#Total games streamed vs Avg games per stream (correlación 0.54)
ggplot(data_twitch_es, aes(x = total_games_streamed, y = avg_games_per_stream)) +
  geom_point(aes(color = avg_games_per_stream), size = 3, alpha = 0.7) +
  scale_color_viridis_c(option = "magma") +
  geom_smooth(method = "lm", color = "blue", linetype = "dashed", size = 1) +
  labs(title = "Relación entre Total de Juegos Transmitidos y Promedio de Juegos por Stream",
       x = "Total de Juegos Transmitidos",
       y = "Promedio de Juegos por Stream") +
  theme_minimal() + 
  theme(plot.title = element_text(size = 15, face = "bold", hjust = 0.5), 
        plot.caption = element_text(size = 8, hjust = 1), 
        axis.title.x = element_text(margin = margin(t = 20)), 
        axis.title.y = element_text(margin = margin(r = 20)))


#Top 5 juegos más jugados por día con más espectadores:

custom_palette <- c("#8682bd", "#4c3f77", "#7c587f", "#a4bcbc", "#051126",
                    "purple", "#007f97", "#f3f6e9", "#bcd8f9", "#5c87ba",
                    "#6c5397", "#8d6cb1", "#4a2b7e", "#2e4277", "#abc4b8",
                    "#f4b2c1", "#ad99d5", "#639eaf", "#95d0d1", "#3e5b82")

# Agrupar por día y juego, y sumar los total de espectadores
top_games_by_day_viewers <- data_twitch_es %>%
  group_by(most_active_day, most_streamed_game) %>%
  summarise(total_viewers = sum(avg_viewers_per_stream, na.rm = TRUE)) %>%
  arrange(most_active_day, desc(total_viewers)) %>%
  group_by(most_active_day) %>%
  slice_head(n = 5) 

top_games_by_day_viewers$most_active_day <- factor(top_games_by_day_viewers$most_active_day, 
                                                   levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))

ggplot(top_games_by_day_viewers, aes(x = most_active_day, y = total_viewers, fill = most_streamed_game)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Top 5 Juegos Más Jugados por Día con Más Espectadores",
       x = "Día de la Semana",
       y = "Total de Espectadores",
       fill = "Juego") +
  scale_fill_manual(values = custom_palette) +  # Aplicar la paleta personalizada
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
        legend.position = "bottom")