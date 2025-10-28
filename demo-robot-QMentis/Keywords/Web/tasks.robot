*** Settings ***
Documentation     Keywords for Tasks Module
Resource          ../../Global/super.robot
Resource          ../../ObjectRepository/Web/tasks.robot
Resource          common.robot

*** Keywords ***
Create Task
    [Arguments]    ${tasks_dict}    ${check_page_header}=True
    Comment    Clicking on create button in Tasks module
    Click On Create
    Comment    Enter Task details \ in Tasks module
    Enter Task Details    ${tasks_dict}
    Comment    Click on save button in Tasks module
    Click on Save
    Run Keyword If    ${check_page_header}==True    Check Page Header    ${tasks_dict}[Title]

Enter Task Details
    [Arguments]    ${tasksdict}
    Comment    Enter value in title field
    Run Keyword If    'Title' in ${tasksdict}    Input Text    ${tasks.text.title}    ${tasksdict}[Title]
    Comment    Select Item from Dropdown in assigned to field
    Run Keyword If    'Assigned to' in ${tasksdict}    Select Item from Dropdown    Assigned to    ${tasksdict}[Assigned to]
    Comment    Search and Select Item from Combo box in deal field
    Run Keyword If    'Deal' in ${tasksdict}    Search and Select    Deal    ${tasksdict}[Deal]
    Comment    Search and Select case field
    Run Keyword If    'Case' in ${tasksdict}    Search and Select    Case    ${tasksdict}[Case]
    Comment    Search and Select tags field
    Run Keyword If    'Tags' in ${tasksdict}    Search and Select    Tags    ${tasksdict}[Tags]
    Comment    Search and select contact field
    Run Keyword If    'Contact' in ${tasksdict}    Search and Select    Contact    ${tasksdict}[Contact]
    Comment    Enter value in identifier field
    Run Keyword If    'Identifier' in ${tasksdict}    Input Text    ${tasks.text.identifier}    ${tasksdict}[Identifier]
    Comment    Enter value in completion field
    Run Keyword If    'Completion' in ${tasksdict}    Input Text    ${tasks.text.completion}    ${tasksdict}[Completion]
    Comment    Enter value in description field
    Run Keyword If    'Description' in ${tasksdict}    Input Text    ${tasks.text.description}    ${tasksdict}[Description]
    Comment    Select Item from Dropdown in type field
    Run Keyword If    'Type' in ${tasksdict}    Select Item from Dropdown    Type    ${tasksdict}[Type]
    Comment    Select Item from Dropdown in priority field
    Run Keyword If    'Priority' in ${tasksdict}    Select Item from Dropdown    Priority    ${tasksdict}[Priority]
    Comment    Select Item from Dropdown in status field
    Run Keyword If    'Status' in ${tasksdict}    Select Item from Dropdown    Status    ${tasksdict}[Status]

Edit Tasks
    [Arguments]    ${tasks_dict}    ${record_name}
    Perform Table Actions    edit    ${record_name}
    Enter Task Details    ${tasks_dict}
    Click on Save
    Check Page Header    ${tasks_dict}[title]

Delete Tasks
    [Arguments]    ${record_name}
    Comment    Performing Delete record in Tasks Module
    Perform Table Actions    delete    ${record_name}
    Comment    Perform Actions on Delete Confirmation Pop up
    Perform Action on Confirmation Box    Delete

Search Task
    [Arguments]    ${filter.name}    ${value}
    Comment    Performing Filter Operation in Tasks Module
    Filters    ${filter.name}    ${value}
    comment    Checking the record displayed
    Check Records Displayed    ${value}
