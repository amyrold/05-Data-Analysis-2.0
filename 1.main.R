# === general ==================================================================#
## 1.main.R 
## the first file a user should use and run as it contains information  critical
## to run the whole project
# authors:
# 
# R version
R.version.string
# "R version 4.0.2 (2020-06-22)"
#
# NOTE: run the 1.main.R before starting your session.
#
## the '##' are extra comments, delete when using this as template
## use the icon with horizontal lines next to source at the top of this window
## to get the table of content 

# === script index =============================================================#
## the different script files of your analysis workflow
## numbering names will make sure they are nicely ordered
# 1.main.R        
# 2.data.manip.R
# 3.analysis.R
## for big projects you may want to have multiple analysis files
## big project may also require you to write and store functions in a script
# 4.functions.R
## and this can apply to figure functions too
# 5.figures.R

##### 1. Define Global Variables #####
# === global variables =========================================================#
#1a. clear your Global Environment to be sure that old objects don't break your code or give you wrong results. 
rm(list = ls()) # Create and remove a list of all the objects int the Global Environment
#1b. set your working directory and folder structure as you like.
working.dir <- getwd() #Store the path to working directory

## declare variables that will be used across the project and should not be 
## changed. For example names, or a range of e.g. dates selected, etc
## var.name.1 <- "something" # important variable doing....
## var.name.2 <- "something.different" #

# === libraries ================================================================#

# install libraries needed for the project
#install.packages("name.of.package")

# load the libraries needed for the project to run 
#library(name.of.package) #....

# === folder management ========================================================#

#1b. Cont...
# folder names
folder.names <- c("a.data.raw","b.data.clean", "c.results","d.figures")

# create folders if they don't exit yet. 
for(i in 1:length(folder.names)){ 
  if(file.exists(folder.names[i]) == FALSE){
    dir.create(folder.names[i])
  } 
}
# paths to the folders. The 'p.' indicates the variable is a path.
# make sure the variable names describe the folder.names
p.data.raw <- paste(working.dir, "/", folder.names[1], "/", sep = "")
p.data.clean <- paste(working.dir, "/", folder.names[2], "/", sep = "")
p.results <- paste(working.dir, "/", folder.names[3], "/", sep = "")
p.fig <- paste(working.dir, "/", folder.names[4], "/", sep = "")

# === run script ==============================================================#

# run scripts needed to make other scripts files work (e.g. functions.R)
source("4.functions.R")
#___ end _______________________________________________________________________