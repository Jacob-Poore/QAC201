# Mars Crater Research Project - R Script
# Author: Jacob Poore

# Load Libraries ----
library(descr)
library(ggplot2)

# Load Data ----
# Download the Mars Crater Database online
# Save as "marscrater_pds.RData" in your working directory
# Or modify the path below to point to your data file location

load("marscrater_pds.RData")
MARS <- marscrater_pds

# Primary Filter: keep only rows with at least one morphology ejecta classification
MARS <- MARS[
  MARS$morphology_ejecta_1 != "" |
    MARS$morphology_ejecta_2 != "" |
    MARS$morphology_ejecta_3 != "", ]

# Frequency Distributions ----
freq(MARS$morphology_ejecta_1)
freq(MARS$morphology_ejecta_1 == "Rd")
freq(MARS$diam_circle_image)

# Data Management ----
MARS$diameter <- MARS$diam_circle_image
MARS$depth <- MARS$depth_rimfloor_topog
MARS$ejecta_type <- MARS$morphology_ejecta_1
MARS$depth[MARS$depth == 0 ] <- NA
MARS$diameter[MARS$diameter == 0 ] <- NA

MARS$depth_diameter_ratio <- MARS$depth / MARS$diameter
MARS$depth_diameter_ratio[MARS$depth_diameter_ratio == 0 ] <- NA

MARS$ejecta_complex[MARS$morphology_ejecta_2 == "" & MARS$morphology_ejecta_3 == ""] <- 0
MARS$ejecta_complex[MARS$morphology_ejecta_2 == "" & MARS$morphology_ejecta_3 != ""] <- 1
MARS$ejecta_complex[MARS$morphology_ejecta_2 != "" & MARS$morphology_ejecta_3 == ""] <- 1
MARS$ejecta_complex[MARS$morphology_ejecta_2 != "" & MARS$morphology_ejecta_3 != ""] <- 2

MARS$layers <- MARS$number_layers
MARS$lat <- MARS$latitude_circle_image
MARS$lon <- MARS$longitude_circle_image

MARS$ejecta_complex <- as.factor(MARS$ejecta_complex)

MARS$hemisphere <- ifelse(MARS$lat >= 0, "Northern", "Southern")
MARS$abs_lat <- abs(MARS$lat)
MARS$log_diameter <- log(MARS$diameter)
MARS$log_depth <- log(MARS$depth)

ejecta_freq <- as.data.frame(table(MARS$ejecta_type))
ejecta_freq <- ejecta_freq[order(-ejecta_freq$Freq), ]


# Exploratory Visualizations ----
freq(MARS$ejecta_complex)

ggplot(data=MARS)+ 
  geom_histogram(aes(x=diameter)) +
  ylab("Count of Diameter Size") + 
  ggtitle("Histogram of Diameter Size")

ggplot(data=MARS)+ 
  stat_summary(aes(x=ejecta_complex,y=depth_diameter_ratio),fun=mean,geom="bar") +
  geom_smooth(aes(x=ejecta_complex,y=depth_diameter_ratio),method="lm") + 
  ylab("Mean of Depth Diameter Ratios") + 
  ggtitle("Mean of Depth Diameter Ratios by Ejecta Classification")

ggplot(data=MARS)+ 
  stat_summary(aes(x=ejecta_complex,y=diameter),fun=mean,geom="bar") +
  geom_smooth(aes(x=ejecta_complex,y=diameter),method="lm") + 
  ylab("Mean of Diameter Size") + 
  ggtitle('Mean of Diameter Size by Ejecta Classification "Complexity"')

ggplot(data=MARS) + 
  stat_summary(aes(x=ejecta_type, y=depth)) +
  theme(legend.position = "none") +
  ggtitle("Crater Depth Distribution by Ejecta Type") +
  xlab("Ejecta Type") +
  ylab("Depth (m)")

ggplot(data=MARS) + 
  geom_histogram(aes(x=depth), bins=40, fill="coral") +
  ggtitle("Distribution of Crater Depths") +
  xlab("Depth (m)") +
  ylab("Count")

ggplot(data=MARS) + 
  geom_point(aes(x=diameter, y=depth_diameter_ratio, color=factor(ejecta_complex)), alpha=0.5) +
  ggtitle("Depth-Diameter Ratio vs Diameter by Complexity") +
  xlab("Diameter (km)") +
  ylab("Depth-Diameter Ratio") +
  labs(color="Ejecta Complexity")

