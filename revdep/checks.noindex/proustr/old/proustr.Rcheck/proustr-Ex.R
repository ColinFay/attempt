pkgname <- "proustr"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('proustr')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
cleanEx()
nameEx("pr_detect_days")
### * pr_detect_days

flush(stderr()); flush(stdout())

### Name: pr_detect_days
### Title: Detect french days
### Aliases: pr_detect_days

### ** Examples

a <- data.frame(jours = c("C'est lundi 1er mars et mardi 2", 
"Et mercredi 3", "Il est revenu jeudi."))
pr_detect_days(a, jours)



cleanEx()
nameEx("pr_detect_months")
### * pr_detect_months

flush(stderr()); flush(stdout())

### Name: pr_detect_months
### Title: Detect french months
### Aliases: pr_detect_months

### ** Examples

a <- data.frame(month = c("C'est lundi 1er mars et mardi 2", 
"Et mercredi 3", "Il est revenu en juin."))
pr_detect_months(a, month)



cleanEx()
nameEx("pr_detect_pro")
### * pr_detect_pro

flush(stderr()); flush(stdout())

### Name: pr_detect_pro
### Title: Detect French pronoums
### Aliases: pr_detect_pro

### ** Examples

library(proustr)
a <- proust_books()[1,] 
pr_detect_pro(a, text, verbose = TRUE)
pr_detect_pro(a, text)



cleanEx()
nameEx("pr_keep_only_alnum")
### * pr_keep_only_alnum

flush(stderr()); flush(stdout())

### Name: pr_keep_only_alnum
### Title: Remove non alnum elements
### Aliases: pr_keep_only_alnum

### ** Examples

pr_keep_only_alnum("neuilly-en-thelle")



cleanEx()
nameEx("pr_normalize_punc")
### * pr_normalize_punc

flush(stderr()); flush(stdout())

### Name: pr_normalize_punc
### Title: Normalize punctuation
### Aliases: pr_normalize_punc

### ** Examples

a <- proustr::albertinedisparue[1:20,]
pr_normalize_punc(albertinedisparue, text)



cleanEx()
nameEx("pr_stem_sentences")
### * pr_stem_sentences

flush(stderr()); flush(stdout())

### Name: pr_stem_sentences
### Title: Stem a dataframe containing a column with sentences
### Aliases: pr_stem_sentences

### ** Examples

a <- proustr::laprisonniere[1:10,]
pr_stem_sentences(a, text)




cleanEx()
nameEx("pr_stem_words")
### * pr_stem_words

flush(stderr()); flush(stdout())

### Name: pr_stem_words
### Title: Stem a dataframe containing a column with words
### Aliases: pr_stem_words

### ** Examples

a <- data.frame(words = c("matin", "heure", "fatigué","sonné","lois", "tests","fusionner"))
pr_stem_words(a, words)




cleanEx()
nameEx("pr_unacent")
### * pr_unacent

flush(stderr()); flush(stdout())

### Name: pr_unacent
### Title: Remove accents
### Aliases: pr_unacent

### ** Examples

pr_unacent("du chêne")



cleanEx()
nameEx("proust_books")
### * proust_books

flush(stderr()); flush(stdout())

### Name: proust_books
### Title: Tidy data frame of Marcel Proust's 7 novels from La Recherche
### Aliases: proust_books

### ** Examples


#Create the tibble 
proust <- proust_books()
 




cleanEx()
nameEx("proust_characters")
### * proust_characters

flush(stderr()); flush(stdout())

### Name: proust_characters
### Title: Characters from Proust Books
### Aliases: proust_characters

### ** Examples


#Creates the tibble 
proust <- proust_characters()
 




cleanEx()
nameEx("proust_random")
### * proust_random

flush(stderr()); flush(stdout())

### Name: proust_random
### Title: Create a Random Proust extract
### Aliases: proust_random

### ** Examples

proust_random(4)



cleanEx()
nameEx("proust_stopwords")
### * proust_stopwords

flush(stderr()); flush(stdout())

### Name: proust_stopwords
### Title: Stop Words
### Aliases: proust_stopwords

### ** Examples

proust_stopwords()



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
