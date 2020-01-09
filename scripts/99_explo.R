

#  ------------------------------------------------------------------------
#
# Title : Exploration
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


# Tweets par lignes
metro_tweets[, .N, by = screen_name]


# Date min & max
metro_tweets[, list(min = min(created_at), max = max(created_at)), by = screen_name]


# perturbé
metro_tweets[, list(perturbe = sum(grepl("perturbé", text))), by = screen_name]

# interrompu
metro_tweets[, list(interrompu = sum(grepl("interrompu", text))), by = screen_name]

# Mouvement social
metro_tweets[, list(perturbe = sum(grepl("Mouvement social", text))), by = screen_name]

metro_tweets[, list(
  interrompu = any(grepl("interrompu", text))
), by = list(screen_name, date = as.Date(created_at))][, list(
  interrompu = sum(interrompu), N = .N, ratio = sum(interrompu)/.N
), by = screen_name][order(N)]






# RER ---------------------------------------------------------------------


tweets_rer <- readRDS(file = "datas/r_tweets.rds")


# Tweets par lignes
tweets_rer[, .N, by = screen_name]


# Date min & max
tweets_rer[, list(min = min(created_at), max = max(created_at)), by = screen_name]


# perturbé
tweets_rer[, list(perturbe = sum(grepl("perturbé", text))), by = screen_name]

tweets_rer[, list(
  perturbe = any(grepl("perturbé", text) & grepl("trafic", tolower(stringi::stri_escape_unicode(text))))
), by = list(screen_name, date = as.Date(created_at))][, list(
  perturbe = sum(perturbe), N = .N, ratio = sum(perturbe)/.N
), by = screen_name][order(ratio)]



# interrompu
tweets_rer[, list(interrompu = sum(grepl("interrompu", text))), by = screen_name]

tweets_rer[, list(
  interrompu = any(grepl("interrompu", text))
), by = list(screen_name, date = as.Date(created_at))][, list(
  interrompu = sum(interrompu), N = .N, ratio = sum(interrompu)/.N
), by = screen_name][order(ratio)]



# Grève
tweets_rer[, list(interrompu = sum(grepl("grève", text))), by = screen_name]

tweets_rer[, list(interrompu = sum(grepl("Mouvement social", text))), by = screen_name]




# Transilien --------------------------------------------------------------


tweets_transilien <- readRDS(file = "datas/t_tweets.rds")


# Tweets par lignes
tweets_transilien[, .N, by = screen_name]


# Date min
tweets_transilien[, min(created_at), by = screen_name]


# perturbé
tweets_transilien[, list(perturbe = sum(grepl("perturbé", text))), by = screen_name]

tweets_transilien[, list(
  perturbe = any(grepl("perturbé", text))
), by = list(screen_name, date = as.Date(created_at))][, list(
  perturbe = sum(perturbe), N = .N, ratio = sum(perturbe)/.N
), by = screen_name][order(ratio)]



# interrompu
tweets_transilien[, list(interrompu = sum(grepl("interrompu", text))), by = screen_name]


tweets_transilien[, list(
  interrompu = any(grepl("interrompu", text))
), by = list(screen_name, date = as.Date(created_at))][, list(
  interrompu = sum(interrompu), N = .N, ratio = sum(interrompu)/.N
), by = screen_name][order(ratio)]


