*** Settings ***
Library     ../libraries/CarbonEmissionCalculator.py
Library     SeleniumLibrary
Resource    MainResource.robot
Variables   locators.yaml

*** Keywords ***
Home Energy Tab Should Be Visible
    Wait Until Element Is Visible    ${GENERAL.BTN_HOME_ENERGY_TAB}    10

Home Energy Title Should Be Visible
    Wait Until Element Is Visible    ${GENERAL.TXT_TITLE_SCREEN}
    Element Should Contain    ${GENERAL.TXT_TITLE_SCREEN}    Carbon Footprint Calculator 

Access Home Energy Screen
    Insert Household Data And Get Started
    Home Energy Tab Should Be Visible
    Home Energy Title Should Be Visible

Select '${primary_source}' As Primary Heating Source
    Select From List By Label    ${HOME_ENERGY.PRIMARY_SOURCE_SELECTOR}    ${primary_source}

Fill Fuel Oil Average Monthly Bill In '${consumption_type_label}' With ${fuel_oil_input}
    Select From List By Label    ${HOME_ENERGY.UTILITY.FUEL_OIL_SELECTOR}    ${consumption_type_label}
    Fill input field ${HOME_ENERGY.UTILITY.FUEL_OIL_FIELD} with the value ${fuel_oil_input}

Verify That For Fuel Oil Utility Calculation Using '${fuel_oil_input}' In '${consumption_type}' Is Correct
    ${expected_emission}=  Build Expected Text For Fuel Oil Emissions    ${consumption_type}    ${fuel_oil_input}
    Element Text Should Be    ${HOME_ENERGY.UTILITY.FUEL_OIL_LBS_VALUE}    ${expected_emission}

Verify That For Fuel Oil Summary Card Using '${fuel_oil_input}' In '${consumption_type}' Is Correct
    ${total_emission}=  Build Expected Text For Fuel Oil Emissions    ${consumption_type}    ${fuel_oil_input}

    Verify That Current Total Is Correct    ${total_emission}
    Verify That Total After Planned Actions Is Correct    ${total_emission}