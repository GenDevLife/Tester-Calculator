@echo off
rem ลบไฟล์ .html และ .xml ที่เป็น output ของ Robot Framework
del /q /f *.html
del /q /f *.xml
del /q /f *.jpg

echo Clean-up complete.
pause