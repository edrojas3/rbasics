# RECUERDA QUE TIENES QUE DARLE "source" A LOS ARCHIVOS EN DONDE ESTÁN LAS FUNCIONES.

# directorio de csv's
csvdir = "csv_files"

# Juntar los archivos
main_df = append.dfs(csvdir)

# remover 0's
main_df = main_df[main_df$Length > 0,]

# graficar
graph(main_df)
