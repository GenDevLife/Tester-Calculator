*** Settings ***
Documentation    ทดสอบเครื่องคิดเลขโดยเปิดโปรแกรมครั้งเดียวและปิดหลังทดสอบเสร็จ
Library          FlaUILibrary
Library          Process
Resource        ../Keywords/Keywords.robot

Suite Setup    BeforeTestSetup
Suite Teardown    AfterTestSetup

*** Test Cases ***
Case 1.1 ทดสอบเครื่องคิดเลขโหมด Standard
    [Documentation]    ตรวจสอบว่าสามารถเปลี่ยนไปยังโหมด Standard ได้
    [Tags]    เครื่องคิดเลข    โหมดมาตรฐาน
    Sleep    1.0s
    # Switch To Standard Mode
    Repeat Keyword    5 times    FlaUILibrary.Click    //Button[@AutomationId="num8Button"]
    FlaUILibrary.Click    //Button[@Name="Plus"]

    Repeat Keyword    5 times    FlaUILibrary.Click    //Button[@AutomationId="num2Button"]
    FlaUILibrary.Click    //Button[@Name="Equals"]

    # ดึงค่าจากเครื่องคิดเลข
    ${actual_Result}    Get Name From Element    //Text[@AutomationId="CalculatorResults"]

    # ลบเครื่องหมายจุลภาค (,) ออกจากตัวเลข และตัด "Display is "
    ${actual_Result_Cleaned}    Evaluate    "${actual_Result}".replace('Display is ', '').replace(',', '').strip()

    # ตั้งค่าตัวแปรให้เป็น Global เพื่อใช้ใน Case ถัดไป
    Set Global Variable    ${actual_Result_Cleaned}    ${actual_Result_Cleaned}

    # ตรวจสอบว่าได้ค่าถูกต้อง
    Should Contain    ${actual_Result_Cleaned}    111110

Case 1.2 คัดลอกผลลัพธ์และเปลี่ยนไปโหมด Programmer
    [Documentation]    ตรวจสอบว่าสามารถเปลี่ยนไปยังโหมด Programmer และวางค่าผลลัพธ์ได้
    [Tags]    เครื่องคิดเลข    โหมดโปรแกรมเมอร์
    Sleep    1.0s
    # เปิดเมนูเลือกโหมดเครื่องคิดเลข
    Switch To Programmer Mode

    # ถ้าตัวแปรเป็น None หรือไม่มีค่า ให้หยุดการทำงาน
    Run Keyword If    '${actual_Result_Cleaned}' == ''    Fail    "ตัวแปร actual_Result_Cleaned ไม่มีค่า"

    # แปลงตัวเลขจาก String เป็น List ของตัวเลขแต่ละหลัก
    ${number_list}    Evaluate    list(str(${actual_Result_Cleaned}))

    # ป้อนค่าตัวเลขแต่ละหลักลงไปในเครื่องคิดเลข
    FOR    ${char}    IN    @{number_list}
        FlaUILibrary.Click    //Button[@AutomationId="num${char}Button"]
    END

    # ดึงค่าที่ถูกแปลงเป็นเลขฐานอื่นๆ ในโหมด Programmer
    ${programmer_Result}    Get Name From Element    //Text[@AutomationId="CalculatorResults"]
    Log    ${programmer_Result}

    # ลบ "Display is " และเครื่องหมายจุลภาค (,) ออก
    ${programmer_Result_Cleaned}    Evaluate    "${programmer_Result}".replace('Display is ', '').replace(',', '').strip()

    # ตรวจสอบว่าเลขที่ป้อนเข้ามาถูกต้อง (ในโหมด Programmer)
    Should Contain    ${programmer_Result_Cleaned}    111110

