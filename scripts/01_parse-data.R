

#  ------------------------------------------------------------------------
#
# Title : Data preparation
#    By : Victor
#  Date : 2018-08-22
#    
#  ------------------------------------------------------------------------





# Packages ----------------------------------------------------------------

library("data.table")





# Metro -------------------------------------------------------------------

metro_rds <- list.files(path = "datas/raw/", pattern = "metro", full.names = TRUE)

metro_tweets <- rbindlist(lapply(metro_rds, readRDS), fill = TRUE)
metro_tweets

metro_tweets <- metro_tweets[is_retweet == FALSE & is_quote == FALSE & is.na(reply_to_status_id)]
metro_tweets <- metro_tweets[, list(status_id, created_at, screen_name, text, reply_to_status_id, favorite_count, retweet_count)]
metro_tweets <- unique(metro_tweets, by = "status_id")
metro_tweets


saveRDS(metro_tweets, file = "datas/m_tweets.rds")





# RER ---------------------------------------------------------------------

rer_rds <- list.files(path = "datas/raw/", pattern = "rer", full.names = TRUE)

rer_tweets <- rbindlist(lapply(rer_rds, readRDS), fill = TRUE)
rer_tweets

rer_tweets <- rer_tweets[is_retweet == FALSE & is_quote == FALSE & is.na(reply_to_status_id)]
rer_tweets <- rer_tweets[, list(status_id, created_at, screen_name, text, reply_to_status_id, favorite_count, retweet_count)]
rer_tweets <- unique(rer_tweets, by = "status_id")
rer_tweets


saveRDS(rer_tweets, file = "datas/r_tweets.rds")





# Transilien --------------------------------------------------------------


transilien_rds <- list.files(path = "datas/raw/", pattern = "transilien", full.names = TRUE)

transilien_tweets <- rbindlist(lapply(transilien_rds, readRDS), fill = TRUE)
transilien_tweets

transilien_tweets <- transilien_tweets[is_retweet == FALSE & is_quote == FALSE & is.na(reply_to_status_id)]
transilien_tweets <- transilien_tweets[, list(status_id, created_at, screen_name, text, reply_to_status_id, favorite_count, retweet_count)]
transilien_tweets <- unique(transilien_tweets, by = "status_id")
transilien_tweets


saveRDS(transilien_tweets, file = "datas/t_tweets.rds")







