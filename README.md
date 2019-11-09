# SSNAPInterface

## Installation

``` r
# Install development version from GitHub
devtools::install_github("SSNAP/SSNAPInterface")
```

Note that at present this is a private repository; to log in from the
command line you should set the GITHUB_PAT environment variable.
Refer to [Github PAT](https://github.com/settings/tokens) for more
information on setting this up. You can alternatively download and
build the package from the site.

## What is SSNAPInterface?

SSNAPInterface is an R package to handle the onboarding of SSNAP data.

At present, SSNAP data comes in the form of Comma Separated Values
files, which can be exported from the
[SSNAP website](http://www.strokeaudit.org).

The SSNAP project aims to be eventually agnostic about where
SSNAP data comes from - so that we can fetch data directly from the
SSNAP database, or indeed from other sources such as
[HL7 FHIR](https://www.hl7.org/fhir/).

The purpose of the design of SSNAPInterface is to try to keep any of
the initial loading and tidying of data separate from subsequent
analysis steps. It is not generally intended for external use as the
common way to deal with data will be through the SSNAPStats package
which outputs pre-processed cohorts and measures.

The main function, ssnapcsv, imports data from a CSV file for use.
The file format must be specified - this allows us in future to add
format conversions if needed. SSNAPStats, the sole intended recipient,
usually calls this itself.

The CSV file format is documented within the resources section of
the [SSNAP website](http://www.strokeaudit.org).

## How is the source CSV data modified?

We do extensive remodelling of the data to optimise it for analysis:
- We remove any redundant fields.
- We convert "Y / N" fields into Booleans.
- We convert "Y / N / NK" fields into optional Booleans, where NA
represents the "Not Known" / "Not Appropriate" option.
- We convert other fields with mutually exlusive options with only
two or three possible answers to optional / non-optional booleans
(such as S2StrokeType which could be either "I" or "PIH" to
S2StrokeTypeIsInfarct which is either TRUE or FALSE).
- We have some fields such as the thrombolysis no but reasons, or
thrombolysis complications field where we use a series of related
TRUE / FALSE statements. We convert these into Bitfields where each
item is allocated a binary bit number (decimal 1, 2, 4, 8 etc); and
the answers are stored as a single integer. This keeps the package
data smaller and allows us to use binary logic to work with the
data which is significantly quicker and neater.
- We produce four new fields S1PatientClockStartDateTime,
S1TeamClockStartDateTime, S7DeathDate and S7TeamClockStopDateTime.
These four fields are essential for the cohort selection functions.
These are priorities to be moved into the SSNAP dataset proper where
they can be created upon record lock to allow us to fetch data
using SQL queries from the SSNAP database without the need to fetch
all records.

The functions output a [tibble](http://tibble.tidyverse.org) (ie. a
data frame optimised for the [Tidyverse](https://www.tidyverse.org)
R package suite).

Beware that this package is in early development and APIs and outputs
may change.

## Contributing to this package

### Unit testing

Code should be checked in wherever possible with unit tests for
proving that the given portion of code works. This packages uses the
[TestThat](http://testthat.r-lib.org) package to produce unit tests.

If you find a bug within this code, it is good practice to firstly
write a unit test which proves the bug, add it to the unit tests, and
then fix the bug before proving that all the other unit tests pass
satisfactorily before checking it in.

Unit tests are run whenever you select Check. You can also run them
independently of the full check using Cmd-Shift-T (Mac) or
Ctrl-Shift-T (Windows).

### Code style guide

This code is written using the
[Tidyverse style guide](http://style.tidyverse.org) coding style. It
is checked using
[lintr](https://www.rdocumentation.org/packages/lintr/versions/0.2.0):


``` r
# Check your update meets the lintr style guide
lintr::lint_package
```

Check the output in the Markers tab of the Consule for any style
errors and correct them. A unit test also runs lintr: so your code
will fail the lintr unit test if a style error is found.

### Documentation

Each key function (all external functions and major internal ones
are documented using
[Roxygen2](http://kbroman.org/pkg_primer/pages/docs.html). In
addition, a website for the package is created within the package
using [pkgdown](http://pkgdown.r-lib.org). To update the web pages
use:

``` r
# Update the package website documentation
pkgdown::build_site()
```
