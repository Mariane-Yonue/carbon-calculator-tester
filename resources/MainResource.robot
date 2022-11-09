*** Settings ***
Library    SeleniumLibrary
Variables  locators.yaml

*** Variable ***
${BROWSER}    chrome
${URL}    https://www3.epa.gov/carbon-footprint-calculator/

*** Keywords ***
## Utils

Access EPA website
    Open Browser  ${URL}  ${BROWSER}
    Wait Until Element Is Visible  ${HOME.TXT_TITLE_SCREEN}
    Title Should Be  Carbon Footprint Calculator | Climate Change | US EPA

Fill input field ${field_name} with the value ${input}
    Input Text  ${field_name}  ${input}

## Household
Fill Number Of People In Household Field With Value
    [Arguments]  ${num_household}
    Fill input field ${HOME.INPUT_NUM_HOUSEHOLD} with the value ${num_household}

Fill ZIP Code Field With Value
    [Arguments]  ${zipcode}
    Fill input field ${HOME.INPUT_ZIP_CODE} with the value ${zipcode}

Click On Get Started Button
    Click Button    ${HOME.BTN_GET_STARTED}

Insert Household Data And Get Started
    Fill Number Of People In Household Field With Value  1
    Fill ZIP Code Field With Value  12345
    Click On Get Started Button

## Summary
Verify That Current Total Is Correct
    [Arguments]  ${expected}
    Element Text Should Be    ${SUMMARY.CURRENT_TOTAL}    ${expected}

Verify That Total After Planned Actions Is Correct
    [Arguments]  ${expected}
    Element Text Should Be    ${SUMMARY.TOTAL_AFTER_ACTIONS}    ${expected}

Verify That US Average Is Correct
    [Arguments]  ${expected}
    Element Text Should Be    ${SUMMARY.AVERAGE}    ${expected}