Case 1.3 ตรวจสอบค่าที่แปลงเป็นเลขฐานต่างๆ ในโหมด Programmer
    [Documentation]    ตรวจสอบว่าสามารถคลิกเพื่อดูค่าของเลขฐาน HEX, DEC, OCT, BIN ได้
    [Tags]    เครื่องคิดเลข    โหมดโปรแกรมเมอร์    เลขฐาน
    Sleep    2.0s

    # คลิกที่ปุ่ม HEX และดึงค่า
    FlaUILibrary.Click    //RadioButton[@AutomationId="hexButton"]
    Sleep    1.5s
    ${HEX_Result}    Get Name From Element    //Text[@AutomationId="CalculatorResults"]
    
    # คลิกที่ปุ่ม DEC และดึงค่า
    FlaUILibrary.Click    //RadioButton[@AutomationId="decimalButton"]
    Sleep    1.5s
    ${DEC_Result}    Get Name From Element    //Text[@AutomationId="CalculatorResults"]

    # คลิกที่ปุ่ม OCT และดึงค่า
    FlaUILibrary.Click    //RadioButton[@AutomationId="octolButton"]
    Sleep    1.5s
    ${OCT_Result}    Get Name From Element    //Text[@AutomationId="CalculatorResults"]

    # คลิกที่ปุ่ม BIN และดึงค่า
    FlaUILibrary.Click    //RadioButton[@AutomationId="binaryButton"]
    Sleep    1.5s
    ${BIN_Result}    Get Name From Element    //Text[@AutomationId="CalculatorResults"]

    # ลบช่องว่างและจุลภาคออกจากค่าที่ได้
    ${HEX_Cleaned}    Evaluate    "${HEX_Result}".replace('Display is ', '').replace(' ', '').replace(',', '').strip()
    ${DEC_Cleaned}    Evaluate    "${DEC_Result}".replace('Display is ', '').replace(',', '').strip()
    ${OCT_Cleaned}    Evaluate    "${OCT_Result}".replace('Display is ', '').replace(' ', '').replace(',', '').strip()
    ${BIN_Cleaned}    Evaluate    "${BIN_Result}".replace('Display is ', '').replace(' ', '').replace(',', '').strip()

    # ตรวจสอบว่าค่าที่ได้ถูกต้อง
    Should Be Equal As Strings    ${HEX_Cleaned}    1B206
    Should Be Equal As Strings    ${DEC_Cleaned}    111110
    Should Be Equal As Strings    ${OCT_Cleaned}    331006
    Should Be Equal As Strings    ${BIN_Cleaned}    00011011001000000110
    Sleep    1.0s
    FlaUILibrary.Click    //Button[@AutomationId="clearEntryButton"]


Case 1.4 ทดสอบการปรับย่อ-หน้าจอ
    [Documentation]    ตรวจสอบว่าสามารถปรับหน้าจอได้ถูกต้อง
    [Tags]    หน้าจอ    เครื่องคิดเลข
    Sleep    1.0s
    FlaUILibrary.Click    //Button[@Name="Maximize Calculator"]
    Sleep    1.0s
    FlaUILibrary.Click    //Button[@Name="Restore Calculator"]

Case 1.5 ทดสอบการใช้หน่วยความจำ (Memory Functions)
    [Documentation]    ตรวจสอบว่าฟังก์ชัน Memory สามารถทำงานได้
    [Tags]    เครื่องคิดเลข    หน่วยความจำ
    Sleep    1.0s

    # กดเลข 5 และบันทึกค่าลงหน่วยความจำ
    FlaUILibrary.Click    //Button[@AutomationId="num5Button"]
    FlaUILibrary.Click    //Button[@Name="MS"]
    Sleep    1.0s

    # กด MR เพื่อนำค่าที่บันทึกไว้กลับมา
    FlaUILibrary.Click    //Button[@Name="MR"]
    ${memory_Result}    Get Name From Element    //Text[@AutomationId="CalculatorResults"]
    Should Be Equal As Strings    ${memory_Result}    "5"

    # กด MC เพื่อล้างค่าหน่วยความจำ
    FlaUILibrary.Click    //Button[@Name="MC"]
    Sleep    1.0s

    # ตรวจสอบว่า Memory ถูกล้างแล้ว
    FlaUILibrary.Click    //Button[@Name="MR"]
    ${memory_Clear_Result}    Get Name From Element    //Text[@AutomationId="CalculatorResults"]
    Should Be Equal As Strings    ${memory_Clear_Result}    "0"


