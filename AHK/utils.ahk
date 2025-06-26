::vsc::Run, code
::notepad::Run, notepad.exe
::cmd::Run, cmd.exe

^!t::  ; Ctrl+Alt+T
FormatTime, now,, yyyy-MM-dd HH:mm:ss
SendInput %now%
return

^!p::
InputBox, users, Enter User Count
InputBox, pricePerUser, Price per User
total := users * pricePerUser
MsgBox, % "Total Monthly Revenue: $" . total
return
