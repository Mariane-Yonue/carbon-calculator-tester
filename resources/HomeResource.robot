*** Settings ***
Library     SeleniumLibrary
Variables   locators.yaml

*** Keywords ***
Home Screen Button Should Be Visible
    Wait Until Element Is Visible    ${HOME.BTN_GET_STARTED}

Home Screen Form State Should Be Empty
    Element Text Should Be    ${HOME.INPUT_NUM_HOUSEHOLD}    ${EMPTY}
    Element Text Should Be    ${HOME.INPUT_ZIP_CODE}    ${EMPTY}
