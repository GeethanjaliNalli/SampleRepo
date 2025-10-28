echo off
set source=%~dp0
set today=%Date:~10,4%%Date:~4,2%%Date:~7,2%
set t=%time:~0,8%
set t=%t::=%
set t=%t: =0%
set timestamp=%today%_%t%
set results=%source%\Results\UI_Reports
set tag=%1
set instances=%2
echo %timestamp%
@echo "#######################################"
@echo "# Executing Mobile Testcases #"
@echo "#######################################"
@echo robot --logtitle Web_Tests_Report --reporttitle Web_Tests_Report --outputdir %source%\Results\UI_Reports KeywordTestcases\Web\*.robot
@echo robot --logtitle Web_Tests_Report --reporttitle Web_Tests_Report --outputdir %results%  --variable url:%url% KeywordTestcases\Web\Dashboard.robot 
@echo robot --logtitle Web_Tests_Report --reporttitle Web_Tests_Report --outputdir %results% KeywordTestcases\Web\%suite%.robot
@echo robot --logtitle Web_Tests_Report --reporttitle Mobile_Tests_Report --outputdir %results% -i Smoke .\KeywordTestCases\Mobile\*.robot
@echo robot --logtitle Mobile_Tests_Report --reporttitle Mobile_Tests_Report --outputdir %results% -i %tag% .\KeywordTestCases\Mobile\*.robot
pabot --processes %instances% --testlevelsplit -i %tag% .\KeywordTestcases\Web\.
@echo pabot --processes 5 --testlevelsplit -i Smoke .\KeywordTestcases\Web\*.robot