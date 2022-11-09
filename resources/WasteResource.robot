*** Settings ***
Library     ../libraries/CarbonEmissionCalculator.py
Library     SeleniumLibrary
Resource    MainResource.robot
Variables   locators.yaml

*** Keywords ***
Waste Tab Should Be Visible
    Wait Until Element Is Visible  ${GENERAL.BTN_WASTE_TAB}  10

Click On Waste Tab
    Click Element    ${GENERAL.BTN_WASTE_TAB}

Waste Title Should Be Visible
    Wait Until Element Is Visible    ${GENERAL.TXT_TITLE_SCREEN}
    Element Should Contain    ${GENERAL.TXT_TITLE_SCREEN}    Waste

Access Waste Screen
    Insert Household Data And Get Started
    Waste Tab Should Be Visible
    Click On Waste Tab
    Waste Title Should Be Visible

Select Newspaper Checkbox In Current Emissions
    Select Checkbox    ${WASTE.CHECKBOX_CURRENT_EMISSION_NEWPAPER}

Select Aluminum Checkbox In Reduced Emissions
    Select Checkbox    ${WASTE.CHECKBOX_REDUCED_EMISSION_ALUMINUM}

Verify Estimated Current Saved Emissions After Selecting '${checkbox_type}' Checkbox Is Correct
    ${expected_saved}=  Get Saved Amount By Recycled Material  ${checkbox_type}
    ${expected_current}=  Build Expected Text For Waste Emissions After Recycling  ${checkbox_type}

    Element Text Should Be    ${WASTE.TXT_WASTE_SAVED}    ${expected_saved}
    Element Text Should Be    ${WASTE.TXT_WASTE_CURRENT}    ${expected_current}

Verify Estimated Reduced Emissions After Selecting '${checkbox_type}' Checkbox Is Correct
    ${expected_saved}=  Get Saved Amount By Recycled Material    ${checkbox_type}

    Element Text Should Be    ${WASTE.TXT_WASTE_WILL_SAVE}    ${expected_saved}

Verify That Waste Summary Card Selecting Checkbox '${checkbox_type}' Is Correct
    ${total_emission}=  Build Expected Text For Waste Emissions After Recycling    ${checkbox_type}

    Verify That Current Total Is Correct    ${total_emission}
    Verify That Total After Planned Actions Is Correct    ${total_emission}

Verify That Waste Summary Card After Starting Recycling '${checkbox_type}' Is Correct
    ${total_emission}=  Build Expected Text For Waste Emissions After Recycling    ${checkbox_type}
    ${us_average_emission}=  Build Expected Text For Us Average Recycled Waste Emissions

    Verify That Current Total Is Correct    ${us_average_emission}
    Verify That Total After Planned Actions Is Correct    ${total_emission}