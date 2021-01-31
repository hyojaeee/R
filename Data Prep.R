#Data Preparation practice

#get file from directory
getwd()
setwd("/Users/hyojae/Desktop/R Studio/Data Preparation")
fin <- read.csv("P3-Future-500-The-Dataset.csv", na.strings = c(""))

#Change ID/Inception/Industry to be Factor
str(fin)
fin$ID <- as.factor(fin$ID)
fin$Inception <- as.factor(fin$Inception)
fin$Industry <- as.factor(fin$Industry)

#using gsub to pattern matching
fin$Revenue <- gsub("\\$","",fin$Revenue)
fin$Revenue <- gsub(",","",fin$Revenue)
fin$Expenses <- gsub(" Dollars","",fin$Expenses)
fin$Expenses <- gsub(",","",fin$Expenses)
fin$Growth <- gsub("%","",fin$Growth)

#Change Revenue/Expenses/Profit to be numeral
fin$Revenue <- as.numeric(fin$Revenue)
fin$Expenses <- as.numeric(fin$Expenses)
fin$Growth <- as.numeric(fin$Growth)
str(fin)

#using which() for missing value
fin[!complete.cases(fin),]
fin[which(fin$Revenue==9746272),]

#using is.na() for missing value
fin[is.na(fin$Industry),]

#make backup for file
fin_backup <- fin

#removing records with missing data
fin <- fin[!is.na(fin$Industry),]

#resetting the dataframe index
rownames(fin) <- NULL
tail(fin)

#replacing missing data: Factual Analysis Method
fin[is.na(fin$State),]
fin[is.na(fin$State) & fin$City == "New York","State"] <- "NY"
fin[c(11,377),]
fin[is.na(fin$State) & fin$City == "San Francisco","State"] <- "CA"
fin[c(82,265),]
fin[!complete.cases(fin),]

#replacing missing data: Median computation method
med_ret_emp <- median(fin[fin$Industry == "Retail", "Employees"], na.rm = TRUE)
fin[is.na(fin$Employees) & fin$Industry == "Retail", "Employees"] <- med_ret_emp
fin[3,]
med_fin_emp <- median(fin[fin$Industry == "Financial Services", "Employees"], na.rm = TRUE)
fin[is.na(fin$Employees) & fin$Industry == "Financial Services", "Employees"] <- med_fin_emp
fin[330,]
med_cons_gro <- median(fin[fin$Industry == "Construction", "Growth"], na.rm = TRUE)
fin[is.na(fin$Growth) & fin$Industry == "Construction", "Growth"] <- med_cons_gro
fin[!complete.cases(fin),]
med_cons_rev <- median(fin[fin$Industry == "Construction", "Revenue"], na.rm = TRUE)
med_cons_exp <- median(fin[fin$Industry == "Construction", "Expenses"], na.rm = TRUE)
fin[is.na(fin$Revenue) & fin$Industry == "Construction", "Revenue"] <- med_cons_rev
fin[is.na(fin$Expenses) & fin$Industry == "Construction", "Expenses"] <- med_cons_exp

#replacing missing data: Deriving Values Method
fin[is.na(fin$Profit),"Profit"] <- fin[is.na(fin$Profit),"Revenue"] - fin[is.na(fin$Profit),"Expenses"]
fin[is.na(fin$Expenses),"Expenses"] <- fin[is.na(fin$Expenses),"Revenue"] - fin[is.na(fin$Expenses),"Profit"]
fin[c(8,15,42),]



