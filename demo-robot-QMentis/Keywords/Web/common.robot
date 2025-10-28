*** Settings ***
Documentation     Common Keywords Applicable Across All Modules
Resource          ../../Global/super.robot
Resource          ../../ObjectRepository/Web/common.robot
Resource          ../../ObjectRepository/Web/login.robot

*** Keywords ***
Launch Browser
    [Arguments]    ${browser_name}    ${url}
    Run Keyword If    '${browser_name}'=='Chrome' or '${browser_name}'=='chrome' or '${browser_name}'=='gc'    Open Browser    ${url}    gc
    Comment    if the browser is Chrome it will open the Chrome browser
    Run Keyword If    '${browser_name}'=='Firefox' or '${browser_name}'=='firefox' or '${browser_name}'=='ff'    Open Browser    ${url}    Firefox
    Comment    if the browser is Firefox it will open the Firefox browser
    Run Keyword If    '${browser_name}'=='edge' or '${browser_name}'=='Edge'    Open Browser    ${url}    edge

Launch Browser and Navigate to URL
    [Arguments]    ${url}    ${browser_name}
    ${session}    Run Keyword And Return Status    Get Session Id
    Run Keyword If    ${session}==True    Go To    ${url}
    ...    ELSE    Launch Browser    ${browser_name}    ${url}
    Maximize Browser Window
    Comment    Set Browser Position    ${browser_name}

Login to Cogmento Application
    [Arguments]    ${username}    ${password}
    Comment    Set Test Message    Launch Browser: ${BROWSER_NAME}
    Launch Browser and Navigate to URL    ${URL}    ${BROWSER_NAME}
    Comment    Launch Chrome Browser and Navigate to Cogmento URL
    Enter Login Details    ${username}    ${password}
    Comment    Enter a valid username and valid password
    sleep    3s
    Wait Until Element Is Visible    ${common.label.home.username}    ${LONG_WAIT}    User not able to login to the application
    common.Take Screenshot

Enter Login Details
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible    ${login.text.email}    ${LONG_WAIT}    Login page is not displayed after waiting ${LONG_WAIT}
    Input Text    ${login.text.email}    ${username}
    Input Text    ${login.text.password}    ${password}
    Click Element    ${login.button.login}

Read TestData From Excel
    [Arguments]    ${testcaseid}    ${sheet_name}
    [Documentation]    Read TestData from excel file for required data.
    ...
    ...    Example:
    ...    Read TestData From Excel TC_01 SheetName
    ${test_prerequisite_data}    CustomLibrary.Get Ms Excel Row Values Into Dictionary Based On Key    ${TESTDATA_FOLDER}/TestData.xlsx    ${testcaseid}    ${sheet_name}
    Comment    Set Global Variable    ${test_prerequisite_data}
    [Return]    ${test_prerequisite_data}

Take Screenshot
    Capture Page Screenshot

Read Data From Excel
    [Arguments]    ${testcase_name}
    ${COMPANY_DATA}    CustomLibrary.Get Ms Excel Row Values Into Dictionary Based On Key    ${TESTDATA_FOLDER}/TestData.xlsx    ${testcase_name}    Company
    Set Global Variable    ${COMPANY_DATA}
    ${CONTACT_DATA}    CustomLibrary.Get Ms Excel Row Values Into Dictionary Based On Key    ${TESTDATA_FOLDER}/TestData.xlsx    ${testcase_name}    Contacts
    Set Global Variable    ${CONTACT_DATA}
    ${DEAL_DATA}    CustomLibrary.Get Ms Excel Row Values Into Dictionary Based On Key    ${TESTDATA_FOLDER}/TestData.xlsx    ${testcase_name}    Deals
    Set Global Variable    ${DEAL_DATA}
    ${CASE_DATA}    CustomLibrary.Get Ms Excel Row Values Into Dictionary Based On Key    ${TESTDATA_FOLDER}/TestData.xlsx    ${testcase_name}    Cases
    Set Global Variable    ${CASE_DATA}
    ${TASK_DATA}    CustomLibrary.Get Ms Excel Row Values Into Dictionary Based On Key    ${TESTDATA_FOLDER}/TestData.xlsx    ${testcase_name}    Tasks
    Set Global Variable    ${TASK_DATA}

Set Browser Position
    [Arguments]    ${browser_name}
    Run Keyword If    '${browser_name}'=='Chrome' or '${browser_name}'=='chrome' or '${browser_name}'=='gc'    Set Window Position    0    5
    Run Keyword If    '${browser_name}'=='Firefox' or '${browser_name}'=='firefox' or '${browser_name}'=='ff'    Set Window Position    1005    6
    Set Window Size    959    1047

Create Screenshot Directory
    Run Keyword And Ignore Error    Create Directory    ${EXECDIR}/Screenshots
    Set Screenshot Directory    ${EXECDIR}/Screenshots

Get Filename For Image
    ${time}=    Get Time
    ${time}=    Remove String    ${time}    -
    ${time}=    Remove String    ${time}    :
    ${time}=    Remove String    ${time}    ${SPACE}
    ${filename}=    Set Variable    flower_${BROWSER_NAME}_${time}.png
    Return From Keyword    ${filename}

