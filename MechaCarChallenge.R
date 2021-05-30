## Linear Regression to Predict MPG

# Load dplyr package
library(dplyr)

# Import and read in the MechaCar_mpg.csv file
MechaCar <- read.csv(file = 'MechaCar_mpg.csv',check.names = F,stringsAsFactors = F)

# Perform linear regression
lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD,data=MechaCar)

# Determine the p-value and r-squared value of linear regression model
summary(lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD,data=MechaCar))

## Summary Statistics on Suspension Coils

# Import and read in the Suspension_Coil.csv file
SuspensionCoils <- read.csv(file = 'Suspension_Coil.csv',check.names = F,stringsAsFactors = F)

# Create a total_summary DataFrame
total_summary <- SuspensionCoils %>% summarize(Mean=mean(PSI), Median=median(PSI), Variance=var(PSI), SD=sd(PSI))

# Create a lot_summary DataFrame
lot_summary <- SuspensionCoils %>% group_by(Manufacturing_Lot) %>% 
  summarize(Mean=mean(PSI), Median=median(PSI), Variance=var(PSI), SD=sd(PSI))

## T-Tests on Suspension Coils

# Determine if PSI of all manufacturing lots is different from population mean
t.test(SuspensionCoils$PSI,mu=1500)

# Determine if PSI of Lot 1 is different from population mean
t.test(subset(SuspensionCoils, Manufacturing_Lot=="Lot1")$PSI,mu=1500)

# Determine if PSI of Lot 2 is different from population mean
t.test(subset(SuspensionCoils, Manufacturing_Lot=="Lot2")$PSI,mu=1500)

# Determine if PSI of Lot 3 is different from population mean
t.test(subset(SuspensionCoils, Manufacturing_Lot=="Lot3")$PSI,mu=1500)

