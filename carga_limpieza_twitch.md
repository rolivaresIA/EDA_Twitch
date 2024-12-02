### Análisis exploratorio de datos en Twitch

En la última década, las plataformas de streaming han transformado la
manera en que consumimos entretenimiento, ofreciendo un medio
interactivo y en tiempo real para conectar a creadores con sus
audiencias. Entre estas plataformas, **Twitch** se ha consolidado como
el líder indiscutible en la transmisión de contenido en vivo,
especialmente en el ámbito de los videojuegos. Durante la pandemia,
Twitch experimentó un boom de creadores y espectadores, y mi mejor amigo
fue uno de ellos. Empezó como un hobby, transmitiendo juegos y creando
una pequeña comunidad que, con el tiempo, ha ido creciendo. Aunque aún
no es famoso, sueña con vivir de esto y convertirlo en su carrera.

Siempre me ha interesado cómo funciona Twitch, y viendo su esfuerzo
diario, decidí ayudarlo. Quiero analizar datos de la plataforma para
identificar qué estrategias, comportamientos o patrones pueden hacer que
un streamer destaque y crezca más rápido. Mi objetivo es responder a la
pregunta: **“¿De qué forma sería más fácil que mi amigo se haga famoso y
pueda vivir de Twitch?”** y ofrecerle recomendaciones claras basadas en
evidencia.

**El siguiente proyecto se dividirá en 3 secciones:**

-   Limpieza y carga de datos
-   Análisis exploratorio univariado
-   Análisis exploratorio bivariado

### Limpieza y Carga de Datos

Como primer paso, debemos instalar los paquetes que utilizaremos en este
proyecto:

<table>
<thead>
<tr class="header">
<th style="text-align: left;">Variable</th>
<th style="text-align: left;">Descripcion</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">RANK</td>
<td style="text-align: left;">Ranking del streamer</td>
</tr>
<tr class="even">
<td style="text-align: left;">NAME</td>
<td style="text-align: left;">Nickname del streamer</td>
</tr>
<tr class="odd">
<td style="text-align: left;">LANGUAGE</td>
<td style="text-align: left;">Idioma del stream</td>
</tr>
<tr class="even">
<td style="text-align: left;">TYPE</td>
<td style="text-align: left;">Tipo de stream</td>
</tr>
<tr class="odd">
<td style="text-align: left;">MOST_STREAMED_GAME</td>
<td style="text-align: left;">Juego más streameado</td>
</tr>
<tr class="even">
<td style="text-align: left;">2ND_MOST_STREAMED_GAME</td>
<td style="text-align: left;">Segundo juego más streameado</td>
</tr>
<tr class="odd">
<td style="text-align: left;">AVERAGE_STREAM_DURATION</td>
<td style="text-align: left;">Duración del stream en horas</td>
</tr>
<tr class="even">
<td style="text-align: left;">FOLLOWERS_GAINED_PER_STREAM</td>
<td style="text-align: left;">Seguidores ganados por stream</td>
</tr>
<tr class="odd">
<td style="text-align: left;">AVG_VIEWERS_PER_STREAM</td>
<td style="text-align: left;">Cantidad de viewers por stream</td>
</tr>
<tr class="even">
<td style="text-align: left;">AVG_GAMES_PER_STREAM</td>
<td style="text-align: left;">Cantidad de juegos por stream</td>
</tr>
<tr class="odd">
<td style="text-align: left;">TOTAL_TIME_STREAMED</td>
<td style="text-align: left;">Tiempo total stremeado en horas</td>
</tr>
<tr class="even">
<td style="text-align: left;">TOTAL_FOLLOWERS</td>
<td style="text-align: left;">Cantidad total de seguidores</td>
</tr>
<tr class="odd">
<td style="text-align: left;">TOTAL_VIEWS</td>
<td style="text-align: left;">Cantidad total de vistas</td>
</tr>
<tr class="even">
<td style="text-align: left;">TOTAL_GAMES_STREAMED</td>
<td style="text-align: left;">Cantidad total de juegos streameados</td>
</tr>
<tr class="odd">
<td style="text-align: left;">ACTIVE_DAYS_PER_WEEK</td>
<td style="text-align: left;">Cantidad de días activo por semana</td>
</tr>
<tr class="even">
<td style="text-align: left;">MOST_ACTIVE_DAY</td>
<td style="text-align: left;">Día más activo</td>
</tr>
<tr class="odd">
<td style="text-align: left;">DAY_WITH_MOST_FOLLOWERS_GAINED</td>
<td style="text-align: left;">Día con más seguidores conseguidos</td>
</tr>
</tbody>
</table>

