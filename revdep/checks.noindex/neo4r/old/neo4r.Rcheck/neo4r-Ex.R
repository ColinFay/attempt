pkgname <- "neo4r"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('neo4r')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
cleanEx()
nameEx("neo4j_api")
### * neo4j_api

flush(stderr()); flush(stdout())

### Name: neo4j_api
### Title: A Neo4J Connexion
### Aliases: neo4j_api
### Keywords: datasets

### ** Examples

## Not run: 
##D con <- neo4j_api$new(url = "http://localhost:7474", user = "neo4j", password = "password")
## End(Not run)





cleanEx()
nameEx("read_cypher")
### * read_cypher

flush(stderr()); flush(stdout())

### Name: read_cypher
### Title: Read a cypher file
### Aliases: read_cypher

### ** Examples

## Not run: 
##D read_cypher("random/create.cypher")
## End(Not run)



cleanEx()
nameEx("send_cypher")
### * send_cypher

flush(stderr()); flush(stdout())

### Name: send_cypher
### Title: Send a cypher file to be executed
### Aliases: send_cypher

### ** Examples

## Not run: 
##D send_cypher("random/create.cypher")
##D path <- "data-raw/constraints.cypher"
## End(Not run)



cleanEx()
nameEx("vec_to_cypher")
### * vec_to_cypher

flush(stderr()); flush(stdout())

### Name: vec_to_cypher
### Title: Turn a named vector into a cypher list
### Aliases: vec_to_cypher vec_to_cypher_with_var

### ** Examples


vec_to_cypher(iris[1, 1:3], "Species")
vec_to_cypher_with_var(iris[1, 1:3], "Species", a)



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
