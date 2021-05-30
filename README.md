# MechaCar Statistical Analysis
## Overview
### *Purpose*
Jeremy, an employee of AutosRUs, has been tasked with performing retrospective data analysis of historical data, analytical verification and validation of current automotive specifications, and study design of future product testing. Jeremy has asked for help reviewing production data on AutosRUs’ newest prototype, the MechaCar, which is suffering from production troubles that are blocking the manufacturing team’s progress. By assessing this data, upper management hopes to gain insights that may help the manufacturing team. Jeremy wishes to:
-	Perform multiple linear regression analysis to identify which variables in the dataset predict the mpg of MechaCar prototypes
-	Collect summary statistics on the pounds per square inch (PSI) of the suspension coils from the manufacturing lots
-	Run t-tests to determine if the manufacturing lots are statistically different from the mean population
-	Design a statistical study to compare vehicle performance of the MechaCar vehicles against vehicles from other manufacturers

# Analysis
## Linear Regression to Predict MPG
To begin, I downloaded the “MechaCar_mpg.csv” file and placed it in the active directory for my R session. Then, I created a new RScript and named it “MechaCarChallenge.R” and saved it to my active directory. Within my new RScript, I used the library() function to load the dplyr package. Subsequently, I imported and read in the MechaCar_mpg.csv file as a DataFrame:
```
# Load dplyr package
library(dplyr)

# Import and read in the MechaCar_mpg.csv file
MechaCar <- read.csv(file = 'MechaCar_mpg.csv',check.names = F,stringsAsFactors = F)
```
After the data was imported, I performed the linear regression, passing all six variables from the MechaCar DataFrame into the lm() function and setting the MechaCar DataFrame equal to the data parameter:
```
# Perform linear regression
lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD,data=MechaCar)
```
Next, I used the summary() function to determine the p-value and r-squared value for the linear regression model:
```
# Determine the p-value and r-squared value of linear regression model
summary(lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD,data=MechaCar))
```
The output looked as follows:
![Linear_Regression.png]( https://github.com/kcharb7/MechaCar_Statistical_Analysis/blob/main/Images/Linear_Regression.png)

### *Summary*
1.	Which variables/coefficients provided a non-random amount of variance to the mpg values in the dataset?
According to the output, vehicle_length and ground_clearance provided a non-random amount of variance to the mpg values in the dataset. This suggests that vehicle length and ground_clearance have a significant impact on mpg values. Alternately, vehicle_weight, spoiler_angle, and AWD provided a random amount of variance and were not significantly associated with mpg values.
2.	Is the slope of the linear model considered to be zero? Why or why not?
The p-value of the linear model is less than our assumed significance level of 0.05, and thus the slope of the linear model is not zero.
3.	Does this linear model predict mpg of MechaCar prototypes effectively? Why or why not?
The r-squared value is 0.71, indicating that approximately 71% of the variability of mpg values is explained by the linear model. While a model with 71% predictability is fairly good, there are likely other variables not included within this dataset that may better predict mpg values.
## Summary Statistics on Suspension Coils
I downloaded the “Suspension_Coil.csv” file and placed it in the active directory of my R session. Then, I imported and read the file in my RScript as a table:
```
# Import and read in the Suspension_Coil.csv file
SuspensionCoils <- read.csv(file = 'Suspension_Coil.csv',check.names = F,stringsAsFactors = F)
```
After the data was imported, I created a DataFrame containing the mean, median, variance, and standard deviation of the SuspensionCoil’s PSI column using the summarize() function:
```
# Create a total_summary DataFrame
total_summary <- SuspensionCoils %>% summarize(Mean=mean(PSI), Median=median(PSI), Variance=var(PSI), SD=sd(PSI))
```
The total_summary DataFrame looked as follows:
![total_summary.png]( https://github.com/kcharb7/MechaCar_Statistical_Analysis/blob/main/Images/total_summary.png)
Next, I created a lot_summary DataFrame with each manufacturing lot grouped by the mean, median, variance, and standard deviation of the SuspensionCoil’s PSI column using the group_by() function and the summarize() function:
```
# Create a lot_summary DataFrame
lot_summary <- SuspensionCoils %>% group_by(Manufacturing_Lot) %>% 
  summarize(Mean=mean(PSI), Median=median(PSI), Variance=var(PSI), SD=sd(PSI))
```
The lot_summary DataFrame looked as follows:
![lot_summary.png]( https://github.com/kcharb7/MechaCar_Statistical_Analysis/blob/main/Images/lot_summary.png)
### *Summary*
1.	The design specifications for the MechaCar suspension coils dictate that the variance of the suspension coils must not exceed 100 pounds per square inch. Does the current manufacturing data meet this design specification for all manufacturing lots in total and each lot individually? Why or why not?
According to the summary statistics, all manufacturing lots in total meet this design specification with a variance of 62.29 pounds per square inch. However, when looking at each manufacturing lot individually, Lot 3 does not meet this design specification as their variance is equal to 170.29 pounds per square inch. Lot 1 and Lot 2 have variances of 0.98 and 7.47 pounds per square inch, respectively. 
## T-Tests on Suspension Coils
I performed a one-sample t-test using the t.test() function to determine if the PSI across all manufacturing lots was statistically different from the population mean of 1,500 pounds per square inch:
```
# Determine if PSI of all manufacturing lots is different from population mean
t.test(SuspensionCoils$PSI,mu=1500)
```
The output look as follows:
![all_lots_t-test.png]( https://github.com/kcharb7/MechaCar_Statistical_Analysis/blob/main/Images/all_lots_t-test.png)
I performed three additional one-sample t-tests using the t.test() function and its subset() argument to determine if the PSI for each manufacturing lot was statistically different from the population mean of 1,500 pounds per square inch:
```
# Determine if PSI of Lot 1 is different from population mean
t.test(subset(SuspensionCoils, Manufacturing_Lot=="Lot1")$PSI,mu=1500)

# Determine if PSI of Lot 2 is different from population mean
t.test(subset(SuspensionCoils, Manufacturing_Lot=="Lot2")$PSI,mu=1500)

# Determine if PSI of Lot 3 is different from population mean
t.test(subset(SuspensionCoils, Manufacturing_Lot=="Lot3")$PSI,mu=1500)
```
The outputs looked as follows:
![Lot1_t-test.png]( https://github.com/kcharb7/MechaCar_Statistical_Analysis/blob/main/Images/Lot1_t-test.png)

![Lot2_t-test.png]( https://github.com/kcharb7/MechaCar_Statistical_Analysis/blob/main/Images/Lot2_t-test.png)

![Lot3_t-test.png]( https://github.com/kcharb7/MechaCar_Statistical_Analysis/blob/main/Images/Lot3_t-test.png)

### *Summary*
The p-value for the one-sample t-test comparing the PSI across all manufacturing lots to the population mean of 1,500 pounds per square inch was 0.06, higher than the assumed significance level of 0.05. Therefore, the two means are statistically similar. Similarly, the p-values for the one-sample t-tests comparing the PSI of manufacturing lots 1 and 2 to the population mean of 1,500 pounds per square inch was 1 and 0.6, respectively, higher than the assumed significance level of 0.05. Therefore, the mean PSIs for lots 1 and 2 are statistically similar to the population mean. Contrarily, the p-value for the one-sample t-test comparing the PSI of manufacturing lot 3 to the population mean of 1,500 pounds per square inch was 0.04, lower than the assumed significance level of 0.05. Therefore, the mean PSI for lot 3 is statistically different than the population mean. 
## Study Design: MechaCar vs Competition
Some of the most important metrics for consumers when deciding which car to purchase include purchase price, city fuel efficiency, and maintenance cost. A proposed study design would be to collect and analyze the average purchase price, city fuel efficiency, and maintenance cost for MechaCar and the competition. The study would test the following hypotheses:
H0: There is no difference in the average purchase price, city fuel efficiency, and maintenance cost between MechaCar and the competition.
Ha: There is a difference in the average purchase price, city fuel efficiency, and maintenance cost between MechaCar and the competition.
To conduct the study, the average purchase price, city fuel efficiency, and maintenance cost must be collected for MechaCar and their top competitor. As each variable is continuous and from different samples, a two-sample t-test will be conducted to compare each of the means for purchase price, city fuel efficiency, and maintenance cost between MechaCar and that of the competition. The p-value from these tests will be used to determine whether the null hypothesis will be rejected, with a p-value of 0.05 set as the significance level. 
