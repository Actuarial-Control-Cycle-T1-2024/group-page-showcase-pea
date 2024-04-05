



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
In scenario testing, we performed the best estimated and sensitivity testing on the expense, mortality rate, inflation rate, investment yield and lapse rate.
In addition to conducting a stress test on investment yields, we examined the minimum face amount to determine if adjustments were necessary.
For details, please refer to the Appendix 10 sheet Excel file in “Results”.
### SPWL
*	With the same premium charged, the profitability is slightly improved after the implementation of the health incentive program (PM 0.12% higher and VNBM 0.05% higher)
*	Invest yield is the most significant in sensitivity testing.
*	Under the worst-case scenario, PM and VNBM are still positive.
*	On invest yield stress testing, we will face a nearly zero PM (0.35%) and negative VNBM (-5.21%)
*	On minimum face amount testing, we found that under the old minimum face amount (Č100,000), two of our key age groups will result in a loss. After testing, a minimum face amount of Č160,000 is recommended.
### T20
* With the same premium charged, the profitability is improved after the implementation of the health incentive program (PM 1.5% higher and VNBM 16.67% higher)
*	Mortality is the most significant factor in sensitivity testing.
*	Under the worst-case scenario, PM and VNBM are still positive.
*	Upon investment yield stress testing, PM and VNBM are still positive.
*	On minimum face amount testing, we found that under the old minimum face amount (Č50,000), four of our crucial age groups will result in a loss. After testing, a minimum face amount of Č430,000 is recommended.

## Risks and Risk Mitigation Plans	
### Risks
#### Inflation Risk: 
The cost of implementing and maintaining health incentive programs may exceed projections due to inflation, impacting profitability.
#### Engagement Risk: 
Insured individuals may engage with the health incentive programs less than expected, reducing the effectiveness of these programs.
#### Model Risk: 
Difficulty in accurately measuring the health outcomes resulting from the incentives can lead to challenges in assessing the program's effectiveness.
#### Long-Term Sustainability Risk: 
There might be concerns about the long-term sustainability of the incentives if health improvements do not lead to reduced claims.
#### Misuse Risk: 
There is a potential for misuse of health incentives, where individuals might find ways to exploit the system without actually improving their health.
#### Regulation risk: 
Insurance programs must comply with everchanging regulations, which can vary over time.
#### Social impact risk: 
Large-scale health programs may have unexpected social impacts, such as increased stress or social dislocation due to changes in coverage or benefits.
### Risk Mitigation Strategies
#### Inflation risk hedging: 
A long-term contract with a service provider can mitigate inflation risks in a project.
#### Engagement Strategies: 
Develop robust engagement strategies, like gamification or personalized goals, to encourage participation in health programs.
#### Partnerships: 
Collaborate with healthcare providers and wellness experts to develop and refine incentive programs based on best practices and current research.
#### Long-Term Incentive Adjustment: 
Review and adjust incentives over time to ensure they remain effective and sustainable in promoting healthier behaviours and reducing insurance claims.
#### Program Design: 
Create incentive programs that require demonstrable health improvements, such as biometric screenings, to qualify for benefits.
#### Dedicated Regulation Team: 
Stay informed about regulatory changes and adjust programs as needed.
#### Societal Monitoring: 
Monitor on social impacts and adjust programs to minimize adverse effects. Engage with people in the community to maintain social cohesion.

## Data Limitations	
| Data limitation                                      | Description                                                                                                                                                           | Corresponding Assumptions                                                                                              | Justification                                                                                                                                                                                                                           |
|------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Lack of data on the effectiveness and cost of incentive programs | The dataset provides minimal information on the Approximate Per Capita Cost of intervention, making it challenging to analyse the accurate cost of effectiveness. | Assume effectiveness varies, as mentioned in the assumption section.                                                   | This assumption is justified by the need to use available data to extrapolate potential costs and benefits.                                                                                                                            |
| Lack of detailed policyholder behaviour data         | The datasets provide limited insights into policyholders' behaviours that might lead to policy lapses or claims, such as significant lifestyle changes or shifts in financial status. | Assume the policyholder behaviour which could influence lapse or mortality rates remains consistent through the policy term. | This assumption is necessary due to the need for longitudinal data on policyholder behaviour changes over time. It not only simplifies the model but also highlights the importance of understanding the dynamic data.                 |
| Lack of data on external economic factors            | The datasets do not include other economic data except inflation and interest spot rates; other factors, such as unemployment rates, may also influence the lapse rate. | Assume all other external economic factors do not have a consistent or significant impact on the model’s predictions regarding policy lapses and mortality rates. | This assumption allows the analysis to proceed while acknowledging the limitation of not considering a complete economic perspective.                                                                                                   |
| Limited severity on smoker status                    | The datasets classify policyholders simply as smokers or non-smokers without accounting for the quantity or duration of smoking, which would significantly affect mortality and lapse rates. | Assume the smoker status classification is sufficiently binary for the analysis.                                         | This assumption allows the analysis to proceed with available data.                                                                                                                                                                      |

