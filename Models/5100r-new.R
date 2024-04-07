library(tidyverse)
library(readxl)
library(survival)
library(survminer)
library(ggplot2)
library(writexl)
library(forecast)
library(tseries)
library(derivmkts)
library(reshape2)
set.seed(5100)
#write_xlsx(sim_rates_summary, "sim_rates_summary.xlsx")
case_data <- read_csv("2024-srcsc-superlife-inforce-dataset.csv", col_names = TRUE, skip = 3)
case_data <- case_data %>% distinct()

case_data <- case_data %>% 
  mutate(Lapse.Indicator = ifelse(Lapse.Indicator == "Y", 1, Lapse.Indicator))

case_data$Lapse.age <- c(0)
case_data$Holding.length <- c(0)
case_data$Year.of.Lapse <- as.numeric(case_data$Year.of.Lapse)
case_data$Holding.length <- case_data$Year.of.Lapse-case_data$Issue.year
case_data$Lapse.age <- case_data$Issue.age+case_data$Holding.length
# Calculate the observation time for each policy
case_data$obs_time <- ifelse(!is.na(case_data$Year.of.Death),
                             case_data$Year.of.Death - case_data$Issue.year,
                             ifelse(!is.na(case_data$Year.of.Lapse),
                                    case_data$Year.of.Lapse - case_data$Issue.year,
                                    max(case_data$Issue.year, na.rm = TRUE) - case_data$Issue.year))
case_data$Lapse.Indicator <- as.numeric(case_data$Lapse.Indicator)


# Replace NA values with specified criteria
case_data <- case_data %>%
  mutate(Death.indicator = ifelse(is.na(Death.indicator), 0, as.numeric(Death.indicator)),
         Lapse.Indicator = ifelse(is.na(Lapse.Indicator), 0, as.numeric(Lapse.Indicator)),
         Cause.of.Death = ifelse(is.na(Cause.of.Death), "Alive", Cause.of.Death))


# Apply logical checks
# When death indicator is 1, ensure Year.of.Death and Cause.of.Death are not "alive"
case_data <- case_data %>% 
  filter(!(Death.indicator == 1 & (is.na(Year.of.Death) | Cause.of.Death == "alive")))

# Adjust Year.of.Lapse to NA when Death indicator is 1
case_data <- case_data %>% 
  mutate(Year.of.Lapse = ifelse(Death.indicator == 1, NA, Year.of.Lapse))


# Split the data into SPWL and T20
SPWL <- case_data %>% filter(Policy.type == "SPWL")
T20 <- case_data %>% filter(Policy.type == "T20")

# Overall lapse rate
general_LR <- case_data %>% 
  summarise(Lapse.Rate = sum(Lapse.Indicator == 1, na.rm = TRUE) / n()) %>% 
  pull(Lapse.Rate)

# Lapse rate by each year of joining
LRtable <- case_data %>%
  group_by(Issue.year) %>%
  summarise(Lapse_Rate = sum(Lapse.Indicator == 1, na.rm = TRUE) / n()) %>%
  ungroup() %>%
  complete(Issue.year = full_seq(Issue.year, period = 1), fill = list(Lapse_Rate = 0)) %>%
  rename(Input = Issue.year, Output = Lapse_Rate)

# Print the overall lapse rate
print(general_LR)

# View the lapse rate by year table
view(LRtable)

# Plot the lapse rate by year
ggplot(LRtable, aes(x = Input, y = Output)) +
  geom_step(color = "brown3") +
  scale_x_continuous(breaks = 2001:2023, limits = c(2001, 2023), labels = as.character(2001:2023)) +
  scale_y_continuous(limits = c(0, 1)) +
  labs(x = "Year", y = "Rate", title = "Policy Withdrawal Rate by Year") +
  theme_minimal()

# Imputed lapse rates based on adjacent years or other logical methodology
#imputed_lr_2008 <- (LRtable$Output[which(LRtable$Input == 2007)] + LRtable$Output[which(LRtable$Input == 2010)]) / 2
#imputed_lr_2009 <- (LRtable$Output[which(LRtable$Input == 2007)] + LRtable$Output[which(LRtable$Input == 2010)]) / 2

# Replace the 0 values with the imputed values
#LRtable$Output[which(LRtable$Input == 2008)] <- imputed_lr_2008
#LRtable$Output[which(LRtable$Input == 2009)] <- imputed_lr_2009

