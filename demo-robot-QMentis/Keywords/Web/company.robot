*** Settings ***
Documentation     Keywords for Company Module
Resource          ../../Global/super.robot
Resource          ../../ObjectRepository/Web/company.robot
Resource          common.robot

*** Keywords ***
Create company
    [Arguments]    ${dict_company_data}    ${check_page_header}=True
    Click On Create
    Comment    creating the company and
    Comment    entering the company details in company page
    Enter company details    ${dict_company_data}
    Comment    after creating the company it will save
    Click on Save
    Run Keyword If    ${check_page_header}==True    Check Page Header    ${dict_company_data}[Name]

Edit company
    [Arguments]    ${companydict}    ${record_name}    ${check_page_header}=True
    Perform Table Actions    edit    ${record_name}
    Comment    performing edit operation in table actions
    Enter company details    ${companydict}
    Comment    entering the name in existing name
    Click on Save
    Run Keyword If    ${check_page_header}==True    Check Page Header    ${companydict}[name]

Enter company details
    [Arguments]    ${dictCompany}
    Comment    Enter name in title field
    Run Keyword If    'Name' in ${dictCompany}    Input Text    ${company.text.name}    ${dictCompany}[Name]
    Comment    entering website of the company
    Run Keyword If    'URL' in ${dictCompany}    Input Text    ${company.text.url}    ${dictCompany}[URL]
    Comment    entering the text in the address text field
    Run Keyword If    'Address' in ${dictCompany}    Input Text    ${company.text.address}    ${dictCompany}[Address]
    Comment    entering the text in the city text field
    Run Keyword If    'City' in ${dictCompany}    Input Text    ${company.text.city}    ${dictCompany}[City]
    Comment    entering the text in the state text field
    Run Keyword If    'State' in ${dictCompany}    Input Text    ${company.text.state}    ${dictCompany}[State]
    Comment    entering the text in the zip text field
    Run Keyword If    'Zip' in ${dictCompany}    Input Text    ${company.text.zip}    ${dictCompany}[Zip]
    Comment    entering Phone number
    Run Keyword If    'Phone_Number' in ${dictCompany}    Input Text    ${company.text.phone.number}    ${dictCompany}[Phone_Number]
    Comment    entering    phone number type like home, work, mobile,others
    Run Keyword If    'Phone_Number_Type' in ${dictCompany}    Input Text    ${company.text.phone.number.type}    ${dictCompany}[Phone_Number_Type]
    Comment    entering the email address in text field
    Run Keyword If    'Email_Address' in ${dictCompany}    Input Text    ${company.text.email}    ${dictCompany}[Email_Address]
    Comment    entering the Personal email address in text field
    Run Keyword If    'Personal_Email' in ${dictCompany}    Input Text    ${company.text.personal.email}    ${dictCompany}[Personal_Email]
    Comment    Enter industry in text field
    Run Keyword If    'Industry' in ${dictCompany}    Input Text    ${company.text.industry}    ${dictCompany}[Industry]
    Comment    entering Num of employees in the company
    Run Keyword If    'Num_employees' in ${dictCompany}    Input Text    ${company.text.number.employees}    ${dictCompany}[Num_employees]
    Comment    entering the annual revenue of company
    Run Keyword If    'Annual_revenue' in ${dictCompany}    Input Text    ${company.text.annual.revenue}    ${dictCompany}[Annual_revenue]
    Comment    selecting priority from dropdown
    Run Keyword If    'Priority' in ${dictCompany}    Select Item from Dropdown    Priority    ${dictCompany}[Priority]
    Comment    selecting status from dropdown
    Run Keyword If    'Status' in ${dictCompany}    Select Item from Dropdown    Status    ${dictCompany}[Status]
    Comment    selecting source from dropdown
    Run Keyword If    'Source' in ${dictCompany}    Select Item from Dropdown    Source    ${dictCompany}[Source]
    Comment    entering the vat_number in the text field
    Run Keyword If    'Vat_number' in ${dictCompany}    Input Text    ${company.text.vat.number}    ${dictCompany}[Vat_number]
    Comment    entering the text in the identifier text field

Delete company
    [Arguments]    ${title_companyname}
    Perform Table Actions    delete    ${title_companyname}
    Comment    performing the delete operation in table actions
    Perform Action on Confirmation Box    Delete
    Comment    checking the pop up message is delete operation.

Search company
    [Arguments]    ${dropdown}    ${company_name}
    Filters    ${dropdown}    ${company_name}
    Comment    checking the filter by name and oprator dropdown
    Check Records Displayed    ${company_name}
    Comment    After searching the company in company records
