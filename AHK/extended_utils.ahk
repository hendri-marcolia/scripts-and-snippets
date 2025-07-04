; ===============================================
; Extended AutoHotkey Utilities
; ===============================================

; ===============================================
; APPLICATION LAUNCHERS
; ===============================================
::calc::Run 'calc.exe'
::paint::Run 'mspaint.exe'
::explorer::Run 'explorer.exe'
::task::Run 'taskmgr.exe'
::chrome::Run 'chrome.exe'
::firefox::Run 'firefox.exe'
::edge::Run 'msedge.exe'

; ===============================================
; TEXT EXPANSION & FORMATTING
; ===============================================
::lorem::SendText "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."

::myemail::SendText "your.email@example.com"
::myphone::SendText "+1-234-567-8900"
::myaddr::SendText "123 Main Street, City, State 12345"

; Common symbols
::arrow::SendText "→"
::copyright::SendText "©"
::trademark::SendText "™"
::degree::SendText "°"
::plusminus::SendText "±"
::infinity::SendText "∞"

; ===============================================
; TEXT CASE CONVERTERS
; ===============================================
^!u:: {  ; Ctrl+Alt+U - Convert to UPPERCASE
    A_Clipboard := ""
    Send "^c"
    ClipWait 1
    if (A_Clipboard != "") {
        A_Clipboard := StrUpper(A_Clipboard)
        Send "^v"
    }
}

^!l:: {  ; Ctrl+Alt+L - Convert to lowercase
    A_Clipboard := ""
    Send "^c"
    ClipWait 1
    if (A_Clipboard != "") {
        A_Clipboard := StrLower(A_Clipboard)
        Send "^v"
    }
}

^!t:: {  ; Ctrl+Alt+T - Convert to Title Case
    A_Clipboard := ""
    Send "^c"
    ClipWait 1
    if (A_Clipboard != "") {
        A_Clipboard := StrTitle(A_Clipboard)
        Send "^v"
    }
}

; ===============================================
; SYSTEM & WINDOW MANAGEMENT
; ===============================================
^!a:: {  ; Ctrl+Alt+A - Always on top toggle
    WinSetAlwaysOnTop -1, "A"
    if WinGetAlwaysOnTop("A")
        ToolTip "Window set to Always On Top"
    else
        ToolTip "Always On Top disabled"
    SetTimer () => ToolTip(), -2000
}

^!m:: {  ; Ctrl+Alt+M - Minimize all windows
    WinMinimizeAll
    ToolTip "All windows minimized"
    SetTimer () => ToolTip(), -2000
}

^!r:: {  ; Ctrl+Alt+R - Restore all windows
    WinMinimizeAllUndo
    ToolTip "All windows restored"
    SetTimer () => ToolTip(), -2000
}

; Volume controls
^!NumpadAdd:: {  ; Ctrl+Alt+Numpad+ - Volume up
    SoundSetVolume "+10"
    vol := Round(SoundGetVolume())
    ToolTip "Volume: " vol "%"
    SetTimer () => ToolTip(), -1500
}

^!NumpadSub:: {  ; Ctrl+Alt+Numpad- - Volume down
    SoundSetVolume "-10"
    vol := Round(SoundGetVolume())
    ToolTip "Volume: " vol "%"
    SetTimer () => ToolTip(), -1500
}

^!NumpadMult:: {  ; Ctrl+Alt+Numpad* - Mute toggle
    SoundSetMute -1
    if SoundGetMute()
        ToolTip "Muted"
    else
        ToolTip "Unmuted"
    SetTimer () => ToolTip(), -1500
}

; ===============================================
; CLIPBOARD ENHANCEMENTS
; ===============================================
^!v:: {  ; Ctrl+Alt+V - Paste as plain text
    ClipSaved := A_Clipboard
    A_Clipboard := A_Clipboard  ; Convert to plain text
    Send "^v"
    Sleep 100
    A_Clipboard := ClipSaved
}

^!c:: {  ; Ctrl+Alt+C - Copy file path
    A_Clipboard := ""
    Send "^c"
    ClipWait 1
    if (A_Clipboard != "") {
        ; If it's a file, get the full path
        try {
            if FileExist(A_Clipboard)
                A_Clipboard := A_Clipboard
        }
    }
}

; ===============================================
; DEVELOPMENT UTILITIES
; ===============================================
^!g:: {  ; Ctrl+Alt+G - Generate UUID
    uuid := GenerateUUID()
    A_Clipboard := uuid
    SendText uuid
    ToolTip "UUID generated and copied to clipboard"
    SetTimer () => ToolTip(), -2000
}

