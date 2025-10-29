*** Settings ***
Documentation     Keywords for Negative Test: Duplicate Email Detection (TC-N003)
Resource          ../ObjectRepository/Web/contacts.robot
Resource          ../ObjectRepository/Web/common.robot
Library           SeleniumLibrary

*** Keywords ***

Go To Contacts Page
    [Documentation]    Navigates to the Contacts page from the main navigation.
    Wait Until Element Is Visible    ${Contacts Link}
    Click Element    ${Contacts Link}
    Wait Until Page Contains Element    ${Create Button}

Click Create Contact Button
    [Documentation]    Clicks the Create button to start adding a new contact.
    Wait Until Element Is Visible    ${Create Button}
    Click Element    ${Create Button}
    Wait Until Page Contains Element    ${First Name Input}

Input Contact Details With Duplicate Email
    [Arguments]    ${first_name}=Test    ${last_name}=User    ${email}=test@example.com
    [Documentation]    Inputs contact details using an email that already exists in the system.
    Input Text    ${First Name Input}    ${first_name}
    Input Text    ${Last Name Input}     ${last_name}
    Input Text    ${Email Address Input}    ${email}

Click Save Contact Button
    [Documentation]    Clicks the Save button to attempt to create the contact.
    Wait Until Element Is Visible    ${Save Button}
    Click Element    ${Save Button}

Verify Duplicate Email Error Message Displayed
    [Documentation]    Verifies that the error message for duplicate email is displayed.
    # Assuming an error message element appears after trying to save with duplicate email
    Wait Until Page Contains    email is already in use
    Page Should Contain    email is already in use

Create Contact With Duplicate Email And Verify Error
    [Documentation]    High-level keyword to attempt to create a contact with a duplicate email and verify error message.
    Go To Contacts Page
    Click Create Contact Button
    Input Contact Details With Duplicate Email
    Click Save Contact Button
    Verify Duplicate Email Error Message Displayed
