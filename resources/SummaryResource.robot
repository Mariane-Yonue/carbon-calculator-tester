*** Settings ***
Library     ../libraries/CarbonEmissionCalculator.py
Library     SeleniumLibrary
Resource    HomeResource.robot
Resource    MainResource.robot
Variables   locators.yaml

*** Keywords ***
Click Start Over Link
    Wait Until Element Is Visible    ${SUMMARY.LINK_STAR_OVER}    10
    Click Link    ${SUMMARY.LINK_STAR_OVER}
    Handle Alert

Verify That Start Over Reset Calculator
    Home Screen Button Should Be Visible
    Home Screen Form State Should Be Empty

Click View Your Report Button
    Wait Until Element Is Visible    ${SUMMARY.BTN_VIEW_REPORT}
    Click Button    ${SUMMARY.BTN_VIEW_REPORT}

Verify Report Totals For Waste Without Recycling
    ${us_average_emission}=  Build Expected Text For Us Average Recycled Waste Emissions

    Element Text Should Be    ${REPORT.TXT_CURRENT_TOTAL}    ${us_average_emission}
    Element Text Should Be    ${REPORT.TXT_NEW_TOTAL}    ${us_average_emission}
    Element Text Should Be    ${REPORT.TXT_US_AVERAGE}    ${us_average_emission}