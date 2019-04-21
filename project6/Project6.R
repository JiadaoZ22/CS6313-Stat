#project6
cpu <- scan("C:\\Users\\Qi\\Desktop\\cpu.txt")
theta.hat <- log(mean(cpu))

#resample
theta.hat.star<-c()
for(i in 1:1000){
  theta.hat.star[i] <- log(mean(sample(cpu,30,replace = TRUE))) 
}
#estimate mean
theta.hat.bs <- mean(theta.hat.star)  

#estimate bias
bias.bs <- theta.hat.bs - theta.hat

#estimate standard error
se.bs <- sd(theta.hat.star)

#estimate percentile of theta.hat
a <- sort(theta.hat.star)
a2.5 <- a[25]
a97.5 <- a[975]

#estimate percentile of theta.hat-theta
a2.5d <- a2.5 -theta.hat
a97.5d <- a97.5 - theta.hat

#CI
#Normal approximation
ci1 <- theta.hat-bias.bs + c(-qnorm(1-0.025),-qnorm(0.025)) * se.bs
#Basic bootstrap
ci2 <- 2*theta.hat + c(-a97.5,-a2.5)
#Percentile bootstrap
ci3 <- c(a2.5,a97.5)

#plot
hist(theta.hat.star,breaks=30,probability=TRUE,main="1000 resampling", xlab = 'log of theta.hat', ylab = 'density' )
qqnorm(theta.hat.star)
qqline(theta.hat.star)

