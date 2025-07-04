Toggle := false  ; Declare the Toggle variable globally

^!h::
{
    global Toggle  ; Declare the Toggle variable as global inside the hotkey block
    Toggle := !Toggle  ; Toggle the state between true and false
    if (Toggle)
    {
        SetTimer(HideWindow, 1000)  ; Start the timer to call HideWindow every second
    }
    else
    {
        SetTimer(HideWindow, "Off")  ; Stop the timer when toggled off
    }
}

HideWindow()
{
    if WinExist("ahk_class H-SMILE-FRAME"){
        WinHide("ahk_class H-SMILE-FRAME")  ; Hide the window every second
    }
}



^!u:: {  ; Ctrl+Alt+U
    if WinExist("ahk_class H-SMILE-FRAME"){
        WinShow("ahk_class H-SMILE-FRAME")
    }
}
