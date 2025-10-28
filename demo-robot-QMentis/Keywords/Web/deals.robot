*** Settings ***
Documentation     Keywords for Deals Module
Resource          ../../Global/super.robot
Resource          ../../ObjectRepository/Web/deals.robot
Resource          common.robot

*** Keywords ***
Create Deals
    [Arguments]    ${dict_deal_data}    ${check_page_header}=True
    Click on Create
    Enter Deal Details    ${dict_deal_data}
    Click on Save
    Run Keyword If    ${check_page_header}==True    Check Page Header    ${dict_deal_data}[Title]

Edit Deals
    [Arguments]    ${dict_deal_data}    ${record_name}    ${check_page_header}=True
    Perform Table Actions    edit    ${record_name}
    Enter Deal Details    ${dict_deal_data}
    Click on Save
    Run Keyword If    ${check_page_header}==True    Check Page Header    ${dict_deal_data}[Title]

Enter Deal Details
    [Arguments]    ${dict_deal_data}
    Comment    Enter value in title field
    Run Keyword If    'Title' in ${dict_deal_data}    Input Text    ${deal.text.title}    ${dict_deal_data}[Title]
    Run Keyword If    'Assigned to' in ${dict_deal_data}    Select Item from Dropdown    Assigned To    ${dict_deal_data}[Assigned to]
    Run Keyword If    'Company' in ${dict_deal_data}    Search and Select    Company    ${dict_deal_data}[Company]
    Run Keyword If    'Contact' in ${dict_deal_data}    Search and Select    Contacts    ${dict_deal_data}[Contact]
    Run Keyword If    'Description' in ${dict_deal_data}    Clear and Input Text    ${deal.text.description}    ${dict_deal_data}[Description]
    Run Keyword If    'Probability' in ${dict_deal_data}    Clear and Input Text    ${deal.text.probability}    ${dict_deal_data}[Probability]
    Run Keyword If    'Tags' in ${dict_deal_data}    Search and Select    Tags    ${dict_deal_data}[Tags]
    Run Keyword If    'Amount' in ${dict_deal_data}    Clear and Input Text    ${deal.text.amount}    ${dict_deal_data}[Amount]
    Run Keyword If    'Products' in ${dict_deal_data}    Search and Select    Products    ${dict_deal_data}[Products]
    Run Keyword If    'Commision' in ${dict_deal_data}    Clear and Input Text    ${deal.text.commision}    ${dict_deal_data}[Commision]
    Run Keyword If    'Stage' in ${dict_deal_data}    Select Item from Dropdown    Stage    ${dict_deal_data}[Stage]
    Run Keyword If    'Status' in ${dict_deal_data}    Select Item from Dropdown    Status    ${dict_deal_data}[Status]
    Run Keyword If    'Next steps' in ${dict_deal_data}    Clear and Input Text    ${deal.text.nextsteps}    ${dict_deal_data}[Next steps]
    Run Keyword If    'Type' in ${dict_deal_data}    Select Item from Dropdown    Type    ${dict_deal_data}[Type]
    Run Keyword If    'Source' in ${dict_deal_data}    Select Item from Dropdown    Source    ${dict_deal_data}[Source]
    Run Keyword If    'Identifier' in ${dict_deal_data}    Clear and Input Text    ${deal.text.identifier}    ${dict_deal_data}[Identifier]

Delete Deals
    [Arguments]    ${record_name}
    Perform Table Actions    delete    ${record_name}
    Perform Action on Confirmation Box    Delete

Delete A Deal In Web
    [Arguments]    ${Deal_Title}
    Login to Cogmento Application    sasapurambabu79@gmail.com    Ram@4321
    Maximize Browser Window
    Navigate to Modules    Deals
    ${Deal_Delete}    Update dynamic Xpath    ${common.icon.table.delete}    ${Deal_Title}
    Wait Until Element Is Visible    ${Deal_Delete}    ${MEDIUM_WAIT}
    Click Element    ${Deal_Delete}
    Wait Until Element Is Visible    ${common.btn.delete}    ${MEDIUM_WAIT}
    Click Element    ${common.btn.delete}
    Wait Until Element Is Not Visible    ${Deal_Delete}    ${MEDIUM_WAIT}
    Close Browser