## Final Recommendations
The introduction of a health incentive program to our product lineup, without undergoing repricing, represents a strategic enhancement to SuperLife's competitiveness and appeal. This initiative, designed to align with increasing consumer demand for value-added services, involves strategic adjustments to the minimum face amounts following scenario testing to ensure financial stability and prevent potential losses. By offering these programs at competitive pricing within Lumaria's economic environment, we not only make our life insurance products more accessible but also foster a win-win situation for both policyholders and the company. The health incentive program aims to encourage healthier lifestyles among policyholders, potentially reducing overall risk profiles and leading to lower claim rates, which, in turn, supports SuperLife's profitability and policyholder satisfaction. This approach underscores our commitment to innovation, helping policyholders achieve financial prosperity and peace of mind, maintaining financial stability, and positioning SuperLife as a forward-thinking insurer in the market.

## Appendix	
Appendix 1: Further Data Cleaning

Outlier Detection and Treatment: 
Identifying and addressing outliers in variables such as face amount and policyholder age, which could otherwise distort analysis findings.
These cleaning steps addressed significant data quality issues, laying a solid foundation for the subsequent analysis. The meticulous approach to preparing the dataset highlights the importance of accuracy and integrity in data analysis, ensuring that the insights drawn are reliable and actionable.

Appendix 2: Tendency, distribution and key findings:

Numerical Variables:

Policy Holding Length: 
The dataset revealed an average holding time for a policy of approximately 12.22 years, indicating a moderate level of long-term commitment among policyholders. This metric is pivotal as it highlights the duration policyholders remain engaged before lapsing or making claims.

Lapse Rate by Year: 
A notable decline in lapse rates was observed over the years, decreasing from 0.745 in 2001 to 0.089 in 2010. This trend suggests an improvement in policyholder retention or possible changes in policy terms or market conditions that favour continued engagement.

Mortality Rate by Year: 
Mortality rates gradually increase from 0.0000470 in 2001 to 0.000968 in 2010. Although these increases are relatively small, they reflect the policyholder base's natural ageing or underwriting quality variations over time.

Categorical Variables:

Smoker Status Distribution: 
Non-smokers dominate the dataset, comprising 91.4% of T20 and 97.5% of SPWL policyholders. This demographic skew has significant implications for policy pricing and risk management, given the well-documented impact of smoking on mortality and health risks.

Policy Type Distribution: 
The analysis distinguishes between SPWL and T20 policy types, each serving different customer segments with distinct lapse and mortality rates. The precise impact of these differences on the portfolio's performance and risk profile is a critical area for further analysis.

Key Findings:

Improvement in Policy Retention Over Time: The decreasing lapse rates suggest enhancements in policy retention strategies or the design of newer policies that encourage longer engagements.

Gradual Increase in Mortality Rates:

The slight upward trend in mortality rates over the years could indicate an ageing policyholder base or external factors influencing policyholder health, emphasizing the importance of continuously monitoring mortality trends for actuarial accuracy and financial planning.

Identification of Significant Age at Lapse: 

The age distribution at policy lapse points to specific age ranges where policyholders are more likely to lapse, suggesting that life stages or changing financial priorities play roles in policy retention.

Diverse Survival Probabilities: 

The survival analysis reveals varied probabilities of policy continuation across different demographic and policy type segments, highlighting the need for tailored approaches in policy design, pricing, and customer engagement strategies.

Appendix 3: Detailed methodology of Trend of Lapse rate:

