

#  ------------------------------------------------------------------------
#
# Title : Collect tweets from Metro/RER/Transilien accounts
#    By : Victor
#  Date : 2018-08-22
#    
#  ------------------------------------------------------------------------



# Packages ----------------------------------------------------------------

library( data.table )
library( rtweet )




# Twitter API authentication ----------------------------------------------

twitter_token <- readRDS(file = "datas/twitter_token.rds")





# Metro -------------------------------------------------------------------

# all metro accounts
lignes_RATP <- sprintf("Ligne%d_RATP", 1:14)

# get tweets
tweets_lignes <- lapply(X = lignes_RATP, FUN = get_timeline, n = 3200, token = twitter_token)
tweets_lignes <- rbindlist(tweets_lignes)

# save data
saveRDS(tweets_lignes, file = sprintf("datas/raw/tweets_metro_%s.rds", format(Sys.Date())))





# RER ---------------------------------------------------------------------

lignes_rer <- c("RER_A", "RERB", "RERC_SNCF", "RERD_SNCF", "RERE_SNCF")

tweets_rer <- lapply(X = lignes_rer, FUN = get_timeline, n = 3200, token = twitter_token)
tweets_rer <- rbindlist(tweets_rer)

saveRDS(tweets_rer, file = sprintf("datas/raw/tweets_rer_%s.rds", format(Sys.Date())))





# Transilien --------------------------------------------------------------

transilien <- c("LIGNEL_sncf", "LIGNEJ_SNCF", "lignesNetU_SNCF", "LigneH_SNCF", "LIGNEP_SNCF", "LIGNER_SNCF")

tweets_transilien <- lapply(X = transilien, FUN = get_timeline, n = 3200, token = twitter_token)
tweets_transilien <- rbindlist(tweets_transilien)

saveRDS(tweets_transilien, file = sprintf("datas/raw/tweets_transilien_%s.rds", format(Sys.Date())))








