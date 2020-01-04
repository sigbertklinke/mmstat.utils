# demoApp #

Runs a Shiny demo app or shows an overview of all Shiny demo apps related to `topic`. 
If more than one app relates to `topic` a list of apps is shown otherwise the app is run.

```r
demoApp() 
demoApp('gettext') 

```

# dsub #

Performs dollar substitution in a text.

```r
dsub('$a EUR', a=3)
dsub('$a EUR', list(a=3))
```

# readme.md #

Creates lines for a README.md for Github based on roxygen2 comments using [`roxygen2::parse_package`](https://cran.r-project.org/web/packages/roxygen2/roxygen2.pdf).

