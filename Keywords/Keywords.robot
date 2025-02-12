*** Settings ***
Library    FlaUILibrary

*** Keywords ***
BeforeTestSetup
    Launch Application    calc.exe
    Sleep    2s

AfterTestSetup
    FlaUILibrary.Click    //Button[@AutomationId="Close"]

Switch To Programmer Mode
    FlaUILibrary.Click    //Button[@Name="Open Navigation"]
    Sleep    1s
    FlaUILibrary.Click    //ListItem[@Name="Programmer Calculator"]