# Plot the adjusted lapse rates
#ggplot(LRtable, aes(x = Input, y = Output)) +
#  geom_step(color = "brown3") +
#  scale_x_continuous(breaks = 2001:2023, limits = c(2001, 2023), labels = as.character(2001:2023)) +
#  scale_y_continuous(limits = c(0, 1)) +
#  labs(x = "Year", y = "Rate", title = "Policy Withdrawal Rate by Year Adjusted") +
#  theme_minimal()

#lapse rate of each cohort by year 
LTBbyYear <- case_data %>%
  filter(Policy.type == "T20") %>%
  group_by(Year.of.Lapse) %>%
  summarize(n_lapses = n()) %>%
  mutate(population = rev(cumsum(rev(n_lapses)))) %>%
  mutate(lps_rate = ifelse(population == n_lapses, 1, n_lapses / (population - n_lapses)))

LTBbyYear <- head(LTBbyYear, -1)
view(LTBbyYear)
#the lapse rate is actually pretty low??
# Yes hahahaha

#####Mortality rate by year#####
MTBbyYear <- case_data %>%
  group_by(Year.of.Death) %>%
  summarize(n_deaths = n()) %>%
  mutate(population = rev(cumsum(rev(n_deaths)))) %>%
  mutate(mort_rate = ifelse(population == n_deaths, 1, n_deaths / (population - n_deaths)))

MTBbyYear <- head(MTBbyYear, -1)
view(MTBbyYear)


#####policy holding length#####
# NA is assumed as non-lapse and replaced as 20 
holding_count <- table(case_data$Holding.length)
holding_rate <- holding_count/sum(holding_count)


#table of policy holding length, count and percentage
holding_table <- data.frame(
  Length = names(holding_count),
  Count = as.numeric(holding_count),
  Rate = as.numeric(holding_rate)
)
avg_length <- weighted.mean(as.numeric(holding_table$Length), holding_table$Rate)
avg_length #weighted average of policy holding time 
view(holding_table)

#####T20 lapse rate#####
T20_holding_count <- table(T20$Holding.length)
T20$Year.of.Death <- as.numeric(T20$Year.of.Death)
T20$Year.of.Lapse <- as.numeric(T20$Year.of.Lapse)
T20$PYoD <- T20$Year.of.Death-T20$Issue.year
T20$PYoD[is.na(T20$PYoD)] <- 20 # NA is assumed as not dead and replaced as 20
T20$Holding.length[is.na(T20$Holding.length)] <- 20
T20$Death.indicator[is.na(T20$Death.indicator)] <- 0
T20$Lapse.Indicator[is.na(T20$Lapse.Indicator)] <- 0
#T20_PYoD_count <- table(T20$PYoD)

# Policy year T:0~19
onhold <- numeric()
for(i in 1:20){
  onhold[i]<- sum(T20$Death.indicator == 0 & T20$Holding.length >= i-1) +
    sum(T20$PYoD > i-1)#+sum(T20$Death.indicator == 0 & T20$Lapse.Indicator == 0) 
}

T20_lapse_trend<- data.frame(
  Length = names(T20_holding_count),
  LCount = as.numeric(T20_holding_count)
)

T20_lapse_trend$LRate <- T20_lapse_trend$LCount/onhold
T20_lapse_trend <- T20_lapse_trend[1:20,]
plot(x=T20_lapse_trend$Length,y=T20_lapse_trend$LRate,xlab = "Lapsed policy year", ylab = "Lapse Rate", col="pink",main = "Trend of Lapse Rate",type="b")

#####Smoker status distribution#####
#whole population
case_data %>% #count() is better for "larger categories"
  count(Smoker.Status,Policy.type) %>% 
  mutate(Percentage=n/sum(n))
#T20
case_data %>%  
  filter(Policy.type=="T20") %>% 
  count(Smoker.Status) %>% 
  mutate(Percentage=n/sum(n))
#SPWL
case_data %>%  
  filter(Policy.type=="SPWL") %>% 
  count(Smoker.Status) %>% 
  mutate(Percentage=n/sum(n))
#####Distribution#####
case_data %>% #count() is better for "larger categories"
  count(Sex,Smoker.Status)

#lapsed & by gender
case_data %>%  
  filter(Lapse.Indicator==1) %>% 
  count(Sex) %>% 
  mutate(Percentage=n/sum(n))

