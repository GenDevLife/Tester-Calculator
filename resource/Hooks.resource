*** Settings ***
Library    FlaUILibrary

*** Keywords ***
BeforeTestSetup
    Launch Application    calc.exe
    Sleep    2s

AfterTestSetup
    Click    //Button[@AutomationId="Close"]
