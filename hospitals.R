### Hospitalisations

library(data.table)
library(readxl)
library(tidyverse)
library(ggplot2)
library(plotly)
library(scales)
library(fasttime)
library(lubridate)
###
ho <- fread("https://coronavirus.data.gov.uk/api/v2/data?areaType=nhsRegion&metric=covidOccupiedMVBeds&metric=newAdmissions&format=csv")
ho <- ho[,c(2,4,5,6)]

hopp <- ggplot(ho) +
  geom_point(aes(x=date, y=newAdmissions, colour=areaName), size=0.8, alpha=0.8)+
  geom_smooth(aes(x=date, y=newAdmissions, colour=areaName), span=0.2,se=F, fullrange=T, alpha=0.8)+
  ggtitle("New admissions in Hospitals by region (daily with trend). Source of data - coronavirus.gov.uk") +
  ylim(0,NA) +
  facet_wrap(vars(areaName), scales="fixed")
ggplotly(hopp, dynamicTicks = T) %>% layout(showlegend=F, legend= list(x=0, y =1))
## log y-scale
hopp <- ggplot(ho) +
  geom_point(aes(x=date, y=newAdmissions, colour=areaName), size=0.8, alpha=0.8)+
  geom_smooth(aes(x=date, y=newAdmissions, colour=areaName), span=0.2,se=F, fullrange=T, alpha=0.8)+
  ggtitle("New admissions (log) in Hospitals by region (daily with trend). Data: coronavirus.gov.uk") +
  ylim(0,NA) +
  scale_y_log10() +
  facet_wrap(vars(areaName), scales="fixed")
ggplotly(hopp, dynamicTicks = T) %>% layout(showlegend=F, legend= list(x=0, y =1))

