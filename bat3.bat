@echo off
setlocal enableextensions enabledelayedexpansion

if "%~1"=="" (
    set "directory=%cd%"    
    echo Counting Files In Current Directory.
    echo.
) else (
    set "directory=%*"    
    echo Counting Files In All Directories.
    echo.
)

set "totalcount=0"
set "error="

for %%d in (%directory%) do (
    if not exist "%%~d" (
        echo DIRECTORY "%%~d" WAS NOT LOCATED!
        echo.
        echo Check For Errors And Try Again!
        set "error=1"
    ) else (
        pushd "%%~d" >nul
        if errorlevel 1 (
            echo "%%~d" IS NOT A DIRECTORY!
            echo.
            echo Check For Errors And Try Again!
            set "error=1"
        ) else (    
            set "count=0"     
   	    echo Contents Of Directory "%%~d":
	    echo.
            for /f "tokens=*" %%i in ('dir /a-d-h-r /b /s 2^>nul') do (
                set /a count+=1
                echo %%i
            )
	    echo.
            echo The directory "%%~d" contains !count! files.
            set /a totalcount+=count
            popd >nul
	    echo.
        )
    )
)

if not defined error (    
    echo ALL Directories Contain %totalcount% Files Total.
)

echo.
echo.
pause

endlocal

if defined error (exit /b 1) else (exit /b 0)
