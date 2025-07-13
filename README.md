# Modeling the Impact of Factors on Housing Prices in Qianzhen District, Kaohsiung

## Project Description

This project investigates the determinants of housing prices in Kaohsiung’s Qianzhen District using transaction data from 2017 to 2024. We analyze structural and locational variables using multiple regression models, including proximity to Light Rail Transit (LRT), building characteristics, and amenities. The findings are relevant to urban policy, housing affordability, and infrastructure planning.

## Getting Started

### Prerequisites

* R (version 4.0 or higher)
* Required R packages:

  ```r
  install.packages(c("readxl", "dplyr", "ggplot2", "segmented"))
  ```

### Data & Setup

1. Download the dataset `house price data 2.xlsx` and place it in your working directory.
2. Set your working directory:

   ```r
   setwd("~/Desktop/[your-folder]/house")
   ```
3. Run the regression analysis and generate output plots using the code in `analysis/housing_analysis.R`.

## File Structure

```
project-root/
├── README.md
├── data/
│   └── house price data 2.xlsx
├── figures/
│   ├── descriptivestats
│   ├── Figure1　shows the yearly trend of average unit prices from Year 106 to 113.

│   ├── Figure2　 illustrates the linear relationship between distance to the LRT station and unit price.

│   ├── Figure3　 compares unit prices by the presence of a building management organization. 

│   └── Figure4　presents unit prices grouped by parking availability. Homes with parking tend to have higher unit prices, supporting the idea that parking adds significant value to property.

```

## Analysis

### Research Problem

Which property-specific factors contribute most significantly to rising housing prices in Qianzhen District?

We employ four models:

* **Model 1**: Binary LRT accessibility (within 500m)
* **Model 2**: Continuous LRT distance (`lrtdis`)
* **Model 3**: Quadratic LRT distance (`lrtdis` + `lrtdis^2`)
* **Model 4**: Segmented regression estimating a threshold effect

### Sample R Code for Analysis

```r
library(dplyr)
library(readxl)
library(ggplot2)
library(segmented)

# Set working directory
setwd("~/Desktop/[your-folder]/house")

# Load dataset
data <- read_excel("house price data 2.xlsx")

# Model 1
model1 <- lm(總價 ~ 房 + 廳 + 衛 + 車位 + 有無管理組織 + 屋齡 + 土地移轉面積 + 建物移轉面積 + lrt, data = data)
summary(model1)

# Model 2
model2 <- lm(總價 ~ 房 + 廳 + 衛 + 車位 + 有無管理組織 + 屋齡 + 土地移轉面積 + 建物移轉面積 + lrtdis, data = data)
summary(model2)

# Model 3
model3 <- lm(總價 ~ 房 + 廳 + 衛 + 車位 + 有無管理組織 + 屋齡 + 土地移轉面積 + 建物移轉面積 + lrtdis + I(lrtdis^2), data = data)
summary(model3)

# Model 4
base_model <- lm(總價 ~ 房 + 廳 + 衛 + 車位 + 有無管理組織 + 屋齡 + 土地移轉面積 + 建物移轉面積 + lrtdis, data = data)
model4 <- segmented(base_model, seg.Z = ~lrtdis)
summary(model4)
plot(model4)
```

### Data Visualization

Additional plots include:

```r
# Yearly price trend
house_price_data_2_ %>%
  group_by(交易年) %>%
  summarise(avg_price = mean(單價元平方公尺, na.rm = TRUE)) %>%
  ggplot(aes(x = as.numeric(交易年), y = avg_price)) +
  geom_line(color = "steelblue") +
  labs(title = "Yearly Trend", x = "Year", y = "Avg Price/m²")

# Boxplot by building type
ggplot(house_price_data_2_, aes(x = 建物型態, y = 單價元平方公尺)) +
  geom_boxplot(fill = "lightblue") +
  coord_flip()

# Scatter: floor vs. price
ggplot(house_price_data_2_, aes(x = 樓層, y = 單價元平方公尺)) +
  geom_point(alpha = 0.3) +
  geom_smooth(method = "lm")

# Scatter: building area vs. price
ggplot(house_price_data_2_, aes(x = 建物移轉面積, y = 單價元平方公尺)) +
  geom_point(alpha = 0.3) +
  geom_smooth(method = "loess")
```

## Results

| Model | Key Finding                                         | R²     |
| ----- | --------------------------------------------------- | ------ |
| 1     | Within 500m: +NT\$454,629 (p < 0.01)                | 0.6828 |
| 2     | Each meter: -NT\$1,239 (p < 0.001)                  | 0.6872 |
| 3     | Quadratic effect: negative curvature                | 0.6882 |
| 4     | Breakpoint: 1,518m; stronger negative effect beyond | 0.6885 |

## Conclusion

* Building and land area positively affect price.
* Older houses are less valued.
* Parking availability adds value.
* Management presence slightly reduces price (possibly due to building type).
* Proximity to LRT strongly increases property value (especially within 1.5km).

## Contributors

* **111ZU1059 Chou Yi Lin** — Data Processing
* **112266002 Eric** — Data Cleaning
* **111405182 Tzu Jui Wang** — Model Design&Data Dnanlysis& coder& To Do List PM/Writer
* **113266005 TENG Yun** — Visualization & Interpretation
* **112266009 Sawa Tatsuki** — Documentation & Integration



## Acknowledgments

We sincerely thank the Ministry of the Interior (Taiwan) for providing open-access real estate transaction data, and our course instructors for their guidance and feedback.

## References

* Ministry of the Interior. (2024). *Real Estate Price Index*. [https://pip.moi.gov.tw](https://pip.moi.gov.tw)
* Rosen, S. (1974). *Hedonic prices and implicit markets: Product differentiation in pure competition*. *Journal of Political Economy*, 82(1), 34–55.
