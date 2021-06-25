# Uso: h = compare2artists(artist1, artist2)
# 
# La función toma dos métricas de spotify para dos artistas y grafica un diagrama de dispersión y la distribución de cada métrica en los márgenes.
#
# INPUTS
# obligatorios:
#    1. artista1: string con el nombre del primer artista o banda
#    2. artista2: string con el nombre del segundo artista o banda 
# opcionales:
#    x: métrica a graficar en el eje x. Default = "valence".
#    y: métrica a graficar en el eje x. Default = "energy".
#           otras opciones son:
#             * danceability
#             * loudness
#             * speechiness
#             * acousticness
#             * instrumentalness
#             * liveness
#    colorvalues: vector de 2 elementos con los colores para usar en la gráfica. Default = c("#d8b365","#5ab4ac").
#    id: client-id de la API de spotify for developers.
#    secret: client-secret de la app
#
# Outputs:
#   h: objeto de ggplot con la gráfica

 
compare2artists = function(artist1, artist2, 
                           x="valence", y="energy",
                           colorvalues=c("#d8b365","#5ab4ac"),
                           id='',
                           secret=''){
  # librería necesarias
  library(spotifyr) # para acceder a los datos de spotify
  # library(dplyr)    
  library(ggplot2) # para graficar diagramas de dispersión
  library(ggExtra) # para añadir distribuciones en los márgenes
  
  # Autentificación
  Sys.setenv(SPOTIFY_CLIENT_ID = id)
  Sys.setenv(SPOTIFY_CLIENT_SECRET = secret)
  
  access_token <- get_spotify_access_token()
  
  # Obtener características de audio de 
  a1 = get_artist_audio_features(artist1)
  a2 = get_artist_audio_features(artist2)
  
  # Reducir la base de datos a las columnas necesarias
  a1_sub = dplyr::select(a1, artist_name, x, y)
  a2_sub = dplyr::select(a2, artist_name, x, y)
  
  # Juntar las bases de datos para graficar
  A = rbind(a1_sub, a2_sub)
  
  # Graficar
  h  = ggplot(A, aes(A[,x], A[,y], color=artist_name)) + 
          geom_point() + # diagrama de dispersión
          scale_color_manual(values = colorvalues) + # definir colores a usar
          labs(x=x, y=y) + # etiquetas del eje x  y
          theme(legend.position = "bottom", 
            legend.title = element_blank())
  
  h = ggMarginal(h, groupColour = T, groupFill = T) # añade distribuciones a los márgenes
  
  return (h) # define el objeto gráfico cómo output de la función
    
}