library(dplyr)
library(readxl) 
library(ggplot2)
library(dplyr)
setwd("~/Desktop/  /house")

# 
library(readxl)

# 讀取資料
data <- read_excel("house price data 2.xlsx")


summary(model2)

library(dplyr)
house_price_data_2_ %>%
  group_by(交易年) %>%
  summarise(avg_price = mean(單價元平方公尺, na.rm = TRUE)) %>%
  ggplot(aes(x = as.numeric(交易年), y = avg_price)) +
  geom_line(color = "steelblue", size = 1.2) +
  geom_point(color = "navy") +
  labs(title = "Yearly Trend of Price per Square Meter",
       x = "Year",
       y = "Avg Price per m²")
ggplot(house_price_data_2_, aes(x = 建物型態, y = 單價元平方公尺)) +
  geom_boxplot(fill = "lightblue", outlier.color = "red", outlier.shape = 1) +
  coord_flip() +
  labs(title = "Price per m² by Building Type", x = "Building Type", y = "Price per m²")
ggplot(house_price_data_2_, aes(x = 樓層, y = 單價元平方公尺)) +
  geom_point(alpha = 0.3, color = "darkblue") +
  geom_smooth(method = "lm", color = "orange", se = FALSE) +
  labs(title = "Price per m² vs. Floor", x = "Floor", y = "Price per m²")
ggplot(house_price_data_2_, aes(x = 建物移轉面積, y = 單價元平方公尺)) +
  geom_point(alpha = 0.3, color = "seagreen") +
  geom_smooth(method = "loess", color = "darkgreen", se = FALSE) +
  labs(title = "Price per m² vs. Building Size", x = "Building Area (m²)", y = "Price per m²")


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