En este proyecto me voy a enfocar en distintas métricas que permitan
responder a la pregunta inicial. Estas serán principalmente el **IDIOMA,
JUEGOS MÁS STREMEADOS, DÍAS MÁS ACTIVOS, DURACIÓN PROMEDIO DE STREAMS,
SEGUIDORES GANADOS POR STREAM**. Si bien esta data representa el TOP
1000 de Streamers en la plataforma, nos da una visión general del
comportamiento y/o tendencias para posteriormente, realizar conclusiones
propias.

```{r echo=TRUE}
    data_twitch <- read_csv("dataset/datasetV2.csv")
```
```{r echo=TRUE}
    head(data_twitch, 20)
```
    ## # A tibble: 20 × 17
    ##     RANK NAME             LANGUAGE TYPE   MOST_STREAMED_GAME 2ND_MOST_STREAMED_GA…¹ AVERAGE_STREAM_DURAT…²
    ##    <dbl> <chr>            <chr>    <chr>  <chr>              <chr>                                   <dbl>
    ##  1     1 kaicenat         English  perso… Just Chatting      I'm Only Sleeping                         7.6
    ##  2     2 jynxzi           English  perso… Tom Clancy's Rain… NBA 2K20                                  5.4
    ##  3     3 caedrel          English  perso… League of Legends  I'm Only Sleeping                         6.3
    ##  4     4 caseoh_          English  perso… NBA 2K23           Just Chatting                             4.6
    ##  5     5 ibai             Spanish  perso… Just Chatting      League of Legends                         4.1
    ##  6     6 auronplay        Spanish  perso… Minecraft          Just Chatting                             3.7
    ##  7     7 zerator          French   perso… World of Warcraft  VALORANT                                  5.1
    ##  8     8 tarik            English  perso… VALORANT           Counter-Strike                            7.6
    ##  9     9 riotgames        English  espor… League of Legends  League of Legends: Wi…                    8.5
    ## 10    10 papaplatte       German   perso… Just Chatting      Minecraft                                 7.6
    ## 11    11 dota2_paragon_ru Russian  perso… Dota 2             <NA>                                     10.7
    ## 12    12 aminematue       French   perso… Grand Theft Auto V Just Chatting                             4.3
    ## 13    13 kato_junichi0817 Japanese perso… Apex Legends       VALORANT                                  6.3
    ## 14    14 fps_shaka        Japanese perso… PUBG: BATTLEGROUN… Apex Legends                              9.6
    ## 15    15 illojuan         Spanish  perso… Just Chatting      Minecraft                                 4.5
    ## 16    16 hasanabi         English  perso… Just Chatting      Grand Theft Auto V                        7.4
    ## 17    17 montanablack88   German   perso… Just Chatting      Fortnite                                  4.8
    ## 18    18 playapex         English  espor… Apex Legends       Variety                                   5.3
    ## 19    19 lolpacifictw     Chinese  espor… League of Legends  <NA>                                      5.6
    ## 20    20 pgl_dota2        English  espor… Dota 2             <NA>                                     10.2
    ## # ℹ abbreviated names: ¹​`2ND_MOST_STREAMED_GAME`, ²​AVERAGE_STREAM_DURATION
    ## # ℹ 10 more variables: FOLLOWERS_GAINED_PER_STREAM <dbl>, AVG_VIEWERS_PER_STREAM <dbl>,
    ## #   AVG_GAMES_PER_STREAM <dbl>, TOTAL_TIME_STREAMED <dbl>, TOTAL_FOLLOWERS <dbl>, TOTAL_VIEWS <dbl>,
    ## #   TOTAL_GAMES_STREAMED <dbl>, ACTIVE_DAYS_PER_WEEK <dbl>, MOST_ACTIVE_DAY <chr>,
    ## #   DAY_WITH_MOST_FOLLOWERS_GAINED <chr>

    miss_var_summary(data_twitch)

    ## # A tibble: 17 × 3
    ##    variable                       n_miss pct_miss
    ##    <chr>                           <int>    <num>
    ##  1 2ND_MOST_STREAMED_GAME             77     7.71
    ##  2 RANK                                0     0   
    ##  3 NAME                                0     0   
    ##  4 LANGUAGE                            0     0   
    ##  5 TYPE                                0     0   
    ##  6 MOST_STREAMED_GAME                  0     0   
    ##  7 AVERAGE_STREAM_DURATION             0     0   
    ##  8 FOLLOWERS_GAINED_PER_STREAM         0     0   
    ##  9 AVG_VIEWERS_PER_STREAM              0     0   
    ## 10 AVG_GAMES_PER_STREAM                0     0   
    ## 11 TOTAL_TIME_STREAMED                 0     0   
    ## 12 TOTAL_FOLLOWERS                     0     0   
    ## 13 TOTAL_VIEWS                         0     0   
    ## 14 TOTAL_GAMES_STREAMED                0     0   
    ## 15 ACTIVE_DAYS_PER_WEEK                0     0   
    ## 16 MOST_ACTIVE_DAY                     0     0   
    ## 17 DAY_WITH_MOST_FOLLOWERS_GAINED      0     0

