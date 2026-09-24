# fixed_pipeline.R

library(tidyverse)
library(ggplot2)

# Load data
data(swiss)
df <- swiss

# Isolate provinces with Catholic percentage > 50 and flag them
high_catholic <- df |>
  filter(Catholic > 50) |>
  mutate(is_majority = TRUE)

# Calculate summary stats
summary_stats <- high_catholic |>
  summarize(
    avg_fertility = mean(Fertility, na.rm = TRUE),
    avg_education = mean(Education, na.rm = TRUE),
    max_ag = max(Agriculture, na.rm = TRUE)
  )

# Plot the results
plot <- ggplot(summary_stats, aes(x = avg_fertility, y = avg_education)) +
  geom_point(color = "red") +
  theme_minimal() +
  labs(title = "Fertility vs Education in Majority Catholic Swiss Provinces")

# Create outputs/ directory if it does not exist, then save the plot
if (!dir.exists("outputs")) {
  dir.create("outputs")
}
ggsave("outputs/my_plot.png", plot)
