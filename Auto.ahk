Gui, +AlwaysOnTop
Gui, Add, Text,, ----------------------------------------PASTE SHEETS HERE-----------------------------------------
Gui, Add, Edit, R10 w300 vPianoMusic
Gui, Add, Text,, 								Press - = [ ] to start autoplaying.
Gui, Add, Text,, 								Modified by: Crimsxn K1ra
Gui, Add, Text,,								NOTE: restart the app before pasting a new sheet.
Gui, Add, Text,, ----------------------------------Progress-----------------------------------
Gui, Add, Edit, ReadOnly w300 vNextNotes
Gui, Show

PianoMusic := ""
CurrentPos := 1
KeyPressStartTime := 0

PlayNextNote()
{
    global PianoMusic, CurrentPos, KeyDelay, KeyPressStartTime
    Gui, Submit, Nohide
    PianoMusic := RegExReplace(PianoMusic, "`n|`r|/| ")

    if (CurrentPos > StrLen(PianoMusic))
    {
        CurrentPos := 1
    }

    if (CurrentPos <= StrLen(PianoMusic) && A_TickCount - KeyPressStartTime < 3000)
    {
        if (RegExMatch(PianoMusic, "U)(\[.*]|.)", Keys, CurrentPos))
        {
            CurrentPos += StrLen(Keys)
            Keys := Trim(Keys, "[]")
            SendInput, {Raw}%Keys%
            Sleep, %KeyDelay%
        }
    }

    NextNotes := SubStr(PianoMusic, CurrentPos, 50)
    GuiControl,, NextNotes, %NextNotes%
}

-::
=::
[::
]::
    KeyPressStartTime := A_TickCount
    PlayNextNote()
    KeyPressStartTime := 0
return

GuiClose:
    ExitApp