#Data
revenue <- c(14574.49, 7606.46, 8611.41, 9175.41, 8058.65, 8105.44, 11496.28, 9766.09, 10305.32, 14379.96, 10713.97, 15433.50)
expenses <- c(12051.82, 5695.07, 12319.20, 12089.72, 8658.57, 840.20, 3285.73, 5821.12, 6976.93, 16618.61, 10054.37, 3803.96)

#Solution
# profit for each month
profit <- revenue - expenses
profit

# profit after tax for each month (tax rate is 30%)
after_tax <- round(profit * 0.70, 2)
after_tax

# profit margin for each month (equals to profit after tax divided by revenue)
profit_margin <- round(after_tax / revenue, 2) * 100
profit_margin

#good months - where the profit after tax was greater than the mean for the year
#bad months - where the profit after tax was less than the mean for the year
#the best month - where the profit after tax was max for the year
#the worst month - where the profit after tax was min for the year
N <- 12
M <- mean(after_tax)
M
good_months <- M < after_tax
bad_months <- M > after_tax



best_month <- after_tax == max(after_tax)
best_month
worst_month <- after_tax == min(after_tax)
worst_month

revenue_1000 <- round(revenue / 1000)
expense_1000 <- round(expenses / 1000)
profit_1000 <- round(profit / 1000)
after_tax_1000 <- round(after_tax / 1000)

total <- rbind(revenue_1000,
               expense_1000,
               profit_1000,
               after_tax_1000,
               good_months,
               bad_months,
               best_month,
               worst_month)

total