#lapsed & by age
case_data %>%  
  filter(Lapse.Indicator==1) %>% 
  count(Lapse.age) %>% 
  mutate(Percentage=n/sum(n))

#how our sample matches the demographic pattern given in the encyclopaedia where the age we use here is at policy issuance
lumaria_population <- data.frame(
  AgeRange = c("0-14", "15-24", "25-54", "55-64", "65+"),
  PercentOfPopulation = c(20, 18, 46, 12, 4)
)

case_age_distribution <- case_data %>%
  mutate(AgeRange = case_when(
    Issue.age <= 14 ~ "0-14",
    Issue.age <= 24 ~ "15-24",
    Issue.age <= 54 ~ "25-54",
    Issue.age <= 64 ~ "55-64",
    TRUE ~ "65+"
  )) %>%
  group_by(AgeRange) %>%
  summarise(Count = n(), .groups = 'drop') %>%
  mutate(PercentOfSample = (Count / sum(Count)) * 100)
#min(case_data$Issue.age) #minimum issue age is 26, we might analyse the policyholders from 26

comparison_table <- merge(lumaria_population, case_age_distribution, by = "AgeRange", all = TRUE)
comparison_table <- comparison_table %>%
  rename(PercentOfLumariaPopulation = PercentOfPopulation, PercentOfCaseSample = PercentOfSample)

print(comparison_table)


##### Lapse rate by Policy Type#####
lapse_rate_by_type <- case_data %>%
  group_by(Policy.type) %>%
  summarise(LapseRate = sum(Lapse.Indicator == 1, na.rm = TRUE) / n(), .groups = 'drop')

print(lapse_rate_by_type)#no lapse for SPWL for both genders

# For a more detailed analysis, you can calculate lapse rates by combinations of variables, e.g., Policy Type and Gender
lapse_rate_by_type_gender <- case_data %>%
  group_by(Policy.type, Sex) %>%
  summarise(LapseRate = sum(Lapse.Indicator == 1, na.rm = TRUE) / n(), .groups = 'drop')

print(lapse_rate_by_type_gender)

# Filter for lapsed policies
lapsed_policies <- case_data %>% 
  filter(Lapse.Indicator == 1) %>%
  mutate(AgeAtLapse = Year.of.Lapse - Issue.year + Issue.age) # Calculate age at the time of lapse

# Analyze age distribution at lapse
age_distribution_at_lapse <- lapsed_policies %>%
  group_by(AgeAtLapse) %>%
  summarise(Count = n()) %>%
  mutate(Percentage = (Count / sum(Count)) * 100)

