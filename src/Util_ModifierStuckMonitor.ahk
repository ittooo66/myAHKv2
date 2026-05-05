; Core_Mods.ahk の仮想修飾キーが押下されたまま残っている場合に通知する

ModifierStuckMonitor_LastInputAt := A_TickCount
ModifierStuckMonitor_InputHook := InputHook("V")
ModifierStuckMonitor_InputHook.KeyOpt("{All}", "N")
ModifierStuckMonitor_InputHook.OnKeyDown := ModifierStuckMonitor_OnKeyDown
ModifierStuckMonitor_InputHook.Start()
SetTimer ModifierStuckMonitor_Check, 1000

ModifierStuckMonitor_Check() {
    global ModifierStuckMonitor_LastInputAt
    static firstPressedAt := Map(), delayMs := 5000, tooltipId := 20
    stuckLabels := []

    ; 修飾キーが押され始めた時刻を記録し、一定時間を超えたものだけ表示対象にする
    for _, mod in ModifierStuckMonitor_Definitions() {
        name := mod[1]
        isPressed := mod[2].Call()
        if isPressed && !firstPressedAt.Has(name)
            firstPressedAt[name] := A_TickCount
        else if !isPressed && firstPressedAt.Has(name)
            firstPressedAt.Delete(name)

        if isPressed && A_TickCount - firstPressedAt[name] >= delayMs
            stuckLabels.Push(name)
    }

    ; Lockキーのトグル状態も警告対象にする
    for _, lockKey in ["NumLock", "ScrollLock", "CapsLock"]
        if GetKeyState(lockKey, "T")
            stuckLabels.Push(lockKey "(T)")

    ; InputHookで拾えないホットキー入力を A_TimeIdleKeyboard / A_PriorKey で補完する
    if (A_TimeIdleKeyboard < delayMs && A_PriorKey != "") {
        isModifierKey := false
        for _, mod in ModifierStuckMonitor_Definitions()
            for _, key in mod[3]
                if (A_PriorKey = key)
                    isModifierKey := true
        if !isModifierKey
            ModifierStuckMonitor_LastInputAt := A_TickCount - A_TimeIdleKeyboard
    }

    ; 非修飾キー入力がしばらく無い場合だけ Tooltip を表示する
    text := ""
    if (stuckLabels.Length && A_TickCount - ModifierStuckMonitor_LastInputAt >= delayMs) {
        text := "Stuck : "
        for index, label in stuckLabels
            text .= (index = 1 ? "" : "-") label
    }
    ToolTip text, , , tooltipId
}

ModifierStuckMonitor_OnKeyDown(ih, vk, sc) {
    global ModifierStuckMonitor_LastInputAt
    keyId := Format("vk{:02X}sc{:03X}", vk, sc)
    keyName := GetKeyName(keyId)

    ; 修飾キー自身の押下は入力あり扱いにしない
    for _, mod in ModifierStuckMonitor_Definitions()
        for _, key in mod[3]
            if (keyName = key || keyId = key)
                return
    ModifierStuckMonitor_LastInputAt := A_TickCount
}

ModifierStuckMonitor_Definitions() {
    ; Core_Mods.ahk の仮想修飾キーと、InputHook/A_PriorKey で除外する物理キー名を対応させる
    static mods := [
        ["LCMD()", LCMD, ["vkEB", "LWin"]],
        ["RCMD()", RCMD, ["vkFF", "RWin"]],
        ["CAPS()", CAPS, ["LControl", "RControl", "sc03A", "vk14sc03A", "CapsLock"]],
        ["SHIFT()", SHIFT, ["LShift", "RShift"]],
        ["LSHIFT()", LSHIFT, ["LShift"]],
        ["RSHIFT()", RSHIFT, ["RShift"]],
        ["SPACE()", SPACE, ["Space"]],
        ["ALT()", ALT, ["LAlt", "RAlt"]],
        ["RALT()", RALT, ["RAlt"]],
        ["LALT()", LALT, ["LAlt"]],
        ["MLB()", MLB, ["LButton"]],
        ["MRB()", MRB, ["RButton"]],
        ["MMB()", MMB, ["MButton"]],
        ["MSBLB()", MSBLB, ["XButton1"]],
        ["MSBLF()", MSBLF, ["XButton2"]],
        ["MSBRF()", MSBRF, ["F19", "LControl", "RControl", "LAlt", "RAlt"]],
        ["MSBRB()", MSBRB, ["F20", "LAlt", "RAlt", "LShift", "RShift"]]
    ]
    return mods
}
