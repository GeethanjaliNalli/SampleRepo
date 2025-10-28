*** Settings ***
Documentation     Combining all libraries into a single file to use as a common reference


Library           SeleniumLibrary
Library           String
Resource          global_variables.robot
Library           OperatingSystem
Library           Collections
Resource          application_variables.robot
Resource          reportPortalconfig.robot
Library           ../Library/CustomLibrary.py


