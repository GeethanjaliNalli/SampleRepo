echo off
set source=%~dp0
set today=%Date:~10,4%%Date:~4,2%%Date:~7,2%
set t=%time:~0,8%
set t=%t::=%
set t=%t: =0%
set timestamp=%today%_%t%
set results=%source%\Results\UI_Reports
set tag=%1
@echo set suite=%2
echo %timestamp%
@echo "#######################################"
@echo "# Executing Web UI Testcases #"
@echo "#######################################"
@echo robot --logtitle Web_Tests_Report --reporttitle Web_Tests_Report --outputdir %results% -i %tag% .\KeywordTestCases\Web\DemoSuite.robot\*.robot
@echo robot --logtitle Mobile_Tests_Report --reporttitle Mobile_Tests_Report --outputdir %results% -i %tag% .\KeywordTestCases\Web\%suite%.robot
robot --logtitle Mobile_Tests_Report --reporttitle Mobile_Tests_Report --outputdir %results% -i %tag% .\KeywordTestCases\Web\.