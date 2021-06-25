# función para números primos

# USO: p = es.primo(n)

# entradas:
# n: número a evaluar 

# salidas:
# p: valor lógico. TRUE = n es primo

es.primo = function(n) {
  
  if (n == 2){
    resultado = TRUE
  } else if (n %% 2 == 0) {
    resultado = FALSE
  } else {
    resultado = TRUE
    for (ii in 2:round(n/2)) {
      if (n %% ii == 0) {
        resultado = FALSE
      }
    }
  }
  
  return(resultado)
}

mul2num= function(num1, num2) {
  return(num1*num2)
}


