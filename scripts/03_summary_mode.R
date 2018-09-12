
#  ------------------------------------------------------------------------
#
# Title : Summary by transport mode
#    By : Victor
#  Date : 2018-09-10
#
#  ------------------------------------------------------------------------



# Packages ----------------------------------------------------------------

library("data.table")
library("stringr")
library("lubridate")
library("billboarder")



# Datas -------------------------------------------------------------------

# Metro
m_incidents <- readRDS("docs/m_incidents.rds")
m_incidents_tot <- m_incidents[, list(value = sum(value)), by = list(screen_name, variable = as.character(variable))]


# RER
r_incidents <- readRDS("docs/r_incidents.rds")
r_incidents_tot <- r_incidents[, list(value = sum(value)), by = list(screen_name, variable = as.character(variable))]


# Transilien
t_incidents <- readRDS("docs/t_incidents.rds")
t_incidents_tot <- t_incidents[, list(value = sum(value)), by = list(screen_name, variable = as.character(variable))]




# Total metro -------------------------------------------------------------

m_incidents_tot[, lib := str_remove(string = screen_name, pattern = "_RATP")]
m_incidents_tot[, lib := str_replace(string = lib, pattern = "(\\d{1,2})", replacement = " \\1")]

billboarder(data = m_incidents_tot) %>% 
  bb_barchart(
    mapping = bbaes(x = lib, y = value, group = variable),
    stacked = TRUE, rotated = TRUE
  ) %>% 
  bb_data(
    order = "desc",
    groups = list(as.list(c("perturbe", "interrompu"))),
    names = list("perturbe" = "Perturbé", "interrompu" = "Interrompu")
  ) %>% 
  bb_colors_manual(interrompu = "#FA5858", perturbe = "#F7D358") %>% 
  bb_y_grid(show = TRUE) %>% 
  bb_labs(
    title = "Total lignes de métro",
    y = "Nombre de tweets"
  )





# Total RER ---------------------------------------------------------------

libs <- c(
  "RER A" = "RER_A",
  "RER B" = "RERB", 
  "RER C" = "RERC_SNCF",
  "RER D" = "RERD_SNCF", 
  "RER E" = "RERE_SNCF"
)

r_incidents_tot[, lib := names(libs)[chmatch(x = screen_name, table = libs)]]
setorder(r_incidents_tot, lib, variable)


billboarder(data = r_incidents_tot) %>% 
  bb_barchart(
    mapping = bbaes(x = lib, y = value, group = variable),
    stacked = TRUE, rotated = TRUE
  ) %>% 
  bb_data(
    order = "desc",
    groups = list(as.list(c("perturbe", "interrompu"))),
    names = list("perturbe" = "Perturbé", "interrompu" = "Interrompu")
  ) %>% 
  bb_colors_manual(interrompu = "#FA5858", perturbe = "#F7D358") %>% 
  bb_y_grid(show = TRUE) %>% 
  bb_labs(
    title = "Total lignes de RER",
    y = "Nombre de tweets"
  )




# Total transilien --------------------------------------------------------

libs <- c(
  "Ligne J" = "LIGNEJ_SNCF",
  "Ligne L" = "LIGNEL_sncf", 
  "Ligne P" = "LIGNEP_SNCF",
  "Ligne R" = "LIGNER_SNCF", 
  "Ligne H" = "LigneH_SNCF", 
  "Lignes N et U" = "lignesNetU_SNCF"
)

t_incidents_tot[, lib := names(libs)[chmatch(x = screen_name, table = libs)]]
setorder(t_incidents_tot, lib, variable)

billboarder(data = t_incidents_tot) %>% 
  bb_barchart(
    mapping = bbaes(x = lib, y = value, group = variable),
    stacked = TRUE, rotated = TRUE
  ) %>% 
  bb_data(
    order = "",
    groups = list(as.list(c("perturbe", "interrompu"))),
    names = list("perturbe" = "Perturbé", "interrompu" = "Interrompu")
  ) %>% 
  bb_colors_manual(interrompu = "#FA5858", perturbe = "#F7D358") %>% 
  bb_y_grid(show = TRUE) %>% 
  bb_labs(
    title = "Total lignes de Transilien",
    y = "Nombre de tweets"
  )






