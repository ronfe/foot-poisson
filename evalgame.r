EvalGame <- function(home, away){
  game <- Games(parameter)
  match <- game[which(game$V1 == home & game$V2 == away),]
  predScore <- paste(match$V3, match$V4, sep='-')
  probs <- ProbTable(parameter, home, away)
  resProbs <- ResultProbs(probs)
  a <- which.max(c(resProbs$HomeWin, resProbs$Draw, resProbs$AwayWin))
  b <- c('W', 'D', 'L')
  predRes <- b[a]
  re <- list(paste(home, away, predScore, predRes, sep=','), probs)
  return(re)
}