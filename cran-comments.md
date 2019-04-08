## Test environments
* local OS X install, R 3.4.4
* ubuntu 14.04 (on travis-ci), R 3.4.4
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 0 note

* This is a resubmission after Uwe Ligges feedback : 
"  Found the following (possibly) invalid URLs:
     URL: https://cran.rstudio.com/web/packages/attempt/index.html
       From: README.md
       Status: 200
       Message: OK
       CRAN URL not in canonical form
     Canonical CRAN.R-project.org URLs use https."

-> Changed to canonical URL
