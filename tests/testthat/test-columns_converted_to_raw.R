library(ssnapinterface)
library(ssnapstats)
context("Match SSNAP measures to imported CSV")

for (measure in ssnap_measures) {
  test_that(glue::glue("CSV columns for {measure$stem_name}"), {
    # Convert the ssnap_measure columns to raw CSV column names
    raw_cols <- ssnap_measure_to_raw_csv_columns(measure$csv_columns)
    # Look for any columns which aren't known after conversion
    missing_cols <- setdiff(raw_cols, names(column_types$cols))
    # Make sure the output is a comparison of string vectors,
    # so that any error output is easy to spot which strings need
    # reviewing
    if (is.null(missing_cols) | (length(missing_cols) == 0)) {
      missing_cols <- ""
    }
    expected_cols <- vector(mode = "character",
                            length = length(missing_cols))
    expect_equal(expected_cols, missing_cols)
  })
}