![1712298982727](https://github.com/Actuarial-Control-Cycle-T1-2024/group-page-showcase-pea/assets/101699608/244f958a-0833-41b0-8d11-393769b0f3e4)

As for the numerator, a new column named Holding is used to count the number of lapses at each policy year. Length is created and calculated by Lapsed year-Issue year, where the lapsed year is capped at 20 since the term insurance product of our interest is 20 years. Then, the number of each holding length can be counted. 
Then, as for the denominator, existing policies at policy year T are calculated by the group “alive and Holding duration longer than T-1 years” plus the group “death occurred after Policy Year T.” To calculate the “death occurred after Policy Year T”, another column of “Policy year of death” is created, calculated by Year of death- Issue year which is also capped at 20 for the same reason. 

In the dataset, after data cleaning, the missing value in the column Year of Lapse and Year of Death is interpreted as “the event of death or lapse did not happen”, namely, the policyholder did not lapse or die within the 20 years. Therefore, it is reasonable to replace the blanks with 20. 

![image](https://github.com/Actuarial-Control-Cycle-T1-2024/group-page-showcase-pea/assets/101699608/3d54fc7c-e74b-426d-ae72-3a7dbf3a32d2)
Holding.length: the duration of the policyholders’ 
PYod: Policy Year of Death
obs_time: observation time

Appendix 4: Interest projection
Output: 
Through this, we have obtained the table on the right. This table shows the 10-year risk-free interest rate forecast, along with its critical confidence interval values.

![image](https://github.com/Actuarial-Control-Cycle-T1-2024/group-page-showcase-pea/assets/101699608/f2c9c0ab-41c8-4625-a9eb-4ca72a9d12d8)

Appendix 5: Face amount analysis by policy type weighted average calculation.

Taking T20 as an example, we first calculated the weighted average of face amount at each age We grouped them by the abovementioned segment and then calculated a further weighted average of each age group. We have also computed the percentage of each age group that takes up the population of a particular policy type.

Appendix 6. Cost Effectiveness of the Programs
| Cost Effectiveness | Intervention Names                                  |
|--------------------|-----------------------------------------------------|
| 0.016091954        | Wellness Programs                                   |
| 0.042857143        | Fitness Tracking Incentives                         |
| 0.011481056        | Smoking Cessation Programs                          |
| 0.014354067        | Annual Health Check-ups                             |
| 0.035555556        | Telemedicine Services                               |
| 0.133333333        | Healthy Eating Campaigns                            |
| 0.014354067        | Weight Management Programs                          |
| 0.025287356        | Mental Health Support                               |
| 0.013793103        | Financial Planning Assistance                       |
| 0.057142857        | Educational Workshops                               |
| 0.095238095        | Incentives for Vaccinations                         |
| 0.013793103        | Regular Dental Check-ups                            |
| 0.011494253        | Vision Care Programs                                |
| 0.177777778        | Safety Campaigns                                    |
| 0.023076923        | Driving Safety Courses                              |
| 0.034482759        | Heart Health Screenings                             |
| 0.014354067        | Chronic Disease Management                          |
| 0.076190476        | Sleep Hygiene Programs                              |
| 0.155555556        | Community Fitness Challenges                        |
| 0.00861244         | Discounted Gym Memberships                          |
| 0.133333333        | Online Health Resources                             |
| 0.020689655        | Personalized Health Plans                           |
| 0.133333333        | Well-being Apps                                     |
| 0.111111111        | Hydration Campaigns                                 |
| 0.133333333        | Sun Safety Awareness                                |
| 0.057142857        | Emergency Preparedness Training                     |
| 0.177777778        | Social Connection Initiatives                       |
| 0.104761905        | Holistic Stress Reduction                           |
| 0.066666667        | Financial Incentives for Healthy Behaviour          |
| 0.013793103        | Genetic Testing                                     |
| 0.020689655        | Alcohol Moderation Programs                         |
| 0.133333333        | Environmental Wellness                              |
| 0.018390805        | Employee Assistance Programs                        |
| 0.057142857        | Holistic Nutrition Education                        |
| 0.142857143        | Incentives for Preventive Screenings                |
| 0.020689655        | Holistic Health Assessments                         |
| 0.142857143        | Cancer Prevention Initiatives                       |
| 0.133333333        | Community Gardens                                   |
| 0.085714286        | Active Aging Programs                               |
| 0.076190476        | Home Safety Inspections                             |
| 0.104761905        | Mindfulness Programs                                |
| 0.133333333        | Parenting Support Services                          |
| 0.133333333        | Travel Safety Tips                                  |
| 0.057142857        | Financial Literacy Workshops                        |
| 0.085714286        | Hiking and Outdoor Activities Groups                |
| 0.085714286        | Cognitive Health Programs                           |
| 0.133333333        | Art and Creativity Classes                          |
| 0.020689655        | Mind-Body Wellness Retreats                         |
| 0.066666667        | Incentives for Regular Medication Adherence         |
| 0.057142857        | Ergonomic Workstation Assessments                   |
| 0.072716004        | average                                             |

## Reference list	















