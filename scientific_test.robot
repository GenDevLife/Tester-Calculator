*** Settings ***
Documentation    Scientific Mode Test Cases
Library    FlaUILibrary
Resource    ./resource/Hooks.resource
Resource    ./resource/Utility.resource

Test Setup    BeforeTestSetup
Test Teardown    AfterTestSetup

*** Test Cases ***
Sin Test
    Switch To Scientific Mode
    Click    //Button[@Name="Sine"]
    Click    //Button[@AutomationId="num3Button"]
    Click    //Button[@AutomationId="equalButton"]
    ${result}    Get Name From Element    //Text[@AutomationId="CalculatorResults"]
    Log    ${result}

Log Test
    Switch To Scientific Mode
    Click    //Button[@Name="Log"]
    Click    //Button[@AutomationId="num1Button"]
    Click    //Button[@AutomationId="num0Button"]
    Click    //Button[@AutomationId="equalButton"]
    ${result}    Get Name From Element    //Text[@AutomationId="CalculatorResults"]
    Should Contain    ${result}    1