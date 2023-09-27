*** Settings ***
Library  ..\\..\\TestKeywords\\Example\\MyLibrary.py

Test Setup      Connect					
Test Teardown   Disconnect

*** Test Cases ***
Example that calls a Python keyword
   [Tags]    regression    example
   ${output}=   execute_command   echo "Hi! This is example for Robot-Framework"
   Should be equal   ${output}    "Hi! This is example for Robot-Framework"

Another Example with Different Tags
   [Tags]    sanity    example
   ${output}=    execute_command    echo "This is a sanity test"
   Should be equal    ${output}    "This is a sanity test"
   