ggplot(data=MARS) + 
  stat_summary(aes(x=factor(ejecta_complex), y=depth_diameter_ratio),
               fun.data=mean_se, geom="errorbar", width=0.5) +
  stat_summary(aes(x=factor(ejecta_complex), y=depth_diameter_ratio),
               fun=mean, geom="point", size=3, color="red") +
  ggtitle("Mean Depth-Diameter Ratio with Standard Error") +
  xlab("Ejecta Complexity") +
  ylab("Depth-Diameter Ratio")

ggplot(data=MARS) + 
  geom_bar(aes(x=factor(ejecta_complex), fill=factor(ejecta_complex))) +
  ggtitle("Count of Craters by Ejecta Complexity") +
  xlab("Ejecta Complexity Level") +
  ylab("Count") +
  labs(fill="Complexity")

ggplot(data=MARS) + 
  geom_density(aes(x=diameter, fill=ejecta_type), alpha=0.5) +
  ggtitle("Diameter Density Distribution by Ejecta Type") +
  xlab("Diameter (km)") +
  ylab("Density")

ggplot(data=MARS) + 
  geom_density(aes(x=depth_diameter_ratio, fill=factor(ejecta_complex)), alpha=0.5) +
  ggtitle("Depth-Diameter Ratio Density by Complexity") +
  xlab("Depth-Diameter Ratio") +
  ylab("Density") +
  labs(fill="Ejecta Complexity")+
  theme_minimal()

ggplot(data=MARS) + 
  geom_point(aes(x=diameter, y=depth, color=ejecta_type, size=depth_diameter_ratio), alpha=0.5) +
  theme(legend.position = "none") +
  ggtitle("Crater Depth vs Diameter with Ratio as Size") +
  xlab("Diameter (km)") +
  ylab("Depth (km)") +
  labs(size="Depth/Diameter Ratio")

# Statistical Analysis ----
# ANOVA
anova <- aov(depth_diameter_ratio ~ ejecta_complex, data = MARS)
summary(anova)
TukeyHSD(anova)

# Linear Regression ----
MARS$ejecta_complex_numeric <- as.numeric(as.character(MARS$ejecta_complex))
regression_model <- lm(depth_diameter_ratio ~ ejecta_complex_numeric, data = MARS)
summary(regression_model)

ggplot(data = MARS, aes(x = ejecta_complex_numeric, y = depth_diameter_ratio)) +
  geom_jitter(aes(color = factor(ejecta_complex_numeric)), alpha = 0.3, width = 0.1, height = 0) +
  geom_smooth(method = "lm", se = TRUE, color = "blue", fill = "lightblue") +
  labs(title = "Linear Regression: Depth-Diameter Ratio by Ejecta Complexity",
       x = "Ejecta Complexity Level (0=Simple, 1=Moderate, 2=Complex)",
       y = "Depth-Diameter Ratio",
       color = "Complexity Level") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5))

ggplot(data = MARS, aes(x = factor(ejecta_complex_numeric), y = depth_diameter_ratio)) +
  geom_boxplot(aes(fill = factor(ejecta_complex_numeric)), alpha = 0.5) +
  geom_smooth(aes(x = ejecta_complex_numeric, y = depth_diameter_ratio), 
              method = "lm", se = TRUE, color = "red", size = 1.2) +
  labs(title = "Depth-Diameter Ratio by Ejecta Complexity with Linear Trend",
       x = "Ejecta Complexity Level",
       y = "Depth-Diameter Ratio",
       fill = "Complexity") +
  theme_minimal()

ggplot(data = MARS, aes(x = diameter, y = depth)) +
  geom_point(aes(color = factor(ejecta_complex_numeric)), alpha = 0.4) +
  geom_smooth(method = "lm", se = TRUE, color = "darkgreen", fill = "lightgreen") +
  labs(title = "Linear Regression: Crater Depth by Diameter",
       x = "Crater Diameter (km)",
       y = "Crater Depth (km)",
       color = "Ejecta Complexity") +
  theme_minimal()

# Multiple Regression ----
multiple_regression_model <- lm(depth_diameter_ratio ~ ejecta_complex+ ejecta_type + diameter + abs(lat) + abs(lon) + layers, data = MARS)
summary(multiple_regression_model)
confint(multiple_regression_model)

