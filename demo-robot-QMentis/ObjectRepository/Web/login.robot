*** Settings ***
Documentation     List of XPaths Used for Login

*** Variables ***
${login.text.email}    email
${login.text.password}    password
${login.button.login}    //div[text()='Login']
${login.errormsg.container}    //div[@class='ui negative message']
${login.error.message}    //div[@class='ui negative message']//p
