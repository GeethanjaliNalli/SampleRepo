*** Settings ***
Resource    ../../Global/super.robot
Resource    ../../Keywords/Web/common.robot
Resource    ../../Keywords/Web/contact.robot
Resource    ../../ObjectRepository/Web/contacts.robot
Resource    ../../Global/application_variables.robot
Resource    ../../Global/global_variables.robot

*** Test Cases ***
Invalid Email Format Rejection
    [Documentation]    TC-N002: Verify system rejects invalid email formats and displays appropriate error message when creating a new contact.
    [Tags]    Regression    Negative    Contacts    EmailValidation    Medium
    [Setup]    Launch Application And Login
    Go To Contact Creation Screen
    Enter Contact Details With Invalid Email
    Submit Contact Creation Form
    Verify Invalid Email Error Message Displayed
    Verify Contact Not Created
    [Teardown]    Close Browser
