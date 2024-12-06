# NBA Player Statistics Analysis - 2024 Season

## Problem Description
This project analyzes NBA player statistics from the 2024 season to gain insights into player performance and uncover relationships between key basketball metrics. The objective is to clean, process, and visualize the data to highlight patterns and trends in player performance.

## Data
The dataset is derived from [Basketball Reference's 2024 NBA season player statistics](https://www.basketball-reference.com/). It includes the following metrics:
- **PTS**: Points per game
- **AST**: Assists
- **TOV**: Turnovers
- **TRB**: Rebounds
- **STL**: Steals
- **BLK**: Blocks
- **Pos**: Player position

After processing, the data is structured into a clean, ready-to-analyze format using tools like **Pandas** (Python) or **Tidyverse** (R).

---

## Approach

### 1. Data Collection
- **Python**: 
  - Scrape the player statistics table using `requests` and `BeautifulSoup`.
  - Parse the data into a Pandas DataFrame.
- **R**: 
  - Use the `rvest` package to scrape the data.
  - Parse and structure the data into a DataFrame.

### 2. Data Cleaning
- Remove rows without player names and redundant headers.
- Fill missing values with `0`.
- Convert numeric columns to appropriate data types using:
  - Python: `astype`
  - R: `mutate`

### 3. Exploratory Data Analysis (EDA)
We perform the following EDA steps using **Matplotlib/Seaborn** (Python) or **ggplot2** (R):
- **Distribution of Points (PTS)**: Histogram to reveal scoring trends.
- **Assists vs. Turnovers**: Scatter plot, categorized by player position.
- **Correlation Analysis**: Heatmap of relationships among key metrics.
- **Top Scorers**: Bar plot of the top 10 players by points per game.
- **Skill Comparison**: Radar chart for specific player performance metrics.
- **Points vs. Rebounds**: Bubble plot with bubble size representing assists.
- **Points by Position**: Box plot comparing scoring distributions across player positions.

---

## Visualizations
### 1. Points Distribution (Histogram)
- **Description**: Displays the frequency and density of points per game (PTS), highlighting scoring trends.

### 2. Assists vs. Turnovers (Scatter Plot)
- **Description**: Shows the relationship between assists (AST) and turnovers (TOV), with points colored by player position.

### 3. Correlation Heatmap
- **Description**: Depicts statistical relationships among key metrics (PTS, AST, TRB) using correlation coefficients.

### 4. Top Scorers (Bar Plot)
- **Description**: Highlights the top 10 players by points per game, enabling quick comparisons.

### 5. Skill Comparison (Radar Chart)
- **Description**: Visualizes a specific player's performance metrics (PTS, AST, TRB, STL, BLK).

### 6. Points vs. Rebounds (Bubble Plot)
- **Description**: Examines the relationship between points and rebounds. Bubble size represents assists, while color indicates position.

### 7. Points by Position (Box Plot)
- **Description**: Compares scoring distributions across player positions, showing medians and variations.

---

## How to Run
### Python
1. Install dependencies:
   ```bash
   pip install pandas matplotlib seaborn beautifulsoup4

#### R
1. Install dependencies:
   ```bash
  install.packages(c("tidyverse", "rvest", "ggplot2", "ggradar", "corrplot"))

