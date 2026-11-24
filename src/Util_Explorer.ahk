; Windows Explorer 関連の追加機能

ExplorerPrefixRename_ShowGui() {
    if (WinGetClass("A") != "CabinetWClass") {
        ToolTip("Explorer上で実行してください。"), SetTimer(() => ToolTip(), -2500)
        return
    }

    files := ExplorerPrefixRename_GetSelectedFiles()
    if (files.Length = 0) {
        ToolTip("選択中のファイルがありません。"), SetTimer(() => ToolTip(), -2500)
        return
    }

    renameGui := Gui("+AlwaysOnTop", "Prefix Rename - " files.Length " files")
    renameGui.SetFont("s10", "Yu Gothic UI")
    prefixEdit := renameGui.AddEdit("w300")
    runButton := renameGui.AddButton("x+8 w70 Default", "実行")
    replacePrefixCheck := renameGui.AddCheckBox("xm y+8", "既存Prefixの書き換え")

    runButton.OnEvent("Click", (*) => ExplorerPrefixRename_Run(renameGui, prefixEdit.Value, files, replacePrefixCheck.Value))
    renameGui.OnEvent("Escape", (*) => renameGui.Destroy())
    HotIfWinActive("ahk_id " renameGui.Hwnd)
    Hotkey("^Enter", (*) => ExplorerPrefixRename_Run(renameGui, prefixEdit.Value, files, replacePrefixCheck.Value), "On")
    HotIfWinActive()
    renameGui.Show("AutoSize")
    prefixEdit.Focus()
}

ExplorerPrefixRename_GetSelectedFiles() {
    hwnd := WinGetID("A")
    files := Array()

    try {
        shell := ComObject("Shell.Application")
        for window in shell.Windows {
            if (window.HWND != hwnd)
                continue

            for item in window.Document.SelectedItems {
                path := item.Path
                if (path != "" && FileExist(path) && !DirExist(path))
                    files.Push(path)
            }
            break
        }
    } catch as e {
        logger("Explorer selected files fetch failed: " . e.Message, "ERROR")
    }

    return files
}

ExplorerPrefixRename_Run(renameGui, prefix, files, replacePrefix) {
    prefix := Trim(prefix)
    if (prefix = "" && !replacePrefix) {
        renameGui.Destroy()
        ToolTip("prefix が空のためスキップしました。"), SetTimer(() => ToolTip(), -2500)
        return
    }

    if RegExMatch(prefix, '[\\/:*?"<>|]') {
        MsgBox('prefix にファイル名として使えない文字が含まれています。`n\ / : * ? " < > |', "Prefix Rename")
        return
    }

    renamePlan := Array()
    targets := Map()

    for path in files {
        SplitPath(path, &fileName, &dir)
        newFileName := ExplorerPrefixRename_BuildFileName(prefix, fileName, replacePrefix)
        newPath := ExplorerPrefixRename_GetUniquePath(dir, newFileName, path, targets)
        targetKey := StrLower(newPath)

        if (targetKey = StrLower(path))
            continue
        targets[targetKey] := true

        renamePlan.Push([path, newPath])
    }

    if (renamePlan.Length = 0) {
        MsgBox("リネーム対象がありません。", "Prefix Rename")
        return
    }

    renamed := 0
    failed := Array()
    for pair in renamePlan {
        try {
            FileMove(pair[1], pair[2], 0)
            renamed++
        } catch as e {
            failed.Push(pair[1] "`n" e.Message)
            logger("Explorer prefix rename failed: " . pair[1] . " -> " . pair[2] . " / " . e.Message, "ERROR")
        }
    }

    renameGui.Destroy()
    if (failed.Length = 0) {
        ToolTip(renamed " 件をリネームしました。"), SetTimer(() => ToolTip(), -3000)
    } else {
        message := renamed " 件をリネームしました。`n" failed.Length " 件に失敗しました。"
        Loop Min(failed.Length, 5)
            message .= "`n`n" failed[A_Index]
        MsgBox(message, "Prefix Rename")
    }
}

ExplorerPrefixRename_BuildFileName(prefix, fileName, replacePrefix) {
    if !replacePrefix
        return prefix "_" fileName

    underscorePos := InStr(fileName, "_")
    if (underscorePos <= 1) {
        if (prefix = "")
            return fileName
        return prefix "_" fileName
    }

    restName := SubStr(fileName, underscorePos + 1)
    if (prefix = "")
        return restName

    return prefix "_" restName
}

ExplorerPrefixRename_GetUniquePath(dir, fileName, sourcePath, targets) {
    SplitPath(fileName, , , &ext, &nameNoExt)
    suffix := 1

    loop {
        if (suffix = 1)
            candidateName := fileName
        else if (ext = "")
            candidateName := nameNoExt "_" suffix
        else
            candidateName := nameNoExt "_" suffix "." ext
        candidatePath := dir "\" candidateName
        candidateKey := StrLower(candidatePath)

        if !targets.Has(candidateKey) && (candidateKey = StrLower(sourcePath) || !FileExist(candidatePath))
            return candidatePath

        suffix++
    }
}
