pkgname <- "languagelayeR"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('languagelayeR')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
cleanEx()
nameEx("get_lang")
### * get_lang

flush(stderr()); flush(stdout())

### Name: get_lang
### Title: Get language
### Aliases: get_lang

### ** Examples

## Not run: 
##D get_lang(query = "I really really love R and that's a good thing, right?", api_key = "apikey")
## End(Not run)



cleanEx()
nameEx("get_supported_lang")
### * get_supported_lang

flush(stderr()); flush(stdout())

### Name: get_supported_lang
### Title: Get supported languages
### Aliases: get_supported_lang

### ** Examples

## Not run: 
##D get_supported_lang(api_key = "yourapikey")
## End(Not run)



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
