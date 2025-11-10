*** Settings ***
Documentation     Keywords for TC-N002: Invalid Email Format Rejection
Resource          ../ObjectRepository/Web/contacts.robot
Resource          ../ObjectRepository/Web/common.robot
Library           SeleniumLibrary

*** Keywords ***

Go To Contact Creation Screen
    [Documentation]    Navigates from main dashboard to the contact creation screen.
    Click Element    ${Contacts Link}
    Wait Until Element Is Visible    ${Create Button}
    Click Element    ${Create Button}
    Wait Until Element Is Visible    ${First Name Input}

Input Invalid Email In Contact Form
    [Arguments]    ${first_name}    ${last_name}    ${invalid_email}
    [Documentation]    Fills the contact creation form with invalid email format.
    Input Text    ${First Name Input}    ${first_name}
    Input Text    ${Last Name Input}    ${last_name}
    Input Text    ${Email Address Input}    ${invalid_email}

Submit Contact Form
    [Documentation]    Clicks the Save button to submit the contact creation form.
    Click Element    ${Save Button}

Verify Invalid Email Error Message Displayed
    [Documentation]    Verifies that the error message for invalid email is displayed.
    Wait Until Page Contains Element    locator('error_email_format_message')    timeout=5s    # TODO: Replace with actual locator for error message
    Element Should Be Visible    locator('error_email_format_message')    # TODO: Replace with actual locator for error message

Verify No Contact Is Saved
    [Arguments]    ${invalid_email}
    [Documentation]    Verifies that no contact with the invalid email is saved in the CRM system.
    # This keyword should be implemented according to the application's search or listing functionality.
    Go To Contact List
    Page Should Not Contain    ${invalid_email}

Go To Contact List
    [Documentation]    Navigates to the contacts list page.
    Click Element    ${Contacts Link}
    Wait Until Page Contains Element    ${Create Button}