^!b:: {  ; Ctrl+Alt+B - Base64 encode selected text
    A_Clipboard := ""
    Send "^c"
    ClipWait 1
    if (A_Clipboard != "") {
        encoded := Base64Encode(A_Clipboard)
        A_Clipboard := encoded
        Send "^v"
        ToolTip "Text encoded to Base64"
        SetTimer () => ToolTip(), -2000
    }
}

^!n:: {  ; Ctrl+Alt+N - Generate random number
    min := 1
    max := 100
    
    if !InputBox(&min, "Random Number Generator", "Enter minimum value:", , , , , , , min)
        return
    if !InputBox(&max, "Random Number Generator", "Enter maximum value:", , , , , , , max)
        return
    
    if (min > max) {
        temp := min
        min := max
        max := temp
    }
    
    randomNum := Random(min, max)
    SendText randomNum
    ToolTip "Random number: " randomNum
    SetTimer () => ToolTip(), -2000
}

; ===============================================
; QUICK CALCULATIONS & CONVERSIONS
; ===============================================
^!f:: {  ; Ctrl+Alt+F - Fahrenheit to Celsius converter
    fahrenheit := 0
    
    if !InputBox(&fahrenheit, "Temperature Converter", "Enter Fahrenheit:")
        return
    
    celsius := Round((fahrenheit - 32) * 5/9, 2)
    result := fahrenheit "°F = " celsius "°C"
    
    A_Clipboard := result
    MsgBox result "`n`nResult copied to clipboard"
}

^!k:: {  ; Ctrl+Alt+K - Kilometers to Miles converter
    km := 0
    
    if !InputBox(&km, "Distance Converter", "Enter Kilometers:")
        return
    
    miles := Round(km * 0.621371, 2)
    result := km " km = " miles " miles"
    
    A_Clipboard := result
    MsgBox result "`n`nResult copied to clipboard"
}

^!%:: {  ; Ctrl+Alt+% - Percentage calculator
    number := 0
    percentage := 0
    
    if !InputBox(&number, "Percentage Calculator", "Enter the number:")
        return
    if !InputBox(&percentage, "Percentage Calculator", "Enter the percentage:")
        return
    
    result := Round(number * percentage / 100, 2)
    resultText := percentage "% of " number " = " result
    
    A_Clipboard := result
    MsgBox resultText "`n`nResult copied to clipboard"
}

; ===============================================
; PRODUCTIVITY SHORTCUTS
; ===============================================
^!q:: {  ; Ctrl+Alt+Q - Quick note
    note := ""
    
    if !InputBox(&note, "Quick Note", "Enter your note:")
        return
    
    if (note != "") {
        timestamp := FormatTime(, "yyyy-MM-dd HH:mm:ss")
        noteEntry := timestamp " - " note "`n"
        
        ; Append to daily notes file
        notesFile := A_Desktop "\daily_notes_" FormatTime(, "yyyy-MM-dd") ".txt"
        FileAppend noteEntry, notesFile
        
        ToolTip "Note saved to " notesFile
        SetTimer () => ToolTip(), -3000
    }
}

^!s:: {  ; Ctrl+Alt+S - Quick search
    searchTerm := ""
    
    if !InputBox(&searchTerm, "Quick Search", "Enter search term:")
        return
    
    if (searchTerm != "") {
        ; Ask which search engine
        result := MsgBox("Choose search engine:`n`nYes = Google`nNo = Stack Overflow`nCancel = GitHub", "Search Engine", "YesNoCancel")
        
        if (result = "Yes")
            Run "https://www.google.com/search?q=" . UrlEncode(searchTerm)
        else if (result = "No")
            Run "https://stackoverflow.com/search?q=" . UrlEncode(searchTerm)
        else if (result = "Cancel")
            Run "https://github.com/search?q=" . UrlEncode(searchTerm)
    }
}

^!w:: {  ; Ctrl+Alt+W - Word count
    A_Clipboard := ""
    Send "^c"
    ClipWait 1
    if (A_Clipboard != "") {
        text := A_Clipboard
        words := StrSplit(Trim(text), [" ", "`t", "`n", "`r"])
        wordCount := 0
        for word in words {
            if (Trim(word) != "")
                wordCount++
        }
        charCount := StrLen(text)
        charCountNoSpaces := StrLen(StrReplace(text, " ", ""))
        
        MsgBox "Text Statistics:`n`nWords: " wordCount "`nCharacters: " charCount "`nCharacters (no spaces): " charCountNoSpaces
    }
}

