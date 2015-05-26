Games <- function(parameters) {
  teams <- rownames(parameters$teams)
  P <- parameters$teams
  home <- parameters$home
  n <- length(teams)
  C <- data.frame()
  row <- 1
  for (i in 1:n) {
    for (j in 1:n) {
      if (i != j) {
        C[row,1] <- teams[i]
        C[row,2] <- teams[j]
        C[row,3] <- rpois(1, exp(P[i,]$Attack - P[j,]$Defence + home))
        C[row,4] <- rpois(1, exp(P[j,]$Attack - P[i,]$Defence))
        row <- row + 1
      }
    }
  }
  return(C)
}