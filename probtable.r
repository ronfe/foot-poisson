ProbTable <- function(parameters,hometeam,awayteam) {
  teams <- rownames(parameters$teams)
  P <- parameters$teams
  home <- parameters$home
  a <- which(teams == hometeam)
  b <- which(teams == awayteam)
  lambdaa <- exp(P[a,]$Attack - P[b,]$Defence + home)
  lambdab <- exp(P[b,]$Attack - P[a,]$Defence)
  A <- as.numeric()
  B <- as.numeric()
  for(i in 0:6) {
    A[(i+1)] <- dpois(i,lambdaa)
    B[(i+1)] <- dpois(i,lambdab)
  }
  A[8] <- 1 - sum(A[1:7])
  B[8] <- 1 - sum(B[1:7])
  name <- c("0","1","2","3","4","5","6","7+")
  zero <- mat.or.vec(8,1)
  C <- data.frame(row.names=name)
  for(j in 1:8) {
    for(k in 1:8) {
      C[j,k] <- A[k]*B[j]
    }
  }
  colnames(C) <- name
  return(round(C*100,2))
}