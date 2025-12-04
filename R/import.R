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

sea_snake1<-janitor::clean_names(sea_snake1) 
sea_snake1 <-srename(sea_snake1, svl = svl_cm , head_length = head_length_mm , tail_length = tail_length_cm , head_width = head_width_mm , body_width = body_width_cm , eye_diam = eye_diam_mm)

#changer chr en fct
sea_snake1$sex<- as.factor(sea_snake1$sex)
sea_snake1$adult<- as.factor(sea_snake1$adult)
sea_snake1$genus<- as.factor(sea_snake1$genus)
sea_snake1$species<- as.factor(sea_snake1$species)
# Etape 4 : Ajout des labels et des unités --------------------------------

sea_snake1 <- labelise(sea_snake1,
  label = list(
    genus = "genre",
    species = "espèce",
    museum = "musée",
    museum_rego_no = "id du musée",
    svl = "longueur museau-cloaque",
    tail_length = "longueur de la queue",
    tail_width_max = "largeur de la queue",
    head_length = "longueur de la tête",
    head_width = "largeur de la tête",
    body_width = "largeur du corps",
    eye_diam= "diamètre de l'œuil",
    sex = "sexe",
    adult= "adulte ?"
      ),
  units = list(
    genus = NA,
    species = NA,
    museum = NA,
    museum_rego_no = NA,
    svl = "cm",
    tail_length = "cm",
    tail_width_max = "max",
    head_length = "mm",
    head_width = "mm",
    body_width = "cm",
    eye_diam = "mm",
    sex = NA,
    adult = NA
  ))

# Etape 5 : Sauvegarde locale des données retravaillées -------------------
write$rds(sea_snake1, "data/sea_snake1.rds")

