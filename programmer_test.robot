*** Settings ***
Documentation    Programmer Mode Test Cases
Library    FlaUILibrary
Resource    ./resource/Hooks.resource
Resource    ./resource/Utility.resource

Test Setup    BeforeTestSetup
Test Teardown    AfterTestSetup

*** Test Cases ***
Bitwise AND Test
    Switch To Programmer Mode
    Click    //Button[@AutomationId="num8Button"]
    Click    //Button[@Name="Bitwise AND"]
    Click    //Button[@AutomationId="num3Button"]
    Click    //Button[@AutomationId="equalButton"]
    ${result}    Get Name From Element    //Text[@AutomationId="CalculatorResults"]
    Log    ${result}

Binary Conversion Test
    Switch To Programmer Mode
    Click    //Button[@AutomationId="num5Button"]
    Click    //Button[@Name="Convert to Binary"]
    ${result}    Get Name From Element    //Text[@AutomationId="CalculatorResults"]
    Should Contain    ${result}    101
