library('RUnit')

source('irsvanilla.R')

test.suite = defineTestSuite("example",
                dirs = file.path("test"),
                testFileRegexp = 'R')

test.result <- runTestSuite(test.suite)

printTextProtocol(test.result)