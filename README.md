



# Table of Contents
1. [Executive Summary](#executive-summary)
2. [Program Design](#program-design)
3. [Modelling and Pricing](#modelling-and-pricing)
4. [Scenario Analysis](#scenario-analysis)
5. [Risks and Risk Mitigation Plans](#risks-and-risk-mitigation-plans)
6. [Data Limitations](#data-limitations)
7. [Final Recommendations](#final-recommendations)
8. [Appendix](#appendix)
9. [Reference List](#reference-list)

## Executive Summary

This report outlines strategic approaches to drive mortality reduction and the well-being of policyholders in Lumania by implementing targeted health incentives. The content delves into the multifaceted benefits that health incentives can yield for both SuperLife and its policyholders. In addition, this document will address how these incentives can not only retain current policyholders but also serve as an attractive feature for potential customers. Therefore, such intervention activities can improve marketability and competitiveness, which could eventually add economic value to SuperLife.

It is imperative that such incentives consider the diverse demographic and socioeconomic landscape of the country to ensure broad accessibility and effectiveness. Of which, the prospect of such incentive programs is evaluated by various quantitative approaches which will be presented in detail below. Also, the components of our programs is selected by prudent analysis to achieve the optimal trade-off between implementation cost and benefits from mortality improvement on targeted age groups.

Our comprehensive research offers insights into the potential short-term and long-term enhancements in mortality rates attributed to adopting health incentives. With concerns of solvency, several tests are conducted on our projecting simulations. By presenting a spectrum of scenarios, from the most optimistic to the most conservative, we underscore the practicality and potential positive outcomes of integrating these health incentives within SuperLife's offerings. Moreover, risks are inevitable for every insurance business, especially before introducing new policies. Risks and their corresponding mitigation methods are also discussed in this report.

In conclusion, the proposed health-incentive activities represent SuperLife’s commitment to the well-being of its policyholders as well as constant profitability growth and sustainability. SuperLife would strengthen its competitive position and deliver long-term economic value to such an entity by focusing on product innovation, market expansion, and operational efficiency.

## Program Design

### Exploratory Data Analysis
This analysis covers demographic patterns associated with policyholder participation, mortality rates, customer behaviours, and economic status. Furthermore, the interest rate projections have been formulated based on the current dataset. This approach is instrumental in evaluating the potential profitability and the enhancement of economic value. Using these explanatory data and projections as a foundation, we can construct our model to analyse further the impact and effectiveness of the health incentive programs.
#### Initial Data Cleaning: 
Data cleaning was a critical preliminary step to ensure the accuracy and reliability of the EDA. The process involved:

Deduplication: Removing duplicate records to prevent skewed analysis results. 

Handling Missing Values: Imputing or removing entries with missing information, particularly in critical variables like lapse, death indicators, and cause of death. For instance, missing Year of Lapse values were addressed to differentiate between active policies and those that had lapsed or resulted in claims.

Data Type Conversion: Ensuring that variables like the lapse and death indicator were correctly formatted as numerical values to facilitate statistical analysis.
#### Dataset Description:
This dataset contains 9,878,582 observations from SuperLife’s policyholder records, including variables as shown below.   
![image](https://github.com/Actuarial-Control-Cycle-T1-2024/group-page-showcase-pea/assets/101699608/d57caf27-4d66-4128-b022-20f778039b3f)
![image](https://github.com/Actuarial-Control-Cycle-T1-2024/group-page-showcase-pea/assets/101699608/23fe48b6-3f5a-4a44-a3ad-41ad47c6319d)
After further Data Cleaning (Appendix 1), some tendencies in numerical variables, distributional properties in categorical variables are obtained and some other key findings (Appendix 2). 

#### Key inputs of profitability modelling:  
Modelling 1: Lapse rate analysis on T20 product 
To explore customer behaviour, we have calculated the lapse rate at each policy year. Since there is no lapse in the Whole-life policy, it would be more meaningful to analyse the lapse rate of the 20-year term insurance product. 
Methodology (Appendix 3):
Lapse rate=(number of lapse at policy year T)/(Number of existing policies at policy year T)
Findings:  The graph on the left shows the likelihood of withdrawing from 20-year term insurance at each policy year. Universally, it shows a decreasing trend, which indicates that people are less and less likely to withdraw from their policy as time passes until the end of the policy is approaching. The intuition behind the surge is that policyholders have found themselves unable to make claims as the policy is ending. Therefore, they opt to withdraw from their policy to get a certain amount of refund before the policy is completely terminated.![image](https://github.com/Actuarial-Control-Cycle-T1-2024/group-page-showcase-pea/assets/101699608/61b6c797-1ebf-4869-890a-5c42ca359bae)

## Modelling and Pricing	
## Scenario analysis
## Risks and Risk Mitigation Plans	
## Data Limitations	
## Final Recommendations	
## Appendix	
## Reference list	















