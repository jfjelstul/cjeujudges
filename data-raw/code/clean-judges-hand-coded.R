################################################################################
# Joshua C. Fjelstul, Ph.D.
# cjeujudges R package
################################################################################

# libraries
library(tidyverse)
library(lubridate)

# read in bio data
judge_backgrounds <- read.csv("data-raw/judge-bios-hand-coded.csv", stringsAsFactors = FALSE)

# read in judge data
load("data/judges.RData")

# select variables
judge_backgrounds <- select(
  judge_backgrounds,
  first_name, last_name, member_state, item_text,
  type_education, type_job, type_other,
  job_lawyer, job_academic, job_politician, job_judge, job_civil_servant,
  court_lower, court_high, court_cjeu, court_international,
  common_law_university
)

# select variables
judges <- select(
  judges,
  judge_id, first_name, last_name, last_name_label, last_name_latin, last_name_latin_label, member_state
)

# merge data
judge_backgrounds <- left_join(judge_backgrounds, judges, by = c("first_name", "last_name", "member_state"))

# item number
judge_backgrounds <- judge_backgrounds |>
  group_by(judge_id) |>
  mutate(
    item_number = 1:n()
  )

# item id
judge_backgrounds$item_id <- str_c(judge_backgrounds$judge_id, str_pad(judge_backgrounds$item_number, side = "left", pad = "0", width = 2), sep = ":")

# sort data
judge_backgrounds <- arrange(judge_backgrounds, judge_id, item_number)

# key id
judge_backgrounds$key_id <- 1:nrow(judge_backgrounds)

# organize variables
judge_backgrounds <- select(
  judge_backgrounds,
  key_id, judge_id, item_id,
  first_name, last_name, last_name_latin,
  last_name_label, last_name_latin_label,
  item_number, item_text,
  type_education, type_job, type_other,
  job_judge, job_lawyer, job_civil_servant, job_academic, job_politician,
  court_lower, court_high, court_cjeu, court_international,
  common_law_university
)

# save files
write.csv(judge_backgrounds, "build/csv/judge_backgrounds.csv", row.names = FALSE)
save(judge_backgrounds, file = "build/rdata/judge_backgrounds.RData")
save(judge_backgrounds, file = "data/judge_backgrounds.RData")

################################################################################
# end R script
################################################################################
