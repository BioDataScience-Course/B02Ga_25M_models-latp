# Importation et remaniement des données



# Etape 1 : Importation des données brutes --------------------------------

# Ceci est nécessaire pour les tests SDD, ne pas utiliser dans un "vrai" projet
if (!"tools:tests" %in% search())
  source(here::here("tests/tools_tests.R"), attach(NULL, name = "tools:tests"))

# Configure Knitr to use AGG as graphic device
knitr::opts_chunk$set(dev = "ragg_png")

# Configuration de l'environnement
SciViews::R("model", lang = "fr")

sea_snake <- read("data/Aipysurine_sex_dimorphism_for_Dryad2.xlsx") 

# Etape 2 : Description brève des données ---------------------------------

#* A. Genus name
#* B. species name
#* C. Museum in which specimens are stored (Australian Museum or Museums and Art Galleries of the Northern Territory [=MAGNT])
#* D. Museum registration number
#* E. Snout-vent length (cm)
#* F. Tail length (cm)
#* G. Tail maximum width (cm)
#* H. Head length (mm) measured along jawline
#* I. Head width (mm) at widest point
#* J. Body width at midbody (cm)
#* K. Eye diameter (mm)
#* L. Sex (f = female, m = male)
#* M. Maturity (a = adult, j = juvenile)

#In all columns, "0" = missing data due to damaged or incomplete specimen

# Etape 3 : Nettoyage des données  ----------------------------------------
sea_snake %>.%
sfilter(., 
  `Tail length (cm)`> 0, `tail width (max)`> 0, `head length (mm)`> 0, `head width (mm)`> 0, `eye diam. (mm)`> 0 ) -> sea_snake_propre

# Etape 4 : Ajout des labels et des unités --------------------------------



# Etape 5 : Sauvegarde locale des données retravaillées -------------------

