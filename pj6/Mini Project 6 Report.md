# Mini Project 6 Report
**Jiadao Zou
jxz172230**
## Question
Consider the prostate cancer dataset available on eLearning as prostate cancer.csv. It consists of data on 97 men with advanced prostate cancer. A description of the variables is given in Figure 1. We would like to understand how PSA level is related to the other predictors in the dataset. Note that vesinv is a qualitative variable. You can treat gleason as a quantitative variable.
Build a “reasonably good” linear model for these data by taking PSA level as the response variable. Carefully justify all the choices you make in building the model. Be sure to verify the model assumptions. In case a transformation of response is necessary, try the natural log transformation. Use the final model to predict the PSA level for a patient whose quantitative predictors are at the sample means of the variables and qualitative predictors are at the most frequent category.
![-w928](media/15564789118411/15564792451712.jpg)

# Answer
## Analyse
- > First we draw the boxplot of the PSA
```
# Read data
data <- read.csv("prostate_cancer.csv")
# boxplot drawing
boxplot(data$psa, main="Distribution Graph of PSA levels")
```
![-w277](media/15564789118411/15564804044773.jpg)
**As we could see, the original distribution is not good cause there are many outliers and two tails are not balanced.**

- > Then, we plot the Natural Log distribution of PSA and have a look
```
boxplot(log(data$psa), main="Distribution Graph of Log of PSA levels")
```
![-w274](media/15564789118411/15564805652646.jpg)
**This time, natural log transformation makes the distribution less skewed and reduce the number of outliers.   
Therefore, we should use transformed Distribution of PSA levels.**
```
y <- log(data$psa)
```

- > Next, we try to fit the response to each predictors left. Also, notice that "vesinv" is a qualitative variable and "gleason" is a quantitative value.
<!--1-->
- >
> -  Transformed PSA level && "cancervol"
> 
```
plot(data$cancervol, y, main="Transformed PSA level && cancervol)
fit1 <- lm(y ~ cancervol, data = data)
summary(fit1)
```    
![-w219](media/15564789118411/15564814884123.jpg)
![-w486](media/15564789118411/15564815110520.jpg)
   <!--2-->
> - Transformed PSA level && "Weight"
> 
```
plot(data$weight, y, main="Transformed PSA level && weight)
fit2 <- lm(y ~ weight, data = data)
summary(fit2)
```   
![-w214](media/15564789118411/15564831524924.jpg)
![-w503](media/15564789118411/15564831837218.jpg)
> - Transformed PSA level && "Age"
> 
```
plot(data$age, y, main="Transformed PSA level && Age)
fit3 <- lm(y ~ age, data = data)
summary(fit3)
```   
![-w222](media/15564789118411/15564833488449.jpg)
![-w538](media/15564789118411/15564833876968.jpg)
> - Transformed PSA level && "Benpros"
> 
```
plot(data$benpros, y, main="Transformed PSA level && Benpros)
fit4 <- lm(y ~ benpros, data = data)
summary(fit4)
```   
![-w225](media/15564789118411/15564835198034.jpg)
![-w505](media/15564789118411/15564834880343.jpg)
> - Transformed PSA level && "Capspen"
> 
```
plot(data$capsen, y, main="Transformed PSA level && Capsen)
fit5 <- lm(y ~ capsen, data = data)
summary(fit5)
```   
![-w231](media/15564789118411/15564838075987.jpg)
![-w508](media/15564789118411/15564841587944.jpg)
> - Transformed PSA level && "Gleason"
> 
```
plot(data$gleason, y, main="Transformed PSA level && Gleason)
fit6 <- lm(y ~ gleason, data = data)
summary(fit6)
```
![-w227](media/15564789118411/15564847123211.jpg)
![-w490](media/15564789118411/15564846969601.jpg)
> - Transformed PSA level && "vesinv"
> 
```
plot(data$vesinv, y, main="Transformed PSA level && Vesinv)
fit7 <- lm(y ~ vesinv, data = data)
summary(fit7)
```
![-w503](media/15564789118411/15564850080987.jpg)
<!--3-->  
- > From the above summary:
> - 
>**As we have seen, features: {cancervol, capspen, gleason and vesinv} are significant predictors because their t-test p-values are $\leq$ 0.05.**
>
> - Build a linear model with above significant predictors
> 
> 
```
fit8 <- lm(y ~ cancervol + factor(vesinv) + capspen + gleason, data=data)
summary(fit8)
```
![-w485](media/15564789118411/15564857775652.jpg)
    We could see that "capspen" is not significant. To verify it, we should use ANOVA table:
    ```
    fit9 <- lm(y ~ cancervol + factor(vesinv) + gleason, data=data)
    anova(fit8, fit9)
    ```
    ![-w540](media/15564789118411/15564860586996.jpg)
    Since the P-value is $\gg 0.05$, it indicates "capspen" is insignificant. **Also, we want to make sure the features we drop at the very beginning are really unimportant.**
    ```
    fit10 <- lm(y ~ cancervol + weight + factor(vesinv) + gleason, data=data)
    anova(fit10, fit9)
    ```
    ![-w497](media/15564789118411/15564863837231.jpg)
    ```
    fit11 <- lm(y ~ cancervol + age +factor(vesinv) + gleason, data=data)
    anova(fit11, fit9)
    ```
    ![-w419](media/15564789118411/15564864624380.jpg)