ggplot(data = MARS, aes(x = ejecta_complex_numeric, y = depth_diameter_ratio)) +
  geom_jitter(aes(color = diameter), alpha = 0.3, width = 0.1, height = 0) +
  geom_smooth(method = "lm", se = TRUE, color = "blue", fill = "lightblue") +
  scale_color_gradient(low = "yellow", high = "purple") +
  labs(title = "Multiple Regression: Depth-Diameter Ratio by Ejecta Complexity",
       x = "Ejecta Complexity Level (0=Simple, 1=Moderate, 2=Complex)",
       y = "Depth-Diameter Ratio",
       color = "Diameter (km)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5))

depth_diameter_model <- lm(log_depth ~ log_diameter, data = MARS)
summary(depth_diameter_model)

lat_model <- lm(depth_diameter_ratio ~ abs_lat * diameter, data = MARS)
summary(lat_model)

ggplot(data = MARS, aes(x = abs_lat, y = depth_diameter_ratio)) +
  geom_point(aes(color = diameter), alpha = 0.3) +
  geom_smooth(method = "lm", se = TRUE, color = "red", fill = "pink") +
  scale_color_gradient(low = "yellow", high = "purple") +
  labs(title = "Depth-Diameter Ratio vs Absolute Latitude",
       x = "Absolute Latitude (degrees from equator)",
       y = "Depth-Diameter Ratio",
       color = "Diameter (km)") +
  theme_minimal()

top_ejecta <- head(ejecta_freq$Var1, 10)
MARS_top <- MARS[MARS$ejecta_type %in% top_ejecta, ]

ggplot(data = MARS_top, aes(x = reorder(ejecta_type, depth_diameter_ratio, FUN = median), 
                            y = depth_diameter_ratio)) +
  geom_boxplot(aes(fill = ejecta_type), alpha = 0.6) +
  coord_flip() +
  labs(title = "Depth-Diameter Ratio by Ejecta Type (Top 10 Most Common)",
       x = "Ejecta Type",
       y = "Depth-Diameter Ratio") +
  theme_minimal() +
  theme(legend.position = "none")

ejecta_anova <- aov(depth_diameter_ratio ~ ejecta_type, data = MARS_top)
summary(ejecta_anova)

# Final Publication-Quality Figures ----
ggplot(data = MARS, aes(x = abs_lat, y = depth_diameter_ratio)) +
  geom_point(aes(color = diameter), alpha = 0.5, size = 2) +
  geom_smooth(method = "lm", se = TRUE, color = "#1f78b4", fill = "#a6cee3", linewidth = 1.2) +
  scale_color_gradient(low = "#deebf7", high = "#08519c", name = "Diameter (km)") +
  labs(title = "Depth-Diameter Ratio vs Absolute Latitude",
       x = "Absolute Latitude (degrees from equator)",
       y = "Depth-Diameter Ratio") 

ggplot(data = MARS, aes(x = diameter, y = depth_diameter_ratio)) +
  geom_point(aes(color = diameter), alpha = 0.5, size = 2) +
  geom_smooth(method = "lm", se = TRUE, color = "#1f78b4", fill = "#a6cee3", linewidth = 1.2) +
  scale_color_gradient(low = "#deebf7", high = "#08519c", name = "Diameter (km)") +
  labs(title = "Depth-Diameter Ratio vs Crater Diameter",
       x = "Crater Diameter (km)",
       y = "Depth-Diameter Ratio") 

ggplot(data = MARS, aes(x = ejecta_complex_numeric, y = depth_diameter_ratio)) +
  geom_jitter(aes(color = factor(ejecta_complex_numeric)), 
              alpha = 0.5, width = 0.15, height = 0, size = 2) +
  geom_smooth(method = "lm", se = TRUE, color = "#1f78b4", fill = "#a6cee3", linewidth = 1.2) +
  scale_color_manual(values = c("#deebf7", "#9ecae1", "#3182bd"),
                     name = "Complexity Level") +
  labs(title = "Depth-Diameter Ratio by Ejecta Complexity",
       x = "Ejecta Complexity Level",
       y = "Depth-Diameter Ratio") +
  scale_x_continuous(breaks = c(0, 1, 2), labels = c("Simple", "Moderate", "Complex"))

ggplot(data = MARS) + 
  geom_density(aes(x = depth_diameter_ratio, fill = factor(ejecta_complex)), 
               alpha = 0.6, color = NA) +
  scale_fill_manual(values = c("#deebf7", "#9ecae1", "#3182bd"),
                    name = "Ejecta Complexity") +
  labs(title = "Distribution of Depth-Diameter Ratio by Ejecta Complexity",
       x = "Depth-Diameter Ratio",
       y = "Density") 

# Full Improved Model with Interactions ----
improved_model <- lm(
  depth_diameter_ratio ~ 
    log_diameter + I(log_diameter^2) + 
    abs_lat + I(abs_lat^2) + 
    hemisphere + 
    factor(layers) + 
    ejecta_complex_numeric +
    log_diameter:hemisphere + 
    log_diameter:factor(layers) +
    log_diameter:ejecta_complex_numeric,
  data = MARS
)

summary(improved_model)
confint(improved_model)