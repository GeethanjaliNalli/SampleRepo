*** Settings ***
Documentation    Keywords for Diary - New Patient Booking functionality
Resource         ../../Global/super.robot

*** Keywords ***
User Should Be Logged In On Diary Screen
    [Documentation]    Ensures the user is logged in and navigated to the diary screen (precondition)
    # Reuse existing login and navigation keywords if available, else implement navigation
    Login To Application
    Navigate To Diary Screen

Open New Booking Form
    [Documentation]    Opens the new patient booking form from the diary screen
    Wait Until Element Is Visible    ${NEW_BOOKING_BUTTON}
    Click Element                   ${NEW_BOOKING_BUTTON}
    Wait Until Element Is Visible    ${BOOKING_FORM}

Fill Booking Details
    [Documentation]    Fills in all required information for a new patient booking
    # Add steps to fill each required field here using available locators
    # Example: Input Text    ${BOOKING_FORM_FIELD}    ${VALUE}
    # As locators are undefined, this is a placeholder for all required fields
    # Repeat for all required fields

Save New Booking
    [Documentation]    Saves the new booking after filling required information
    Click Element    ${SAVE_BOOKING_BUTTON}
    Wait Until Element Is Not Visible    ${BOOKING_FORM}

Verify New Booking Is Reflected On Diary
    [Documentation]    Verifies that the new booking appears on the selected diary and time slot with the Black "A"-icon
    Wait Until Element Is Visible    ${BOOKING_SLOT}
    Element Should Contain    ${BOOKING_SLOT}    A
    # Add further verification for the Black "A"-icon if possible

Booking Should Not Be Made If Not Saved Or Required Fields Missing
    [Documentation]    Ensures that no booking is made if the form is closed or required fields are missing
    # Attempt to close the form without saving or leave required fields empty
    # Verify that ${BOOKING_SLOT} does not appear or booking is not present
    # Placeholder for negative check