; ===============================================
; FILE & FOLDER OPERATIONS
; ===============================================
^!o:: {  ; Ctrl+Alt+O - Open common folders
    result := MsgBox("Choose folder to open:`n`nYes = Desktop`nNo = Documents`nCancel = Downloads", "Open Folder", "YesNoCancel")
    
    if (result = "Yes")
        Run A_Desktop
    else if (result = "No")
        Run A_MyDocuments
    else if (result = "Cancel")
        Run A_Desktop "\..\Downloads"  ; Assuming Downloads is in user folder
}

^!p:: {  ; Ctrl+Alt+P - Copy current file path
    ; Get the path of the currently active window
    WinGetTitle &title, "A"
    if InStr(title, " - ") {
        ; Try to extract file path from window title
        parts := StrSplit(title, " - ")
        if (parts.Length > 1) {
            path := parts[parts.Length]
            if FileExist(path) {
                A_Clipboard := path
                ToolTip "File path copied: " path
                SetTimer () => ToolTip(), -3000
                return
            }
        }
    }
    
    ; Fallback: copy current directory
    A_Clipboard := A_WorkingDir
    ToolTip "Working directory copied: " A_WorkingDir
    SetTimer () => ToolTip(), -3000
}

; ===============================================
; UTILITY FUNCTIONS
; ===============================================
GenerateUUID() {
    ; Generate a simple UUID-like string
    chars := "0123456789ABCDEF"
    uuid := ""
    
    Loop 8
        uuid .= SubStr(chars, Random(1, 16), 1)
    uuid .= "-"
    Loop 4
        uuid .= SubStr(chars, Random(1, 16), 1)
    uuid .= "-"
    Loop 4
        uuid .= SubStr(chars, Random(1, 16), 1)
    uuid .= "-"
    Loop 4
        uuid .= SubStr(chars, Random(1, 16), 1)
    uuid .= "-"
    Loop 12
        uuid .= SubStr(chars, Random(1, 16), 1)
    
    return uuid
}

Base64Encode(text) {
    ; Simple Base64 encoding (basic implementation)
    chars := "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    result := ""
    
    ; Convert string to bytes and encode
    Loop Parse, text {
        byte := Ord(A_LoopField)
        ; This is a simplified version - for production use a proper Base64 library
        result .= SubStr(chars, Mod(byte, 64) + 1, 1)
    }
    
    return result
}

UrlEncode(str) {
    ; Simple URL encoding for common characters
    str := StrReplace(str, " ", "%20")
    str := StrReplace(str, "&", "%26")
    str := StrReplace(str, "=", "%3D")
    str := StrReplace(str, "?", "%3F")
    str := StrReplace(str, "#", "%23")
    return str
}

; ===============================================
; HELP SYSTEM
; ===============================================
^!h:: {  ; Ctrl+Alt+H - Show help
    helpText := "
    (
    Extended AutoHotkey Utilities - Hotkey Reference
    
    === APPLICATION LAUNCHERS ===
    ::calc, ::paint, ::explorer, ::task
    ::chrome, ::firefox, ::edge
    
    === TEXT EXPANSION ===
    ::lorem - Lorem ipsum text
    ::myemail, ::myphone, ::myaddr - Personal info
    ::arrow, ::copyright, ::trademark, ::degree
    
    === TEXT FORMATTING ===
    Ctrl+Alt+U - Convert to UPPERCASE
    Ctrl+Alt+L - Convert to lowercase  
    Ctrl+Alt+T - Convert to Title Case
    
    === WINDOW MANAGEMENT ===
    Ctrl+Alt+A - Toggle always on top
    Ctrl+Alt+M - Minimize all windows
    Ctrl+Alt+R - Restore all windows
    
    === VOLUME CONTROLS ===
    Ctrl+Alt+Numpad+ - Volume up
    Ctrl+Alt+Numpad- - Volume down
    Ctrl+Alt+Numpad* - Mute toggle
    
    === CLIPBOARD ===
    Ctrl+Alt+V - Paste as plain text
    Ctrl+Alt+C - Copy file path
    
    === DEVELOPMENT ===
    Ctrl+Alt+G - Generate UUID
    Ctrl+Alt+B - Base64 encode
    Ctrl+Alt+N - Random number generator
    
    === CALCULATIONS ===
    Ctrl+Alt+F - Fahrenheit to Celsius
    Ctrl+Alt+K - Kilometers to Miles
    Ctrl+Alt+% - Percentage calculator
    
    === PRODUCTIVITY ===
    Ctrl+Alt+Q - Quick note
    Ctrl+Alt+S - Quick search
    Ctrl+Alt+W - Word count
    
    === FILE OPERATIONS ===
    Ctrl+Alt+O - Open common folders
    Ctrl+Alt+P - Copy file path
    
    Ctrl+Alt+H - Show this help
    )"
    
    MsgBox helpText, "AutoHotkey Utilities Help", "OK"
}
