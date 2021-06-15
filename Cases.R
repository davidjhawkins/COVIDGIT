### Cases from gov.uk
library(data.table)
library(readxl)
library(tidyverse)
library(ggplot2)
library(plotly)
library(scales)
library(fasttime)
library(lubridate)
###
LAcases <- fread("https://api.coronavirus.data.gov.uk/v2/data?areaType=ltla&metric=newCasesBySpecimenDateAgeDemographics&format=csv")
LAcases <- LAcases[,c(2,4,5,6)]
## need to subset the ages into detail and summary
## summary 00_59, 60+, unassigned
LAcases2 <- subset(LAcases, LAcases$age !="unassigned" & LAcases$age!="00_59" & LAcases$age!="60+")

LAcases2 <- subset(LAcases2, LAcases2$areaName=="Blackburn with Darwen")
LAcasespp <- ggplot(LAcases2) +
  geom_point(aes(x=date, y=cases, colour=age), size=0.8, alpha=0.8)+
  geom_smooth(aes(x=date, y=cases, colour=age), span=0.2,se=F, fullrange=T, alpha=0.8)+
  ggtitle(paste(LAcases2$areaName[1],"New cases Source of data - coronavirus.gov.uk")) +
  ylim(0,NA) +
  facet_wrap(vars(age), scales="fixed")
ggplotly(LAcasespp, dynamicTicks = T) %>% layout(showlegend=F, legend= list(x=0, y =1))
## log y-scale
# LAcasespp2 <- ggplot(LAcases) +
#   geom_point(aes(x=date, y=cases, colour=areaName), size=0.8, alpha=0.8)+
#   geom_smooth(aes(x=date, y=cases, colour=areaName), span=0.2,se=F, fullrange=T, alpha=0.8)+
#   ggtitle(paste(LAcases2$areaName[1],"New cases Source of data - coronavirus.gov.uk")) +
#   ylim(0,NA) +
#   scale_y_log10() +
#   facet_wrap(vars(areaName), scales="fixed")
# ggplotly(LAcasespp, dynamicTicks = T) %>% layout(showlegend=F, legend= list(x=0, y =1))

