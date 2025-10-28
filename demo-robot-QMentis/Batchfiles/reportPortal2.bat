bat
@echo off
set RP_ENDPOINT=<your ReportPortal endpoint>
set RP_UUID=<your ReportPortal UUID>
set RP_PROJECT=<your ReportPortal project name>
set RP_LAUNCH=<your ReportPortal launch name>
set RP_ATTRIBUTES=<your ReportPortal attributes>
set RP_DESCRIPTION=<your ReportPortal description>
set RP_MODE=<your ReportPortal mode>
set RP_DEBUG=<your ReportPortal debug mode>

robot --listener "rp:log_level=DEBUG&endpoint=http://reportportal.example.com&projectMyProject&launch="Results"*
