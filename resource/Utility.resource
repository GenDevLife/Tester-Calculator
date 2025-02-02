*** Settings ***
Library    FlaUILibrary

*** Keywords ***
Switch To Standard Mode
    Click    //Button[@Name="Open Navigation"]
    Sleep    1s
    Click    //ListItem[@Name="Standard"]

Switch To Scientific Mode
    Click    //Button[@Name="Open Navigation"]
    Sleep    1s
    Click    //ListItem[@AutomationId="Scientific"]

Switch To Programmer Mode
    Click    //Button[@Name="Open Navigation"]
    Sleep    1s
    Click    //ListItem[@Name="Programmer"]
