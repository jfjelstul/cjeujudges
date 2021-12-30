################################################################################
# Joshua C. Fjelstul, Ph.D.
# cjeujudges R package
################################################################################

# libraries
library(codebookr)

# read in data
load("data/judges.RData")
load("data/judge_backgrounds.RData")

##################################################
# documentation
##################################################

# read in data
datasets <- read.csv("documentation/datasets.csv", stringsAsFactors = FALSE)
variables <- read.csv("documentation/variables.csv", stringsAsFactors = FALSE)

# save data
save(datasets, file = "data/datasets.RData")
save(variables, file = "data/variables.RData")

# documentation
load("data/variables.RData")
load("data/datasets.RData")

# document data
codebookr::document_data(
  file_path = "R/",
  variables_input = variables,
  datasets_input = datasets,
  include_variable_type = TRUE,
  author = "Joshua C. Fjelstul, Ph.D.",
  package = "cjeujudges"
)

##################################################
# codebook
##################################################

# create a codebook
codebookr::create_codebook(
  file_path = "codebook/cjeujudges_codebook.tex",
  datasets_input = datasets,
  variables_input = variables,
  title_text = "The CJEU Judges Database",
  version_text = "1.0",
  footer_text = "The CJEU Judges Database Codebook \\hspace{5pt} | \\hspace{5pt} Joshua C. Fjelstul, Ph.D.",
  author_names = "Joshua C. Fjelstul, Ph.D.",
  theme_color = "#4B94E6",
  heading_font_size = 24,
  subheading_font_size = 10,
  title_font_size = 16,
  table_of_contents = TRUE,
  include_variable_type = TRUE
)

################################################################################
# end R script
################################################################################
