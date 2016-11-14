library('RUnit')

source('R/notificationTime.R')

test.suite = defineTestSuite("example",
                dirs = file.path("R/testNotif"),
                testFileRegexp = 'R')

test.result <- runTestSuite(test.suite)

printTextProtocol(test.result)
