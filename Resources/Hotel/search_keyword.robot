*** Settings ***
Library    SeleniumLibrary
Library    String
Variables  ../../Environment/environments.py
Variables    PageObjects/Hotel/search_locators.py
Variables    Resources/CustomKeyword/FetchTestData.py

*** Keywords ***

Open Air Application
    Open Browser     ${air_application_url}    ${browser}
    Set Window Size    ${window_height}    ${window_width}


Select City Or Location Name
    [Arguments]     ${search_data}
    ${my_dict}=         Create Dictionary   &{search_data}
    Sleep    3s
    Click Element    ${cross_button}
    Click Element    ${hotel_link}
    Wait Until Element Is Visible    ${max_room_text}
    Click Element    ${city_field}
    Wait Until Element Is Visible    ${input_city_field}
    Input Text    ${input_city_field}    ${my_dict.City}
    Wait Until Element Is Visible    ${city}
    Click Element    ${city}

Select Check In Date And Check Out Date
    [Arguments]     ${search_data}
    ${my_dict}=         Create Dictionary   &{search_data}
    ${check_in_date_replaced}    Replace String    ${check_in_date}    Month    ${my_dict.Month}
    ${check_in}    Convert To String    ${my_dict.CheckInDate}
    ${check_in_date}    Replace String    ${check_in_date_replaced}    Date    ${check_in}
    Click Element    ${check_in_date}
    ${check_out_date_replaced}    Replace String    ${check_out_date}    Month    ${my_dict.Month}
    ${check_out}    Convert To String    ${my_dict.CheckOutDate}
    ${check_out_date}    Replace String    ${check_out_date_replaced}    Date    ${check_out}
    Click Element    ${check_out_date}

Select Room And Guest Details
    [Arguments]     ${search_data}
    ${my_dict}=         Create Dictionary   &{search_data}
    Click Element    ${room_field}
    ${room}    Convert To String    ${my_dict.Room}
    ${input_room_count}    Replace String    ${input_room_field}    RoomCount    ${room}
    Click Element    ${input_room_count}
    ${room_count}    Get Text    ${room_field}
    Click Element    ${children_field}
    ${no_of_children}    Convert To String    ${my_dict.NoOfChildren}
    ${input_children_count}    Replace String    ${input_children_field}    ChildrenCount    ${no_of_children}
    Click Element    ${input_children_count}
    ${children_count}    Get Text    ${children_field}
    Click Element    ${child_age_field}
    ${age_of_child}    Convert To String    ${my_dict.AgeOfChild}
    ${input_child_age_count}    Replace String    ${input_child_age_field}    ChildAge    ${age_of_child}
    ${child_age}    Get Text    ${child_age_field}
    Click Element    ${input_child_age_count}
    Click Element    ${apply_button}
    RETURN    ${room_count}    ${children_count}

Click On Search Button
    Wait Until Element Is Visible    ${search_button}
    Click Element    ${search_button}

Verify Hotel Search Results
    [Arguments]     ${room_count}    ${children_count}    ${search_data}
    ${my_dict}=         Create Dictionary   &{search_data}
    Sleep    3s
    Page Should Contain    Showing Properties

    ${city_name}    Get Value    ${city_name}
    Should Be Equal As Strings    ${city_name}    ${my_dict.City}

    ${check_in_date}    Get Value    ${check_in_date_on_search_result}
    ${check_in_date_split}    Split String    ${check_in_date}    ${space}
    ${check_in_date}    Set Variable    ${check_in_date_split[1]}
    Should Be Equal As Integers    ${check_in_date}    ${my_dict.CheckInDate}

    ${check_out_date}    Get Value    ${check_out_date_on_search_result}
    ${check_out_date_split}    Split String    ${check_out_date}    ${space}
    ${check_out_date}    Set Variable    ${check_out_date_split[1]}
    Should Be Equal As Integers    ${check_out_date}    ${my_dict.CheckOutDate}

    ${guest_details}    Get Value    ${guest_details}
    ${guest_details_split}    Split String    ${guest_details}    ,
    ${room_count}    Set Variable    ${guest_details_split[0]}
    ${room_count}    Split String    ${room_count}    ${space}
    ${room_count}    Set Variable    ${room_count[0]}
    Should Be Equal As Integers    ${room_count}    ${my_dict.Room}

    ${adult_count}    Set Variable    ${guest_details_split[1]}
    ${adult_count}    Split String    ${adult_count}    ${space}
    ${adult_count}    Set Variable    ${adult_count[1]}
    Should Be Equal As Integers    ${adult_count}    ${my_dict.NoOfAdult}

    ${child_count}    Set Variable    ${guest_details_split[2]}
    ${child_count}    Split String    ${child_count}    ${space}
    ${child_count}    Set Variable    ${child_count[1]}
    Should Be Equal As Integers   ${child_count}    ${children_count}

    Page Should Contain    ${my_dict.City}


Click On Price Filter
    Click Element    ${checkbox_price_range}


Verify Hotel Search Results Are Displayed According To The Price Filter
    ${price_min}    Set Variable    0
    ${price_max}    Set Variable    2000
    ${out_of_range_flag}    Set Variable    False
    Sleep    3s
    ${all_prices}    Get Webelements    ${prices}
    FOR    ${price_element}    IN    @{all_prices}
        ${price_text}    Get Text    ${price_element}
        ${price_text}    Replace String    ${price_text}    ₹    ${EMPTY}
        ${price_text}    Replace String    ${price_text}    ,    ${EMPTY}
        ${price}    Convert To Number    ${price_text}
        Log    Price: ${price}
        # Check if the price is within the range
        Run Keyword If    not ${price_min} <= ${price} <= ${price_max}
        ...    Run Keywords
        ...    Log    Price out of range: ${price}
        ...    AND    Set Variable    ${out_of_range_flag}    True
    END

    Run Keyword If    ${out_of_range_flag}
    ...    Log    Out-of-range prices: ${out_of_range_flag}
    ...    Fail    Prices are not within the range 0-2000 rupees.
