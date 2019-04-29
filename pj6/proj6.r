# Read the prostate cancer data
pc <- read.csv('prostate_cancer.csv', header=T)
str(pc)
attach(pc)

# Look at distributions of the predictors
table(cancervol)
table(weight)
table(age)
table(benpros)
table(vesinv)
table(capspen)
table(gleason)

boxplot(age, main="Patient's Age")
plot(age,cancervol)

# Look at relationships b/w response & each predictor one by one
plot(cancervol, psa)
fit1 <- lm(psa ~ cancervol, data = pc)
abline(fit1)

plot(weight, psa)
fit2 <- lm(psa ~ weight, data = pc)
abline(fit2)

plot(age, psa)
fit3 <- lm(psa ~ age, data = pc)
abline(fit3)

plot(benpros, psa)
fit4 <- lm(psa ~ benpros, data = pc)
abline(fit4)

plot(factor(vesinv), psa)
fit5 <- lm(psa ~ factor(vesinv), data = pc)
abline(fit5)

plot(capspen, psa)
fit6 <- lm(psa ~ capspen, data = pc)
abline(fit6)

plot(gleason, psa)
fit7 <- lm(psa ~ gleason, data = pc)
abline(fit7)

## From plots we can see relatively strong positive trends 
## on fit1, fit5, fit6 and fit7. Thus we suspect the predictors 
## on them to be important.
fit8 = lm(psa ~ cancervol + factor(vesinv) + capspen + gleason, data=pc)

## What if we drop one?
# drop 'capspen'
fit9 = lm(psa ~ cancervol + factor(vesinv) + gleason, data=pc)
anova(fit8, fit9)

## What if we drop 'gleason'?
# drop 'gleason'
fit10 = lm(psa ~ cancervol + factor(vesinv), data=pc)
anova(fit9, fit10)

## Can we drop any further?
fit11 = lm(psa ~ cancervol, data=pc)
anova(fit10, fit11)

fit12 = lm(psa ~ factor(vesinv))
anova(fit10, fit12)

#### Automatic stepwise models ####
# forward
fit13 <- step(
	lm(psa ~ 1, data = pc), 
	scope = list(upper = ~ cancervol + weight + age + benpros + 
		factor(vesinv) + capspen + gleason), 
	direction = "forward"
)

# backward
fit14 <- step(
	lm(psa ~ cancervol + weight + age + benpros + 
		factor(vesinv) + capspen + gleason, data = pc), 
	scope = list(lower = ~ 1), 
	direction = "backward"
)

# both
fit15 <- step(
	lm(psa ~ 1, data=pc), 
	scope = list(lower = ~ 1, upper = ~cancervol + weight + age + benpros + 
		factor(vesinv) + capspen + gleason), 
	direction = "both"
)

# ANOVA Test
anova(fit13, fit14)
anova(fit13, fit15)

### The final model is psa ~ cancervol + factor(vesinv)

## Let's test our model for model assumptions.

# Residual Plot
plot(fitted(fit10), resid(fit10))
abline(h = 0)

# QQ-Plot
qqnorm(resid(fit10))
qqline(resid(fit10))

## There're outliers, so do a log transformation
y = log(psa)
fit16 = lm(y ~ cancervol + factor(vesinv))

# Residual Plot (AFTER LOG TRANSFORMATION)
plot(fitted(fit16), resid(fit16))
abline(h = 0)

## QQ-Plot (AFTER LOG TRANSFORMATION)
qqnorm(resid(fit16))
qqline(resid(fit16))

# looks much better! Let's see the slope and the intercept.
summary(fit16)

###################################### Let's predict!
# Find mean of 'cancervol'
x1 = mean(cancervol)

# Find the most frequent element in 'vesinv'
vesinv.t = table(factor(vesinv))
x2 = names(which.max(vesinv.t))

# Get the beta0, beta1, and gamma, then choose ‘vesinv’ = ‘0’ as base category
beta0 = 1.80346
beta1 = 0.07249
prediction = beta0 + beta1 * x1






























