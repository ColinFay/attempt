pkgname <- "tidystringdist"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('tidystringdist')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
cleanEx()
nameEx("tidy_comb")
### * tidy_comb

flush(stderr()); flush(stdout())

### Name: tidy_comb
### Title: Tidy combine
### Aliases: tidy_comb tidy_comb.data.frame tidy_comb.default

### ** Examples

tidy_comb(iris, "this", Species)
tidy_comb(state.name, "Paris")



cleanEx()
nameEx("tidy_comb_all")
### * tidy_comb_all

flush(stderr()); flush(stdout())

### Name: tidy_comb_all
### Title: Tidy combine all
### Aliases: tidy_comb_all tidy_comb_all.data.frame tidy_comb_all.default

### ** Examples

tidy_comb_all(iris, Species)
tidy_comb_all(state.name)




cleanEx()
nameEx("tidy_stringdist")
### * tidy_stringdist

flush(stderr()); flush(stdout())

### Name: tidy_stringdist
### Title: Tidy stringdist calculation
### Aliases: tidy_stringdist

### ** Examples

proust <- tidy_comb_all(c("Albertine", "Françoise", "Gilberte", "Odette", "Charles"))
tidy_stringdist(proust)



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
