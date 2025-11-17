# Terminal shells

* Default: Ubuntu
* Ubuntu, Powershell, VS Cmd, CMD

# Windoes features

* Enable Windows Sandbox
* Enable Windows Subsystem for Linux

# Explorer

* [_] Hide extensions for known files types
* Decrease space between items
* Navigation pane > Expand to open folder
* Apply to all folders
*
*    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" IconsOnly 0
*    Stop-Process -Name explorer -Force


# Taskbar:

* Hide search
* Combine taskbar buttons: never
* Other system tray icons:
  * Task Manager
  * Everything
  * Slack

# Startup

* Run dansk.ahk

# Apps

* .NET Framework 4.7 targeting pack: https://dotnet.microsoft.com/en-us/download/dotnet-framework/thank-you/net47-developer-pack-offline-installer

# git

git config --global difftool.bc.cmd '"%LOCALAPPDATA%/Programs/Beyond Compare 5/bcomp.exe" "$LOCAL" "$REMOTE"'
git config --global mergetool.bc.cmd '"%LOCALAPPDATA%/Programs/Beyond Compare 5/bcomp.exe" "$LOCAL" "$REMOTE" "$BASE" "$MERGED"'