```
fit12 <- lm(y ~ cancervol + benpros + factor(vesinv) + gleason, data=data)
anova(fit12, fit9)
```
![-w459](media/15564789118411/15564866026619.jpg)
**From the above images, anova shows "benpros" is important. Which means the feature we should use to construct the linear model are {cancervol, benpros, vesinv, gleason}, and we could see the final model as below:**
```
fit12
```
![-w562](media/15564789118411/15564869361744.jpg)
So, the mathematics question:
$ln(PSA)=-0.65013+0.06488*cancervol+0.09136*benpros+0.6842(vesinv=1)+0.33376*gleason$ 
- > **Analyse our model**
> - Now, plot the residual graph for the linear model we build:
> 
```
plot(fitted(fit12), resid(fit12), main="Residual Plot")
abline(h=0)
```
> ![-w738](media/15564789118411/15564903408657.jpg)
> Resident points are scattered around zero and there is no obvious pattern of these points.
> 
> - Now, plot the Normal Q-Q plot for the linear model we build:
> 
```
qqnorm(resid(fit12))
qqline(resid(fit12))
```
> ![-w767](media/15564789118411/15564905236933.jpg)
> From above plot,  It’s good if residuals are lined well on the straight dashed line. In other words, residual points are approximately around the straight line which means the errors are normally distributed.  
> 
> - Then, we take a look at time series plot:
> 
```
plot(resid(fit9), type="1", main="Tine Series Plot")
abline(h=0)
```
> ![-w686](media/15564789118411/15564906649874.jpg)
> From that series plot, we could not see there is obvious pattern between time interval and residual points. That shows out model is good because errors are independent.
>
- > **Final step, comparing our model with AIC generated models**
> - Backward AIC:
> 
```
fit13.backward <- step(lm(y ~ cancervol + weight + age + benpros + factor(vesinv) + capspen + gleason, data=data), scope = list(lower = ~-1), direction = "backward")
```
![-w413](media/15564789118411/15564919781777.jpg)
> - Forward AIC:
> 
```
fit13.forward <- step(lm(y ~ 1, data=data), scope = list(upper = ~cancervol + weight + age + benpros + factor(vesinv) + capspen + gleason), direction = "forward")
```
![-w415](media/15564789118411/15564919031870.jpg)
> - Both AIC:
> 
```
fit13.forward <- step(lm(y ~ cancervol + weight + age + benpros + factor(vesinv) + capspen + gleason, data=data)), scope = list(upper = ~cancervol + weight + age + benpros + factor(vesinv) + capspen + gleason), direction = "both")
```
![-w417](media/15564789118411/15564919887429.jpg)
> - **Result of above three different stepwise model selection methods agree with our model.**
> 
- > **Predicting:**
> - concervol:
> 
```
concervol <- mean(data$concervol)
concervol
``` 
![-w122](media/15564789118411/15564926272525.jpg)
> - benpros:
> 
```
benpros <- mean(data$benpros)
benpros
```
![-w126](media/15564789118411/15564926842567.jpg)
> - vesinv:
> 
```
vesinv.t <- table(factor(data$vesinv))
vesinv <- names(which.max(vesinv.t))
vesinv
```
![-w84](media/15564789118411/15564927002121.jpg)
> - gleason
> 
```
gleason <- mean(data$gleason)
gleason
```
![-w133](media/15564789118411/15564926630910.jpg)
> - Predicting the response by current predictor and arguments
> 
```
arguments <- data.frame(cancervol: cancervol, benpros: benpros, vesinv: vesinv, gleason: gleason)
PSA_log_response <- predict(fit12, arguments)
exp(PSA_log_response)
```
![-w89](media/15564789118411/15564929308361.jpg)
So the predicted PSA level is 10.2835.








 
    



