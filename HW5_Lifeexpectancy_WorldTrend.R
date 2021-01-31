data <- read.csv(file.choose())
head(data)
df <- data.frame(Code = Country_Code, At.1960 = Life_Expectancy_At_Birth_1960, At.2013 = Life_Expectancy_At_Birth_2013)
head(df) 
str(data)
str(df)

merged <- merge(data, df, by.x = "Country.Code" , by.y = "Code")
head(merged)
str(merged)
?split()

At1960 <- data[data$Year == 1960,]
head(At1960)
At2013 <- data[data$Year == 2013,]
rm(merged)
tail(At2013)

rm(merged)
stat1960 <- merge(df, At1960, by.x = "Code", by.y = "Country.Code")
stat2013 <- merge(df, At2013, by.x = "Code", by.y = "Country.Code")

head(stat1960)
tail(stat1960)

stat1960$At.2013 <- NULL
str(stat1960)

head(stat2013)
tail(stat2013)
stat2013$At.1960 <- NULL
str(stat2013)

qplot(data = stat1960, x = Fertility.Rate, y = At.1960, size = I(2), color = Region, alpha = I(0.6), main = "Life Expectancy vs. Fertility Rate (1960)")

qplot(data = stat2013, x = Fertility.Rate, y = At.2013, size = I(2), color = Region, alpha = I(0.6), main = "Life Expectancy vs. Fertility Rate (2013)")





