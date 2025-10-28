*** Settings ***
Documentation     List of XPaths Used in the Contacts Module

*** Variables ***
${contacts.text.firstname}    name=first_name
${contacts.text.lastname}    name=last_name
${contacts.text.middlename}    name=middle_name
${contacts.text.email}    //input[@placeholder='Email address']
${contacts.text.personalemail}    //input[@placeholder='Personal email, Business, Alt...']
${contacts.text.description}    name=description
${contacts.text.address_street}    name=address
${contacts.text.address_city}    name=city
${contacts.text.address_state}    name=state
${contacts.text.address_postcode}    name=zip
${contacts.text.phone_number}    //div/input[@placeholder='Number']
${contacts.text.position}    name=position
${contacts.text.department}    name=department
${contacts.text.phone_home}    //div[@class="four fields"]//div/input[@name="name"]
${contacts.text.identifier}    name=identifier
${contacts.text.socialchannels}    //div[@class="three fields"]/div/div[@class='ui input']/input[@name='value']
