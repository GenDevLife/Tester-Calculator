*** Settings ***
Library    FlaUILibrary
Library    Process

Variables    ../Variables/Utility.yaml


*** Keywords ***
BeforeTestSetup
    # ตรวจสอบว่ามี Calculator เปิดอยู่หรือไม่
    ${is_running}    Run Keyword And Return Status    Is Process Running    Calculator.exe
    Run Keyword If    not ${is_running}    Launch Application    ${xpath_calculator}
    Sleep    2s

AfterTestSetup
    # ตรวจสอบว่าปุ่ม Close มีอยู่ก่อนปิดโปรแกรม
    ${is_visible}    Run Keyword And Return Status    FlaUILibrary.Element Should Exist    ${xpath_closecalc_button}    timeout=2s
    Run Keyword If    ${is_visible}    FlaUILibrary.Click    ${xpath_closecalc_button}

Verify Standard Mode
    [Documentation]    ตรวจสอบว่าเครื่องคิดเลขอยู่ในโหมด Standard
    ${is_standard}    Run Keyword And Return Status    FlaUILibrary.Element Should Exist    ${xpath_standard_menu}    timeout=2s
    Run Keyword If    not ${is_standard}    Switch To Standard Mode

Switch To Standard Mode
    FlaUILibrary.Click    ${xpath_navigation_button}
    Sleep    1s
    FlaUILibrary.Click    ${xpath_standard_menu}

Switch To Programmer Mode
    FlaUILibrary.Click    ${xpath_navigation_button}
    Sleep    1s
    FlaUILibrary.Click    ${xpath_programmer_menu}

Switch To Scientific Mode
    FlaUILibrary.Click    ${xpath_navigation_button}
    Sleep    1s
    FlaUILibrary.Click    ${xpath_scientific_menu}
