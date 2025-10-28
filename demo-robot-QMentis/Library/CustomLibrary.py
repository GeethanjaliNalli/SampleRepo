from robot.libraries.BuiltIn import BuiltIn
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.action_chains import ActionChains
import xlrd
import calendar
import time
import json
import datetime
from PIL import Image, ImageChops
from datetime import timedelta, date
from appdirs import user_data_dir
import string
import names
import random_names
import random as r
from tkinter import Tk, Canvas

class CustomLibrary(object):

    def __init__(self):
        self.firstname = "firstname"
        self.lastname = "lastname"

    @property
    def _sel_lib(self):
        return BuiltIn().get_library_instance('SeleniumLibrary')

    @property
    def _driver(self):
        return self._sel_lib.driver

    def open_chrome_browser(self, url):
        """Return the True if Chrome browser opened """
        selenium = BuiltIn().get_library_instance('SeleniumLibrary')
        print(self.get_chrome_profile_path());
        try:
            options = webdriver.ChromeOptions()
            options.add_argument("disable-extensions")
            options.add_experimental_option("excludeSwitches", ["enable-automation", "load-extension"])
            # options.add_argument("user-data-dir=C:\\Users\\sande\\AppData\\Local\\Google\\Chrome\\User Data") #Path to your chrome profile
            options.add_argument("user-data-dir=" + self.get_chrome_profile_path())  # Path to your chrome profile
            selenium.create_webdriver('Chrome', chrome_options=options)
            selenium.go_to(url)
        except Exception as e:
            raise e

    def javascript_click_by_xpath(self, xpath):
        element = self._driver.find_element_by_xpath(xpath)
        self._driver.execute_script("arguments[0].click();", element)

    def wait_until_time(self, arg):
        time.sleep(int(arg))

    def get_chrome_profile_path(self):
        chrome_profile_path = user_data_dir('Chrome', 'Google') + '\\User Data'
        # chrome_profile_path = "C:/Users/Srihari/AppData/Local/Google/Chrome/user data"
        return chrome_profile_path

    def get_ms_excel_row_values_into_dictionary_based_on_key(self, filepath, keyName, sheetName=None):
        """Returns the dictionary of values given row in the MS Excel file """
        workbook = xlrd.open_workbook(filepath)
        snames = workbook.sheet_names()
        dictVar = {}
        if sheetName == None:
            sheetName = snames[0]
        if self.validate_the_sheet_in_ms_excel_file(filepath, sheetName) == False:
            return dictVar
        worksheet = workbook.sheet_by_name(sheetName)
        noofrows = worksheet.nrows
        dictVar = {}
        headersList = worksheet.row_values(int(0))
        for rowNo in range(1, int(noofrows)):
            rowValues = worksheet.row_values(int(rowNo))
            if str(rowValues[0]) != str(keyName):
                continue
            for rowIndex in range(0, len(rowValues)):
                cell_data = rowValues[rowIndex]
                if (str(cell_data) == "" or str(cell_data) == None):
                    continue
                cell_data = self.get_unique_test_data(cell_data)
                print(cell_data)

                dictVar[str(headersList[rowIndex])] = str(cell_data)
        return dictVar

    def get_all_ms_excel_row_values_into_dictionary(self, filepath, sheetName=None):
        """Returns the dictionary of values all row in the MS Excel file """
        workbook = xlrd.open_workbook(filepath)
        snames = workbook.sheet_names()
        all_row_dict = {}
        if sheetName == None:
            sheetName = snames[0]
        if self.validate_the_sheet_in_ms_excel_file(filepath, sheetName) == False:
            return all_row_dict
        worksheet = workbook.sheet_by_name(sheetName)
        noofrows = worksheet.nrows
        headersList = worksheet.row_values(int(0))
        for rowNo in range(1, int(noofrows)):
            each_row_dict = {}
            rowValues = worksheet.row_values(int(rowNo))
            for rowIndex in range(0, len(rowValues)):
                cell_data = rowValues[rowIndex]
                if (str(cell_data) == "" or str(cell_data) == None):
                    continue
                cell_data = self.get_unique_test_data(cell_data)
                each_row_dict[str(headersList[rowIndex])] = str(cell_data)
            all_row_dict[str(rowValues[0])] = each_row_dict
        return all_row_dict

    def get_all_ms_excel_matching_row_values_into_dictionary_based_on_key(self, filepath, keyName, sheetName=None):
        """Returns the dictionary of matching row values from the MS Excel file based on key"""
        workbook = xlrd.open_workbook(filepath)
        snames = workbook.sheet_names()
        all_row_dict = {}
        if sheetName == None:
            sheetName = snames[0]
        if self.validate_the_sheet_in_ms_excel_file(filepath, sheetName) == False:
            return all_row_dict
        worksheet = workbook.sheet_by_name(sheetName)
        noofrows = worksheet.nrows
        headersList = worksheet.row_values(int(0))
        indexValue = 1
        for rowNo in range(1, int(noofrows)):
            rowValues = worksheet.row_values(int(rowNo))
            if str(rowValues[0]) != str(keyName):
                continue
            each_row_dict = {}
            for rowIndex in range(0, len(rowValues)):
                cell_data = rowValues[rowIndex]
                if (str(cell_data) == "" or str(cell_data) == None):
                    continue
                cell_data = self.get_unique_test_data(cell_data)
                each_row_dict[str(headersList[rowIndex])] = str(cell_data)
            all_row_dict[str(indexValue)] = each_row_dict
            indexValue += 1
        return all_row_dict

    def get_unique_test_data(self, testdata):
        """Returns the unique if data contains unique word """
        ts = calendar.timegm(time.gmtime())
        unique_string = str(ts)
        testdata = testdata.replace("UNIQUE", unique_string)
        testdata = testdata.replace("Unique", unique_string)
        testdata = testdata.replace("unique", unique_string)

        if testdata != None and "RANDOM_EMAILID" in testdata:
            email=self.get_rnd_email_address()
            testdata=testdata.replace("RANDOM_EMAILID",email)
            
        if testdata != None and "RANDOM_PHONENUMBER" in testdata:
            phno=self.get_rnd_phone_number()
            testdata=testdata.replace("RANDOM_PHONENUMBER",phno)

        if testdata != None and "RANDOM_FULL_NAME" in testdata:
            firstname=self.get_rnd_first_name('male')
            lastname =self.get_rnd_last_name()
            fullname = firstname+" " +lastname
            testdata=testdata.replace("RANDOM_FULL_NAME",fullname)
            
        if testdata != None and "RANDOM_FULL_NAME_FEMALE" in testdata:
            firstname=self.get_rnd_first_name('female')
            lastname =self.get_rnd_last_name()
            fullname = firstname+" " + lastname
            testdata=testdata.replace("RANDOM_FULL_NAME_FEMALE",fullname)        
            
        if testdata != None and "RANDOM_FIRST_NAME" in testdata:
            firstname=self.get_rnd_first_name()
            testdata=testdata.replace("RANDOM_FIRST_NAME",firstname)
        
        if testdata != None and "RANDOM_MIDDLE_NAME" in testdata:
            middlename=self.get_rnd_middle_name()
            testdata=testdata.replace("RANDOM_MIDDLE_NAME",middlename)
        if testdata != None and "RANDOM_LAST_NAME" in testdata:
            lastname=self.get_rnd_last_name()
            testdata=testdata.replace("RANDOM_LAST_NAME",lastname)

        if testdata != None and "RANDOM_FULL_NAME_FEMALE" in testdata:
            firstname=self.get_rnd_first_name('female')
            testdata=testdata.replace("RANDOM_FIRST_NAME_FEMALE",firstname)
            
        if testdata != None and "RANDOM_COMPANY" in testdata:
            companyname=self.get_rnd_company_name()
            testdata=testdata.replace("RANDOM_COMPANY",companyname)
        if testdata != None and "RANDOM_STREET" in testdata:
            address=self.get_rnd_short_address()
            testdata=testdata.replace("RANDOM_STREET",address)
        if testdata != None and "RANDOM_CITY" in testdata:
            county=self.get_rnd_county()
            testdata=testdata.replace("RANDOM_CITY",county)
        if testdata != None and "RANDOM_STATE" in testdata:
            state=self.get_rnd_state()
            testdata=testdata.replace("RANDOM_STATE",state)       
        return testdata

    def validate_the_sheet_in_ms_excel_file(self, filepath, sheetName):
        """Returns the True if the specified work sheets exist in the specifed MS Excel file else False"""
        workbook = xlrd.open_workbook(filepath)
        snames = workbook.sheet_names()
        sStatus = False
        if sheetName == None:
            return True
        else:
            for sname in snames:
                if sname.lower() == sheetName.lower():
                    wsname = sname
                    sStatus = True
                    break
            if sStatus == False:
                print("Error: The specified sheet: " + str(sheetName) + " doesn't exist in the specified file: " + str(
                    filepath))
        return sStatus

    def get_future_date(self, futuredate):
        end_date = date.today() + timedelta(days=futuredate)
        return end_date.strftime("%d")

    def compare_images(self, expected_file_path, actual_image_path, ):
        actual_image = Image.open(actual_image_path)
        expected_image = Image.open(expected_file_path)
        diff = ImageChops.difference(expected_image, actual_image)
        print(diff)
        if list(actual_image.getdata()) == list(expected_image.getdata()):
            print("Identical")
            return False
        else:
            print("Different")
            return True

    def wait_until_element_clickable(self, locator):
        """ An Expectation for checking that an element is either invisible or not present on the DOM."""
        if locator.startswith("//") or locator.startswith("(//"):
            WebDriverWait(self._driver, 60).until(EC.element_to_be_clickable((By.XPATH, locator)))
        else:
            WebDriverWait(self._driver, 60).until(EC.element_to_be_clickable((By.ID, locator)))

    def mouse_move_by_offset(self):
        """ Mouse move to 0,0 """
        action = ActionChains(self._driver)
        action.move_by_offset(0, 10)
        action.perform()
        time.sleep(2)

    def get_rnd_first_name(self,gender='female'):
        firstname = names.get_first_name(gender)
        firstname = random_names.First()
        self.firstname = firstname
        return firstname

    def get_rnd_last_name(self):
        lastname = names.get_last_name()
        self.lastname=lastname
        return lastname
    
    def get_rnd_middle_name(self):
        middlename = random_names.Middle()
        return middlename

    def get_rnd_company_name(self):
        companyname = random_names.Company()
        return companyname
    
    def get_rnd_full_name(self,gender='male'):
        fullname=names.get_full_name(gender)
        print (fullname)
        return fullname

    def get_rnd_phone_number(self):
        ph_no='9'
        for i in range(1, 10):
            ph_no+= str(r.randint(0, 9))
        print(ph_no)
        return ph_no

    def get_rnd_email_address(self):                
        #res = ''.join(r.choice(string.ascii_letters) for x in range(10))
        #res="AutoTest" + res + "@gmail.com"
        #res = names.get_full_name().strip()+"@gmail.com"
        res=self.firstname+self.lastname+"@gmail.com"
        res = ''.join(res.split())
        return res
    
    def get_rnd_short_address(self):
        address = random_names.ShortAddress()
        print (address)
        return address

    def get_rnd_county(self):
        county = random_names.County()
        return county
    
    def get_rnd_state(self):
        state = random_names.States()
        return state

    def get_current_dateandtime(self):
        current_time = datetime.datetime.now()
        return current_time
    
    def double_click(self, event):
        '''  set flag when there is a double click '''
        self.double_click_flag = True

    def get_random_string(self):
        N = 7
        res = ''.join(r.choices(string.ascii_letters, k=N))
        return res
    
    
    # def get_rnd_email_address(self):
    #    email = random_names.EmailAddress()
    #    return email
        