Después de analizar a que corresponde cada variable y que información
nos van a dar a lo largo del proyecto, vemos que las “clases” están
definidas correctamente.

También se analizan los datos faltantes de nuestra base para decidir que
hacer con ellos. En este caso, podemos ver que solo existe una variable
con **n\_miss** y es la **2ND\_MOST\_STREAMED\_GAME**. Esto tiene
sentido, ya que existen streamers que solo se muestran jugando un juego
y por ende esta variable quedaría sin información. Para efectos de
manipulación de los títulos, los cambiaremos a letras minúsculas y la
variable **2ND\_MOST\_STREAMED\_GAME** será modificada solamente por
letras.Reemplazaremos los valores faltantes de esta variable por la
etiqueta **Sin juego**.

    data_twitch <- rename(data_twitch, SECOND_MOST_STREAMED_GAME = `2ND_MOST_STREAMED_GAME`)

    ## # A tibble: 999 × 17
    ##     RANK NAME       LANGUAGE TYPE        MOST_STREAMED_GAME  SECOND_MOST_STREAMED…¹ AVERAGE_STREAM_DURAT…²
    ##    <dbl> <chr>      <chr>    <chr>       <chr>               <chr>                                   <dbl>
    ##  1     1 kaicenat   English  personality Just Chatting       I'm Only Sleeping                         7.6
    ##  2     2 jynxzi     English  personality Tom Clancy's Rainb… NBA 2K20                                  5.4
    ##  3     3 caedrel    English  personality League of Legends   I'm Only Sleeping                         6.3
    ##  4     4 caseoh_    English  personality NBA 2K23            Just Chatting                             4.6
    ##  5     5 ibai       Spanish  personality Just Chatting       League of Legends                         4.1
    ##  6     6 auronplay  Spanish  personality Minecraft           Just Chatting                             3.7
    ##  7     7 zerator    French   personality World of Warcraft   VALORANT                                  5.1
    ##  8     8 tarik      English  personality VALORANT            Counter-Strike                            7.6
    ##  9     9 riotgames  English  esports     League of Legends   League of Legends: Wi…                    8.5
    ## 10    10 papaplatte German   personality Just Chatting       Minecraft                                 7.6
    ## # ℹ 989 more rows
    ## # ℹ abbreviated names: ¹​SECOND_MOST_STREAMED_GAME, ²​AVERAGE_STREAM_DURATION
    ## # ℹ 10 more variables: FOLLOWERS_GAINED_PER_STREAM <dbl>, AVG_VIEWERS_PER_STREAM <dbl>,
    ## #   AVG_GAMES_PER_STREAM <dbl>, TOTAL_TIME_STREAMED <dbl>, TOTAL_FOLLOWERS <dbl>, TOTAL_VIEWS <dbl>,
    ## #   TOTAL_GAMES_STREAMED <dbl>, ACTIVE_DAYS_PER_WEEK <dbl>, MOST_ACTIVE_DAY <chr>,
    ## #   DAY_WITH_MOST_FOLLOWERS_GAINED <chr>

    names(data_twitch) <- str_to_lower(names(data_twitch))

    data_twitch <- data_twitch %>%
      mutate(second_most_streamed_game = replace_na(second_most_streamed_game, "Sin juego"))

    ## # A tibble: 999 × 17
    ##     rank name       language type        most_streamed_game  second_most_streamed…¹ average_stream_durat…²
    ##    <dbl> <chr>      <chr>    <chr>       <chr>               <chr>                                   <dbl>
    ##  1     1 kaicenat   English  personality Just Chatting       I'm Only Sleeping                         7.6
    ##  2     2 jynxzi     English  personality Tom Clancy's Rainb… NBA 2K20                                  5.4
    ##  3     3 caedrel    English  personality League of Legends   I'm Only Sleeping                         6.3
    ##  4     4 caseoh_    English  personality NBA 2K23            Just Chatting                             4.6
    ##  5     5 ibai       Spanish  personality Just Chatting       League of Legends                         4.1
    ##  6     6 auronplay  Spanish  personality Minecraft           Just Chatting                             3.7
    ##  7     7 zerator    French   personality World of Warcraft   VALORANT                                  5.1
    ##  8     8 tarik      English  personality VALORANT            Counter-Strike                            7.6
    ##  9     9 riotgames  English  esports     League of Legends   League of Legends: Wi…                    8.5
    ## 10    10 papaplatte German   personality Just Chatting       Minecraft                                 7.6
    ## # ℹ 989 more rows
    ## # ℹ abbreviated names: ¹​second_most_streamed_game, ²​average_stream_duration
    ## # ℹ 10 more variables: followers_gained_per_stream <dbl>, avg_viewers_per_stream <dbl>,
    ## #   avg_games_per_stream <dbl>, total_time_streamed <dbl>, total_followers <dbl>, total_views <dbl>,
    ## #   total_games_streamed <dbl>, active_days_per_week <dbl>, most_active_day <chr>,
    ## #   day_with_most_followers_gained <chr>

