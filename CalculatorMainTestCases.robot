*** Settings ***
Library         SeleniumLibrary
Library         random
Resource        resources/HomeResource.robot
Resource        resources/HomeEnergyResource.robot
Resource        resources/MainResource.robot
Resource        resources/SummaryResource.robot
Resource        resources/TransportationResource.robot
Resource        resources/WasteResource.robot
Test Setup      Access EPA website
Test Teardown   Close Browser

*** Test Cases ***
Validate Fuel Oil Dollars Calculation
    [Documentation]  This test case verifies that the calculation of CO2 emissions per year in lbs
    ...              for a random Fuel Oil average monthly bill value (fuel_oil_input) in dollars is correct,
    ...              considering a household of 1 person in a specific Zip Code
    [Tags]  Home Energy  Calculator
    ${fuel_oil_input}=  Evaluate    random.randint(1, 999)    random

    Access Home Energy Screen
    Select 'Fuel Oil' As Primary Heating Source
    Fill Fuel Oil Average Monthly Bill In 'Dollars' With ${fuel_oil_input}
    Verify That For Fuel Oil Utility Calculation Using '${fuel_oil_input}' In 'Dollars' Is Correct
    Verify That For Fuel Oil Summary Card Using '${fuel_oil_input}' In 'Dollars' Is Correct
  
Validate Transportation Emission And Planned Actions
    [Documentation]  This test case verifies that the calculation of CO2 emissions per year in lbs
    ...              for random values of average miles driven per year (avg_miles) and average gas mileage (avg_gas_mileage)
    ...              is correct, considering one vehicle, future planned maintenance and 
    ...              a household of 1 person in a specific Zip Code
    [Tags]  Transportation  Calculator
    ${avg_miles}=  Evaluate    random.randint(1, 15000)    random
    ${avg_gas_mileage}=  Evaluate    random.randint(1, 20)    random

    Access Transportation Screen
    Select Current Maintenance As 'Do Not Do'
    Fill Miles Driven With '${avg_miles}' And Gas Mileage With '${avg_gas_mileage}'
    Select Maintenance For Vehicle As 'Will Do'
    Verify Estimated Emissions Driving '${avg_miles}' Miles With Gas Mileage Of '${avg_gas_mileage}' Without Maintenance
    Verify Reduced Emissions By Doing Maintenance Driving '${avg_miles}' Miles With Gas Mileage Of '${avg_gas_mileage}'
    Verify Summary Card Driving '${avg_miles}' Miles With Gas Mileage Of '${avg_gas_mileage}' And Doing Maintenance

Validate Waste Current Emission Calculation
    [Documentation]  This test case verifies that the calculation of CO2 emissions per year in lbs
    ...              when already recycling newspaper is correct,
    ...              considering a household of 1 person in a specific Zip Code
    [Tags]  Waste  Calculator

    Access Waste Screen
    Select Newspaper Checkbox In Current Emissions
    Verify Estimated Current Saved Emissions After Selecting 'newspaper' Checkbox Is Correct
    Verify That Waste Summary Card Selecting Checkbox 'newspaper' Is Correct

Validate Waste Reduce Emission Calculation
    [Documentation]  This test case verifies that the calculation of CO2 emissions per year in lbs
    ...              when planning recycling aluminum is correct,
    ...              considering a household of 1 person in a specific Zip Code
    [Tags]  Waste  Calculator

    Access Waste Screen
    Select Aluminum Checkbox In Reduced Emissions
    Verify Estimated Reduced Emissions After Selecting 'aluminum' Checkbox Is Correct
    Verify That Waste Summary Card After Starting Recycling 'aluminum' Is Correct

Validate Start Over Link
    [Documentation]  This test case verifies that Start Over link works as expected 
    [Tags]  Start Over  Calculator
    
    Access Home Energy Screen
    Click Start Over Link
    Verify That Start Over Reset Calculator

Validate View Your Report For Waste Without Recycling
    [Documentation]  This test case verifies that the report is generated successfuly
    ...              for Waste calculation without any recycling
    [Tags]  Report  Calculator
    
    Access Waste Screen
    Click View Your Report Button
    Verify Report Totals For Waste Without Recycling