

#  ------------------------------------------------------------------------
#
# Title : Prepare data for rmd
#    By : Victor
#  Date : 2018-08-23
#    
#  ------------------------------------------------------------------------




# Packages ----------------------------------------------------------------

library("data.table")
library("stringr")
library("lubridate")
library("ggplot2")
library("billboarder")





# Metro -------------------------------------------------------------------

metro_tweets <- readRDS(file = "datas/m_tweets.rds")

# Count number of tweets with mention "perturbé" and "interrompu"
m_incidents <- metro_tweets[, list(
  perturbe = sum(str_count(text, "perturbé")),
  interrompu = sum(str_count(text, "interrompu")),
  mouvement_social = sum(str_count(str_to_lower(text), "mouvement social"))
), by = list(screen_name, date = as_date(created_at))]
m_incidents

# Filter on last year available
m_incidents <- m_incidents[date > today() - years(1)]


# add missing days
missing_days <- CJ(
  screen_name = unique(m_incidents$screen_name), 
  date = seq(from = today() - years(1) + days(1), to = today(), by = "day")
)
m_incidents <- m_incidents[missing_days, on = c("screen_name", "date")]



# transpose data
m_incidents <- melt(
  data = m_incidents, 
  id.vars = c("screen_name", "date"), 
  measure.vars = c("perturbe", "interrompu", "mouvement_social")
)
m_incidents[is.na(value), value := 0]
m_incidents <- m_incidents[order(nchar(screen_name), screen_name, date)]

m_incidents



# group by week
m_incidents[, nweek := isoweek(date)]
m_incidents <- m_incidents[, list(value = sum(value), date = min(date)), by = list(screen_name, variable, nweek)]
m_incidents <- m_incidents[order(nchar(screen_name), screen_name, date, variable)]



# save
saveRDS(m_incidents, file = "docs/m_incidents.rds")



# Viz test
billboarder(data = m_incidents[screen_name == "Ligne6_RATP", list(x = date, variable = variable, value = value)]) %>% 
  bb_aes(x = x, y = value, group = variable) %>% 
  bb_linechart(type = "area-step") %>% 
  bb_data(
    groups = list(c("perturbe", "interrompu", "mouvement_social")),
    names = list("perturbe" = "Perturbé", "interrompu" = "Interrompu", "mouvement_social" = "Mouvement social")
  ) %>% 
  bb_x_axis(tick = list(fit = FALSE, format = "%d %b")) %>% 
  bb_y_grid(show = TRUE) %>% 
  bb_colors_manual()







# RER ---------------------------------------------------------------------

rer_tweets <- readRDS(file = "datas/r_tweets.rds")


# Count number of tweets with mention "perturbé" and "interrompu"
r_incidents <- rer_tweets[, list(
  perturbe = sum(str_count(text, "perturbé")),
  interrompu = sum(str_count(text, "interrompu"))
), by = list(screen_name, date = as_date(created_at))]
r_incidents

# Filter on last year available
r_incidents <- r_incidents[date > today() - years(1)]


# add missing days
missing_days <- CJ(
  screen_name = unique(r_incidents$screen_name), 
  date = seq(from = today() - years(1) + days(1), to = today(), by = "day")
)
r_incidents <- r_incidents[missing_days, on = c("screen_name", "date")]



# transpose data
r_incidents <- melt(
  data = r_incidents, 
  id.vars = c("screen_name", "date"), 
  measure.vars = c("perturbe", "interrompu")
)
r_incidents[is.na(value), value := 0]
r_incidents <- r_incidents[order(nchar(screen_name), screen_name, date)]

r_incidents


# Group by week
r_incidents[, nweek := isoweek(date)]
r_incidents <- r_incidents[, list(value = sum(value), date = min(date)), by = list(screen_name, variable, nweek)]
r_incidents <- r_incidents[order(nchar(screen_name), screen_name, date, variable)]


# save
saveRDS(r_incidents, file = "docs/r_incidents.rds")



# Viz test
billboarder(data = r_incidents[screen_name == "RERB", list(x = date, variable = variable, value = value)]) %>% 
  bb_aes(x = x, y = value, group = variable) %>% 
  bb_linechart(type = "area-step") %>% 
  bb_data(
    groups = list(c("perturbe", "interrompu")),
    names = list("perturbe" = "Perturbé", "interrompu" = "Interrompu")
  ) %>% 
  bb_x_axis(tick = list(fit = FALSE, format = "%d %b")) %>% 
  bb_y_grid(show = TRUE) %>% 
  bb_colors_manual()




# Transilien --------------------------------------------------------------

transilien_tweets <- readRDS(file = "datas/t_tweets.rds")


# Count number of tweets with mention "perturbé" and "interrompu"
t_incidents <- transilien_tweets[, list(
  perturbe = sum(str_count(text, "perturbé")),
  interrompu = sum(str_count(text, "interrompu"))
), by = list(screen_name, date = as_date(created_at))]
t_incidents

# Filter on last year available
t_incidents <- t_incidents[date > today() - years(1)]


# add missing days
missing_days <- CJ(
  screen_name = unique(t_incidents$screen_name), 
  date = seq(from = today() - years(1) + days(1), to = today(), by = "day")
)
t_incidents <- t_incidents[missing_days, on = c("screen_name", "date")]



# transpose data
t_incidents <- melt(
  data = t_incidents, 
  id.vars = c("screen_name", "date"), 
  measure.vars = c("perturbe", "interrompu")
)
t_incidents[is.na(value), value := 0]
t_incidents <- t_incidents[order(nchar(screen_name), screen_name, date)]

t_incidents


# Group by week
t_incidents[, nweek := isoweek(date)]
t_incidents <- t_incidents[, list(value = sum(value), date = min(date)), by = list(screen_name, variable, nweek)]
t_incidents <- t_incidents[order(nchar(screen_name), screen_name, date, variable)]



# save
saveRDS(t_incidents, file = "docs/t_incidents.rds")



