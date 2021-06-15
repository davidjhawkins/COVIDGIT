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
ho <- fread("https://api.coronavirus.data.gov.uk/v2/data?areaType=ltla&metric=newCasesBySpecimenDateAgeDemographics&format=csv")
ho <- ho[,c(2,4,5,6)]
## need to subset the ages into detail and summary
## summary 00_59, 60+, unassigned
ho2 <- subset(ho, ho$age !="unassigned" & ho$age!="00_59" & ho$age!="60+")

ho2 <- subset(ho2, ho2$areaName=="Blackburn with Darwen")
hopp <- ggplot(ho2) +
  geom_point(aes(x=date, y=cases, colour=age), size=0.8, alpha=0.8)+
  geom_smooth(aes(x=date, y=cases, colour=age), span=0.2,se=F, fullrange=T, alpha=0.8)+
  ggtitle(paste(ho2$areaName[1],"New cases Source of data - coronavirus.gov.uk")) +
  ylim(0,NA) +
  facet_wrap(vars(age), scales="fixed")
ggplotly(hopp, dynamicTicks = T) %>% layout(showlegend=F, legend= list(x=0, y =1))
## log y-scale
hopp <- ggplot(ho) +
  geom_point(aes(x=date, y=newDeaths28DaysByPublishDate, colour=areaName), size=0.8, alpha=0.8)+
  geom_smooth(aes(x=date, y=newDeaths28DaysByPublishDate, colour=areaName), span=0.2,se=F, fullrange=T, alpha=0.8)+
  ggtitle("New deaths by region (daily with trend). Source of data - coronavirus.gov.uk") +
  ylim(0,NA) +
  scale_y_log10() +
  facet_wrap(vars(areaName), scales="fixed")
