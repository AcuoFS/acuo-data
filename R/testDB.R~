library('RUnit')

source('R/buildDB.R')

test.suite = defineTestSuite("example",
                dirs = file.path("R/test"),
                testFileRegexp = 'R')

test.result <- runTestSuite(test.suite)

printTextProtocol(test.result)
