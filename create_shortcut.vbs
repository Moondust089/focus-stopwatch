Set WshShell = CreateObject("WScript.Shell")
strDesktop = WshShell.SpecialFolders("Desktop")
Set oShellLink = WshShell.CreateShortcut(strDesktop & "\Focus Stopwatch.lnk")

Dim fso
Set fso = CreateObject("Scripting.FileSystemObject")
strPath = fso.GetParentFolderName(WScript.ScriptFullName)

oShellLink.TargetPath = "cmd.exe"
oShellLink.Arguments = "/c """ & strPath & "\run stopwatch.bat"""
oShellLink.IconLocation = strPath & "\pink_alarm_clock_icon.ico"
oShellLink.WindowStyle = 7
oShellLink.WorkingDirectory = strPath
oShellLink.Save

WScript.Echo "Shortcut created on Desktop! You can now right-click 'Focus Stopwatch' on your Desktop and choose 'Pin to Start'."