Case 1.6 ทดสอบการคำนวณเปอร์เซ็นต์ (%)
    [Documentation]    ตรวจสอบว่าสามารถคำนวณเปอร์เซ็นต์ได้ถูกต้อง
    [Tags]    เครื่องคิดเลข    เปอร์เซ็นต์
    Sleep    1.0s

    # ป้อน 50 x 25% และตรวจสอบผลลัพธ์
    FlaUILibrary.Click    //Button[@AutomationId="num5Button"]
    FlaUILibrary.Click    //Button[@AutomationId="num0Button"]
    FlaUILibrary.Click    //Button[@Name="Multiply"]
    FlaUILibrary.Click    //Button[@AutomationId="num2Button"]
    FlaUILibrary.Click    //Button[@AutomationId="num5Button"]
    FlaUILibrary.Click    //Button[@AutomationId="percentButton"]
    FlaUILibrary.Click    //Button[@Name="Equals"]

    ${percent_Result}    Get Name From Element    //Text[@AutomationId="CalculatorResults"]
    ${percent_Cleaned}    Evaluate    "${percent_Result}".replace('Display is ', '').replace(',', '').strip()
    
    Should Be Equal As Strings    ${percent_Cleaned}    "12.5"


Case 1.7 ทดสอบ Factorial และ Square Root
    [Documentation]    ตรวจสอบว่าสามารถคำนวณ Factorial และ Square Root ได้
    [Tags]    เครื่องคิดเลข    ค่าทางคณิตศาสตร์
    Sleep    1.0s

    # ทดสอบ Factorial (5!)
    FlaUILibrary.Click    //Button[@AutomationId="num5Button"]
    FlaUILibrary.Click    //Button[@AutomationId="factorialButton"]
    ${factorial_Result}    Get Name From Element    //Text[@AutomationId="CalculatorResults"]
    ${factorial_Cleaned}    Evaluate    "${factorial_Result}".replace('Display is ', '').replace(',', '').strip()

    Should Be Equal As Strings    ${factorial_Cleaned}    "120"

    # ทดสอบ Square Root (√49)
    FlaUILibrary.Click    //Button[@AutomationId="num4Button"]
    FlaUILibrary.Click    //Button[@AutomationId="num9Button"]
    FlaUILibrary.Click    //Button[@AutomationId="squareRootButton"]
    ${sqrt_Result}    Get Name From Element    //Text[@AutomationId="CalculatorResults"]
    ${sqrt_Cleaned}    Evaluate    "${sqrt_Result}".replace('Display is ', '').replace(',', '').strip()

    Should Be Equal As Strings    ${sqrt_Cleaned}    "7"


Case 1.8 ทดสอบ Bitwise Operations (AND, OR, XOR, NOT)
    [Documentation]    ตรวจสอบว่าสามารถใช้ฟังก์ชัน Bitwise ได้ในโหมด Programmer
    [Tags]    เครื่องคิดเลข    โหมดโปรแกรมเมอร์    Bitwise
    Sleep    1.0s

    Switch To Programmer Mode

    # 1100 AND 1010 = 1000
    FlaUILibrary.Click    //Button[@AutomationId="num1Button"]
    FlaUILibrary.Click    //Button[@AutomationId="num1Button"]
    FlaUILibrary.Click    //Button[@AutomationId="num0Button"]
    FlaUILibrary.Click    //Button[@AutomationId="num0Button"]
    FlaUILibrary.Click    //Button[@Name="AND"]
    FlaUILibrary.Click    //Button[@AutomationId="num1Button"]
    FlaUILibrary.Click    //Button[@AutomationId="num0Button"]
    FlaUILibrary.Click    //Button[@AutomationId="num1Button"]
    FlaUILibrary.Click    //Button[@AutomationId="num0Button"]
    FlaUILibrary.Click    //Button[@Name="Equals"]

    ${bitwise_Result}    Get Name From Element    //Text[@AutomationId="CalculatorResults"]
    ${bitwise_Cleaned}    Evaluate    "${bitwise_Result}".replace('Display is ', '').replace(',', '').strip()

    Should Be Equal As Strings    ${bitwise_Cleaned}    "1000"


Case 1.9 ปิดโปรแกรมเครื่องคิดเลข
    [Documentation]    ตรวจสอบว่าสามารถปิดโปรแกรมได้ถูกต้อง
    [Tags]    เครื่องคิดเลข    ปิดโปรแกรม
    Sleep    1.0s

    # ปิดโปรแกรมเครื่องคิดเลขโดยคลิกปุ่มปิด
    FlaUILibrary.Click    //Button[@AutomationId="Close"]
    Sleep    2.0s
