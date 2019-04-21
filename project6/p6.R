crime <- read.csv("C:/Users/fxl/Desktop/6313/project6/crime.csv")
View(crime)
str(crime)
attach(crime)
fit <- lm(formula = murder.rate ~ poverty + high.school + college + single.parent + unemployed + metropolitan + region)
summary(fit)

par(mfrow=c(1,2))
plot(fitted(fit), resid(fit), main = 'fit')
abline(h=0)
qqnorm(resid(fit), main = 'fit')
qqline(resid(fit), main = 'fit')

fit1 <- lm(formula = murder.rate ~  single.parent + metropolitan + region)
anova(fit1, fit)
summary(fit1)
par(mfrow=c(1,2))
plot(fitted(fit1), abs(resid(fit1)))
qqnorm(resid(fit1))
qqline(resid(fit1))

single <- crime$single.parent
metro <- crime$metropolitan
region <- crime$region

single_mean <- mean(single)
metro_mean <- mean(metro)
region_freq <- sort(table(region),decreasing = TRUE)[1]

x.new <- data.frame(single.parent=single_mean,metropolitan=metro_mean,region='South')
predict(fit1,newdata = x.new)

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