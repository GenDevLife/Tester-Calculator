*** Settings ***
Documentation    FlaUI in Robot Framework
Library    FlaUILibrary
Resource    ./resource/Hooks.resource

Test Setup    BeforeTestSetup
Test Teardown    AfterTestSetup

*** Test Cases ***
Test Calculator
    [Documentation]    This test case verifies entering value in calculator
    [Tags]    Demo
    Sleep    2.0s
    #Click    //Button[@Name="Eight"]
    Click    //Button[@AutomationId="num8Button"]
    Click    //Button[@AutomationId="num8Button"]
    #Click    //Button[@Name="Eight"]
    Click    //Button[@Name="Plus"]
    Click    //Button[@Name="Two"]
    Click    //Button[@Name="Equals"]
    
    ${actual_Result}    Get Name From Element    //Text[@AutomationId="CalculatorResults"]
    Log    ${actual_Result}
    Should Contain    ${actual_Result}    90
