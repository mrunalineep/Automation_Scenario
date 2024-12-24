*** Settings ***
Library    SeleniumLibrary
Resource    Resources/Hotel/search_keyword.robot
Library   Resources/CustomKeyword/FetchTestData.py

Test Setup      Open Air Application
Test Teardown   Close Browser

*** Variables ***
${search_td}=        ${CURDIR}${/}..${/}..${/}TestData${/}Hotel${/}search_testdata.xlsx


*** Test Cases ***
TC_01 Verify Domestic Hotel Search Results
    ${search_data}    fetch_testdata_by_id    ${search_td}    search_hotel_data    TC_01
    Select City Or Location Name    ${search_data}
    Select Check In Date And Check Out Date    ${search_data}
    ${room_count}    ${children_count}    Select Room And Guest Details    ${search_data}
    Click On Search Button
    Verify Hotel Search Results    ${room_count}    ${children_count}    ${search_data}


TC_02 Verify Hotel Search Results Are Displayed According To The Price Filter
    ${search_data}    fetch_testdata_by_id    ${search_td}    search_hotel_data    TC_02
    Select City Or Location Name    ${search_data}
    Select Check In Date And Check Out Date    ${search_data}
    ${room_count}    ${children_count}    Select Room And Guest Details    ${search_data}
    Click On Search Button
    Verify Hotel Search Results    ${room_count}    ${children_count}    ${search_data}
    Click On Price Filter
    Verify Hotel Search Results Are Displayed According To The Price Filter
