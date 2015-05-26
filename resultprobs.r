ResultProbs <- function(probs) {
  R <- matrix(0,3,1)
  n <- length(probs)
  for(i in 1:n) {
    for(j in 1:n) {
      if(i > j) {
        R[3] <- R[3] + probs[i,j]
      } else {
        if(i == j) {
          R[2] <- R[2] + probs[i,j]
        } else {
          R[1] <- R[1] + probs[i,j]
        }
      }
    }
  }
  return(list(HomeWin=R[1], Draw=R[2], AwayWin=R[3]))
}