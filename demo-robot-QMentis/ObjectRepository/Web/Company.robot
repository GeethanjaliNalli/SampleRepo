*** Settings ***
Documentation     List of XPaths Used in the Company Module

*** Variables ***
${company.text.description}    name=description    # Description field
${company.text.identifier}    name=identifier    # Identifier field
${company.text.symbol}    name=symbol    # symbol field
${company.text.industry}    name=industry    # industry field
${company.text.title}    name=title    # Title field
${company.text.identifier}    name=identifier    # Identifier field
${company.text.name}    name=name    # name field
${company.text.url}    name=url    # url field
${company.text.vat.number}    name=vat_number    # vat number field
${company.text.annual.revenue}    name=annual_revenue    # annual_revenue field
${company.text.number.employees}    name=num_employees    # num_employees field
${company.text.email}    //label[text()='Email']/../..//input[@name='value']    # email field
${company.text.personal.email}    //label[text()='Email']/../..//input[@name='name']    # Personal email textfield
${company.text.Social Channels}    name=value    # value field
${company.text.phone.number}    //label[text()='Phone']/../..//input[@name='value']    # number text field
${company.text.phone.number.type}    //label[text()='Phone']/../..//input[@name='name']    # phone number type
${company.text.address}    name=address    # address field
${company.text.zip}    name=zip    # zip text field
${company.text.city}    name=city    # city text field
${company.text.state}    name=state    # state text field
