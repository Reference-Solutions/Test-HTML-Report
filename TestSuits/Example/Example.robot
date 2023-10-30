*** Settings ***
Library  ..\\..\\TestKeywords\\Example\\MyLibrary.py

Test Setup      Connect					
Test Teardown   Disconnect

Documentation       We are validating the HiL System Setup is up and running by executing the commands on a remote machine
...                 and getting its output.

Library    SSHLibrary
Library    OperatingSystem

*** Variables ***
${PRIVATE_KEY_PATH}   ~/.ssh/Certificates/keyForSDV
${HOST_ALIAS}         control_baseref_006
${RCAR}               192.168.0.11  # RCAR IP
${OWASYS}             192.168.0.6   # OWASYS IP
${VIP}                192.168.0.2   # VIP IP
${PING_COUNT}         5
${USERNAME}           root
${PASSWORD}           root

*** Test Cases ***
Validate Jump Server Connection and Run Ping Test
    [Documentation]  Test case to verify successful Jump Server login with Private Key.
    ${return_code}    ${output}    Run And Return Rc And Output    ssh -i ${PRIVATE_KEY_PATH} ${HOST_ALIAS} uname -a
    Log    Raspberry Pi Output: ${output}
	
    Run Keyword And Continue On Failure    Should Not Contain    ${output}    Connection timed out
    Run Keyword And Continue On Failure    Should Not Contain    ${output}    No route to host
	
    Run Ping Commands
    #SSH to RCAR
    #SSH to OWASYS

*** Keywords ***
Run Ping Commands
    Run Ping Test    ${RCAR}
    Run Ping Test    ${OWASYS}
    Run Ping Test    ${VIP}

Run Ping Test
    [Arguments]    ${ip}
    ${ping_return_code}    ${ping_output}    Run And Return Rc And Output    ssh -i ${PRIVATE_KEY_PATH} ${HOST_ALIAS} ping -c ${PING_COUNT} ${ip}
    Log    Ping Output for ${ip}: ${ping_output}
    Should Contain    ${ping_output}    ${PING_COUNT} packets transmitted
	
    Run Keyword And Continue On Failure    Should Not Contain    ${ping_output}    Destination Host Unreachable
    Run Keyword And Continue On Failure    Should Not Contain    ${ping_output}    100% packet loss

*** Test Cases ***
SSH to RCAR
    [Documentation]  Test case to verify successful login of RCAR Server.
    ${return_code}    ${output}    Run And Return Rc And Output    ssh -i ${PRIVATE_KEY_PATH} ${HOST_ALIAS} sshpass -p ${PASSWORD} ssh ${USERNAME}@${RCAR} uname -a
    Log    RCAR Server Output: ${output}
	
    Run Keyword And Continue On Failure    Should Not Contain    ${output}    Connection timed out
    Run Keyword And Continue On Failure    Should Not Contain    ${output}    No route to host
	
*** Test Cases ***
SSH to OWASYS
    [Documentation]  Test case to verify successful login of OWASYS Server.
    ${return_code}    ${output}    Run And Return Rc And Output    ssh -i ${PRIVATE_KEY_PATH} ${HOST_ALIAS} ssh ${USERNAME}@${OWASYS} uname -a
    Log    OWASYS Server Output: ${output}

    Run Keyword And Continue On Failure    Should Not Contain    ${output}    Connection timed out
    Run Keyword And Continue On Failure    Should Not Contain    ${output}    No route to host
	
*** Test Cases ***
SSH to VIP
    [Documentation]  Test case to verify successful login of VIP Server.
    ${return_code}    ${output}    Run And Return Rc And Output    ssh -i ${PRIVATE_KEY_PATH} ${HOST_ALIAS} sshpass -p ${PASSWORD} ssh ${USERNAME}@${VIP} "/proc/boot/uname -a"
    Log    VIP Server Output: ${output}
	
    Run Keyword And Continue On Failure    Should Not Contain    ${output}    Connection timed out
    Run Keyword And Continue On Failure    Should Not Contain    ${output}    No route to host
