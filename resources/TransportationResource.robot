*** Settings ***
Library     ../libraries/CarbonEmissionCalculator.py
Library     SeleniumLibrary
Resource    MainResource.robot
Variables   locators.yaml

*** Keywords ***
Transportation Tab Should Be Visible
    Wait Until Element Is Visible    ${GENERAL.BTN_TRANSPORTATION_TAB}    10

Click On Transportation Tab
    Click Element    ${GENERAL.BTN_TRANSPORTATION_TAB}

Transportation Title Should Be Visible
    Wait Until Element Is Visible    ${GENERAL.TXT_TITLE_SCREEN}
    Element Should Contain  ${GENERAL.TXT_TITLE_SCREEN}   Transportation

Access Transportation Screen
    Insert Household Data And Get Started
    Transportation Tab Should Be Visible
    Click On Transportation Tab
    Transportation Title Should Be Visible

Select Current Maintenance As '${label}'
    Select From List By Label   ${TRANSPORTATION.MAINTENANCE_CURRENT_SELECTOR}    ${label}

Fill Miles Driven With '${miles}' And Gas Mileage With '${gas_mileage}'
    Fill input field ${TRANSPORTATION.INPUT_VEHICLE_1_MILES} with the value ${miles}
    Fill input field ${TRANSPORTATION.INPUT_VEHICLE_1_GAS_MILEAGE} with the value ${gas_mileage}

Select Maintenance For Vehicle As '${label}'
    Select From List By Label    ${TRANSPORTATION.MAINTENANCE_REDUCE_SELECTOR}    ${label}

Verify Estimated Emissions Driving '${miles}' Miles With Gas Mileage Of '${gas_mileage}' Without Maintenance
    ${expected_emission}=  Build Expected Text For Total Emission For Vehicle Without Maintenance    ${miles}    ${gas_mileage}

    Element Text Should Be    ${TRANSPORTATION.TXT_VEHICLE_1_EMISSION}    ${expected_emission}

Verify Reduced Emissions By Doing Maintenance Driving '${miles}' Miles With Gas Mileage Of '${gas_mileage}'
    ${expected_emission_reduction}=  Build Expected Text For Saved Emissions With Maintenance    ${miles}    ${gas_mileage}
    ${expected_money_saved}=  Build Expected Text For Saved Money With Maintenance    ${miles}    ${gas_mileage}

    Element Text Should Be    ${TRANSPORTATION.TXT_SAVED_DOLLARS_MAINTENANCE}    ${expected_money_saved}
    Element Text Should Be    ${TRANSPORTATION.TXT_SAVED_EMISSION_MAINTENANCE}    ${expected_emission_reduction}
    

Verify Summary Card Driving '${miles}' Miles With Gas Mileage Of '${gas_mileage}' And Doing Maintenance
    ${total_emission}=  Build Expected Text For Total Emission For Vehicle Without Maintenance    ${miles}    ${gas_mileage}
    ${new_total_emission}=  Build Expected Text For Total Emission For Vehicle With Maintenance    ${miles}    ${gas_mileage}
    ${us_average_emission}=  Build Expected Text For Us Average For Vehicle

    Verify That Current Total Is Correct    ${total_emission}
    Verify That Total After Planned Actions Is Correct    ${new_total_emission}
    Verify That US Average Is Correct    ${us_average_emission}