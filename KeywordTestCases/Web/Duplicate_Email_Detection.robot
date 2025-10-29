*** Settings ***
Resource    ../../Global/super.robot
Resource    ../../Keywords/Web/common.robot
Resource    ../../Keywords/Web/contact.robot
Resource    ../../ObjectRepository/Web/contacts.robot
Resource    ../../Global/application_variables.robot
Resource    ../../Global/global_variables.robot

*** Test Cases ***
Duplicate Email Detection
    [Documentation]    Verify that the system prevents creation of a contact with a duplicate email and displays an appropriate error message.
    [Tags]    Regression    Negative    Contacts    EmailValidation
    [Setup]    Login To CRM
    Go To Contacts Page
    Click Add New Contact Button
    Input Contact Details    ${EXISTING_CONTACT_NAME}    ${EXISTING_CONTACT_EMAIL}
    Submit New Contact
    Verify Duplicate Email Error Message Displayed    ${DUPLICATE_EMAIL_ERROR_MESSAGE}
    [Teardown]    Logout From CRM
