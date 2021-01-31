# Homework 1
# Test the Law of Large Numbers for N random normally distributed 
# numbers with mean = 0, stdev = 1
# Create an R script that will count how many of these numbers fall 
# between -1 and 1 and divide by the total quantity of N
# E(X) = 68.2%

N <- 10000
counter <- 0
for (i in rnorm(N)) {
  if (i >= -1 & i <= 1) {
    counter <- counter + 1
  }
}

answer <- counter / N
answer


