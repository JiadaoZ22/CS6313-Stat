# Mini Project 2 Report
Jiadao Zou
jxz172230
## Q1
1. **(12 points) Consider the dataset roadrace.csv posted on eLearning. It contains observations on 5875 runners who finished the 2010 Beach to Beacon 10K Road Race in Cape Elizabeth, Maine. You can read the dataset in R using read.csv function.**
    - (a) **Create a bar graph of the variable Maine, which identifies whether a runner is from Maine or from somewhere else (stated using Maine and Away). You can use barplot function for this. What can we conclude from the plot? Back up your conclusions with relevant summary statistics.**
        - Figure: please see the ```Code Section P1.a```.
        - As we can see, far more runners are from Maine instead of somewhere else. They are barely 3 to 1.  

    - (b) **Create two histograms the runners’ times (given in minutes) — one for the Maine group and the second for the Away group. Make sure that the histograms on the same scale. What can we conclude about the two distributions? Back up your conclusions with relevant summary statistics, including mean, standard deviation, range, median, and interquartile range.**
        - Figure and Summary Statistic: please see the ```Code Section P1.b```.
        - At the first glance, the two group of data have a very similar going. Their means are both around 3000 seconds. However, we should notice that the y axis value of these two histograms are different that indicts the difference of their total number of runner.  
        
    - (c) **Repeat (b) but with side-by-side boxplots.**
        - Figure and Summary Statistic: please see the ```Code Section P1.c```.
        - By observing the boxplots, we could see the similarity mentioned in the previous answer. So we could conclude that runners from different places don't have an obvious difference in performance. So, location may not be the case of running time.
    - (d) **Create side-by-side boxplots for the runners’ ages (given in years) for male and female runners. What can we conclude about the two distributions? Back up your conclusions with relevant summary statistics, including mean, standard deviation, range, median, and interquartile range.**
        - Figure and Summary Statistic: please see the ```Code Section P1.d```.  
        - As we can see, generally speaking, the male runner group is a bit older than the female runner group (from median), also most of the runner are within 30-50 years old while from Q3 and Maximum we could conclude that men participants could be beyond almost 10 years older than the eldest female participants though Q1 and Minimum shows that both young men and women are all tend to participate running. Last, there are several outlier in female sets which indicates there still exist some women who are agile than most of their peers.

1. **(8 points) Consider the dataset motorcycle.csv posted on eLearning. It contains the number of fatal motorcycle accidents that occurred in each county of South Car- olina during 2009. Create a boxplot of data and provide relevant summary statistics. Discuss the features of the data distribution. Identify which counties may be con- sidered outliers. Why might these counties have the highest numbers of motorcycle fatalities in South Carolina?**  

    - Figure and Summary Statistic: please see the ```Code Section P2```. (One of the boxplots is very large and I have to compress them to get printed, so the displaying may hurt)
    - From the boxplots, we could see the median is around 14 accidents/year, the variance is inside a reasonable field. However, there are two counties beyond Maximum that we could take them as anomalous values. So, we could see ```GREENVILLE and HORRY``` are the outlier. The reasons why they have the highest numbers of motorcycle fatalities may due to the poor rider's capability (motor-lincense is too easy to get), road situation too bad and car drivers' lacking of awareness of riders, or maybe they just simply have far more riders than other county.
    