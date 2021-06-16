### tests per case with varying lag
#https://api.coronavirus.data.gov.uk/v2/data?areaType=utla&metric=newLFDTests&metric=uniqueCasePositivityBySpecimenDateRollingSum&metric=uniquePeopleTestedBySpecimenDateRollingSum&format=csv
#https://api.coronavirus.data.gov.uk/v2/data?areaType=ltla&metric=uniqueCasePositivityBySpecimenDateRollingSum&format=csv
library(data.table)
library(readxl)
library(tidyverse)
library(ggplot2)
library(plotly)
library(scales)
library(fasttime)
library(lubridate)
###
css <- fread("https://api.coronavirus.data.gov.uk/v2/data?areaType=ltla&metric=uniqueCasePositivityBySpecimenDateRollingSum&format=csv")
#ho <- ho[,c(2,4,5,6)]
#  subset(css, css$date >= "2021-01-01") & css$uniqueCasePositivityBySpecimenDateRollingSum >=6
csspp <- ggplot(css) +
  #geom_point(aes(x=date, y=uniqueCasePositivityBySpecimenDateRollingSum, colour=areaName), size=0.8, alpha=0.8)+
  geom_smooth(aes(x=date, y=uniqueCasePositivityBySpecimenDateRollingSum, colour=areaName), span=0.2,se=F, fullrange=T, alpha=0.8)+
  ggtitle("uniqueCasePositivityBySpecimenDateRollingSum Source of data - coronavirus.gov.uk") +
  ylim(0,NA) #+
  #facet_wrap(vars(areaName), scales="free")
ggplotly(csspp, dynamicTicks = T) %>% layout(showlegend=F)

## was %>% layout(showlegend=F, legend= list(x=0, y =1))