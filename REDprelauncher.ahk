#SingleInstance Force
#MaxHotkeysPerInterval 2000

SetTitleMatchMode, 3

buttonPressed := 0
Gui, Add, Picture,w400 h-1, logo.png
Gui, Add, Text,x10 y110, Cyberpunk 2077 Speedrun Launcher by nicnacnic
Gui, Add, Text,x10 y135, In each text field, enter the path to the folder where the program is located.
Gui, Add, Text,x10 y150, Don't link directly to the executable. If the path has a space, don't add quotes.
Gui, Add, Text,x10 y165, And don't add a trailing backslash.
Gui, Add, Text,x10 y180, Example: C:\Program Files (x86)\Steam\steamapps\common\Cyberpunk 2077
Gui, Add, Text,x10 y210, All fields will automaticlly save on exit. 
Gui, Add, Text,x10 y240, Normal Folder Path
Gui, Add, Edit, r1 vnormalPath w280 x130 y237
Gui, Add, Text,x10 y266, Speedrun Folder Path
Gui, Add, Edit, r1 vspeedrunPath w280 x130 y263
Gui, Add, Text,x10 y292, Livesplit Folder Path
Gui, Add, Edit, r1 vlivesplitPath w280 x130 y289
Gui, Add, Text,x10 y318, Quick Restart Hotkey
Gui, Add, Hotkey, vrestartHotkey w280 x130 y315
Gui, Add, Text,x10 y342, Launch Livesplit
Gui, Add, CheckBox, vlaunchLivesplit x130 y342
Gui, Add, Button, gButtonNormal w125 h30 x10 y362, Normal
Gui, Add, Button, gButtonSpeedrun w125 h30 x145 y362, Speedrun
Gui, Add, Button, w100 gButtonExit w125 h30 x280 y362, Exit
Gui Show,, CP77 Speedrun Launcher

IniRead, IniRead, settings.INI, Settings, normalPath
GuiControl,, normalPath, %IniRead%
IniRead, IniRead, settings.INI, Settings, speedrunPath
GuiControl,, speedrunPath, %IniRead%
IniRead, IniRead, settings.INI, Settings, livesplitPath
GuiControl,, livesplitPath, %IniRead%
IniRead, IniRead, settings.INI, Settings, restartHotkey
GuiControl,, restartHotkey, %IniRead%
IniRead, IniRead, settings.INI, Settings, launchLivesplit
GuiControl,, launchLivesplit, %IniRead%

Gui, Show
Return

ButtonNormal:
saveSettings()
IniRead, IniRead, settings.INI, Settings, normalPath
Run, "%IniRead%\bin\x64\Cyberpunk2077.exe"
buttonPressed := 1
Gui, Destroy
Goto openLivesplit

ButtonSpeedrun:
saveSettings()
IniRead, IniRead, settings.INI, Settings, speedrunPath
Run, "%IniRead%\bin\x64\Cyberpunk2077.exe"
buttonPressed := 2
Gui, Destroy
Goto openLivesplit

openLivesplit:
IniRead, IniRead, settings.INI, Settings, launchLivesplit

If (IniRead = 1)
{
	IniRead, IniRead, settings.INI, Settings, livesplitPath
	Run, "%IniRead%\Livesplit.exe"
}
IniRead, IniRead, settings.INI, Settings, restartHotkey
Hotkey, %IniRead%, restartGame
Goto gameOpen

gameOpen:
Sleep, 10000

SetTimer, close, 10000

Close:
	IfWinNotExist, ahk_exe Cyberpunk2077.exe
	{
		WinClose, ahk_exe Cyberpunk2077.exe
		Exitapp
	}
Return

restartGame:
WinClose, ahk_exe Cyberpunk2077.exe

If (buttonPressed = 1)
{
	IniRead, IniRead, settings.INI, Settings, normalPath
	Run, "%IniRead%\bin\x64\Cyberpunk2077.exe"
	Goto gameOpen
}
If (buttonPressed = 2)
{
	IniRead, IniRead, settings.INI, Settings, speedrunPath
	Run, "%IniRead%\bin\x64\Cyberpunk2077.exe"
	Goto gameOpen
}
Return

ButtonExit:
saveSettings()
ExitApp

saveSettings() {
GuiControlGet, normalPath
IniWrite, %normalPath%, settings.INI, Settings, normalPath
GuiControlGet, speedrunPath
IniWrite, %speedrunPath%, settings.INI, Settings, speedrunPath
GuiControlGet, livesplitPath
IniWrite, %livesplitPath%, settings.INI, Settings, livesplitPath
GuiControlGet, restartHotkey
IniWrite, %restartHotkey%, settings.INI, Settings, restartHotkey
GuiControlGet, launchLivesplit
IniWrite, %launchLivesplit%, settings.INI, Settings, launchLivesplit
return
}