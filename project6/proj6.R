crime <- read.csv("C:/Users/fxl/Desktop/6313/project6/crime.csv")
View(crime)
str(crime)
attach(crime)
fit <- lm(formula = murder.rate ~ poverty + high.school + college + single.parent + unemployed + metropolitan + region)
summary(fit)
plot(fitted(fit), resid(fit), main = 'fit')
abline(h=0)
y <- log10(murder.rate)
fit1 <- update(fit, y ~ .)
summary(fit1)
plot(fitted(fit1), resid(fit1), main="fit1")
abline(h=0)
par(mfrow=c(1,2))
qqnorm(resid(fit1), main = 'fit1')
qqline(resid(fit1), main = 'fit1')
qqnorm(resid(fit), main = 'fit')
qqline(resid(fit), main = 'fit')

hist(resid(fit), main='fit')
hist(resid(fit2), main='fit1')


# region
fit2 <- lm(formula = y ~ poverty +  high.school + college + single.parent + unemployed + metropolitan)
anova(fit2, fit1)

# poverty
fit3 <- lm(formula = y ~ high.school + college + single.parent + unemployed + metropolitan + region)
anova(fit3, fit1)
summary(fit3)

# high.school
fit4 <- lm(formula = y ~  college + single.parent + unemployed + metropolitan + region)
anova(fit4, fit3)
summary(fit4)

# college
fit5 <- lm(formula = y ~  single.parent + unemployed + metropolitan + region)
anova(fit5, fit4)
summary(fit5)

# UNEMPLOYED
fit6 <- lm(formula = y ~  single.parent + metropolitan + region)
anova(fit6, fit5)
summary(fit6)



fit10.forward <- step(lm(y ~ 1, data = crime), 
                      scope = list(upper = ~poverty + high.school + college + single.parent + unemployed + metropolitan + region),
                      direction = "forward")

fit11.backward <- step(lm(y ~ poverty + high.school + college + single.parent + unemployed + metropolitan + region, data = crime), 
                       scope = list(lower = ~1), direction = "backward")

fit12.both <- step(lm(y ~ 1, data = crime), 
                   scope = list(lower = ~1, upper = ~poverty + high.school + college + single.parent + unemployed + metropolitan + region),
                   direction = "both")

anova(fit6, fit1)

anova(fit6, fit12.both)

plot(fitted(fit6), resid(fit6))
abline(h = 0)

# plot of absolute residuals

plot(fitted(fit6), abs(resid(fit6)))

# normal QQ plot
qqnorm(resid(fit6))
qqline(resid(fit6))