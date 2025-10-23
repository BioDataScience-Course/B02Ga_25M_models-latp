# Importation et remaniement des données

# Ceci est nécessaire pour les tests SDD, ne pas utiliser dans un "vrai" projet
if (!"tools:tests" %in% search())
  source(here::here("tests/tools_tests.R"), attach(NULL, name = "tools:tests"))

# Configure Knitr to use AGG as graphic device
knitr::opts_chunk$set(dev = "ragg_png")

# Configuration de l'environnement
SciViews::R("model", lang = "fr")

sea_snake <- read("data/Aipysurine_sex_dimorphism_for_Dryad2.xlsx") 

# Etape 1 : Importation des données brutes --------------------------------



# Etape 2 : Description brève des données ---------------------------------



# Etape 3 : Nettoyage des données  ----------------------------------------



# Etape 4 : Ajout des labels et des unités --------------------------------



# Etape 5 : Sauvegarde locale des données retravaillées -------------------

