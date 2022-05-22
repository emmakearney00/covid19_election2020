#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(sjPlot)
library(dplyr)
library(readr)
library(ggforce)
library(tidyverse)
library(shinythemes)
library(stargazer)
library(shinydashboard)

#Make sure your data is in the same folder as your app.R
#You should also do your data wrangling in a separate script and use
#write.csv() to save your final dataset

#This is for a csv but you can load data however you normal would
df10 <- read_csv("final_data4.csv") 


ui <- navbarPage(
  "Impact of COVID-19 on 2020 Presidential Election",
  tabPanel("Home", 
           titlePanel("Home"),
           h3("Project Background and Motivations"),
           p("This study of how the American public responded in the polls to the COVID-19 pandemic is preceded and motivated by several studies exploring public blame attribution in United States elections. Achen and Bartels (2004) establish the complexity in attribution of political responsibility in their exploration of electoral responses to “act of God”-like events—drought, flu, and shark attacks—occurring in the 20th century, and find blame attribution to be inconsistent across events. These findings point to the idea that our expectations for how the public attributes blame may not be accurate and motivate this analysis of the role of COVID-19 for the Republican party in the 2020 elections. 
             We can cautiously shape expectations about the impacts of COVID-19 based on an analysis of a more recent catastrophic event: Hurricane Katrina. Malhotra and Kuo (2008) explores public attribution of blame in response to Hurricane Katrina through the lens of partisanship bias as well as office bias (bias toward what government positions are to blame). These results offer significant evidence for what one might expect about the role of partisan bias in blame attribution in the 2020 elections: that Republicans will be less likely and Democrats more likely to punish Trump in the polls for COVID-19."),
           h3("Hypothesis"),
           p("The Counties with more exposure to COVID-19 will blame the Republican party more in the 2020 elections. In addition, Majority Democrat counties will blame Trump in the polls more significantly than majority Republican counties of the same level of exposure to COVID-19.")
           
           
  ),
  
  tabPanel("Data",
           titlePanel("Data"),
           h3("COVID-19 Deaths"), 
           p("I measure my main independent variable, COVID-19 deaths, as the total COVID-19 deaths per thousand people in the county population occurring in a county through October 31st of 2020. Data on county-level COVID-19 deaths is provided by", a(href = "https://usafacts.org/visualizations/coronavirus-covid-19-spread-map/", "USAFacts.")),
           p("Data on county-level population is provided by", a(href = "https://www.ers.usda.gov/data-products/county-level-data-sets/download-data/", "Economic Research Service"), "in the U.S. Department of Agriculture."), 
           h3("President Trump Vote Share"), 
           p("My dependent variable is the county level change in vote share for Trump between the 2016 and 2020 election. I calculated this variable by subtracting a county’s Trump vote share in 2016 from the county’s Trump vote share in 2020. Data for these elections comes from a", a(href = "https://github.com/tonmcg/US_County_Level_Election_Results_08-20", "GitHub"), 
             "source, Tony McGovern, who scraped the 2020 election at the county-level from results published by Fox News, Politico, and the New York Times. 2016 election results at the county-level are scraped from results published by Townhall.com."), 
           
  ),
  
  
  tabPanel("Checkpoint 3: Visualizations",
           fluidPage(
             theme = shinytheme("darkly"),
             plotOutput("plot1"),
             p("The mean COVID-19 deaths per thousand is .574. The median COVID-19 deaths per thousand is .400, standard deviation 0.614, and IQR .606."),
             plotOutput("plot2"),
             p("The mean change in GOP vote share between the 2016-2020 Presidential Elections is .014 percentage points, meaning Trump had a higher vote share of a county on average in 2020 than in 2016. The median change is approximately .012, the IQR .028, and the standard deviation .029."),
             plotOutput("plot3"), 
             p("The Pearson's correlation coefficient for the relationship between these variables is 0.068. Null hypothesis is that the correlation between COVID-19 deaths and change in vote share for Trump 2016-2020 is 0. Our alternative hypothesis is that there will be a negative correlation between COVID-19 deaths and change in vote share for Trump 2016-2020 (in line with the hypothesis that the public with greater exposure to COVID-19 will blame the incumbent president more for COVID-19). When we complete a correlation test and compute the test statistic, we fail to reject the null hypothesis at the 95% level of significance. The test statistic is 3.8205 and the 95% confidence interval includes 0."),
             uiOutput("lm2"),
              
             
           )),
  
  
  
  tabPanel("Checkpoint 3: Discussion",
           titlePanel("Analyses"),
           h3("Univariate Description Analysis"), 
           p("For COVID-19 Deaths per Thousand, the vast majority of counties are clustered between 0 and 2 (which we can also see on the scatterplot), and the distribution is very positively skewed. The intent of scaling covid deaths to per 1000 people was to account for the size of a county. As for GOP vote share change 2016-2020, the distribution is slightly left skewed which also reveals itself in the difference between the mean (0.014) and the median (.012).
"), 
           h3("Bivariate Description Analysis and Hypothesis Test for Correlation"), 
           p("Based on this preliminary analysis of the relationship between COVID-19 deaths and GOP vote share change 2016-2020, there appears to be a very weak association between these variables (we fail to reject the null that the correlation is 0). The simple regression actually indicates a statistically significant, though likely not practical, positive relationship: an additional death per thousand effects on average a .003 percentage point increase in GOP vote share. However, we have not yet controlled for other possible confounding variables such as party majority in a county, change in wage growth, or change in unemployment especially as a result of COVID-19. Going forward, these will be included in the regression. Aside from including control variables, the lacking relationship between these variables in my preliminary analysis does not mean there is nothing significant to be found here. My main hypothesis was that exposure to COVID-19 (via higher death count) would cause a lower vote share for Trump in 2020 compared to counties with lesser exposure to COVID-19. The data in aggregate may or may not support this once I include for control variables. But I also intend to study how each party punished or did not punish Trump for COVID-19 deaths, as well as how counties with older populations responded in the polls. Once we look at the data through a more refined lens, we might see a more significant relationship.")
  ),
  
  tabPanel("Checkpoint 4: Visualizations",
           fluidPage(
             theme = shinytheme("darkly"),
             uiOutput("lm1"),
             p("Old Dummy is a dummy variable that =1 if the county population as a percent of >60 population greater than the median, and =0 if less than the median. 2016 GOP Vote Share Dummy is a dummy variable =1 if the county's 2016 GOP Vote share is > .5 and = 0 if <= .5. Deviation from Baseline Unemployment is calculated as the difference in unemployment on 10/31/2020 from a county's baseline unemployment estimate (measured in percentage points"),
             plotOutput("plot4"),
             p(),
             plotOutput("plot5"),
             p() 
             
           )),
  tabPanel("Checkpoint 4: Discussion",
           titlePanel("Analyses"),
           h3("Regression Model overview"), 
           p("In this stage of my analysis, I am looking into how the effect of COVID-19 deaths on GOP Vote Share Change 2016-2020 is different for different county characteristics. The county characteristics are political affiliation (measured as a dummy of whether or not a county voted Majority Republican in 2016, “2015 GOP Vote Share Dummy” = 1 if GOP vote share > .5), and percent of old (> 60 years of age) population (“Old Dummy” = 1 if % old population > median). Lastly, I include Deviation from Baseline Unemployment as a control because change in economic conditions historically influences voting habits. 
"), 
           h3("Coefficient Estimates"), 
           p("Given the three-way interaction term, I will interpret my coefficient estimates as the marginal effect of COVID-19 deaths/thousand on GOP Vote Share change: DY/DX = 0.02 -0.021*Z - .017W + 0.02(ZW) where DY/DX is the marginal change in GOP Vote Share Change for every one increase in COVID-19 Deaths per Thousand, Z is the “2016 GOP Vote Share Dummy”, and W is the “Old Dummy”. The marginal effect for counties that voted majority Republican in 2016 and have an old (>60) population greater than the median is .002 (.2 percentage points). The marginal effect for counties that voted majority Republican in 2016 and have an old population less than the median is -.001 (.1 percentage points). The marginal effect for counties that did not vote majority Republican in 2016 and have an old (>60) population greater than the median is .003 (.3 percentage points). The marginal effect for counties that did not vote majority Republican in 2016 and have an old (>60) population less than the median is .02 (2 percentage points). All my coefficient estimates are statistically significant at the .01 level of significance."),
           h3("Hypothesis Test and Model Fit"),
           p("All my estimates are statistically significant to the .01 level of significance, however, 
my adjusted R^2 value is .070, meaning my model explains 7% of the variation in the dependent variable. This implies a lot of the data is left unexplained, but comparing it to the simpler version of this regression model without the interaction terms, this model version explains about 4% more variation. The implications of a low R^2 need to be considered when interpreting the prediction models. My RSE is also very high (0.028) at 2.8 percentage points relative to the magnitude of my coefficient estimates. 
"),
           h3("Predictions"), 
           p("When we look at the prediction plots, some of the results are puzzling. In counties that had a <.5 Republican vote share in 2016, both young and old counties saw a positive effect of COVID-19 deaths per thousand on the GOP Vote Share Change, younger counties with a much stronger positive effect than older counties. 
In counties that had a >.5 Republican vote share in 2016, COVID-19 Deaths per Thousand appears to have effects of much less magnitude. The effect of COVID-19 deaths for younger counties was negative and for older counties was positive. 
I have included a separate plot with the data points visible to show that the prediction lines do a quite poor job with the data as a whole, and this is also reflected in the adjusted R^2 value of 0.070. 
"),
           h3("Discussion"), 
           p("My original hypothesis was that counties with more “exposure” to COVID-19 will blame the Republican party more in the 2020 election, and that Republican counties will blame the Republican Party for COVID-19 deaths less than Democrat counties. I also posited that older counties would blame the Republican Party in the polls more because they are one of the most threatened by the virus. The results of my model do not provide evidence that these hypotheses are true. For every category of county except for counties that were young (Old Dummy = 0) and Republican (2016 Vote Share Dummy = 1), the marginal effect of COVID-19 Deaths per Thousand is positive, which would suggest increased exposure to COVID-19 via more deaths did not result in any punishment in the polls. Looking at the political inclinations of a county only, it appears that the marginal effect was positive for both (.0115 for non-Republican Majority counties and .0005 for Republican Majority counties), and it is especially surprising to see non-Republican Majority counties actually see a greater marginal effect on GOP Vote Share Change over Republican Majority counties. Looking at county age only, the marginal effect was positive for both (.0025 for older counties and .0095 for younger counties). Older counties hesitated to increase their vote share compared to younger counties, but the positive coefficients are puzzling with respect to my hypothesis and background literature. Although my coefficients are statistically significant, I think there are limited conclusions that can be drawn from this study because of the significant amount of unexplained variability in the data. Nevertheless, the limited evidence this study provides suggests that generally, more exposure to COVID-19 via death effected an increase in GOP Vote Share Change 2016-2020 on the county level. 

")
  ),
  
  tabPanel("About", 
           titlePanel("About"),
           h3("About Me"),
           p("My name is Emma Kearney and I am an A.B Candidate in Economics at Harvard College. 
             You can reach me at emmakearney@college.harvard.edu.")
  )
)

server <- function(input, output, session) {
  m.lm <- lm(gop_vote_share_change ~ deaths_per_thousand + dummy_2016 + dummy_old + deaths_per_thousand * dummy_2016 + dummy_2016*dummy_old + deaths_per_thousand*dummy_old + deaths_per_thousand * dummy_2016 *dummy_old + PU_change, data=df10)
  output$lm1 <- renderUI(HTML(stargazer(m.lm, type="html", title = "Linear Regression Model of the GOP Vote Share Change with Interaction",
                                        dep.var.labels = "Change in GOP Vote Share", 
                                        covariate.labels = c("COVID-19 Deaths Per Thousand", "2016 GOP Vote Share Dummy", "Old Dummy", "Deviation from Baseline Unemployment Percent", "COVID-19 Deaths Per Thousand * 2016 GOP Vote Share Dummy", "2016 GOP Vote Share Dummy * Old Dummy", "COVID-19 Deaths Per Thousand * Old Dummy", "COVID-19 Deaths Per Thousand*2016 GOP Vote Share Dummy * Old Dummy"))))
  s.lm <- lm(gop_vote_share_change ~ deaths_per_thousand, data = df10)
  output$lm2 <- renderUI(HTML(stargazer(s.lm, type = "html", title = "Linear Regression Model of the GOP Vote Share Change",
                                        dep.var.labels = "Change in GOP Vote Share", 
                                        coviaraite.labels = "COVID-19 Deaths Per Thousand")))
  
  output$plot1 <- renderPlot({
    ggplot(df10, aes(x = deaths_per_thousand)) +
      geom_histogram(color = "white", binwidth = .25) +
      geom_vline(aes(xintercept = mean(deaths_per_thousand)), color = "red", linetype = "dotted") +
      annotate("text", x = 1, y = 500, 
               label = paste0("Mean = ", 
                              round(mean(df10$deaths_per_thousand, na.rm = TRUE), 3))) +
      labs(title = "County-Level COVID-19 Deaths per Thousand as of 31 October 2020: Right-Skewed", 
           x = NULL, 
           y = "Frequency", 
           caption = "Source: USAFacts") 
  }, res = 96)
  
  output$plot2 <- renderPlot({
    ggplot(df10, aes(x = gop_vote_share_change)) + 
      geom_histogram(color = "white", binwidth = .017) +
      geom_vline(aes(xintercept = mean(gop_vote_share_change)), color = "red", linetype = "dotted") +
      annotate("text", x = .05, y = 1000, 
               label = paste0("Mean = ", 
                              round(mean(df10$gop_vote_share_change, na.rm = TRUE), 3))) +
      labs(title = "Histogram of GOP Vote Share Change 2016-2020: Slightly Left-Skewed", 
           x = "GOP Vote Share Change (percentage points)", 
           y = "Frequency", 
           caption = "Source: Tony McGovern")
  }, res = 96)
  
  output$plot3 <- renderPlot({
    ggplot(df10, aes(x = deaths_per_thousand, y = gop_vote_share_change)) +  
      geom_point() + 
      geom_smooth(color = "orange", se = FALSE, method = "lm") +
      labs(title = "Weak Association Between COVID-19 Deaths and GOP Vote Share Change 2016-2020", 
           x = "COVID-19 Deaths per Thousand", 
           y = "GOP Vote Share Change 2016-2020", 
           caption = "Source: COVID-19 data provided by USAFacts, Election data provided by Tony McGovern") 
    
  }, res = 96)
  
  output$plot5 <- renderPlot({
    plot_model(m.lm, 
               type = "pred",
               terms = c("deaths_per_thousand", "dummy_old", "dummy_2016"), 
               show.data = TRUE, 
               title = "Predicted Values of GOP Vote Share Change as a Function of COVID-19 \nDeaths Per Thousand")
  }, res = 96)
  
  output$plot4 <- renderPlot({
    plot_model(m.lm, 
               type = "pred",
               terms = c("deaths_per_thousand", "dummy_old", "dummy_2016"), 
               title = "Predicted Values of GOP Vote Share Change as a Function of COVID-19 \nDeaths Per Thousand")
    
  }, res = 96)
  
  
}

shinyApp(ui = ui, server = server)
