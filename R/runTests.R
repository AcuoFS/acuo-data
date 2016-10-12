library('RUnit')

source('R/buildDataBase.R')

test.suite = defineTestSuite("example",
                dirs = file.path("R/test"),
                testFileRegexp = 'R')

test.result <- runTestSuite(test.suite)

printTextProtocol(test.result)
