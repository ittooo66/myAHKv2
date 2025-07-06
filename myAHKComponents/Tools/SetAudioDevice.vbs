Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")
scriptDir = objFSO.GetParentFolderName(WScript.ScriptFullName)
ps1Path = Chr(34) & scriptDir & "\SetAudioDevice.ps1" & Chr(34)
objShell.Run "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File " & ps1Path, 0, False