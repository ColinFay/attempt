pkgname <- "dockerfiler"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('dockerfiler')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
cleanEx()
nameEx("Dockerfile")
### * Dockerfile

flush(stderr()); flush(stdout())

### Name: Dockerfile
### Title: A Dockerfile template
### Aliases: Dockerfile
### Keywords: datasets

### ** Examples

my_dock <- Dockerfile$new()



cleanEx()
nameEx("dock_from_desc")
### * dock_from_desc

flush(stderr()); flush(stdout())

### Name: dock_from_desc
### Title: Docker file from DESCRIPTION
### Aliases: dock_from_desc

### ** Examples

## Not run: 
##D my_dock <- dock_from_desc("DESCRIPTION")
##D my_dock
##D my_dock$CMD(r(library(dockerfiler)))
##D my_dock$add_after(
##D cmd = "RUN R -e 'remotes::install_cran(\"rlang\")'",
##D after = 3
##D )
## End(Not run)



cleanEx()
nameEx("r")
### * r

flush(stderr()); flush(stdout())

### Name: r
### Title: Turn an R call into an Unix call
### Aliases: r

### ** Examples

r(print("yeay"))
r(install.packages("plumber", repo = "http://cran.irsn.fr/"))



### * <FOOTER>
###
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
