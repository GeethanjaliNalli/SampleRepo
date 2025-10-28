*** Settings ***
Documentation     Keywords for Cases Module
Resource          ../../Global/super.robot
Resource          ../../ObjectRepository/Web/cases.robot
Resource          common.robot

*** Keywords ***
Create Cases
    [Arguments]    ${dict_case_values}    ${check_page_header}=True
    Click on Create
    Enter Case Details    ${dict_case_values}
    Click on Save
    Run Keyword If    ${check_page_header}==True    Check Page Header    ${dict_case_values}[Title]

Enter Case Details
    [Arguments]    ${dict_case_data} 
    Run Keyword If    'Title' in ${dict_case_data}    Input Text    ${case.text.title}    ${dict_case_data}[Title]
    Run Keyword If    'Assigned to' in ${dict_case_data}    Select Item from Dropdown    Assigned To    ${dict_case_data}[Assigned to]
    Run Keyword If    'Contact' in ${dict_case_data}    Search and Select    Contact    ${dict_case_data}[Contact]
    Run Keyword If    'Company' in ${dict_case_data}    Search and Select    Company    ${dict_case_data}[Company]
    Run Keyword If    'Deal' in ${dict_case_data}    Search and Select    Deal    ${dict_case_data}[Deal]
    Run Keyword If    'Type' in ${dict_case_data}    Select Item from Dropdown    Type    ${dict_case_data}[Type]
    Run Keyword If    'Tags' in ${dict_case_data}    Search and Select    Tags    ${dict_case_data}[Tags]
    Run Keyword If    'Description' in ${dict_case_data}    Input Text    ${case.text.description}    ${dict_case_data}[Description]
    Run Keyword If    'Priority' in ${dict_case_data}    Select Item from filters    priority    ${dict_case_data}[Priority]
    Run Keyword If    'Status' in ${dict_case_data}    Select Item from filters    status    ${dict_case_data}[Status]
    Run Keyword If    'Identifier' in ${dict_case_data}    Input Text    ${case.text.identifier}    ${dict_case_data}[Identifier]

Edit Case Details
    [Arguments]    ${dict_case_data}    ${record_name}    ${check_page_header}=True
    Perform Table Actions    edit    ${record_name}
    Click Element    ${case.text.title}
    Enter Case Details    ${dict_case_data}
    Click on Save
    Run Keyword If    ${check_page_header}==True    Check Page Header    ${dict_case_data}[Title]

Delete Case
    [Arguments]    ${record_name}
    Perform Table Actions    delete    ${record_name}
    Perform Action on Confirmation Box    Delete
