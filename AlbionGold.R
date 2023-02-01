library(lubridate)
library(tidyverse)
df <- read.csv('data/gold_data.csv')
df$date <- as.POSIXct(df$date, format="%Y-%m-%d")
head(df)
df %>%
  group_by(year=floor_date(date, "year")) %>%
  summarize(average_price=mean(price)) %>% 
  mutate(annual_growth_rate=(average_price/lag(average_price) - 1) * 100)
df %>%
  group_by(month=floor_date(date, "month")) %>%
  summarize(average_price=mean(price)) %>% 
  mutate(month_growth_rate=(average_price/lag(average_price) - 1) * 100)
ggplot(data=df)+
  geom_smooth(mapping=aes(x=date,y=price))+
  xlab("Year") + ylab('Price per gold in silver')
df_bar <- df %>%
  group_by(year=floor_date(date, "year")) %>%
  summarize(average_price=mean(price)) %>% 
  mutate(annual_growth_rate=(average_price/lag(average_price) - 1) * 100)
ggplot(data=df_bar)+
  geom_col(mapping=aes(x=year,y=average_price,fill=average_price))+
  xlab("Year") + ylab('Price per gold in silver')+
  guides(fill=guide_legend(title="Average Price"))+
  labs(title="Price per gold in silver vs. Year", subtitle='Albion Online',
       caption="Data collected by albion-online-data")
