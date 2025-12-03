# Martian Crater Depth-Diameter and Ejecta Complexity Analysis

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![R Version](https://img.shields.io/badge/R-%3E%3D4.0.0-blue)](https://www.r-project.org/)

## Overview

This project investigates the relationship between crater morphology and crater geometry on Mars, specifically testing whether ejecta complexity can serve as a reliable predictor of depth-diameter (d/D) ratios. Using data from 38,657 Martian impact craters, this analysis reveals that while ejecta complexity is statistically associated with d/D ratios, geographic factors—particularly latitude-dependent subsurface volatiles—dominate crater geometry, explaining ~250× more variance than morphological features alone.

**Key Finding:** Environmental context (latitude, subsurface ice) matters far more than surface morphology for predicting crater physics, challenging assumptions about using ejecta patterns as proxies for impact energy.

## Research Question

**Can ejecta morphology serve as a proxy for impact physics (as encoded in d/D ratios), or do environmental and temporal factors dominate both independently?**

### Why This Matters

- **Depth-diameter ratio (d/D)** encodes fundamental impact mechanics: energy transfer, gravitational collapse, target material properties, and volatile content
- **Ejecta complexity** (layered patterns) theoretically reflects impact energy, target fluidization, and volatile interaction
- Both metrics *should* respond to the same underlying physics—but do they preserve the same information over time?

## Key Results

### Statistical Summary

| Model | R² | Key Predictors | Interpretation |
|-------|-----|----------------|----------------|
| Ejecta complexity only | 0.0017 | Ejecta type | Statistically significant but explains <1% of variance |
| Geographic model | 0.421 | Latitude, diameter, interaction | Latitude dominates: higher latitudes = shallower craters |
| Full model | 0.443 | All factors + interactions | Geography + size explain 44%; ejecta adds minimal predictive power |

### Main Findings

1. **Ejecta complexity IS associated with d/D ratios**: Complex ejecta craters are 0.0117 deeper (p < 0.001)
2. **BUT geographic factors dominate**: Latitude alone explains 42% of variance vs. 0.17% for ejecta
3. **Subsurface volatiles matter most**: Ice-rich terrain at high latitudes produces systematically shallower craters
4. **Morphology ≠ reliable energy proxy**: Surface features don't preserve impact physics as well as assumed

## Methods

- **Sample**: 38,657 Martian craters from the Mars Crater Database with complete morphological classifications
- **Variables**:
  - **Dependent**: Depth-diameter ratio (d/D)
  - **Primary predictor**: Ejecta complexity (0 = simple, 1 = moderate, 2 = complex)
  - **Controls**: Crater diameter, absolute latitude, hemisphere, subsurface layers
- **Analysis**: ANOVA, linear regression, multiple regression with polynomial terms and interactions
- **Tools**: R (v4.0+), ggplot2, tidyverse

## Visualizations

This repository includes:

1. **Interactive crater map** - Explore d/D ratios and ejecta types across Mars
2. **Latitude effect scatter plots** - Shows strong geographic gradient
3. **Ejecta complexity distributions** - Box plots comparing crater depths
4. **Regression diagnostics** - Model fit visualizations and residual analysis

👉 **[View Interactive Map](./interactive/crater_map.html)** 

## Data Sources

This analysis uses the **Mars Crater Database**, a comprehensive catalog of Martian impact craters with morphological classifications.

**Citation**: Robbins, S. J., & Hynek, B. M. (2012). A new global database of Mars impact craters ≥1 km: 1. Database creation, properties, and parameters. *Journal of Geophysical Research: Planets*, 117(E5).

**Access**: [Mars Crater Database](https://astrogeology.usgs.gov/search/map/Mars/Research/Craters/GoddardMarsDatabase)

*Note: Raw data file not included in repository due to size.


## Requirements

### R Packages

```r
install.packages(c(
  "ggplot2",
  "descr"
))
```

### System Requirements

- R ≥ 4.0.0
- 4GB+ RAM for full dataset analysis
ion is categorical; finer-grained morphological metrics may reveal stronger relationships

## Author

**Jacob Poore**  
Quantitative Analysis Center, Wesleyan University

Contact: jpoore@wesleyan.edu
Website: jpoore.dev

## Citation

```bibtex
@misc{poore2024mars,
  author = {Poore, Jacob},
  title = {The Association Between Crater Dimensions and Ejecta Complexity in Martian Craters},
  year = {2025},
  publisher = {Quantatitve Analysis Center, Wesleyan University},
  url = {https://github.com/Jacob-Poore/QAC201}
}
```

## License

This project is licensed under the MIT License

## References

1. Buhl, E., Sommer, F., Poelchau, M. H., Dresen, G., & Kenkmann, T. (2014). Ejecta from experimental impact craters: Particle size distribution and fragmentation energy. *Icarus*, 237, 131–142.

2. Collins, G. S., Melosh, H. J., & Osinski, G. R. (2012). The Impact-Cratering Process. *Elements*, 8(1), 25–30.

3. Mouginis-Mark, P. (1979). Martian fluidized crater morphology: Variations with crater size, latitude, altitude, and target material. *Journal of Geophysical Research*, 84(B14), 8011–8022.

4. Robbins, S. J., & Hynek, B. M. (2012). A new global database of Mars impact craters ≥1 km: 1. Database creation, properties, and parameters. *Journal of Geophysical Research: Planets*, 117(E5).

---

**Last Updated**: Decemember 2025