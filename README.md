# demoApp #

Runs one Shiny demo app of a package. With `demoApp(package="gettext")` 
you get a vector of topics back of the package `gettext`.

```r
demoApp(package='gettext') 
\dontrun{
  demoApp('app2en', 'gettext') 
  demoApp('app2de', 'gettext') 
}
```

# dsub #

Performs dollar substitution in a text.

```r
dsub('$a EUR', a=3)
dsub('$a EUR', list(a=3))
```

# readme.md #

Creates a README.md for Github based on roxygen2 comments and uses [roxygen2::parse_package()].

