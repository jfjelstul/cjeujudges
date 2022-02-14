# cjeujudges

An `R` package for the CJEU Judges Database. This package includes data on judges at the Court of Justice of the European Union (CJEU), including information about the professional backgrounds of judges, hand-coded from their official biographies. This data is used in IUROPA's [CJEU Database Platform: Decisions and Decision-Makers](http://iuropa.pol.gu.se).

The CJEU Judges Database includes two datasets: `judges` and `judge_backgrounds`.

The `judges` dataset includes data on all judges and Advocate General at the Court of Justice (1952-2021) and the General Court (1989-2021). There is one observation per judge. The dataset includes each judge's first and last name, their last name using only ASCII characters (to avoid character-encoding problems), a label for each judge (for making visualizations) that differentiates between judges with the same last name, their member state, and their gender. The dataset also indicates the positions that each judge has held at the Court and the start date and end date for each position.

The `judge_backgrounds` includes data on professional backgrounds of all judges at the Court of Justice (1953-2021) and the General Court (1989-2021). The sources of the data are the judges' official biographies, which are published online by the Court. There is one observation per biographical item per judge. The dataset indicates whether each item relates to the judge's education, the judge's prior professional experience, or some other category of biographical information (such as membership in a professional society or professional accomplishments). For items related to a judge's professional experience, the dataset indicates whether the judge was a judge (at a different court), a lawyer, a civil servant, an academic, or a politician. For items related to prior experience as a judge, the dataset indicates whether the court was a lower court, a high court, the CJEU, or another international court.

## Installation

You can install the latest development version of the `cjeujudges` package from GitHub:

```r
# install.packages("devtools")
devtools::install_github("jfjelstul/cjeujudges")
```

## Documentation

The codebook for the database is included as a `tibble` in the `R` package: `cjeujudges::codebook`. The same information is also available in the `R` documentation for each dataset. For example, you can see the codebook for the `cjeujudges::judges` dataset by running `?cjeujudges::judges`. You can also read the documentation on the [package website](https://jfjelstul.github.io/cjeujudges/).

## Citation

If you use data from the `cjeujudges` package in a project or paper, please cite the `R` package:

> Joshua Fjelstul (2021). cjeujudges: The CJEU Judges Database. R package version 0.1.0.

The `BibTeX` entry for the package is:

```
@Manual{,
  title = {cjeujudges: The CJEU Judges Database},
  author = {Joshua Fjelstul},
  year = {2021},
  note = {R package version 0.1.0},
}
```

## Problems

If you notice an error in the data or a bug in the `R` package, please report it [here](https://github.com/jfjelstul/cjeujudges/issues).
