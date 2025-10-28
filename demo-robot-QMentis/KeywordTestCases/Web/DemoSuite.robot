*** Settings ***
Documentation     Sample UI test for Cogmento Automation Project
Resource          ../../Global/super.robot
Resource          ../../Keywords/Web/common.robot
Resource          ../../Keywords/Web/company.robot
Resource          ../../Keywords/Web/contact.robot
Resource          ../../Keywords/Web/cases.robot
Resource          ../../Keywords/Web/deals.robot
Resource          ../../Keywords/Web/tasks.robot

*** Test Cases ***
Workflow
    [Tags]    Smoke
    Read Data From Excel    TC-workflow
    Login to Cogmento Application    ${USERNAME}    ${PASSWORD}
    Maximize Browser Window
    Navigate to Modules    Companies
    comment    Reading company details from Excel
    Create company    ${COMPANY_DATA}
    Capture Page Screenshot
    Navigate to Modules    Companies
    Check Records Displayed    ${COMPANY_DATA}[Name]
    Navigate to Modules    Contacts
    comment    set company field to dictionary in Contacts Module
    Set To Dictionary    ${CONTACT_DATA}    Company=${COMPANY_DATA}[Name]
    Create Contact    ${CONTACT_DATA}
    Capture Page Screenshot
    Navigate to Modules    Contacts
    comment    storing contact full name in name variable
    ${contact_full_name}    Get Contact Full Name    ${CONTACT_DATA}
    Check Records Displayed    ${contact_full_name}
    Navigate to Modules    Deals
    comment    set company field to dictionary in Deals Module
    Set To Dictionary    ${DEAL_DATA}    Company=${COMPANY_DATA}[Name]    Contact=${contact_full_name}
    Create Deals    ${DEAL_DATA}
    Capture Page Screenshot
    Navigate to Modules    Deals
    Check Records Displayed    ${DEAL_DATA}[Title]
    Navigate to Modules    Cases
    comment    set company field to dictionary in Cases Module
    Set To Dictionary    ${CASE_DATA}    Company=${COMPANY_DATA}[Name]    Contact=${contact_full_name}    Deal=${DEAL_DATA}[Title]
    Create Cases    ${CASE_DATA}
    Capture Page Screenshot
    Navigate to Modules    Cases
    Check Records Displayed    ${CASE_DATA}[Title]
    Navigate to Modules    Tasks
    Create Task    ${TASK_DATA}
    Capture Page Screenshot
    Navigate to Modules    Tasks
    Check Records Displayed    ${TASK_DATA}[Title]
    [Teardown]    WorkFlow_Teardown

Create Contact And Add Company
    [Tags]    Regression
    Login to Cogmento Application    ${USERNAME}    ${PASSWORD}
    Maximize Browser Window
    Navigate to Modules    Contacts
    ${contact_details}=    Read TestData From Excel    TC-01    Contacts
    Create Contact    ${contact_details}
    Capture Page Screenshot
    Reload Page
    Navigate to Modules    Contacts
    ${name}    Get Contact Full Name    ${contact_details}
    Check Records Displayed    ${name}
    Delete Contacts    ${name}
    Navigate to Modules    Companies
    Check Records Displayed    ${contact_details}[Company]
    Capture Page Screenshot
    Delete company    ${contact_details}[Company]
    [Teardown]    Close Browser

Check contacts with max length
    Login to Cogmento Application    ${USERNAME}    ${PASSWORD}
    Maximize Browser Window
    Navigate to Modules    Contacts
    ${contact_name}=    Generate Random String    81
    ${middle_name}=    Generate Random String    151
    Comment    creating the contact with firstname last name more than 80 characters and Middle name more than 50 characters
    ${case_details}=    Create Dictionary    First_name=${contact_name}    Last_name=${contact_name}    Middle_name=${middle_name}
    Create Contact    ${case_details}    False
    Capture Page Screenshot
    Comment    checking the error message with the maximum characters
    ${actual_error_message}    Get Error Message
    Run Keyword And Continue On Failure    Should Contain    ${actual_error_message}    First Name is longer than 80 characters    Check First name exceeding maximum lenght in error message
    Run Keyword And Continue On Failure    Should Contain    ${actual_error_message}    Last Name is longer than 80 characters    Check Last name exceeding maximum lenght in error message
    Run Keyword And Continue On Failure    Should Contain    ${actual_error_message}    Middle Name(s) is longer than 150 characters    Check Middle name exceeding maximum lenght in error message
    [Teardown]    Close Browser

Check contact mandatory fields error message
    Login to Cogmento Application    ${USERNAME}    ${PASSWORD}
    Maximize Browser Window
    Navigate to Modules    Contacts
    ${case_details}=    Create Dictionary    First_name=    Last_name=
    Create Contact    ${case_details}    False
    Capture Page Screenshot
    Comment    checking the error message with the maximum characters
    Check field required error message    The field First Name is required.
    Check field required error message    The field Last Name is required.
    [Teardown]    Close Browser

Check company name max length
    Login to Cogmento Application    ${USERNAME}    ${PASSWORD}
    Maximize Browser Window
    Navigate to Modules    Companies
    ${company_name}    Generate Random String    251
    Comment    creating the company by using the 251 characters
    ${company_details}=    Create Dictionary    Name=${company_name}
    Create company    ${company_details}    False
    Capture Page Screenshot
    Comment    checking the error message with the maximum characters
    ${actual_error_message}    Get Error Message
    Should Contain    ${actual_error_message}    Validation error: Name is longer than 250 characters    Check Company name exceeding maximum length in error message
    [Teardown]    Close Browser

*** Keywords ***
WorkFlow_Teardown
    Navigate to Modules    Companies
    Delete company    ${COMPANY_DATA}[Name]
    ${contact_full_name}    Get Contact Full Name    ${CONTACT_DATA}
    Navigate to Modules    Contacts
    Delete Contacts    ${contact_full_name}
    Navigate to Modules    Deals
    Delete Deals    ${DEAL_DATA}[Title]
    Navigate to Modules    Cases
    Delete Case    ${CASE_DATA}[Title]
    Navigate to Modules    Tasks
    Delete Tasks    ${TASK_DATA}[Title]
    Close Browser
