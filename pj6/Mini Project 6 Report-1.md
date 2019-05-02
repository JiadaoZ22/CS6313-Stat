# Mini Project 6 Report
**Jiadao Zou:  jxz172230**
**Houyi Liu:  hxl163630**
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
![-w367](media/15564789118411/15567820234563.jpg)
**As we could see, the original distribution is not good cause there are many outliers and two tails are not balanced.**

- > Then, we plot the Natural Log distribution of PSA and have a look
```
boxplot(log(data$psa), main="Distribution Graph of Log of PSA levels")
```
![-w367](media/15564789118411/15567820462077.jpg)
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
plot(data$cancervol, y, main="Transformed PSA level && cancervol")
fit1 <- lm(y ~ cancervol, data = data)
abline(fit1)
summary(fit1)
```    
![-w369](media/15564789118411/15567821790713.jpg)
![-w421](media/15564789118411/15567820912141.jpg)
   <!--2-->
> - Transformed PSA level && "Weight"
> 
```
plot(data$weight, y, main="Transformed PSA level && weight")
fit2 <- lm(y ~ weight, data = data)
abline(fit2)
summary(fit2)
```   
![-w369](media/15564789118411/15567822442947.jpg)
![-w426](media/15564789118411/15567822544936.jpg)
> - Transformed PSA level && "Age"
> 
```
plot(data$age, y, main="Transformed PSA level && Age")
fit3 <- lm(y ~ age, data = data)
abline(fit3)
summary(fit3)
```   
![-w370](media/15564789118411/15567823318358.jpg)
![-w421](media/15564789118411/15567822916611.jpg)
> - Transformed PSA level && "Benpros"
> 
```
plot(data$benpros, y, main="Transformed PSA level && Benpros")
fit4 <- lm(y ~ benpros, data = data)
abline(fit4)
summary(fit4)
```   
![-w372](media/15564789118411/15567823105471.jpg)
![-w420](media/15564789118411/15567823589177.jpg)
> - Transformed PSA level && "Capspen"
> 
```
plot(data$capspen, y, main="Transformed PSA level && Capspen")
fit5 <- lm(y ~ capspen, data = data)
abline(fit5)
summary(fit5)
```   
![-w370](media/15564789118411/15567824472659.jpg)
![-w424](media/15564789118411/15567824577317.jpg)
> - Transformed PSA level && "Gleason"
> 
```
plot(data$gleason, y, main="Transformed PSA level && Gleason")
fit6 <- lm(y ~ gleason, data = data)
abline(fit6)
summary(fit6)
```
![-w370](media/15564789118411/15567825170815.jpg)
![-w415](media/15564789118411/15567825274326.jpg)
> - Transformed PSA level && "vesinv"
> 
```
plot(data$vesinv, y, main="Transformed PSA level && Vesinv")
fit7 <- lm(y ~ vesinv, data = data)
abline(7)
summary(fit7)
```
![-w370](media/15564789118411/15567825943392.jpg)
![-w420](media/15564789118411/15567826043757.jpg)
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
![-w426](media/15564789118411/15567826505891.jpg)
    We could see that "capspen" is not significant. To verify it, we should use ANOVA table:
    ```
    fit9 <- lm(y ~ cancervol + factor(vesinv) + gleason, data=data)
    anova(fit8, fit9)
    ```
![-w412](media/15564789118411/15567827447361.jpg)
    Since the P-value is $\gg 0.05$, it indicates "capspen" is insignificant. **Also, we want to make sure the features we drop at the very beginning are really unimportant.**
    ```
    fit10 <- lm(y ~ cancervol + weight + factor(vesinv) + gleason, data=data)
    anova(fit10, fit9)
    ```
![-w430](media/15564789118411/15567827732542.jpg)
    ```
    fit11 <- lm(y ~ cancervol + age +factor(vesinv) + gleason, data=data)
    anova(fit11, fit9)
    ```
   ![-w373](media/15564789118411/15567828163012.jpg)
```
fit12 <- lm(y ~ cancervol + benpros + factor(vesinv) + gleason, data=data)
anova(fit12, fit9)
```
![-w435](media/15564789118411/15567828386406.jpg)
**From the above images, anova shows "benpros" is important. Which means the feature we should use to construct the linear model are {cancervol, benpros, vesinv, gleason}, and we could see the final model as below:**
```
myfit <- fit12
(myfit)
```
![-w557](media/15564789118411/15567829307732.jpg)
So, the mathematics question:
$ln(PSA)=-0.65013+0.06488*cancervol+0.09136*benpros+0.6842(vesinv=1)+0.33376*gleason$ 
- > **Analyse our model**
> - Now, plot the residual graph for the linear model we build:
> 
```
plot(fitted(myfit), resid(myfit), main="Residual Plot")
abline(h=0)
```
> ![-w368](media/15564789118411/15567830339936.jpg)
> Resident points are scattered around zero and there is no obvious pattern of these points.
> 
> - Now, plot the Normal Q-Q plot for the linear model we build:
> 
```
qqnorm(resid(myfit))
qqline(resid(myfit))
```
> ![-w434](media/15564789118411/15567830716128.jpg)
> From above plot,  It’s good if residuals are lined well on the straight dashed line. In other words, residual points are approximately around the straight line which means the errors are normally distributed.  
> 
> - Then, we take a look at time series plot:
> 
```
plot(resid(myfit), type="1", main="Time Series Plot")
abline(h=0)
```
> ![-w434](media/15564789118411/15567832256182.jpg)
> From that series plot, we could not see there is obvious pattern between time interval and residual points. That shows out model is good because errors are independent.
>
- > **Final step, comparing our model with AIC generated models**
> - Backward AIC:
> 
```
myfit.backward <- step(lm(y ~ cancervol + weight + age + benpros + factor(vesinv) + capspen + gleason, data=data), scope = list(lower = ~-1), direction = "backward")
```
![-w356](media/15564789118411/15567833392090.jpg)
> - Forward AIC:
> 
```
myfit.forward <- step(lm(y ~ 1, data=data), scope = list(upper = ~cancervol + weight + age + benpros + factor(vesinv) + capspen + gleason), direction = "forward")
```
![-w349](media/15564789118411/15567833763660.jpg)
> - Both AIC:
> 
```
myfit.both <- step(lm(y ~ cancervol + weight + age + benpros + factor(vesinv) + capspen + gleason, data=data), scope = list(upper = ~cancervol + weight + age + benpros + factor(vesinv) + capspen + gleason), direction = "both")
```
![-w340](media/15564789118411/15567835181854.jpg)
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
PSA_log_response <- predict(myfit, arguments)
exp(PSA_log_response)
```
![-w89](media/15564789118411/15564929308361.jpg)
So the predicted PSA level is 10.2835.  

## Contribution
> Jiadao Zou: Report Writing, Coding
> Houyi Liu: Coding, Screen Shooting








 
    



