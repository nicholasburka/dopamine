#install.packages("runjags")
library(runjags)

n.inputs <- 25 #divisible by 5
n.reward <- 10 #the number of "dopamine neurons"
n.outputs <- 1

###
sigmoid.activation <- function(x) {
  return (1/(1 + exp(-x)))
}
###
gen.training.exclus <- function(num.each) {
  num.types <- 5
  data <- list(
    input=matrix(data=0,nrow=n.inputs,ncol=num.each*num.types),
    output=rep(0, num.types*num.each) #output is the probability of reward
  )
  
  stims <- sample(0:4, num.each*num.types, replace=TRUE)
  
  for (i in 1:length(stims)) {
    #indexing: change the 5 units in the current input column to 1
    data$input[(stims[i]*num.types+1):(stims[i]*num.types+num.types),i] <- rep(1, num.types)
    data$output[i] <- stims[i]/(num.types-1)
  }
  
  return (data)
}
###
training <- gen.training.exclus(5)

#input.reward.w <- matrix(rnorm(n.inputs*n.reward,mean=0,sd=1), nrow=n.inputs, ncol=n.reward)
#reward.output.w <- matrix(rnorm(n.reward*n.outputs,mean=0,sd=1), nrow=n.reward, ncol=n.outputs)


a<- c(1,2,3,4,5)
a[4:6] <- c(1,2,3)

jags.data <- list(
  n.inputs=n.inputs,
  n.reward=n.reward,
  n.outputs=n.outputs,
  input=training$input,
  output=training$output
)

result <- run.jags('feedforward.txt', monitor=c('ro.mu'), data=jags.data, n.chains=3, burnin=1000, sample=10000)