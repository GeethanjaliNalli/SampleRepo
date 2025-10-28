*** Settings ***
Documentation     Contacts Page Test Cases
Suite Setup       Login to Cogmento Application    ${USERNAME}    ${PASSWORD}
Suite Teardown    Close All Browsers
Test Teardown     Close Browser
Test Template     Contact with Data
Resource          ../../Global/super.robot
Library           DataDriver    ../../Testdata/Testdata.xlsx    sheet_name=Contacts_DD
Resource          ../../Keywords/Web/common.robot
Resource          ../../Keywords/Web/contact.robot
Resource          ../../Keywords/Web/company.robot

*** Variables ***
${testcase_name}    ${EMPTY}

*** Test Cases ***
Create Contacts
    ${testcase_name}

*** Keywords ***
Contact with Data
    [Arguments]    ${testcase_name}
    [Tags]    Smoke
    Log    ${testcase_name}
    Maximize Browser Window
    Comment    Maximizing current browser
    Navigate to Modules    Contacts
    Comment    Navigating to the contact module
    ${contacts_details}=    Read Test Data From Excel    ${testcase_name}    Contacts
    Comment    reading the data from excel
    Create Contact    ${contacts_details}
    Navigate to Modules    Contacts
    ${full_name}    Get Contact Full Name    ${contacts_details}
    Comment    after entering the data in checking the records
    Check Records Displayed    ${full_name}
    Comment    Delete the contacts
    Delete Contacts    ${full_name}
    Run Keyword If    'Company' in ${contacts_details}    Navigate to Modules    Companies
    Run Keyword If    'Company' in ${contacts_details}    Delete company    ${contacts_details}[Company]
