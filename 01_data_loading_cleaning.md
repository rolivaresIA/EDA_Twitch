# 1. Data loading and cleaning

## Context

Streaming platforms have changed how we consume entertainment, and **Twitch** is the leader in live streaming, especially for video games. A close friend of mine became part of that phenomenon: what began as a hobby, streaming games and building a small community, has slowly grown. He is not famous yet, but he dreams of making a living from it.

I have always been curious about how Twitch works and, seeing his daily effort, I decided to help. The goal of this project is to analyse platform data to find which strategies, behaviours or patterns help a streamer stand out and grow faster. The key question is:

> **How can a streamer, especially in the early years, identify and prioritise the strategies that maximise growth on Twitch?**

The analysis is split into three notebooks:

1. Data loading and cleaning (this notebook)
2. Univariate exploratory analysis
3. Bivariate exploratory analysis

## Data loading and cleaning

Required packages: `readr`, `tidyverse`, `naniar`, `knitr`, `RColorBrewer`, `viridis`, `corrplot`.


``` r
library(readr)
library(tidyverse)
library(naniar)
library(knitr)
library(RColorBrewer)
library(viridis)
library(corrplot)
```

The dataset is the Kaggle dataset [Top 1000 Twitch Streamers Data (May 2024)](https://www.kaggle.com/datasets/hibrahimag1/top-1000-twitch-streamers-data-may-2024). Its variables are:


|Variable                       |Description                        |
|:------------------------------|:----------------------------------|
|RANK                           |Streamer ranking                   |
|NAME                           |Streamer nickname                  |
|LANGUAGE                       |Stream language                    |
|TYPE                           |Stream type                        |
|MOST_STREAMED_GAME             |Most streamed game                 |
|2ND_MOST_STREAMED_GAME         |Second most streamed game          |
|AVERAGE_STREAM_DURATION        |Average stream duration (hours)    |
|FOLLOWERS_GAINED_PER_STREAM    |Followers gained per stream        |
|AVG_VIEWERS_PER_STREAM         |Average viewers per stream         |
|AVG_GAMES_PER_STREAM           |Average number of games per stream |
|TOTAL_TIME_STREAMED            |Total time streamed (hours)        |
|TOTAL_FOLLOWERS                |Total followers                    |
|TOTAL_VIEWS                    |Total views                        |
|TOTAL_GAMES_STREAMED           |Total number of games streamed     |
|ACTIVE_DAYS_PER_WEEK           |Active days per week               |
|MOST_ACTIVE_DAY                |Most active day                    |
|DAY_WITH_MOST_FOLLOWERS_GAINED |Day with most followers gained     |

I will focus on the metrics that help answer the initial question: **language, most streamed games, most active days, average stream duration and followers gained per stream**. The data represents the top 1,000 streamers on the platform, so it gives a view of the general behaviour and trends that I can then use to draw my own conclusions.


``` r
data_twitch <- read_csv("dataset/datasetV2.csv")
```


``` r
head(data_twitch, 20)
```

```
## # A tibble: 20 x 17
##     RANK NAME             LANGUAGE TYPE       MOST_STREAMED_GAME 2ND_MOST_STREAMED_GA~1 AVERAGE_STREAM_DURAT~2
##    <dbl> <chr>            <chr>    <chr>      <chr>              <chr>                                   <dbl>
##  1     1 kaicenat         English  personali~ Just Chatting      I'm Only Sleeping                         7.6
##  2     2 jynxzi           English  personali~ Tom Clancy's Rain~ NBA 2K20                                  5.4
##  3     3 caedrel          English  personali~ League of Legends  I'm Only Sleeping                         6.3
##  4     4 caseoh_          English  personali~ NBA 2K23           Just Chatting                             4.6
##  5     5 ibai             Spanish  personali~ Just Chatting      League of Legends                         4.1
##  6     6 auronplay        Spanish  personali~ Minecraft          Just Chatting                             3.7
##  7     7 zerator          French   personali~ World of Warcraft  VALORANT                                  5.1
##  8     8 tarik            English  personali~ VALORANT           Counter-Strike                            7.6
##  9     9 riotgames        English  esports    League of Legends  League of Legends: Wi~                    8.5
## 10    10 papaplatte       German   personali~ Just Chatting      Minecraft                                 7.6
## 11    11 dota2_paragon_ru Russian  personali~ Dota 2             <NA>                                     10.7
## 12    12 aminematue       French   personali~ Grand Theft Auto V Just Chatting                             4.3
## 13    13 kato_junichi0817 Japanese personali~ Apex Legends       VALORANT                                  6.3
## 14    14 fps_shaka        Japanese personali~ PUBG: BATTLEGROUN~ Apex Legends                              9.6
## 15    15 illojuan         Spanish  personali~ Just Chatting      Minecraft                                 4.5
## 16    16 hasanabi         English  personali~ Just Chatting      Grand Theft Auto V                        7.4
## 17    17 montanablack88   German   personali~ Just Chatting      Fortnite                                  4.8
## 18    18 playapex         English  esports    Apex Legends       Variety                                   5.3
## 19    19 lolpacifictw     Chinese  esports    League of Legends  <NA>                                      5.6
## 20    20 pgl_dota2        English  esports    Dota 2             <NA>                                     10.2
## # i abbreviated names: 1: `2ND_MOST_STREAMED_GAME`, 2: AVERAGE_STREAM_DURATION
## # i 10 more variables: FOLLOWERS_GAINED_PER_STREAM <dbl>, AVG_VIEWERS_PER_STREAM <dbl>,
## #   AVG_GAMES_PER_STREAM <dbl>, TOTAL_TIME_STREAMED <dbl>, TOTAL_FOLLOWERS <dbl>, TOTAL_VIEWS <dbl>,
## #   TOTAL_GAMES_STREAMED <dbl>, ACTIVE_DAYS_PER_WEEK <dbl>, MOST_ACTIVE_DAY <chr>,
## #   DAY_WITH_MOST_FOLLOWERS_GAINED <chr>
```


``` r
miss_var_summary(data_twitch)
```

```
## # A tibble: 17 x 3
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
```

The dataset has **999 rows and 17 variables**, and the column types are correctly defined.

Only one variable has missing values (`n_miss`): **2ND_MOST_STREAMED_GAME**. That makes sense: some streamers only ever play one game, so there is no second game. To make the column names easier to work with, I rename `2ND_MOST_STREAMED_GAME` (names starting with a digit are awkward in R), convert all names to lower case, and replace the missing values with the label **No second game**.


``` r
data_twitch <- rename(data_twitch, SECOND_MOST_STREAMED_GAME = `2ND_MOST_STREAMED_GAME`)
names(data_twitch) <- str_to_lower(names(data_twitch))

data_twitch <- data_twitch %>%
  mutate(second_most_streamed_game = replace_na(second_most_streamed_game, "No second game"))
```

Check that the change was applied:


``` r
data_twitch %>%
  filter(second_most_streamed_game == "No second game") %>%
  summarise(streamers_without_second_game = n())
```

```
## # A tibble: 1 x 1
##   streamers_without_second_game
##                           <int>
## 1                            77
```


``` r
miss_var_summary(data_twitch)
```

```
## # A tibble: 17 x 3
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
```

There are no missing values left, so the exploratory analysis can start.
