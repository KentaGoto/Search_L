#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory
; #Warn  ; Enable warnings to assist with detecting common errors.

/*
自分用:
ホットキーの設定
*/

vk1D & h::
{
   Message=
    (
[無変換]+h で使い方を確認。

テキストを選択し、[無変換]+1 で Google 検索

[無変換]+p で peco（pcd）

[無変換]+v で GVim 起動
    )

   Msgbox, 0, 使い方, % Message,
   Return
}

vk1D & F1::
{
    Run, "C:\Program Files\Microsoft VS Code\Code.exe" "D:\tool\AutoHotKey\Search_L\Search_L.ahk"
    Return
}

vk1D & r::
{
    Reload
    Return
}

; Google search
vk1D & 1::
{
    ;クリップボードの内容を保存
    backup = %Clipboard%
    ;クリップボードを空にする
    Clipboard =
    ;選択している文字列がクリップボードにコピーされる
    Send, ^c
    ClipWait,1
    ;クリップボードの内容を変数に入れる
    Clipboard_keyword = %Clipboard%
    ;保存した内容をクリップボードに戻す
    Clipboard = %backup%

    ;アンパサンドのパーセントエンコーディング対応
    Clipboard_keyword := RegExReplace( Clipboard_keyword, "&", "`%26" )
    ;ダブルクォーテーションは2つ並べてエスケープ
    Clipboard_keyword := RegExReplace( Clipboard_keyword, """", "`%22" )

    Run, "http://www.google.co.jp/search?hl=ja&lr=lang_ja&ie=UTF-8&q=%Clipboard_keyword%"
    Return
}

; pcdコマンド※peco
vk1D & p::
{
   SetWorkingDir, C:\Users\kenta-goto
   Run, "pcd"
   Sleep, 100
   Return
}

; GVim
vk1D & v::
{
   SetWorkingDir, C:\vim82-kaoriya-win64
   Run, "C:\vim82-kaoriya-win64\gvim.exe"
   Sleep, 500
   Return
}
