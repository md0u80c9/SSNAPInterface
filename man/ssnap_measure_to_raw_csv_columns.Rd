% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ssnap_measure_to_raw_csv_columns.R
\name{ssnap_measure_to_raw_csv_columns}
\alias{ssnap_measure_to_raw_csv_columns}
\title{Choose CSV columns given list of SSNAP column names}
\usage{
ssnap_measure_to_raw_csv_columns(requested_fields)
}
\arguments{
\item{requested_fields}{A character vector of all the SSNAP fields
requested for the cohorts.}
}
\description{
Each measure in SSNAPStats can describe which measures it needs
from an imported CSV file.
}
\details{
SSNAPInterface needs to make additional adjustments to that list
to reverse the 'tidying effects' it applies to the raw data, to
allow us to do a selective load of only the relevant columns.

This function should effectively calculate given a list of SSNAP
measure column names, which raw columns it needs.
}