Update dynamic Xpath
    [Arguments]    ${locator}    ${text}
    ${new_locator}    Replace String    ${locator}    replaceText    ${text}
    [Return]    ${new_locator}

Navigate to Modules
    [Arguments]    ${module_name}
    Wait Until Element Is Visible    ${common.icon.home}    ${SHORT_WAIT}
    Click Element    ${common.icon.home}
    ${new_loc_module}    Update dynamic Xpath    ${common.icon.module.name}    ${module_name}
    Wait Until Element Is Visible    ${new_loc_module}
    Click Element    ${new_loc_module}
    Mouse Over    ${common.icon.logo.cogmento}
    Reload Page
    Comment    check the page header name
    Check Page Header    ${module_name}

Select Item from Dropdown
    [Arguments]    ${dropdown_name}    ${item_name}
    Comment    Click on dropdown button for the list to be listed
    ${new_dropdown}    Update dynamic Xpath    ${common.dropdown.button}    ${dropdown_name}
    Wait Until Element Is Visible    ${new_dropdown}    ${SHORT_WAIT}    Check the drop down id displayued
    Click Element    ${new_dropdown}
    Comment    Check the drop down list is displayed
    Wait Until Element Is Visible    ${common.dropdown.list}    ${MEDIUM_WAIT}    Check the list of options are displayed on clicking dropdown
    Comment    Select the item from drop down list
    ${new_loc_item}    Update dynamic Xpath    ${common.dropdown.list.select}    ${item_name}
    Comment    selecting the value in the dropdown
    Wait Until Element Is Visible    ${new_loc_item}    ${MEDIUM_WAIT}    Check the item is displayed in the dropdown list
    Click Element    ${new_loc_item}

Select Item from filters
    [Arguments]    ${filter_name}    ${item_name}
    Comment    Click on dropdown button for the list to be listed
    ${new_dropdown}    Update dynamic Xpath    ${common.dropdown.filter.button}    ${filter_name}
    Wait Until Element Is Visible    ${new_dropdown}    ${SHORT_WAIT}    Check the drop down is displayed
    Click Element    ${new_dropdown}
    Comment    Check the drop down list is displayed
    Wait Until Element Is Visible    ${common.dropdown.list}    ${MEDIUM_WAIT}    Check the list of options are displayed on clicking dropdown
    Comment    Select the item from drop down list
    ${new_loc_item}    Update dynamic Xpath    ${common.dropdown.list.select}    ${item_name}
    Comment    selecting the value in the dropdown
    Wait Until Element Is Visible    ${new_loc_item}    ${MEDIUM_WAIT}    Check the item is displayed in the dropdown list

Filters
    [Arguments]    ${search_item}    ${value}
    Wait Until Keyword Succeeds    2    2s    Click Show Filter
    Comment    selecting the dropdown by name in name dropdown and selecting the value in the dropdown
    Select Item from filters    name    ${search_item}
    Comment    selecting the dropdown by name in operator dropdown and selecting the value in the dropdown
    Select Item from filters    operator    Equals
    Comment    entering the text in the value text box
    Input Text    ${common.text.filter.value}    ${value}
    Comment    clicking the search icon the show filters
    Click Element    ${common.icon.filter.search}

Search and Select
    [Arguments]    ${field_name}    ${value}
    ${loc_combo_button}    Update dynamic Xpath    ${common.combobox.button}    ${field_name}
    Comment    Click on Combo box
    Wait Until Element Is Visible    ${loc_combo_button}    ${SHORT_WAIT}
    Click Element    ${loc_combo_button}
    Comment    Enter text in combo box to search
    ${loc_combo_input}    Update dynamic Xpath    ${common.combobox.text}    ${field_name}
    Comment    Add existing text from list of dropdown
    Input Text    ${loc_combo_input}    ${value}
    Wait Until Element Is Visible    ${common.dropdown.list}    ${MEDIUM_WAIT}    Check the list of options are displayed on clicking dropdown
    Comment    Check Add option is displayed for new item and click
    sleep    2s
    ${loc_dropdown_select}    Update dynamic Xpath    ${common.dropdown.list.select}    ${value}
    ${status}    Run Keyword And Return Status    Element Should Be Visible    ${common.combobox.add.new}
    Run Keyword If    '${status}'=='True'    Click Element    ${common.combobox.add.new}
    Run Keyword If    '${status}'=='False'    Click Element    ${loc_dropdown_select}

Logout from application
    Wait Until Element Is Visible    ${common.icon.settings}    ${SHORT_WAIT}
    Click Element    ${common.icon.settings}
    Wait Until Element Is Visible    ${common.icon.settings_logout}    ${SHORT_WAIT}
    Click Element    ${common.icon.settings_logout}

