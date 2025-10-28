*** Settings ***
Documentation     Invalid Test Cases
Suite Setup
Suite Teardown
Test Template     Invalid Login Credientials
Library           DataDriver    ../../Testdata/Testdata.xlsx    sheet_name=Login_DD
Resource          ../../Global/super.robot
Resource          ../../Keywords/Web/common.robot

*** Variables ***
${email}          ${EMPTY}
${password}       ${EMPTY}
${error_message}    ${EMPTY}

*** Test Cases ***
Invalid Login Credientials
    [Setup]    Launch Browser and Navigate to URL    ${URL}    ${BROWSER_NAME}
    ${email}    ${password}    ${error_message}
    [Teardown]    Close Browser

*** Keywords ***
Invalid Login Credientials
    [Arguments]    ${email}    ${password}    ${error_message}
    Comment    Maximizing current browser
    Maximize Browser Window
    Enter Login Details    ${email}    ${password}
    Wait Until Element Is Visible    ${login.errormsg.container}    ${SHORT_WAIT}    Login error message is not displayed
    Capture Page Screenshot
    ${error_msg}    Get Text    ${login.errormsg.container}
    Element Should Contain    ${login.error.message}    ${error_message}
