# Análisis Exploratorio de Datos en Twitch

## 📝 Contexto

En la última década, las plataformas de streaming han revolucionado la forma en que consumimos entretenimiento, brindando un medio interactivo y en tiempo real que conecta a creadores con sus audiencias. Entre todas ellas, Twitch se ha consolidado como el líder indiscutible en transmisiones en vivo, especialmente en el ámbito de los videojuegos. Durante la pandemia, la plataforma vivió un auge significativo en la cantidad de creadores y espectadores, y mi mejor amigo fue parte de este fenómeno. Lo que comenzó como un pasatiempo, transmitiendo videojuegos y construyendo una pequeña comunidad, con el tiempo se ha convertido en una pasión. Aunque aún no ha alcanzado la fama, sueña con transformar este hobby en su carrera profesional.

Siempre he sentido curiosidad por entender cómo funciona Twitch, y al ver el esfuerzo constante de mi amigo por destacar, decidí apoyarlo. Este proyecto busca analizar datos de la plataforma para identificar patrones, estrategias y comportamientos que puedan acelerar su crecimiento como streamer. Mi objetivo es responder la pregunta clave: "¿Cómo puede mi amigo aumentar sus posibilidades de ser reconocido y vivir de Twitch?". A través de un análisis detallado, mi intención es brindarle recomendaciones prácticas y basadas en evidencia que lo ayuden a alcanzar sus metas.

![](https://github.com/rolivaresIA/Data_Cleaning_Project/blob/main/Images/datacleaning.png)

## 📋 Descripción del Proyecto 

Este proyecto se centra en analizar datos del top 1000 streamers de Twitch, obviamente enfocado a la realidad de la comunidad de mi amigo. A través de técnicas de análisis exploratorio de datos (EDA), se identificaron patrones clave sobre duración de streams, juegos más populares, días de la semana con mayor actividad y otras métricas importantes. Con base en este análisis, se desarrollaron recomendaciones prácticas para optimizar el contenido y maximizar la exposición en la plataforma.

El proyecto utiliza R como herramienta principal para la manipulación de datos y visualización, y se organiza en tres etapas fundamentales:

1) Carga y limpieza de los datos.
2) Análisis exploratorio univariado.
3) Análisis exploratorio bivariado.

Por lo tanto, la lectura tanto de Notebooks, como Scripts debe ser en ese orden para tener mayor sentido.

## 🎯 Ojetivo del Proyecto

El objetivo principal es proporcionar una estrategia basada en datos para que mi amigo optimice su actividad como streamer. Esto incluye:

- Identificar los juegos más populares y efectivos para atraer su audiencia.
- Determinar los días y horas diarias óptimas para transmitir.
- Definir una duración promedio de streaming que maximice el alcance sin comprometer la atención del espectador.
- Analizar factores externos que pueden impulsar el crecimiento.

## 💡 Desarrollo del Proyecto

### Paso 1: Carga y limpieza de datos 🗃️

- **Fuente de los datos:** Los datos fueron obtenidos de [Kaggle](https://www.kaggle.com/datasets/hibrahimag1/top-1000-twitch-streamers-data-may-2024) en el dataset "Top 1000 Twitch Streamers Data"
- **Descripción:** El dataset incluye variables como `NAME`, `LANGUAGE`, `MOST_STREAMED_GAME`, `FOLLOWERS_GAINED_PER_STREAM`, `AVG_VIEWERS_PER_STREAM`,`TOTAL_TIME_STREAMED`,`MOST_ACTIVE_DAY`, entra otras. 
- **Formato:** [1 archivo](https://github.com/rolivaresIA/Data_Cleaning_Project/tree/main/original_databases) .CSV con un total de 999 observaciones y 17 variables.
- **Análisis y transformación de valores faltantes en las variables:** Se imputaron o eliminaron valores según su relevancia y distribución.
- **Filtrado:** A lo largo del proyecto, se define seleccionar únicamente los datos relevantes de la comunidad hispanohablante.

### Paso 2: Análisis Exploratorio Univariado 🔍

Se analizaron las distribuciones de variables clave para entender las características principales de los streamers. Algunos hallazgos incluyen:

- La duración promedio de streams mostró una gran concentración alrededor de **4-5 horas.**
- La cantidad de juegos transmitidos varía ampliamente, con algunos streamers diversificando más que otros.
- Juegos como **"Just Chatting"** y **"League of Legends"** son los más frecuentes entre los streamers hispanohablantes.

### Paso 3: Análisis Exploratorio Bivariado 📊

Se investigaron relaciones entre pares de variables para identificar correlaciones y patrones significativos. Entre ellas:

- Relación entre juegos más transmitidos y días de la semana.
- Análisis comparativo de los días: Respecto a mayores transmisiones, mayor cantidad de viewers, mayores seguidores obtenidos.
- Análisis de correlación en variable numéricas

## ✅ Conclusiones y Recomendaciones del Proyecto

**1) Duración de Streams:**
Aunque la duración promedio no mostró una correlación significativa con variables como espectadores o seguidores, los streams de 4 a 5 horas parecen ser óptimos para maximizar la exposición y mantener el interés del público.

**2) Juegos Más Populares:**
Juegos como Just Chatting, League of Legends y Grand Theft Auto V destacan como opciones clave para atraer audiencia. Además, juegos como Minecraft, FIFA 21 y Valorant presentan oportunidades estratégicas para el crecimiento, especialmente si se siguen estrategias de streamers exitosos.

**3) Días Estratégicos:**
Miércoles, jueves y domingo son los días con mayor actividad promedio, lo que los convierte en momentos ideales para transmitir y captar más audiencia.

**4)Relación con los Viewers:**
El crecimiento en vistas impulsa directamente el aumento de seguidores. Estrategias como promocionar el canal mediante clips en plataformas como TikTok y YouTube podrían ser fundamentales para aumentar la visibilidad.

**5) Diversificación:**
Alternar entre juegos populares y menos saturados, además de crear contenido en otras plataformas, puede ampliar la audiencia y fortalecer la comunidad.

El análisis demuestra que un enfoque basado en datos es crucial para destacar en el competitivo mundo del streaming. Con las recomendaciones obtenidas, mi amigo cuenta ahora con una estrategia clara para optimizar su contenido, aumentar su reconocimiento y acercarse a su meta de convertirse en un streamer destacado.
