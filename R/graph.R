graph = function(df, xlab="Tiempo (min)",
                 ylab="Longitud",
                 title="Tamaño ~ Tiempo"){
library(ggplot2)
  ggplot(df, aes(Slice, Length, color=membrana)) +
    geom_point()+
    geom_line() +
    labs(x = xlab, y = ylab, title = title) +
    facet_wrap(ncol=2, ~ muestra)
}