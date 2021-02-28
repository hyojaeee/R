#Deliverables:
#Vaccine types usage 
#Filter by December, January, February each (data updated: 02/20/21)
#Which country has highest count of vaccinations
#Daily vaccinations per country

library('dplyr')

#Connecting data 1
getwd()
setwd("/Users/hyojae/Desktop/R")
vaccine <- read.csv("country_vaccinations.csv")
head(vaccine)
summary(vaccine)
str(vaccine)
vaccine$vaccines <- as.factor(vaccine$vaccines)

#Connecting data 2
population <- read.csv("population_by_country_2020.csv")
head(population)
names(population)[1] <- "Country"
names(population)[2] <- "Population_2020"

#Changing date to Posixtime
vaccine$PosixTime <- as.POSIXct(vaccine$date, format = "%m/%d/%y")
head(vaccine, 5)

#Removing unnecessary columns 
vaccine$date <- NULL
vaccine$source_website <- NULL
head(vaccine)

#Extracting year and month from PosixTime
vaccine$year <- format(vaccine$PosixTime, format="%Y")
vaccine$month <- format(as.Date(vaccine$PosixTime, format="%m/%d/%y"),"%m")

#Merging two dataframes
df <- merge(vaccine, population, by.x = "country", by.y = "Country")
df$source_name <- NULL
df$Yearly.Change <- NULL
df$Net.Change <- NULL
df$Density..P.Km.. <- NULL
df$Land.Area..Km.. <- NULL
df$Migrants..net. <- NULL
df$Fert..Rate <- NULL
df$World.Share <- NULL
head(df)

#Filter vaccination by month: on Dec, Jan, or Feb
dec <- df[df$month == '12',]
jan <- df[df$month == '01',]
feb <- df[df$month == '02',]

#daily vaccinated columns on country and numbers
daily <- vaccine[c('country', 'daily_vaccinations')]

#Sum of daily vaccines for each country
library('data.table')
daily <- as.data.table(daily)
daily[, lapply(.SD, sum, na.rm = T), by = 'country']

#10 Highest numbers of daily vaccinations and countries
top10_daily <- daily[, lapply(.SD, sum, na.rm = T), by = 'country'] %>% top_n(10)

#plot
library('ggplot2')
p <- ggplot(data = top10_daily, aes(x = country, y = daily_vaccinations))
q <- p  + geom_bar(stat = 'identity', position = 'dodge', fill = '#234F1E') +
  scale_y_continuous(labels = scales::comma, breaks = scales::pretty_breaks(n = 10)) +
  scale_x_discrete(labels = c('United Arab Emirates' = 'UAE', 'United Kingdom' = 'UK', 'United States' = 'US')) +
  geom_text(stat = 'identity', aes(label = scales::comma(daily_vaccinations)), color = '#234F1E', 
            vjust = -0.9, nudge_y = 0.5, size = 2.5) 
  
q + ggtitle('Daily Vaccination Counts', subtitle = 'as of 2/20/21') + xlab('Country') + 
  ylab('Cumulative daily vaccine counts') + 
  theme(
    plot.title = element_text(color = '#234F1E', size = 16, face = 'bold.italic', hjust = 0.5),
    plot.subtitle = element_text(size = 8.5, face = 'italic', hjust = 0.65),
    axis.title.x = element_text(size = 10, face = 'bold'),
    axis.title.y = element_text(size = 10, face = 'bold')
  )


