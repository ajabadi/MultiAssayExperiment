context("long and wide format methods")

example("MultiAssayExperiment")

longDF <- longFormat(mae, colDataCols = "sex")
wideDF <- wideFormat(mae, colDataCols = "sex")

test_that("longFormat-ANY returns a data.frame", {
    testMat <- matrix(seq_len(20), nrow = 4, ncol = 5, byrow = TRUE,
                      dimnames = list(LETTERS[1:4], letters[1:5]))

    testESet <- Biobase::ExpressionSet(testMat)

    matDF <- longFormat(testMat)
    ESetDF <- longFormat(testESet)

    expect_true(is(matDF, "data.frame"))
    expect_true(is(ESetDF, "data.frame"))
})

test_that("longFormat returns specified colData column and proper dimensions", {
    expect_true("sex" %in% names(longDF))
    expect_true("sex" %in% names(wideDF))

    expect_true( all(
        c("assay", "primary", "rowname", "colname", "value") %in%
            names(longDF)))

    expect_true("primary" %in% names(wideDF))
    expect_equal(nrow(wideDF), nrow(colData(mae)))
})

test_that("longFormat on MultiAssayExperiment returns DataFrame", {
    expect_true(is(longDF, "DataFrame"))
    expect_true(is(wideDF, "DataFrame"))
})

test_that("wideFormat returns primary column order identical to colData rownames", {
    data("miniACC")
    acc <- miniACC["EZH2", , ]
    wideacc <- wideFormat(acc)
    expect_identical(rownames(colData(acc)),
        as.character(wideacc[["primary"]]))
})