# Plotting the distribution
ggplot(age_distribution_at_lapse, aes(x = AgeAtLapse, y = Percentage)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  theme_minimal() +
  labs(title = "Age Distribution at Policy Lapse", x = "Age at Lapse", y = "Percentage (%)")

# View the table of age distribution at lapse
print(age_distribution_at_lapse)

# Calculate the count of smoker status by issue year
smoker_status_distribution <- case_data %>%
  group_by(Issue.year, Smoker.Status) %>%
  summarise(Count = n(), .groups = 'drop')

# Pivot the data for plotting
smoker_status_distribution_wide <- smoker_status_distribution %>%
  pivot_wider(names_from = Smoker.Status, values_from = Count)
smoker_status_distribution_wide$NSrate <- smoker_status_distribution_wide$NS/(smoker_status_distribution_wide$NS+smoker_status_distribution_wide$S)
smoker_status_distribution_wide$Srate <- 1-smoker_status_distribution_wide$NSrate 

# Plotting the distribution over time
ggplot(smoker_status_distribution_wide, aes(x = Issue.year)) +
  geom_line(aes(y = `S`, colour = "Smoker")) +  
  geom_line(aes(y = `NS`, colour = "Non-Smoker")) +  
  labs(title = "Smoker Status Distribution Over Time",
       x = "Issue Year",
       y = "Number of Policies",
       colour = "Status") +
  theme_minimal()
#Trend of percentage plot
ggplot(smoker_status_distribution_wide, aes(x = Issue.year)) +
  geom_line(aes(y = `Srate`, colour = "Smoker")) +  
  geom_line(aes(y = `NSrate`, colour = "Non-Smoker")) +  
  labs(title = "Smoker Status Distribution Over Time",
       x = "Issue Year",
       y = "Percentage",
       colour = "Status") +
  theme_minimal()
# An increasing number of people joining life insurance, where the proportion of smoker of the policyholders are decreasing.


# Create the Surv object
surv_obj <- Surv(time = case_data$obs_time, event = case_data$Lapse.Indicator)

# Fit Kaplan-Meier survival curves for different cohorts
# By Gender
fit_gender <- survfit(surv_obj ~ Sex, data = case_data)

# Plot the survival curves for Gender
ggsurvplot(fit_gender, data = case_data, pval = TRUE, conf.int = TRUE,
           xlab = "Years", ylab = "Survival Probability",
           title = "Survival Curves by Gender")

# By Smoker Status
fit_smoker_status <- survfit(surv_obj ~ Smoker.Status, data = case_data)
ggsurvplot(fit_smoker_status, data = case_data, pval = TRUE, conf.int = TRUE,
           xlab = "Years", ylab = "Survival Probability",
           title = "Survival Curves by Smoker Status")

# By Policy Type
fit_policy_type <- survfit(surv_obj ~ Policy.type, data = case_data)
ggsurvplot(fit_policy_type, data = case_data, pval = TRUE, conf.int = TRUE,
           xlab = "Years", ylab = "Survival Probability",
           title = "Survival Curves by Policy Type")

# By Underwriting Class
fit_underwriting_class <- survfit(surv_obj ~ Underwriting.Class, data = case_data)
ggsurvplot(fit_underwriting_class, data = case_data, pval = TRUE, conf.int = TRUE,
           xlab = "Years", ylab = "Survival Probability",
           title = "Survival Curves by Underwriting Class")

# By Urban vs Rural
fit_urban_rural <- survfit(surv_obj ~ Urban.vs.Rural, data = case_data)
ggsurvplot(fit_urban_rural, data = case_data, pval = TRUE, conf.int = TRUE,
           xlab = "Years", ylab = "Survival Probability",
           title = "Survival Curves by Urban vs Rural")

# Analysis on Face Amount Distribution
case_data %>%
  ggplot(aes(x = Face.amount, fill = as.factor(Lapse.Indicator))) +
  geom_histogram(position = "identity", alpha = 0.5, bins = 50) +
  labs(title = "Distribution of Policy Face Amounts by Lapse Indicator",
       x = "Policy Face Amount",
       y = "Frequency",
       fill = "Lapse Indicator") +
  theme_minimal()


# mortality_rate <- case_data %>%
#   table(MortalityRate = mean(Death.indicator))
# case_data %>%  
#   count(Death.indicator) %>% 
#   mutate(Percentage=n/sum(n))

#####Face Value Analysis by policy type#####
#How much face value the customer want at the age which the customer first join the policy
PIC_tb <- case_data[,c("Policy.type","Issue.age","Face.amount")] %>%  
  filter(Issue.age>=25) %>% 
  count(Policy.type,Issue.age,Face.amount) 
view(PIC_tb)# PIC_tb stands for # Policy.type,Issue.age,Face_amount table

SPWL_tb <- PIC_tb[PIC_tb$Policy.type == "SPWL", ] #SPWL table
T20_tb <- PIC_tb[PIC_tb$Policy.type == "T20", ] #T20 table
view(SPWL_tb)
view(T20_tb)
summary(SPWL_tb)
summary(T20_tb)

#weighted average of Face.amount at each age and age group
#SPWL
SPWL_wt_avg <- aggregate(SPWL_tb$Face.amount * SPWL_tb$n, by = list(SPWL_tb$Issue.age), FUN = sum) / 
  aggregate(SPWL_tb$n, by = list(SPWL_tb$Issue.age), FUN = sum)
SPWL_wt_avg[1] <- c(35:65)
SPWL_wt_avg[3] <- aggregate(SPWL_tb$n, by = list(SPWL_tb$Issue.age), FUN = sum)[2]
#by each age 
SPWL_wt_avg <- SPWL_wt_avg[,-4] 
names(SPWL_wt_avg) <- c("age","amount","number")
view(SPWL_wt_avg)
plot(x=SPWL_wt_avg$age,y=SPWL_wt_avg$amount,main="SPWL Weighted Average of Face.amount")

#by age group
age_ranges <- c("35-39","40-45","46-55", "56-60", "61-65")
age_boundaries <- c(35,40,46,56,61,Inf)
SPWL_wt_avg$AgeRange <- cut(SPWL_wt_avg$age, breaks = c(age_boundaries), labels=age_ranges,right = FALSE)

SPWL_wtavg_by_group <- SPWL_wt_avg%>%
  group_by(AgeRange) %>%
  summarize(wt_avg_FAmount = sum(amount * number) / sum(number))

ppl <- SPWL_wt_avg%>%
  group_by(AgeRange) %>%
  summarize(wt_avg_FAmount = sum(number))
SPWL_wtavg_by_group[3] <- ppl[2]
names(SPWL_wtavg_by_group) <- c("AgeRange","Amount","Number")
SPWL_wtavg_by_group <- SPWL_wtavg_by_group %>% 
  mutate(Percentage=Number/sum(Number))
names(SPWL_wtavg_by_group[4]) <- "Percentage"
view(SPWL_wtavg_by_group)


#T20
T20_wt_avg <- aggregate(T20_tb$Face.amount * T20_tb$n, by = list(T20_tb$Issue.age), FUN = sum) / 
  aggregate(T20_tb$n, by = list(T20_tb$Issue.age), FUN = sum)
T20_wt_avg[1] <- c(26:55)
T20_wt_avg[3] <- aggregate(T20_tb$n, by = list(T20_tb$Issue.age), FUN = sum)[2]
T20_wt_avg <- T20_wt_avg[,-4]
names(T20_wt_avg) <- c("age","amount","number")
view(T20_wt_avg)
plot(x=T20_wt_avg$age,y=T20_wt_avg$amount,main="T20 Weighted Average of Face.amount",col="skyblue")
#lines(T20_wt_avg)
cor(T20_wt_avg$age,T20_wt_avg$amount) #0.936221 so they are highly related, we might use some regression if have time

#by age group
age_ranges <- c("26-29", "30-35", "36-45","46-50",'51-55')
age_boundaries <- c(25,30,36,46,51,Inf)
T20_wt_avg$AgeRange <- cut(T20_wt_avg$age, breaks = c(age_boundaries), labels=age_ranges,right = FALSE)

T20_wtavg_by_group <- T20_wt_avg%>%
  group_by(AgeRange) %>%
  summarize(wt_avg_FAmount = sum(amount * number) / sum(number))

ppl2 <- T20_wt_avg%>%
  group_by(AgeRange) %>%
  summarize(wt_avg_FAmount = sum(number))
T20_wtavg_by_group[3] <- ppl2[2]
names(T20_wtavg_by_group) <- c("AgeRange","Amount","Number")
T20_wtavg_by_group <- T20_wtavg_by_group %>% mutate(Percentage=Number/sum(Number))
names(T20_wtavg_by_group[4]) <- "Percentage"
view(T20_wtavg_by_group)


#####Face amount analysis by smoker status#####
PISF_tb <- case_data[,c("Policy.type","Issue.age","Smoker.Status","Face.amount")] %>%  
  count(Policy.type,Issue.age,Smoker.Status,Face.amount) 
view(PISF_tb)# PIC_tb stands for # Policy.type,Issue.age,Face_amount table

S_tb <- PISF_tb[PISF_tb$Smoker.Status == "S", ] #smoker table
NS_tb <- PISF_tb[PISF_tb$Smoker.Status == "NS", ] #non smoker table
view(S_tb)
view(NS_tb)
summary(S_tb)
summary(NS_tb)

SPWL_S_tb <- S_tb[S_tb$Policy.type == "SPWL", ]
SPWL_NS_tb <- NS_tb[NS_tb$Policy.type == "SPWL", ]
T20_S_tb <- S_tb[S_tb$Policy.type == "T20", ]
T20_NS_tb <- NS_tb[NS_tb$Policy.type == "T20", ]
summary(SPWL_S_tb)
summary(SPWL_NS_tb)
summary(T20_S_tb)
summary(T20_NS_tb)

#SPWL smoker
SPWL_S_wt_avg <- aggregate(SPWL_S_tb$Face.amount * SPWL_S_tb$n, by = list(SPWL_S_tb$Issue.age), FUN = sum) / 
  aggregate(SPWL_S_tb$n, by = list(SPWL_S_tb$Issue.age), FUN = sum)
SPWL_S_wt_avg[1] <- c(35:65)
SPWL_S_wt_avg[3] <- aggregate(SPWL_S_tb$n, by = list(SPWL_S_tb$Issue.age), FUN = sum)[2]
#by each age 
SPWL_S_wt_avg <- SPWL_S_wt_avg[,-4] 
names(SPWL_S_wt_avg) <- c("age","amount","number")
view(SPWL_S_wt_avg)
(wtavg_SPWL_S <- weighted.mean(SPWL_S_wt_avg$amount,SPWL_S_wt_avg$number))


#SPWL non-smoker
SPWL_NS_wt_avg <- aggregate(SPWL_NS_tb$Face.amount * SPWL_NS_tb$n, by = list(SPWL_NS_tb$Issue.age), FUN = sum) / 
  aggregate(SPWL_NS_tb$n, by = list(SPWL_NS_tb$Issue.age), FUN = sum)
SPWL_NS_wt_avg[1] <- c(35:65)
SPWL_NS_wt_avg[3] <- aggregate(SPWL_NS_tb$n, by = list(SPWL_NS_tb$Issue.age), FUN = sum)[2]
#by each age 
SPWL_NS_wt_avg <- SPWL_NS_wt_avg[,-4] 
names(SPWL_NS_wt_avg) <- c("age","amount","number")
view(SPWL_NS_wt_avg)
(wtavg_SPWL_NS <- weighted.mean(SPWL_NS_wt_avg$amount,SPWL_NS_wt_avg$number))

#T20 smoker
T20_S_wt_avg <- aggregate(T20_S_tb$Face.amount * T20_S_tb$n, by = list(T20_S_tb$Issue.age), FUN = sum) / 
  aggregate(T20_S_tb$n, by = list(T20_S_tb$Issue.age), FUN = sum)
T20_S_wt_avg[1] <- c(26:55)
T20_S_wt_avg[3] <- aggregate(T20_S_tb$n, by = list(T20_S_tb$Issue.age), FUN = sum)[2]
T20_S_wt_avg <- T20_S_wt_avg[,-4]
names(T20_S_wt_avg) <- c("age","amount","number")
view(T20_S_wt_avg)
(wtavg_T20_S <- weighted.mean(T20_S_wt_avg$amount,T20_S_wt_avg$number))

#T20 non-smoker
T20_NS_wt_avg <- aggregate(T20_NS_tb$Face.amount * T20_NS_tb$n, by = list(T20_NS_tb$Issue.age), FUN = sum) / 
  aggregate(T20_NS_tb$n, by = list(T20_NS_tb$Issue.age), FUN = sum)
T20_NS_wt_avg[1] <- c(26:55)
T20_NS_wt_avg[3] <- aggregate(T20_NS_tb$n, by = list(T20_NS_tb$Issue.age), FUN = sum)[2]
T20_NS_wt_avg <- T20_NS_wt_avg[,-4]
names(T20_NS_wt_avg) <- c("age","amount","number")
view(T20_NS_wt_avg)
(wtavg_T20_NS <- weighted.mean(T20_NS_wt_avg$amount,T20_NS_wt_avg$number))


#####Interest Rate projection######

# Read the economic data
economic_data <- read_excel("srcsc-2024-lumaria-economic-data.xlsx", skip = 11, col_names = TRUE)
names(economic_data) <- c("Year", "Inflation", "overnight_rate", "riskfree1", "riskfree10")

# ARIMA Model for 10-year Risk-Free Rate
modelfit <- auto.arima(economic_data$riskfree10, lambda = "auto")
summary(modelfit)

# Residual Diagnostics for ARIMA Model
par(mfrow=c(2,2))  # Set up the graphics layout
plot(resid(modelfit), ylab="Residuals", main="Residuals vs Time", type="p", col="pink")
abline(h=0, col="purple")
hist(resid(modelfit), freq=FALSE, main="Histogram of Residuals")
e <- resid(modelfit)
curve(dnorm(x, mean=mean(e), sd=sd(e)), add=TRUE, col="brown3")
Box.test(e, lag=log(length(e)), type="Ljung-Box")  # Ljung-Box test
qqnorm(e)
qqline(e, col = "steelblue", lwd = 2)  # QQ plot for normality
par(mfrow=c(1,1))
# Forecast using ARIMA model
interest_forecast <- forecast(modelfit, h=110)
plot(interest_forecast)

# Vasicek Model for 10-year Risk-Free Rate
# Define the likelihood function for the Vasicek model
vasicek_likelihood <- function(params, data) {
  theta <- params[1]
  kappa <- params[2]
  sigma <- params[3]
  r <- data
  n <- length(r)
  
  # Initialize likelihood
  log_likelihood <- 0
  
  # Calculate log-likelihood, adding penalty for non-finite values
  for (i in 2:n) {
    drift <- kappa * (theta - r[i - 1])
    diffusion <- sigma^2 * (1 - exp(-2 * kappa)) / (2 * kappa) * (1 - exp(-kappa * (i - 1))) * exp(-kappa * (i - 1))
    if (diffusion <= 0 || is.na(diffusion) || !is.finite(diffusion)) {
      return(1e6)  # Large penalty for non-finite likelihood values
    }
    log_likelihood <- log_likelihood - 0.5 * log(2 * pi * diffusion) - 0.5 * (r[i] - r[i - 1] - drift)^2 / diffusion
  }
  
  return(-log_likelihood)  # Return negative log-likelihood (to minimize)
}

# Initial parameter guesses
initial_guess <- c(0.05, 0.1, 0.01)
lower_bounds <- c(0.01, 0.01, 0.01)  # Slightly more realistic lower bounds
upper_bounds <- c(1, 1, 1)  # Reasonable upper bounds


# Add the conditions on the interest rate data
adjusted_data_minus <- economic_data$riskfree10 - 0.01
adjusted_data_plus <- economic_data$riskfree10 + 0.01

# Maximize likelihood to estimate parameters
fit <- optim(par = initial_guess, fn = vasicek_likelihood, data = economic_data$riskfree10,
             lower = lower_bounds, upper = upper_bounds, method = "L-BFGS-B")

estimated_params <- fit$par
print(estimated_params)

# For adjusted_data_minus
fit_minus <- optim(par = initial_guess, fn = vasicek_likelihood, data = adjusted_data_minus,
                   lower = lower_bounds, upper = upper_bounds, method = "L-BFGS-B")

estimated_params_minus <- fit_minus$par
print(estimated_params_minus)

# For adjusted_data_plus
fit_plus <- optim(par = initial_guess, fn = vasicek_likelihood, data = adjusted_data_plus,
                   lower = lower_bounds, upper = upper_bounds, method = "L-BFGS-B")

estimated_params_plus <- fit_plus$par
print(estimated_params_plus)


# Simulate future interest rate paths with estimated parameters
vasicek_simulation <- function(theta, kappa, sigma, r0, T, dt, Nsim) {
  N <- T / dt
  paths <- matrix(0, ncol = Nsim, nrow = N)
  for (sim in 1:Nsim) {
    r <- numeric(N)
    r[1] <- r0
    for (t in 2:N) {
      r[t] <- r[t - 1] + kappa * (theta - r[t - 1]) * dt + 
        sigma * rnorm(1)
    }
    paths[, sim] <- r
  }
  return(paths)
}


# Ensure 'T' and 'dt' are numeric for division
T <- 110  # Time horizon for simulation (years)
dt <- 1   # Time step (years)
Nsim <- 1000  # Number of simulations
N <- T/dt

# Extract the last value of the risk-free rate as the starting rate
r0 <- as.numeric(tail(economic_data$riskfree10, n=1))

# Run the simulation with the estimated parameters and initial value
simulated_rates <- vasicek_simulation(estimated_params[1], estimated_params[2], 
                                      estimated_params[3], r0, T, dt, Nsim)


# Extract the last value as the starting rate for adjusted_data_minus
r0_minus <- as.numeric(tail(adjusted_data_minus, n=1))

# Run the simulation with the estimated parameters and initial value
simulated_rates_minus <- vasicek_simulation(estimated_params_minus[1], estimated_params_minus[2], 
                                            estimated_params_minus[3], r0_minus, T, dt, Nsim)

# Extract the last value as the starting rate for adjusted_data_minus
r0_plus <- as.numeric(tail(adjusted_data_plus, n=1))

# Run the simulation with the estimated parameters and initial value
simulated_rates_plus <- vasicek_simulation(estimated_params_plus[1], estimated_params_plus[2], 
                                            estimated_params_plus[3], r0_plus, T, dt, Nsim)


# Create a dataframe from the simulated rates matrix
sim_rates_df <- as.data.frame(simulated_rates)

# Add a 'Time' column to the dataframe
sim_rates_df$Time <- seq(from = 1, to = N)

# Use melt from reshape2 to convert the wide format dataframe to a long format dataframe for ggplot
sim_rates_long <- melt(sim_rates_df, id.vars = 'Time')

ggplot(sim_rates_long, aes(x = Time, y = value, group = variable)) +
  geom_line(alpha = 0.1, color = "blue", linewidth = 0.2) +  # Adjusted for transparency and line width
  theme_minimal() +
  labs(title = "Simulated Interest Rate Paths (Vasicek Model)",
       x = "Time (Years)",
       y = "Interest Rate") +
  theme(legend.position = "none")  

# Convert to long format for use with ggplot2
sim_rates_long <- reshape2::melt(sim_rates_df, id.vars = 'Time')

# Calculate summary statistics for each time point
sim_rates_summary <- sim_rates_long %>%
  group_by(Time) %>%
  summarise(
    Mean = mean(value),
    P10 = quantile(value, probs = 0.1),
    P50 = median(value),
    P90 = quantile(value, probs = 0.9)
  )
view(sim_rates_summary)
# Plot the mean and percentile bands
ggplot(sim_rates_summary, aes(x = Time)) +
  geom_ribbon(aes(ymin = P10, ymax = P90), fill = "blue", alpha = 0.1) +
  geom_line(aes(y = P50), color = "blue") +
  geom_line(aes(y = Mean), color = "red") +
  labs(title = "Simulated Interest Rate Paths (Vasicek Model) Summary",
       x = "Time (Years)",
       y = "Interest Rate") +
  theme_minimal()


# Convert the simulated rates matrix to a dataframe
sim_rates_minus_df <- as.data.frame(simulated_rates_minus)
sim_rates_minus_df$Time <- seq(from = 1, to = N)
sim_rates_long_minus <- melt(sim_rates_minus_df, id.vars = 'Time')

# For the dataset with 0.01 subtracted
sim_rates_summary_minus <- sim_rates_long_minus %>%
  group_by(Time) %>%
  summarise(
    Mean = mean(value),
    P10 = quantile(value, probs = 0.1),
    P50 = median(value),
    P90 = quantile(value, probs = 0.9)
  )

# Plot for the dataset with 0.01 subtracted
ggplot(sim_rates_summary_minus, aes(x = Time)) +
  geom_ribbon(aes(ymin = P10, ymax = P90), fill = "blue", alpha = 0.1) +
  geom_line(aes(y = P50), color = "blue") +
  geom_line(aes(y = Mean), color = "red") +
  labs(title = "Simulated Interest Rate Paths (Vasicek Model) - 0.01 Subtracted",
       x = "Time (Years)",
       y = "Interest Rate") +
  theme_minimal()


# Convert the simulated rates matrix to a dataframe
sim_rates_plus_df <- as.data.frame(simulated_rates_plus)
sim_rates_plus_df$Time <- seq(from = 1, to = N)
sim_rates_long_plus <- melt(sim_rates_plus_df, id.vars = 'Time')

# For the dataset with 0.01 added
sim_rates_summary_plus <- sim_rates_long_plus %>%
  group_by(Time) %>%
  summarise(
    Mean = mean(value),
    P10 = quantile(value, probs = 0.1),
    P50 = median(value),
    P90 = quantile(value, probs = 0.9)
  )

# Plot for the dataset with 0.01 added
ggplot(sim_rates_summary_plus, aes(x = Time)) +
  geom_ribbon(aes(ymin = P10, ymax = P90), fill = "blue", alpha = 0.1) +
  geom_line(aes(y = P50), color = "blue") +
  geom_line(aes(y = Mean), color = "red") +
  labs(title = "Simulated Interest Rate Paths (Vasicek Model) + 0.01 Added",
       x = "Time (Years)",
       y = "Interest Rate") +
  theme_minimal()

x <- sim_rates_summary_plus$Time
normal <- sim_rates_summary$Mean
down <- sim_rates_summary_minus$Mean
up <- sim_rates_summary_plus$Mean
df <- data.frame(x, Normal, up, down)
data_tidy <- gather(df, key = "line", value = "value", -x)
ggplot(data_tidy, aes(x = x, y = value, color = line)) +
  geom_line() +
  labs(title = "3 paths of interest rate projection",
       x = "Time",
       y = "Interest rate",
       color = "Lines") +
  theme_minimal()
