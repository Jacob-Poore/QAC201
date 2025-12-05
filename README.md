# Martian Crater Depth-Diameter and Ejecta Complexity Analysis

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![R Version](https://img.shields.io/badge/R-%E2%89%A54.0.0-blue)](https://www.r-project.org/)

## Overview

This project investigates the relationship between crater morphology and crater geometry on Mars, specifically testing whether ejecta complexity can serve as a reliable predictor of depth-diameter (d/D) ratios. Using data from 38,657 Martian impact craters, this analysis reveals that while ejecta complexity is statistically associated with d/D ratios, geographic factors—particularly latitude-dependent subsurface volatiles—dominate crater geometry, explaining ~250× more variance than morphological features alone.

**Key Finding:** Environmental context (latitude, subsurface ice) matters far more than surface morphology for predicting crater physics, challenging assumptions about using ejecta patterns as proxies for impact energy.

## Research Question

**Does ejecta complexity predict crater depth-diameter ratios, or do geographic and physical factors dominate this relationship?**

## Why This Matters

- **Depth-diameter ratio (d/D)** encodes fundamental impact mechanics: energy transfer, gravitational collapse, target material properties, and volatile content. The initial depth reflects impact energy, while the final depth records how the crater slumps under gravity, material strength, and subsurface ice content.

- **Ejecta complexity** (layered patterns) theoretically reflects impact energy, target fluidization, and volatile interaction. More complex ejecta patterns are often associated with ice-rich substrates and higher-energy impacts.

- **Both metrics should respond to the same underlying physics**—but do they preserve the same information over time? On Mars, variations in d/D provide insight into buried ice, soil properties, and long-term erosional modification, making this relationship central to understanding both impact processes and surface evolution.

## Key Results

### Statistical Summary

| Model | R² | Key Predictors | Interpretation |
|-------|-----|----------------|----------------|
| Ejecta complexity only | 0.0017 | Ejecta type | Statistically significant but explains <1% of variance |
| Geographic model | 0.421 | Latitude, diameter, interaction | Latitude dominates: higher latitudes = shallower craters |
| Full model | 0.443 | All factors + interactions | Geography + size explain 44%; ejecta adds minimal predictive power |

### Main Findings

1. **Ejecta complexity IS associated with d/D ratios:** Complex ejecta craters are 0.0117 deeper on average (p < 0.001), with each one-level increase in ejecta complexity corresponding to an average increase of 0.003 in d/D.

2. **BUT geographic factors dominate:** Latitude alone explains 42% of variance vs. 0.17% for ejecta. Absolute latitude shows the largest single-factor influence on d/D, reflecting broad-scale environmental controls.

3. **Subsurface volatiles matter most:** Ice-rich terrain at high latitudes produces systematically shallower, more degraded craters.

4. **Morphology ≠ reliable energy proxy:** Surface features don't preserve impact physics as well as assumed. While impact energy theoretically links to both depth and ejecta complexity, environmental factors (subsurface volatiles, target material) overwhelm the morphological signal.

5. **Size-dependent effects:** The interaction between crater diameter and ejecta complexity suggests that the effect of ejecta type is not uniform but instead varies across crater sizes.

### Implications

**Crater classification:** Cannot infer impact energy from ejecta complexity alone. This challenges the presumed relationship that ejecta morphology reliably preserves subsurface conditions similarly to d/D ratios.

## Methods

### Sample
38,657 Martian craters from the Mars Crater Database with complete morphological classifications, identified through Mars Reconnaissance Orbiter imagery and MOLA topographic data.

### Variables
- **Dependent:** Depth-diameter ratio (d/D) — calculated as crater depth divided by crater diameter, serving as a proxy for both impact energy and the degree of crater preservation
- **Primary predictor:** Ejecta complexity (0 = simple, 1 = moderate, 2 = complex)
- **Controls:** Crater diameter, absolute latitude, hemisphere, subsurface layers

### Analysis
- ANOVA with Tukey HSD post-hoc comparisons
- Linear regression
- Multiple regression with polynomial terms and interaction effects
- Full multivariate model combining polynomial terms for diameter and latitude with ejecta complexity and interaction effects (R² = 0.4431)

### Tools
R (v4.0+), ggplot2, descr

## Visualizations

This repository includes:

- **Interactive crater map** - Explore d/D ratios and ejecta types across Mars
- **Latitude effect scatter plots** - Shows strong geographic gradient
- **Ejecta complexity distributions** - Box plots comparing crater depths
- **Regression diagnostics** - Model fit visualizations and residual analysis

[View Interactive Map](#)

## Data Sources

This analysis uses the **Mars Crater Database**, a comprehensive catalog of Martian impact craters ≥1 km in diameter.

**Citation:** Robbins, S. J., & Hynek, B. M. (2012). A new global database of Mars impact craters ≥1 km: 1. Database creation, properties, and parameters. *Journal of Geophysical Research: Planets*, 117(E5). https://doi.org/10.1029/2011JE003967

**Access:** [Mars Crater Database](https://www.planetarycratercatalogue.com/)

*Note: Raw data file not included in repository due to size.*

## Requirements

### R Packages
```r
install.packages(c(
  "ggplot2",
  "tidyverse"
))
```

### System Requirements
- R ≥ 4.0.0
- 4GB+ RAM for full dataset analysis

## Limitations

- Ejecta classification is categorical; finer-grained morphological metrics may reveal stronger relationships
- This analysis focuses on preserved morphology; temporal degradation effects require further investigation

## Author

**Jacob Poore**  
Quantitative Analysis Center, Wesleyan University

- **Contact:** jpoore@wesleyan.edu
- **Portfolio:** [jpoore.dev/projects](https://jpoore.dev/projects)

## Citation

```bibtex
@misc{poore2025mars,
  author = {Poore, Jacob},
  title = {The Association Between Crater Dimensions and Ejecta Complexity in Martian Craters},
  year = {2025},
  publisher = {Quantitative Analysis Center, Wesleyan University},
  url = {https://github.com/Jacob-Poore/QAC201}
}
```

## License

This project is licensed under the MIT License.

## References

Barlow, N. G. (2003). Martian impact crater ejecta morphologies as indicators of the distribution of subsurface volatiles. *Journal of Geophysical Research: Planets*, 108(E8). https://doi.org/10.1029/2002JE002036

Buhl, E., Sommer, F., Poelchau, M. H., Dresen, G., & Kenkmann, T. (2014). Ejecta from experimental impact craters: Particle size distribution and fragmentation energy. *Icarus*, 237, 131–142. https://doi.org/10.1016/j.icarus.2014.04.039

Collins, G. S., Melosh, H. J., & Osinski, G. R. (2012). The impact-cratering process. *Elements*, 8(1), 25–30. https://doi.org/10.2113/gselements.8.1.25

Robbins, S. J., & Hynek, B. M. (2012). A new global database of Mars impact craters ≥1 km: 2. Global crater properties and regional variations of the simple-to-complex transition diameter. *Journal of Geophysical Research: Planets*, 117(E6). https://doi.org/10.1029/2011JE003967

---

*Last Updated: December 2025*
