Parameters <- function(games) {
  teams <- sort(unique(c(games[,1], games[,2])), decreasing = FALSE)
  n <- length(teams)
  g <- nrow(games)
  Y <- matrix(0,2*g,1)
  for (i in 1:g) {
    Y[((2*i)-1)] <- games[i,3]
    Y[(2*i)] <- games[i,4]
  }
  X <- matrix(0,2*g,((2*n)+1))
  for (i in 1:g) {
    M <- which(teams == games[i,1])
    N <- which(teams == games[i,2])
    X[((2*i)-1),M] <- 1
    X[((2*i)-1),N+n] <- -1
    X[(2*i),N] <- 1
    X[(2*i),M+n] <- -1
    X[((2*i)-1),((2*n)+1)] <- 1
  }
  XX <- X[,-1]
  parameters <- glm(formula = Y ~ 0 + XX, family = poisson)
  Z <- c(0, coefficients(parameters))
  P <- data.frame(row.names=teams, Attack=Z[1:n], Defence=Z[(n+1):(2*n)])
  return(list(teams=P,home=as.numeric(Z[2*n+1])))
}pa