Corroboramos que se hayan aplicado los cambios y que ya no tenemos
valores faltantes:

    filtro_sin_juego <- data_twitch %>% 
      filter(second_most_streamed_game == "Sin juego") %>% 
      group_by(second_most_streamed_game) %>% 
      summarize(count = n())

    ## # A tibble: 1 × 2
    ##   second_most_streamed_game count
    ##   <chr>                     <int>
    ## 1 Sin juego                    77

    miss_var_summary(data_twitch)

    ## # A tibble: 17 × 3
    ##    variable                       n_miss pct_miss
    ##    <chr>                           <int>    <num>
    ##  1 rank                                0        0
    ##  2 name                                0        0
    ##  3 language                            0        0
    ##  4 type                                0        0
    ##  5 most_streamed_game                  0        0
    ##  6 second_most_streamed_game           0        0
    ##  7 average_stream_duration             0        0
    ##  8 followers_gained_per_stream         0        0
    ##  9 avg_viewers_per_stream              0        0
    ## 10 avg_games_per_stream                0        0
    ## 11 total_time_streamed                 0        0
    ## 12 total_followers                     0        0
    ## 13 total_views                         0        0
    ## 14 total_games_streamed                0        0
    ## 15 active_days_per_week                0        0
    ## 16 most_active_day                     0        0
    ## 17 day_with_most_followers_gained      0        0

Finalizando el primer paso del proyecto correspondiente a la limpieza y
carga de datos, podemos ver que no tenemos datos faltantes y podrémos
iniciar con el análisis exploratorio.
