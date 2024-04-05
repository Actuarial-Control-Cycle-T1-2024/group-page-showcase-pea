



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
$$Lapse\ rate=\frac{number\ of\ lapse\ at\ policy\ year\ T}{Number\ of\ existing\ policies\ at\ policy\ year\ T}$$
Findings:  The graph below shows the likelihood of withdrawing from 20-year term insurance at each policy year. Universally, it shows a decreasing trend, which indicates that people are less and less likely to withdraw from their policy as time passes until the end of the policy is approaching. The intuition behind the surge is that policyholders have found themselves unable to make claims as the policy is ending. Therefore, they opt to withdraw from their policy to get a certain amount of refund before the policy is completely terminated

![trend of lapse rate](https://github.com/Actuarial-Control-Cycle-T1-2024/group-page-showcase-pea/assets/112842704/c355ae8b-f764-44e7-ba8c-75c4f1cb6b62)

Modelling 2: Smoker and Non-smoker face amount analysis:
Considering the profitability of an insurance product, it is essential to have underwriting before commencing a policy. For our products, we have analysed the difference in average face amount between smokers and non-smokers and by policy type. 
Methodology:
Since we want to analyse the face amount insured of smokers and non-smokers separately, we have split the dataset by “Smoker. Status”. Each group is analysed by policy types. 
Findings: 
| | T20 | SPWL |
|:---:|:---:|:---:|
| Smoker | 434,165 | 658,947 |
| Non-smoker | 618,139 | 771,984 |

The average face amount insured by smokers is lower than that of non-smokers. Especially for T20 policyholders, there is a significant gap between these two groups. Therefore, the market and premium revenue from the Smoker group are relatively smaller than those of the Non-Smoker group. 
Modelling 3: Projection of interest rate
Interest rate projection is required in such a process to model future cash flows in addition to the standard interest rate.
Methodology: 
A stochastic model is employed here to project the interest rate, as the covariates are not sufficiently provided for Lumania, where the randomness, variability, or uncertainty would also be considered. So, we used the Vasicek Model to forecast our 10-year risk-free rates. 
Firstly, we calculated the required parameters by MLE obtained from the entire dataset of the 10-year risk-free rate, then applied those parameters to our formula below. 
$$dr_t=\kappa(\theta-r_t )dt+\sigma dW_t$$
Then, we can obtain a series of $r_t=r_{t-1}+dr_{t-1}$ by iteration. 
We have also considered the possible fluctuation of interest rates. Similarly, we have generated another two paths for “r+1%” and “r-1%”, respectively, with the same approach.
Below is a graph of 10-year risk-free interest rate projection including “r+1%” (up), “r” (normal) and “r-1%”(down)
![interest proj](https://github.com/Actuarial-Control-Cycle-T1-2024/group-page-showcase-pea/assets/112842704/954e4d6d-94ba-4499-9028-eada5370b898)
For more details, refer to Appendix 4.
Modelling 4: Face amount distribution by age group for both policy types
Methodology: 
The levels of coverage, premiums, and terms may vary by policy type. In this sense, we conducted our face amount by their policy type first, as in T20 and SPWL, then we divided them into different age groups respectively, i.e., the age range of T20 is from 26 to 55, while of SPWL is 35 to 65 and each segment is five years. Then, we can obtain the Average column “Average FA” (Appendix 5) 
Output: 
|Product|Key Age|Age range|Average FA|Count(%)|
|:---:|:---:|:---:|:---:|:---:|
|T20|26|26-29|528272.8|13.30%|
|T20|30|30-35|575823.7|20.00%|
|T20|40|36-45|613664.2|33.40%|
|T20|50|46-50|630886.9|16.63%|
>Note:  The most representative age is selected as the critical age for following modelling.

#### Health Incentive Programs:
In our ongoing commitment to the well-being and safety of our policyholders, we could find two most cost-effective health incentive programs: the Safety Campaign and Social Connection Initiatives, as shown in Figure 3 (Appendix 6). These programs are designed to address significant health risks and improve our community's overall quality of life, mainly focusing on the unique needs of adults over 70. For detailed information on health incentive programs, please refer to Appendix 7
<img width="283" alt="image" src="https://github.com/Actuarial-Control-Cycle-T1-2024/group-page-showcase-pea/assets/112842704/f5585c8e-0441-4a1c-9e95-f0489bc02f50">

**Safety Campaign **
The significance of unintentional home injuries cannot be understated. Lundgren et al. (2009) pointed out that, compared to younger adults, adults aged more than 70 face more significant risks and more severe outcomes from safety-related injuries and deaths. A similar study by Runyan and Casteel found that for individuals aged 70 and older, home injuries are responsible for over 7,000 deaths and 1.7 million emergency room visits annually in the United States alone. Addressing this issue, DiGuiseppi et al. (2010) emphasized that conducting safety education can effectively reduce mortality rates, underscoring the importance of education to mitigate the risks associated with unintentional home injuries among the elderly.

**Social Connection**
In the contemporary world, the silent epidemic of social isolation is increasingly recognized as a significant public health concern. The risk of social isolation increases with age (National Academies of Sciences, 2020). The findings suggest that deficits in social relationships are not only related to mental health but also associated with physical health problems. Social isolation can increase the risk of coronary heart disease and stroke (Valtorta et al., 2015). 
The Social Connection Initiatives are introduced in health insurance as an interventional program encouraging social activities to foster community and reduce isolation. A meta-analysis has found that stronger social bonds may increase the survival rate by 50%, supporting the argument (Holt-Lunstad et al., 2010). Research shows that social connections can extend life, improve health, and improve well-being by influencing people’s minds, bodies, and behaviours—all impacting our health and life expectancy (CDC, 2023).


## Modelling and Pricing	
### Product General Information
<img width="795" alt="image" src="https://github.com/Actuarial-Control-Cycle-T1-2024/group-page-showcase-pea/assets/112842704/0b3c2884-19b8-4b56-90bc-4969e12ebe25">

### Underwriting
The underwriting philosophy and guidelines for SPWL and T20 are similar.
The information collected for the underwriting decision includes:
- Health disclosure questionnaire as part of NB Application Forms
- Medical history statement if the applicant has any medical history.
- Occupational and Lifestyle factors (e.g. smokers are excluded [Appendix 8])
  
With all the information, the underwriter is to decide the rating of the underwriting class. Based on different ratings, the possible underwriting decisions are:

- Agreed as standard
- Agreed with exclusion
- Sub-standard 
- Postpone
- Decline
The maximum sub-standard rate is up to 400% extra mortality.

Expenses:
Besides the cost of the Health Incentive Program, we assume a variety of expenses from acquisition cost (under the basis of both per policy and % of premium), maintenance fee, commission fee (% of premium), taxation (premium tax, stability fund tax and federal tax) and solvency margins (% of accumulative reserve, % of net amount at risk and % of premium).

Economic:
Since SuperLife mainly focuses on life products, we assume they prudently allocate their assets to long-term, risk-free targets.
Additionally, since the historical inflation fluctuated, we consider a fixed rate of 4% instead. We also assume that SuperLife’s hurdle rate is 5%.

Lapse:
There is no significant difference in benefit features between the new and old products, so the policyholder behaviour should be similar. For this reason, we apply the historical lapse rate from the inforce dataset. Note that SPWL is a whole-life product with a lump-sum payment, so there is no lapse.

Distribution:
We assume future policy distribution by pivotal ages with average face amount and percentage from the inforce dataset. Please refer to Appendix 9 Excel file in the sheet “Distribution”.


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
| Risks                                                  | Risk Mitigation Strategies                                                                                     |
|--------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------|
| Inflation Risk: The cost of implementing and maintaining health incentive programs may exceed projections due to inflation, impacting profitability. | Inflation risk hedging: A long-term contract with a service provider can mitigate inflation risks in a project. |
| Engagement Risk: Insured individuals may engage with the health incentive programs less than expected, reducing the effectiveness of these programs. | Engagement Strategies: Develop robust engagement strategies, like gamification or personalized goals, to encourage participation in health programs. |
| Model Risk: Difficulty in accurately measuring the health outcomes resulting from the incentives can lead to challenges in assessing the program's effectiveness. | Partnerships: Collaborate with healthcare providers and wellness experts to develop and refine incentive programs based on best practices and current research. |
| Long-Term Sustainability Risk: There might be concerns about the long-term sustainability of the incentives if health improvements do not lead to reduced claims. | Long-Term Incentive Adjustment: Review and adjust incentives over time to ensure they remain effective and sustainable in promoting healthier behaviours and reducing insurance claims. |
| Misuse Risk: There is a potential for misuse of health incentives, where individuals might find ways to exploit the system without actually improving their health. | Program Design: Create incentive programs that require demonstrable health improvements, such as biometric screenings, to qualify for benefits. |
| Regulation risk: Insurance programs must comply with ever-changing regulations, which can vary over time. | Dedicated Regulation Team: Stay informed about regulatory changes and adjust programs as needed. |
| Social impact risk: Large-scale health programs may have unexpected social impacts, such as increased stress or social dislocation due to changes in coverage or benefits. | Societal Monitoring: Monitor on social impacts and adjust programs to minimize adverse effects. Engage with people in the community to maintain social cohesion. |


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
### Appendix 1: Further Data Cleaning

Outlier Detection and Treatment: 
Identifying and addressing outliers in variables such as face amount and policyholder age, which could otherwise distort analysis findings.
These cleaning steps addressed significant data quality issues, laying a solid foundation for the subsequent analysis. The meticulous approach to preparing the dataset highlights the importance of accuracy and integrity in data analysis, ensuring that the insights drawn are reliable and actionable.

### Appendix 2: Tendency, distribution and key findings:

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

### Appendix 3: Detailed methodology of Trend of Lapse rate:

![1712298982727](https://github.com/Actuarial-Control-Cycle-T1-2024/group-page-showcase-pea/assets/101699608/244f958a-0833-41b0-8d11-393769b0f3e4)

As for the numerator, a new column named Holding is used to count the number of lapses at each policy year. Length is created and calculated by Lapsed year-Issue year, where the lapsed year is capped at 20 since the term insurance product of our interest is 20 years. Then, the number of each holding length can be counted. 
Then, as for the denominator, existing policies at policy year T are calculated by the group “alive and Holding duration longer than T-1 years” plus the group “death occurred after Policy Year T.” To calculate the “death occurred after Policy Year T”, another column of “Policy year of death” is created, calculated by Year of death- Issue year which is also capped at 20 for the same reason. 

In the dataset, after data cleaning, the missing value in the column Year of Lapse and Year of Death is interpreted as “the event of death or lapse did not happen”, namely, the policyholder did not lapse or die within the 20 years. Therefore, it is reasonable to replace the blanks with 20. 

![image](https://github.com/Actuarial-Control-Cycle-T1-2024/group-page-showcase-pea/assets/101699608/3d54fc7c-e74b-426d-ae72-3a7dbf3a32d2)
Holding.length: the duration of the policyholders’ 
PYod: Policy Year of Death
obs_time: observation time

### Appendix 4: Interest projection
Output: 
Through this, we have obtained the table on the right. This table shows the 10-year risk-free interest rate forecast, along with its critical confidence interval values.

![image](https://github.com/Actuarial-Control-Cycle-T1-2024/group-page-showcase-pea/assets/101699608/f2c9c0ab-41c8-4625-a9eb-4ca72a9d12d8)

### Appendix 5: Face amount analysis by policy type weighted average calculation.

Taking T20 as an example, we first calculated the weighted average of face amount at each age We grouped them by the abovementioned segment and then calculated a further weighted average of each age group. We have also computed the percentage of each age group that takes up the population of a particular policy type.

### Appendix 6. Cost Effectiveness of the Programs
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


![1712299297108](https://github.com/Actuarial-Control-Cycle-T1-2024/group-page-showcase-pea/assets/101699608/2ce45cd0-2ec2-44a6-b69b-233deaa6fcd2)

### Appendix 7: Detailed information on safety campaigns 

#### Home Safety inventions programs

1)	Fire safety education
The findings of Lehna et al. have underscored the importance of fire safety education. These studies reveal that home fire safety (HFS) education programs in the United States have notably improved HFS knowledge. Such programs are vital in enhancing the understanding of fire prevention strategies among older adults, ultimately contributing reducing fire-related incidents and fatalities.

3)	Fall prevention education (FPE)
WHO announced that fall-related deaths are highest among the age group over 70 (World Health Organization, 2021). According to Windle, Francis and Coomber, fall prevention education can effectively reduce injuries and deaths by educating fall behaviour and promoting fall risk awareness among older people.

#### Social Connection Initiatives

1)	 Befriending
Befriending provides support and social interaction through establishing friendships, usually by volunteers. Studies have shown that regular visits, phone contact, or attending social events together can reduce feelings of loneliness and depression and improve life satisfaction and social support (Butler & Sandra, 2006).

3)	Mentoring 
Activities include providing advice, sharing experiences, and providing support can increase self-esteem, self-confidence, and social skills, helping to reduce feelings of social isolation (Greaves & Farbus, 2006)

### Appendix 8: distribution and trend of smoking status
![image](https://github.com/Actuarial-Control-Cycle-T1-2024/group-page-showcase-pea/assets/101699608/85c2a6b1-dc5a-46fc-b089-31eb90dec5a2)
![image](https://github.com/Actuarial-Control-Cycle-T1-2024/group-page-showcase-pea/assets/101699608/a50d5d87-7255-4e69-8744-0129c37f3b34)

### Appendix 9. “Distribution” from Excel file

#### SPWL
| Age | PPP | FA       | Count   | Loading | NP    | GP    |
|-----|-----|----------|---------|---------|-------|-------|
| 26  | 1   | 770,000  | 16.10%  | 36.53%  | 3,531 | 5,563 |
| 30  | 1   | 770,000  | 19.43%  | 36.51%  | 3,807 | 5,997 |
| 40  | 1   | 770,000  | 32.17%  | 36.26%  | 4,588 | 7,199 |
| 50  | 1   | 770,000  | 16.17%  | 37.49%  | 5,494 | 8,790 |
| 55  | 1   | 770,000  | 16.13%  | 38.53%  | 5,989 | 9,742 |

#### T20
| Age | PPP | FA       | Count  | Loading | NP  | GP  |
|-----|-----|----------|--------|---------|-----|-----|
| 35  | 20  | 530,000  | 13.30% | 37.00%  | 19  | 31  |
| 40  | 20  | 580,000  | 20.00% | 29.41%  | 31  | 43  |
| 50  | 20  | 610,000  | 33.40% | 29.72%  | 77  | 109 |
| 60  | 20  | 630,000  | 16.63% | 30.00%  | 198 | 283 |
| 65  | 20  | 640,000  | 16.67% | 28.00%  | 327 | 454 |
### Appendix 10: Results
![image](https://github.com/Actuarial-Control-Cycle-T1-2024/group-page-showcase-pea/assets/101699608/6fc5640a-d8eb-4a10-a259-5681ca353801)
![image](https://github.com/Actuarial-Control-Cycle-T1-2024/group-page-showcase-pea/assets/101699608/0aa2ffbe-231a-4ffd-99c2-f60a912655a3)

## Reference list	

- Butler, S. (2006). Evaluating the Senior Companion Program. *Journal of gerontological social work*, 47, 45-70. [doi:10.1300/J083v47n01_05](https://doi.org/10.1300/J083v47n01_05).

- CDC (2023). How Does Social Connectedness Affect Health? Centers for Disease Control and Prevention. Available at: [CDC Website](https://www.cdc.gov/emotional-wellbeing/social-connectedness/affect-health.htm).

- DiGuiseppi, C., Jacobs, D. E., Phelan, K. J., Mickalide, A. D., & Ormandy, D. (2010). Housing Interventions and Control of Injury-Related Structural Deficiencies: A Review of the Evidence. *Journal of Public Health Management and Practice*, 16(5), S34-S43. [https://doi.org/10.1097/PHH.0b013e3181e28b10](https://doi.org/10.1097/PHH.0b013e3181e28b10).

- Greaves, C.J. & Farbus, L. (2006). Effects of creative and social activity on the health and well-being of socially isolated older people: outcomes from a mulit-method observational study. *The Journal of the Royal Society for the Promotion of Health*, vol 126, no 3, pp 133−142.

- Holt-Lunstad, J., Smith, T.B. and Layton, J.B. (2010). Social Relationships and Mortality Risk: A Meta-analytic Review. *PLoS Medicine*, 7(7). [doi:https://doi.org/10.1371/journal.pmed.1000316](https://doi.org/10.1371/journal.pmed.1000316).

- Runyan, C. W., & Casteel, C. (2004). The state of home safety in America. Facts about unintentional injuries in the home. 2nd ed. Washington DC: Home Safety Council.

- J, H.-L., Tb, S., M, B., T, H. and D, S. (2015). Loneliness and Social Isolation as Risk Factors for Mortality: A Meta-Analytic Review. *Perspectives on psychological science: a journal of the Association for Psychological Science*. Available at: [PubMed](https://pubmed.ncbi.nlm.nih.gov/25910392/).

- Lehna C, Merrell J, Furmanek S, Twyman S (2017) Home fire safety intervention pilot with urban older adults living in Wales. *Burns*, 43:69-75. Available at: [https://doi.org/10.1016/j.burns.2016.06.025](https://doi.org/10.1016/j.burns.2016.06.025).

- Lundgren, R.S., Kramer, C.B., Rivara, F.P., Wang, J., Heimbach, D.M., Gibran, N.S., et al. (2009). Influence of comorbidities and age on outcome following burn injury in older adults. *Journal of Burn Care Research*, 30(2):307-314. [http://dx.doi.org/10.1097/BCR.0b013e318198a416](http://dx.doi.org/10.1097/BCR.0b013e318198a416)PMID:19165104.

- National Academies of Sciences, E. (2020). Social Isolation and Loneliness in Older Adults: Opportunities for the Health Care System. National Academies Press. Available at: [National Academies Press](https://nap.nationalacademies.org/catalog/25663/social-isolation-and-loneliness-in-older-adults-opportunities-for-the).

- Valtorta, Nicole & Kanaan, Mona & Gilbody, Simon & Ronzi, Sara & Hanratty, Barbara. (2016). Loneliness and social isolation as risk factors for coronary heart disease and stroke: Systematic review and meta-analysis of longitudinal observational studies. *Heart*, 102. doi:10.1136/heartjnl-2015-308790.

- Windle, K., Francis, J. and Coomber, C. (2011). Preventing Loneliness and Social isolation: Interventions and Outcomes

- World Health Organization (2021). Falls. [online] World Health Organization. Available at: https://www.who.int/news-room/fact-sheets/detail/falls.













