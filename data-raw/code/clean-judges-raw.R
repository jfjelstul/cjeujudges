################################################################################
# Joshua C. Fjelstul, Ph.D.
# cjeujudges R package
################################################################################

# libraries
library(tidyverse)
library(lubridate)

# read in data
judges <- read.csv("data-raw/judges-raw.csv", stringsAsFactors = FALSE)

# arrange
judges <- arrange(judges, member_state_id, start_date, last_name)

# judge id
judges <- judges |>
  group_by(member_state_id) |>
  mutate(
    judge_counter = 1:n(),
    judge_counter = str_pad(judge_counter, width = 2, side = "left", pad = "0"),
    member_state_counter = str_pad(member_state_id, width = 2, side = "left", pad = "0"),
    iuropa_judge_id = str_c("J:", member_state_counter, judge_counter)
  ) |>
  ungroup()

# current
judges$current_member <- as.numeric(str_detect(judges$current_status, "Current"))

# arrange
judges <- arrange(judges, member_state_id, start_date, last_name)

# key id
judges$key_id <- 1:nrow(judges)

# clean date variables
judges$end_date[judges$end_date == "Present"] <- NA
judges$end_date_court_of_justice[judges$end_date_court_of_justice == "Present"] <- NA
judges$end_date_general_court[judges$end_date_general_court == "Present"] <- NA
judges$end_date_civil_service_tribunal[judges$end_date_civil_service_tribunal == "Present"] <- NA
judges$end_date_advocate_general[judges$end_date_advocate_general == "Present"] <- NA

# code as dates
judges$start_date <- ymd(judges$start_date)
judges$start_date_court_of_justice <- ymd(judges$start_date_court_of_justice)
judges$start_date_general_court <- ymd(judges$start_date_general_court)
judges$start_date_civil_service_tribunal <- ymd(judges$start_date_civil_service_tribunal)
judges$start_date_advocate_general <- ymd(judges$start_date_advocate_general)
judges$end_date <- ymd(judges$end_date)
judges$end_date_court_of_justice <- ymd(judges$end_date_court_of_justice)
judges$end_date_general_court <- ymd(judges$end_date_general_court)
judges$end_date_civil_service_tribunal <- ymd(judges$end_date_civil_service_tribunal)
judges$end_date_advocate_general <- ymd(judges$end_date_advocate_general)

# correspondence table
correspondence_table <- select(judges, iuropa_judge_id, last_name_label, brekke_judge_id)

# organize variables
judges <- select(
  judges,
  key_id, iuropa_judge_id,
  full_name, first_name, last_name, last_name_latin, last_name_label, last_name_latin_label,
  member_state_id, member_state, member_state_code,
  birth_year, gender_id, gender, female,
  judge_court_of_justice, judge_general_court, judge_civil_service_tribunal, advocate_general,
  current_status, current_member, count_positions, nonconsecutive_positions,
  start_date, end_date,
  start_date_court_of_justice, end_date_court_of_justice,
  start_date_general_court, end_date_general_court,
  start_date_civil_service_tribunal, end_date_civil_service_tribunal,
  start_date_advocate_general, end_date_advocate_general
)

# IUROPA template
judges_iuropa_template <- select(
  judges,
  iuropa_judge_id,
  full_name, first_name, last_name, last_name_latin, last_name_label, last_name_latin_label,
  member_state, birth_year, female,
  judge_court_of_justice, judge_general_court, judge_civil_service_tribunal, advocate_general,
  current_member, count_positions, nonconsecutive_positions,
  start_date, end_date,
  start_date_court_of_justice, end_date_court_of_justice,
  start_date_general_court, end_date_general_court,
  start_date_civil_service_tribunal, end_date_civil_service_tribunal,
  start_date_advocate_general, end_date_advocate_general
)

# make bools
judges_iuropa_template <- judges_iuropa_template |> mutate(
  female = as.logical(female),
  judge_court_of_justice = as.logical(judge_court_of_justice),
  judge_general_court = as.logical(judge_general_court),
  judge_civil_service_tribunal = as.logical(judge_civil_service_tribunal),
  advocate_general = as.logical(advocate_general),
  current_member = as.logical(current_member),
  nonconsecutive_positions = as.logical(nonconsecutive_positions)
)

# save files
write.csv(judges, "build/csv/judges.csv", row.names = FALSE)
save(judges, file = "build/rdata/judges.RData")
save(judges, file = "data/judges.RData")
write.csv(judges_iuropa_template, "build/database/judges_iuropa_template.csv", row.names = FALSE)
write.csv(correspondence_table, "build/database/correspondence_table.csv", row.names = FALSE)

################################################################################
# end R script
################################################################################
