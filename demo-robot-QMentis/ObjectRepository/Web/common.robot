*** Settings ***
Documentation     Common Xpaths Applicable Across All Modules

*** Variables ***
${common.icon.home}    //i[@class='home icon']
${common.icon.logo.cogmento}    //div[@class='header item']
${common.icon.homemousehower}    //div[@id="main-nav"]//span[text()='replaceText']
${common.dropdown.button}    //label[text()='replaceText']/.././div[@role='listbox']
${common.dropdown.list}    //div[@class='visible menu transition']
${common.dropdown.list.select}    //div[@class='visible menu transition']/div/span[text()='replaceText']
${common.dropdown.filter.button}    name=replaceText
${common.dropdown.private_placeholder}    //div[text()='Select users allowed access.']
${common.icon.filter.search}    //i[@class="search small icon"]
${common.text.filter.value}    //input[@name="value"]
${common.button.filter.show}    //button[text()='Show Filters']
${common.combobox.button}    //label[text()='replaceText']/..//div[@role='combobox']
${common.combobox.text}    //label[text()='replaceText']/..//div[@role='combobox']/input
${common.combobox.add.new}    //div[@class='visible menu transition']/div[@data-additional='true' and @role='option']
${common.label.home.username}    //span[@class='user-display']
${common.table.td.name}    //a[text()='replaceText']    # Dynamic xpath for record names
${common.page.header}    //div[contains(@class,"ui header")]//span[text()='replaceText']
${common.popup.confirmation.box}    //div[contains(@class, 'modal transition visible active')]
${common.button.public.access}    //button[contains(@class,'positive toggle')]
${common.button.confirmation.box}    //button[text()='replaceText']    # Button in confirmation pop up (Delete or Cancel) for tableactions and rubbishbin
${common.button.rubbishbin}    //button/i[@class="trash alternate outline icon"]
${common.button.purgeselected}    //button[@class="ui negative button"]
${common.button.view.addnotes}    //button[@class='ui basic icon button custom-note-btn']
${common.button.create}    //button[text()='Create']
${common.button.save}    //button[text()='Save']
${common.icon.settings}    //div/i[@class='settings icon']
${common.icon.settings_logout}    //i[@class='power icon']
${common.icon.table.view}    //a[text()='replaceText']/../following-sibling::td[@class='right aligned collapsing options-buttons-container']//i[@class='unhide icon']    # Table - View record
${common.icon.table.edit}    //a[text()='replaceText']/../following-sibling::td[@class='right aligned collapsing options-buttons-container']//i[@class='edit icon']    # Table - Edit record
${common.icon.table.delete}    //a[text()='replaceText']/../following-sibling::td[@class='right aligned collapsing options-buttons-container']//i[@class='trash icon']    # Table - Delete record
${common.icon.table.call}    //a[text()='replaceText']/../following-sibling::td[@class='right aligned collapsing options-buttons-container']//i[@class='call icon']    # Table - calls record
${common.popup.confirmation_msg}    //div[contains(@class, 'modal transition visible active')]    # Xpath for confirmation msg
${common.text.rubbishbin_header}    //div[@class="ui header item mb5 light-black"]/span[text()='replaceText']    # Dynamic xpath for Page Header
${common.text.rubbishbin.module_name}    //div[@class='ui menu']/a[text()='replaceText']    # Dynamic xpath for modules in Rubbish Bin
${common.text.addnotes_value}    //a[text()='Notes']/../following-sibling::div//div[@class='note-content']//div/p[text()='replaceText']    # Text in Notes tab in view record page
${common.icon.module.name}    //div[@id="main-nav"]//span[text()='replaceText']
${common.button.privateaccess}    //button[@class='ui small fluid negative toggle button' and text()='Private']
${common.error.message}    //div[@class='ui error floating icon message']/div[@class='content']/p
${common.error.msg.inline}    //span[@class='inline-error-msg']
${common.error.msg.inline.item}    xpath=(//span[@class='inline-error-msg'])[replaceText]
${common.btn.delete}    //button[text()='Delete']
