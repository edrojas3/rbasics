add.groups = function (df, groups, cnames) {
  for (ii in 1:length(groups)){
    g = rep(groups[ii], times=nrow(df))
    df[, cnames[ii]] = g
  } 
  
  return(df)
}

get.groups = function(filename){
  name_split = unlist(strsplit(filename, "-"))
  membrana = name_split[1]
  muestra = substr(name_split[2], 1, nchar(name_split[2])-4) 
  
  return(c(membrana, muestra))
}

append.dfs = function(df_dir){
  DF = data.frame(X = double(),
                  Area = double(),
                  Slice = double(),
                  Length = double(),
                  membrana = factor(),
                  grupo = factor())
  
  files = list.files(df_dir, pattern = "\\csv?")
  print("Se encontraron los sig. archivos:")
  print(files)
  
  for (ii in files) {
    contador = paste("Procesando: ", ii, "...")
    print(contador)
    
    fname = paste(df_dir, ii, sep="/")
    df = read.csv(fname)
    grupos = get.groups(ii)
    cnames = c("membrana", "muestra")
    df = add.groups(df, grupos, cnames)
    
    if (is.na(match("Length", colnames(df)))) {
      mensaje = paste("No se encontraron datos en", ii, sep=" ")
      print(mensaje)
      break
    }

    DF = rbind(DF,df)

  }
  
  print("TERMINADO")
  return(DF)
}



