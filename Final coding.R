library(dplyr)
library(readxl) 
setwd("~/Desktop/  /house")

# 
library(readxl)

# 讀取資料
data <- read_excel("house price data 2.xlsx")


summary(model2)




install.packages("segmented") 
library(segmented)




model1 <- lm(`總價` ~ 房 + 廳 + 衛 + 車位 + 有無管理組織 + 屋齡 + 土地移轉面積 + 建物移轉面積  + lrt, data = data)
summary(model1)


model2 <- lm(`總價` ~ 房 + 廳 + 衛 + 車位 + 有無管理組織 + 屋齡 + 土地移轉面積 + 建物移轉面積  + lrtdis, data = data)
summary(model2)


model3 <- lm(`總價` ~ 房 + 廳 + 衛 + 車位 + 有無管理組織 + 屋齡 + 土地移轉面積 + 建物移轉面積  + lrtdis + I(lrtdis^2), data = data)
summary(model3)


library(segmented)
base_model <- lm(`總價` ~房 + 廳 + 衛 + 車位 + 有無管理組織 + 屋齡 + 土地移轉面積 + 建物移轉面積  + lrtdis, data = data)
model4 <- segmented(base_model, seg.Z = ~lrtdis)
summary(model4)
plot(model4)

