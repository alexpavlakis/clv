# Set up
library(lubridate)
library(dplyr)
library(ggplot2)
library(ggrepel)
library(rstan)
options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)
source("https://raw.githubusercontent.com/alexpavlakis/themes/master/theme_acp.R")

# Generate fake data
N_purch <- 40
set.seed(56)
custs <- data.frame(customer_id = sample(c(1:10), replace = T, size = N_purch),
                    logged = seq.Date(from = date("2016-01-01"), 
                                      to = date("2018-05-01"),
                                      length.out = N_purch),
                    spending = round(rgamma(N_purch, 5, 0.05))) 

# Plot customer timeline
custs %>%
  mutate(prod_price = paste0("$", spending)) %>%
  ggplot() +
  aes(x = logged, y = customer_id) +
  geom_hline(yintercept = c(1:10),
             col = "grey1",
             lty = 2) +
  geom_point(pch = 3,
             cex = 2) +
  geom_text_repel(aes(label = prod_price),
            col = acp_blue,
            nudge_y = 0.2,
            size = 5) +
  scale_x_date("",
               limits = c(date("2016-01-01"), date("2020-01-01"))) +
  scale_y_continuous("",
                     limits = c(0.5, 10.5),
                     breaks = seq(1, 10, 1),
                     labels = paste("Customer", c(1:10))) +
  geom_vline(xintercept = now,
             col = acp_red,
             lty = 2,
             lwd = 0.5) +
  annotate("text", x = date("2019-04-01"), y = 5, 
           label = "?",
           col = acp_red,
           size = 50,
           family = "Times") +
  theme_acp() +
  theme(axis.line.y = element_blank(),
        panel.grid.major = element_blank(),
        axis.text.y = element_text(face = "bold"))

# Format data for modeling
start_day <- date(min(custs$logged))
end_day <- date("2018-05-20")

customer_data <- custs %>%
  group_by(customer_id) %>%
  summarise(x = n() - 1,
            t_x = difftime(max(logged), start_day, units = "days")/30.41,
            t_cal = difftime(end_day, min(logged), units = "days")/30.41,
            mx = mean(spending)) %>%
  arrange(-customer_id)

model_data <- list(
  x = customer_data$x,
  t_x = as.numeric(customer_data$t_x),
  t_cal = as.numeric(customer_data$t_cal),
  mx = customer_data$mx,
  N = nrow(customer_data),
  N_months = 20
)

# Fit model
model_fit <- stan(file = "full_clv.stan",
                  data = model_data,
                  chains = 3,
                  iter = 1000)

# Plot of posterior distributions of LTV
plot(model_fit, pars = "lt_val", ci_level = 0.8) +
  scale_y_continuous(labels = paste("Customer", seq(1, 10, 1)), 
                     breaks = 1:10) +
  scale_x_continuous(" ",
                     limits = c(0, 1250),
                     breaks = seq(0, 1250, 250),
                     labels = paste0("$", seq(0, 1250, 250))) +
  ggtitle("Distributions of customer spending over the next two years") +
  theme_acp() +
  theme(text = element_text(angle = 0))
