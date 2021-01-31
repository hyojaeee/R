#Deliverables:
#Character: Machine name
#Vector: (min, mean, max) utilisation for the month (excluding unknown hours)
#Logical: Has utilisation ever fallen below 90%? TRUE / FALSE
#Vector: All hours where utilisation is unknown (NA’s)
#Dataframe: For this machine
#Plot: For all machines

getwd()
setwd("/Users/hyojae/Desktop/R Studio/Lists")
util <- read.csv("P3-Machine-Utilization.csv")
str(util)
summary(util)
util$Timestamp <- as.factor(util$Timestamp)
util$Machine <- as.factor(util$Machine)

#Derive utilization column
util$Utilization <- 1 - util$Percent.Idle 
head(util,12)

#Handling Date - Times in R
?POSIXct #integer type
util$PosixTime <- as.POSIXct(util$Timestamp, format = "%d/%m/%Y %H:%M")
head(util,12)

#Remove column
util$Timestamp <- NULL

#change arrangement of column
util <- util[,c(4,1,2,3)]

RL1 <- util[util$Machine == "RL1",]
summary(RL1)
RL1$Machine <- factor(RL1$Machine)    #removing other factors

util_stats_rl1 <- c(min(RL1$Utilization, na.rm = T),
                    mean(RL1$Utilization, na.rm = T),
                    max(RL1$Utilization, na.rm = T))

util_under_90 <- length(which(RL1$Utilization < 0.90)) > 0
#as.logical(length(which(RL1$Utilization == 100)))

list_rl1 <- list("RL1", util_stats_rl1, util_under_90)

#naming components of a list
names(list_rl1)
names(list_rl1) <- c("Machine", "Stats", "LowThreshold")

#Another way
rm(list_rl1)
list_rl1 <- list(Machine = "RL1", Stats = util_stats_rl1, LowThreshold = util_under_90)
list_rl1

#practice
list_student <- list(Name = c("Lisa","Craig"), Grade = "Freshman", Major = "Geology", GPA = "3.28")
list_student

#Extracting components of a list
#three ways:
#[] - will always return a list
#[[]] - will always return the actual object
#$ - same as [[]], but prettier

list_rl1
list_rl1[1]
list_rl1[[1]]
list_rl1$Machine

list_rl1[[2]][3]
list_rl1$Stats[3]

#Adding and Deleting list components
list_rl1
list_rl1[7] <- "New Information"

RL1[is.na(RL1$Utilization),]
list_rl1$UnknownHours <- RL1[is.na(RL1$Utilization),"PosixTime"]


#Remove a component, use NULL
list_rl1[4] <- NULL
#!!Notice: numeration has shifted
list_rl1[6] <- NULL
list_rl1[5] <- NULL

#Adding Dataframe
list_rl1$Data <- RL1
list_rl1
summary(list_rl1)
str(list_rl1)

#Subset a list
list_rl1[[4]][1]
list_rl1$UnknownHours[1]

list_rl1[1:3]
list_rl1[c(1,4)]
sublist_rl1 <- list_rl1[c("Machine", "Stats")]
sublist_rl1[[2]][2]
#double square brackets are NOT for subsetting
#list_rl1[[1:3]]  -- this would not work Error

#Building a timeseries plots
library(ggplot2)
p <- ggplot(data = util)
p + geom_line(aes(x = PosixTime, 
                  y = Utilization,
                  color = Machine),
              size = 1.0) + 
  facet_grid(Machine~.) +
  geom_hline(yintercept = 0.90, 
             color = "Grey",
             size = 1.0,
             linetype = 3)

myplot <- p + geom_line(aes(x = PosixTime, 
                            y = Utilization,
                            color = Machine),
                        size = 1.0) + 
  facet_grid(Machine~.) +
  geom_hline(yintercept = 0.90, 
             color = "Grey",
             size = 1.0,
             linetype = 3)

list_rl1$Plot <- myplot
list_rl1
summary(list_rl1)
