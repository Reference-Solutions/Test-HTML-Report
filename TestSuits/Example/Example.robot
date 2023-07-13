*** Settings ***
Library  ..\\..\\TestKeywords\\Example\\MyLibrary.py

Test Setup      Connect					
Test Teardown   Disconnect

*** Test Cases ***
Example that calls a Python keyword
   ${output}=   execute_command   echo "Hi! This is example for Robot-Framework"
   Should be equal   ${output}    "Hi! This is example for Robot-Framework"
   