Check field required error message
    [Arguments]    ${expected_error_message}
    ${actual_error_message}    Set Variable
    Wait Until Element Is Visible    ${common.error.msg.inline}    ${SHORT_WAIT}
    ${erromessage_count}    Get Element Count    ${common.error.msg.inline}
    FOR    ${element}    IN RANGE    1    ${erromessage_count}+1
        ${Index}    Convert To String    ${element}
        ${loc_error_msg}    Update dynamic Xpath    ${common.error.msg.inline.item}    ${Index}
        ${current_item}=    Get Text    ${loc_error_msg}
        ${actual_error_message}    Catenate    ${actual_error_message}    ${current_item}
    END
    Log    ${actual_error_message}
    Should Contain    ${actual_error_message}    ${expected_error_message}

Check error message
    [Arguments]    ${expected_error_message}
    Wait Until Element Is Visible    ${common.error.message}
    ${actual_error_message}=    Get Text    ${common.error.message}
    Should Contain    ${expected_error_message}    ${actual_error_message}

Delete Record
    [Arguments]    ${title_name}
    ${action}=    Set Variable    delete
    Perform Table Actions    ${action}    ${title_name}
    Check Confirmation Pop Up
    Perform Action on Confirmation Box    Delete

Private Access User
    [Arguments]    @{users.list.names}
    Comment    Click the 'Toggle' button to change the access from public to private
    Click Element    ${common.button.public.access}
    comment    Verify Access changed from public to private
    Element Should Be Visible    ${common.button.privateaccess}
    Take Screenshot
    Wait Until Element Is Visible    ${common.dropdown.private_placeholder}
    Click Element    ${common.dropdown.private_placeholder}
    Comment    After clicking placeholder wait until visibility of users list
    Wait Until Element Is Visible    ${common.dropdown.list}
    FOR    ${user}    IN    @{users.list.names}
        ${loc_username}    Update dynamic Xpath    ${common.dropdown.list.select}    ${user}
        Click Element    ${loc_username}
    END

Perform Table Actions
    [Arguments]    ${action}    ${title_name}
    ${newLoc_action}=    Set Variable If    '${action}'=='view'    ${common.icon.table.view}    '${action}'=='edit'    ${common.icon.table.edit}    '${action}'=='delete'    ${common.icon.table.delete}    '${action}'=='call'    ${common.icon.table.call}
    ${updatedLoc_action}    Update dynamic Xpath    ${newLoc_action}    ${title_name}
    Wait Until Element Is Visible    ${updatedLoc_action}    ${MEDIUM_WAIT}
    Click Element    ${updatedLoc_action}
    Run Keyword If    '${action}'=='delete'    Check Confirmation Pop Up
    Run Keyword If    '${action}'!='delete'    Check Page Header    ${title_name}

Check Records Displayed
    [Arguments]    ${record_name}
    ${loc_record_name}    Update dynamic Xpath    ${common.table.td.name}    ${record_name}
    Wait Until Element Is Visible    ${loc_record_name}    ${SHORT_WAIT}

Check RubbishBin Records
    [Arguments]    ${module_name}    ${record_name}
    Click Element    ${common.button.rubbishbin}
    Check Page Header    Rubbish Bin
    ${new_module}    Update dynamic Xpath    ${common.text.rubbishbin.module_name}    ${module_name}
    Click Element    ${new_module}
    Check Records Displayed    ${record_name}

Check Confirmation Pop Up
    Wait Until Element Is Visible    ${common.popup.confirmation.box}    ${SHORT_WAIT}    Check confirmation pop up is displayed

Check Page Header
    [Arguments]    ${module_name}
    ${newHeader_xpath}    Update dynamic Xpath    ${common.page.header}    ${module_name}
    Wait Until Element Is Visible    ${newHeader_xpath}    ${MEDIUM_WAIT}

Perform Action on Confirmation Box
    [Arguments]    ${operation}
    ${newLoc_operation}    Update dynamic Xpath    ${common.button.confirmation.box}    ${operation}
    Wait Until Element Is Visible    ${newLoc_operation}    ${SHORT_WAIT}
    Click Element    ${newLoc_operation}

Click Show Filter
    Wait Until Element Is Visible    ${common.button.filter.show}
    Click Button    ${common.button.filter.show}
    Wait Until Element Is Visible    //button[text()='Hide Filters']

Click and Wait Until
    [Arguments]    ${click_element}    ${wait_element}
    Wait Until Element Is Visible    ${click_element}    ${SHORT_WAIT}
    Click Element    ${click_element}

Click On Create
    Wait Until Element Is Visible    ${common.button.create}
    Click and Wait Until    ${common.button.create}    ${common.button.save}

Click on Save
    Wait Until Element Is Visible    ${common.button.save}    ${SHORT_WAIT}
    Click Element    ${common.button.save}

Check Add Notes Confirmation
    [Arguments]    ${notes_text}
    ${updated_loc}    Update dynamic Xpath    ${common.text.addnotes_value}    ${notes_text}
    Wait Until Element Is Visible    ${updated_loc}

Get Error Message
    Wait Until Element Is Visible    ${common.error.message}    ${LONG_WAIT}    Check error message is displayed
    ${error_msg}    Get Text    ${common.error.message}
    [Return]    ${error_msg}

Clear and Input Text
    [Arguments]    ${locator}    ${value}
    Press Keys    ${locator}    CTRL+a+BACKSPACE
    Input Text    ${locator}    ${value}
