::vsc::Run 'code'
::notepad::Run 'notepad.exe'
::cmd::Run 'cmd.exe'

^!d:: {  ; Ctrl+Alt+D
    now := FormatTime(, "yyyy-MM-dd HH:mm:ss")
    SendText now
}

^!p:: {
    users := 0
    pricePerUser := 0.0

    if !InputBox(&users, "Enter User Count")
        return
    if !InputBox(&pricePerUser, "Price per User")
        return

    total := users * pricePerUser
    MsgBox "Total Monthly Revenue: $" total
}
