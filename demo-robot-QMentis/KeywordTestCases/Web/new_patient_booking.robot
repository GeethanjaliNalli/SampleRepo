*** Settings ***
Documentation    Test suite for verifying new patient booking functionality in Diary module. Ensures that a booking can be created, saved, and reflected on the diary screen with correct icon, and that bookings are not created if required fields are missing or not saved.
Resource    ../../Global/super.robot

*** Test Cases ***
TC00002_Diary_NPB New Patient Booking
    [Documentation]    Verify that a new patient booking can be created and is correctly reflected on the diary screen. Also verify that no booking is made if required information is missing or booking is not saved.
    [Tags]    Diary    Booking    Functional    Medium
    User Should Be Logged In On Diary Screen
    Open New Booking Form
    Fill Booking Details
    Save New Booking
    Verify New Booking Is Reflected On Diary
    Booking Should Not Be Made If Not Saved Or Required Fields Missing
