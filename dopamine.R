#install.packages("runjags")
library(runjags)

###

n.inputs <- 30

#the number of dopamine neurons
n.reward <- 10

n.outputs <- 1

input.reward.w <- matrix(rnorm(n.inputs*n.reward,mean=0,sd=1), nrow=n.inputs, ncol=n.reward)
reward.output.w <- matrix(rnorm(n.reward*n.outputs,mean=0,sd=1), nrow=n.reward, ncol=n.outputs)



j.model <- list(
  i.to.r=input.reward.w,
  r.to.o=reward.output.w
)