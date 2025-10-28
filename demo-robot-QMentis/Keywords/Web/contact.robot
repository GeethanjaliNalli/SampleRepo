*** Settings ***
Documentation     Keywords for Contact Module
Resource          ../../Global/super.robot
Resource          ../../ObjectRepository/Web/contacts.robot
Resource          common.robot

*** Variables ***

*** Keywords ***
Enter Data in Contact
    [Arguments]    ${dict_contact_details}
    comment    Enter Text in the firstname field
    Run Keyword If    'First_name' in ${dict_contact_details}    Clear and Input Text    ${contacts.text.firstname}    ${dict_contact_details}[First_name]
    comment    Enter Text in the middlename field
    Run Keyword If    'Middle_name' in ${dict_contact_details}    Clear and Input Text    ${contacts.text.middlename}    ${dict_contact_details}[Middle_name]
    comment    Enter Text in the lastname field
    Run Keyword If    'Last_name' in ${dict_contact_details}    Clear and Input Text    ${contacts.text.lastname}    ${dict_contact_details}[Last_name]
    comment    Search and select the Tags field
    Run Keyword If    'Tags' in ${dict_contact_details}    Search and Select    Tags    ${dict_contact_details}[Tags]
    comment    Search and select the Company field
    Run Keyword If    'Company' in ${dict_contact_details}    Search and Select    Company    ${dict_contact_details}[Company]
    comment    Select Item from Dropdown in Category field
    Run Keyword If    'Category' in ${dict_contact_details}    Select Item from Dropdown    Category    ${dict_contact_details}[Category]
    comment    Enter Text in the email field
    Run Keyword If    'Email' in ${dict_contact_details}    Input Text    ${contacts.text.email}    ${dict_contact_details}[Email]
    comment    Enter Text in the personal email field
    Run Keyword If    'Personal_email' in ${dict_contact_details}    Input Text    ${contacts.text.personalemail}    ${dict_contact_details}[Personal_email]
    comment    Select Item from Dropdown in Status field
    Run Keyword If    'Status' in ${dict_contact_details}    Select Item from Dropdown    Status    ${dict_contact_details}[Status]
    comment    Enter Text in the description field
    Run Keyword If    'Description' in ${dict_contact_details}    Input Text    ${contacts.text.description}    ${dict_contact_details}[Description]
    comment    Select Item from filters the Social Channel field
    Run Keyword If    'Channel_type' in ${dict_contact_details}    Select Item from filters    channel_type    ${dict_contact_details}[Channel_type]
    comment    Enter Text in the Social channel field
    Run Keyword If    'Value' in ${dict_contact_details}    Input Text    ${contacts.text.socialchannels}    ${dict_contact_details}[Value]
    comment    Enter Text in the Address street field
    Run Keyword If    'Address_street' in ${dict_contact_details}    Input Text    ${contacts.text.address_street}    ${dict_contact_details}[Address_street]
    comment    Enter Text in the Address city field
    Run Keyword If    'Address_city' in ${dict_contact_details}    Input Text    ${contacts.text.address_city}    ${dict_contact_details}[Address_city]
    comment    Enter Text in the Address state field
    Run Keyword If    'Address_state' in ${dict_contact_details}    Input Text    ${contacts.text.address_state}    ${dict_contact_details}[Address_state]
    comment    Enter Text in the Address Post Code field
    Run Keyword If    'Zip' in ${dict_contact_details}    Input Text    ${contacts.text.address_postcode}    ${dict_contact_details}[Zip]
    comment    Select items from filters in \ the Country field
    Run Keyword If    'Country' in ${dict_contact_details}    Select Item from filters    country    ${dict_contact_details}[Country]
    comment    Select Items from filters in \ the Country in Phone field
    Run Keyword If    'Phone_Country' in ${dict_contact_details}    Select Item from filters    hint    ${dict_contact_details}[Phone_Country]
    comment    Enter Number in the Phone number field
    Run Keyword If    'Phone_Number' in ${dict_contact_details}    Input Text    ${contacts.text.phone_number}    ${dict_contact_details}[Phone_Number]
    comment    Enter Text in the Phone number Home field
    Run Keyword If    'Phone_Number_Type' in ${dict_contact_details}    Input Text    ${contacts.text.phone_home}    ${dict_contact_details}[Phone_Number_Type]
    comment    Enter Text in the Position field
    Run Keyword If    'Position' in ${dict_contact_details}    Input Text    ${contacts.text.position}    ${dict_contact_details}[Position]
    comment    Enter Text in the Department field
    Run Keyword If    'Department' in ${dict_contact_details}    Input Text    ${contacts.text.department}    ${dict_contact_details}[Department]
    comment    Select Items from filters in \ the Source field
    Run Keyword If    'Source' in ${dict_contact_details}    Select Item from filters    source    ${dict_contact_details}[Source]
    comment    Enter Text in the identifier field
    Run Keyword If    'Identifier' in ${dict_contact_details}    Input Text    ${contacts.text.identifier}    ${dict_contact_details}[Identifier]

Create Contact
    [Arguments]    ${dict_value}    ${check_page_header}=True
    Click on Create
    Enter Data in Contact    ${dict_value}
    Click on Save
    ${title}    Run Keyword If    ${check_page_header}==True    Get Contact Page Header    ${dict_value}
    Run Keyword If    ${check_page_header}==True    Check Page Header    ${title}

Edit Contact
    [Arguments]    ${dict_value}    ${record_name}    ${check_page_header}=True
    Perform Table Actions    edit    ${record_name}
    Enter Data in Contact    ${dict_value}
    Click on Save
    ${updated_title}    Run Keyword If    ${check_page_header}==True    Get Contact Page Header    ${dict_value}
    Run Keyword If    ${check_page_header}==True    Check Page Header    ${updated_title}

Delete Contacts
    [Arguments]    ${record_name}
    Perform Table Actions    delete    ${record_name}
    Perform Action on Confirmation Box    Delete

Get Contact Full Name
    [Arguments]    ${dict_value}
    ${full_name}    Set Variable If    'Middle_name' in ${dict_value}    ${dict_value}[First_name]${SPACE}${dict_value}[Middle_name]${SPACE}${dict_value}[Last_name]    ${dict_value}[First_name]${SPACE}${dict_value}[Last_name]
    [Return]    ${full_name}

Get Contact Page Header
    [Arguments]    ${dict_value}
    ${name}    Set Variable    ${dict_value}[First_name]${SPACE}${dict_value}[Last_name]
    [Return]    ${name}
