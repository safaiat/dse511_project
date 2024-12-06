# Load required libraries
library(rvest)
library(dplyr)
library(ggplot2)
library(reshape2)

# Step 1: Fetch the webpage content
url <- 'https://www.basketball-reference.com/leagues/NBA_2024_per_game.html'
webpage <- read_html(url)

# Step 2: Parse the HTML content and extract the table
table <- webpage %>% html_node("#per_game_stats") %>% html_table(fill = TRUE)

# Step 3: Convert to a DataFrame
df <- as.data.frame(table)

# Step 4: Save the dataset locally for reproducibility
write.csv(df, "NBA_2024_per_game.csv", row.names = FALSE)
cat("Dataset saved as NBA_2024_per_game.csv\n")

# Step 5: Clean the DataFrame
df <- df %>%
  filter(Player != "" & Player != "Player") %>%
  mutate(across(where(is.character), as.character)) %>%
  mutate(across(where(is.numeric), ~ replace_na(., 0)))

# Step 6: Convert relevant columns to numeric for analysis
numeric_columns <- c('PTS', 'AST', 'TOV', 'TRB', 'STL', 'BLK')
df <- df %>%
  mutate(across(all_of(numeric_columns), as.numeric))

# Step 7: Check column names and availability for plotting
cat("Available Columns:", colnames(df), "\n")
missing_columns <- setdiff(numeric_columns, colnames(df))
if (length(missing_columns) > 0) {
  cat("Some columns are missing:", missing_columns, "\n")
}

# Step 8: Plot 1 - Points per Game Distribution
ggplot(df, aes(x = PTS)) +
  geom_histogram(bins = 20, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Distribution of Points per Game", x = "Points per Game", y = "Frequency") +
  theme_minimal()

# Step 9: Plot 2 - Assists vs. Turnovers
ggplot(df, aes(x = AST, y = TOV, color = Pos)) +
  geom_point(alpha = 0.7) +
  labs(title = "Assists vs. Turnovers by Position", x = "Assists per Game", y = "Turnovers per Game") +
  theme_minimal()

# Step 10: Plot 3 - Correlation Heatmap
correlation_data <- df %>% select(all_of(numeric_columns))
correlation_matrix <- cor(correlation_data, use = "complete.obs")
cor_melt <- melt(correlation_matrix, varnames = c("Var1", "Var2"), value.name = "value")

ggplot(cor_melt, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile(color = "gray80", size = 0.5) +
  geom_text(aes(label = sprintf("%.2f", value)), color = "black", size = 3) +
  scale_fill_gradient2(
    low = "blue", high = "red", mid = "white",
    midpoint = 0, limit = c(-1, 1), space = "Lab",
    name = "Correlation"
  ) +
  labs(title = "Correlation Heatmap of Selected NBA Stats (2024)", x = "Statistics", y = "Statistics") +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    axis.text.y = element_text(size = 10),
    panel.grid = element_blank(),
    legend.position = "right"
  )

# Step 11: Plot 4 - Top Scorers (Bar Plot)
top_scorers <- df %>% top_n(10, PTS)
ggplot(top_scorers, aes(x = reorder(Player, PTS), y = PTS, fill = Player)) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  coord_flip() +
  labs(title = "Top 10 Scorers in the NBA (Per Game)", x = "Player", y = "Points Per Game") +
  theme_minimal()

# Step 12: Radar Chart - Skill Comparison
radar_chart <- function(data, categories, player_name) {
  player_data <- data %>% filter(Player == player_name) %>% select(all_of(categories))
  if (nrow(player_data) == 0) {
    cat("Player", player_name, "not found in the dataset.\n")
    return()
  }
  player_values <- as.numeric(unlist(player_data))
  player_values <- c(player_values, player_values[1])  # Close the radar chart
  
  angles <- seq(0, 2 * pi, length.out = length(player_values))
  radar_df <- data.frame(
    category = c(categories, categories[1]),
    value = player_values,
    angle = angles
  )
  
  ggplot(radar_df, aes(x = angle, y = value)) +
    geom_polygon(fill = "blue", alpha = 0.3) +
    geom_line(color = "blue") +
    geom_point(color = "red") +
    coord_polar(start = 0) +
    scale_x_continuous(breaks = angles[-length(angles)], labels = categories) +
    labs(title = paste(player_name, "Skill Comparison")) +
    theme_minimal()
}

# Define categories and generate radar chart for LeBron James
radar_chart(df, numeric_columns, "LeBron James")

# Step 13: Plot 5 - Points vs. Rebounds by Position
ggplot(df, aes(x = PTS, y = TRB, size = AST, color = Pos)) +
  geom_point(alpha = 0.7) +
  scale_size_continuous(range = c(1, 10)) +
  labs(title = "Points vs. Rebounds (Bubble Size = Assists)", x = "Points Per Game", y = "Rebounds Per Game") +
  theme_minimal()

# Step 14: Plot 6 - Box Plot (Points by Position)
ggplot(df, aes(x = Pos, y = PTS, fill = Pos)) +
  geom_boxplot() +
  labs(title = "Points Per Game by Position", x = "Position", y = "Points Per Game") +
  theme_minimal()
