library('RUnit')

source('R/expectedCalls.R')

test.suite = defineTestSuite("example",
                dirs = file.path("R/testExpectedCalls"),
                testFileRegexp = 'R')

test.result <- runTestSuite(test.suite)

printTextProtocol(test.result)
