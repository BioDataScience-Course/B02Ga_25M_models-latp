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

# Genus = Genus name
# species = species name
# Museum = Museum in which specimens are stored (Australian Museum or Museums and Art Galleries of the Northern Territory [=MAGNT])
# Museum Rego No = Museum registration number
# SVL = Snout-vent length (cm)
# Tail length = Tail length (cm)
# Tail width (max) = Tail maximum width (cm)
# Head length = Head length (mm) measured along jawline
# Head width = Head width (mm) at widest point
# Body width = Body width at midbody (cm)
# Eye diam. = Eye diameter (mm)
# Sex = (f = female, m = male)
# Maturity = (a = adult, j = juvenile)

#In all columns, "0" = missing data due to damaged or incomplete specimen

# Etape 3 : Nettoyage des données  ----------------------------------------
sea_snake %>.%
sfilter(., 
  `genus` != "Aipysu+C370rus" , `Tail length (cm)`> 0, `tail width (max)`> 0, `head length (mm)`> 0, `head width (mm)`> 0, `eye diam. (mm)`> 0 ) -> sea_snake1

# Etape 4 : Ajout des labels et des unités --------------------------------

sea_snake1 <- labelise(sea_snake1,
  label = list(
    `genus` = "genre",
    `species` = "espèce",
    `MUSEUM` = "musée",
    `Museum Rego No` = "id du musée",
    `SVL (cm)` = "longueur museau-cloaque",
    `Tail length (cm)` = "longueur de la queue",
    `tail width (max)` = "largeur de la queue",
    `head length (mm)` = "longueur de la tête",
    `body width (cm)` = "largeur du corps",
    `eye diam. (mm)`= "diamètre de l'œuil",
    `Sex` = "sexe",
    `Adult?`= "adulte ?"
      ),
  units = list(
    `genus` = NA,
    `species`= NA,
    `MUSEUM` = NA,
    `Museum Rego No` = NA,
    `SVL (cm)` = "cm",
    `Tail length (cm)` = "cm",
    `tail width (max)` = "max",
    `head length (mm)` = "mm",
    `body width (cm)` = "cm",
    `eye diam. (mm)`= "mm",
    `Sex` = NA,
    `Adult?`= NA
  ))

# Etape 5 : Sauvegarde locale des données retravaillées -------------------

save(sea_snake1, file = "sea_snake1.rds")
file_move("sea_snake1.rds", "data/sea_snake1.rds")
