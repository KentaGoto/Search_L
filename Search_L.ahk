#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

/*
自分用:
ホットキーの設定
*/

vk1Dsc07B & h::
{
   Message=
         (

[無変換]+F1
このスクリプト自体をvscodeで開く

[無変換]+r
AHKをリロード

[無変換]+1
Google検索

[無変換]+2
アルク検索

[無変換]+3
連想類語辞典検索

[無変換]+4
Google翻訳(英日)

[無変換]+5
YOMIKATA

[無変換]+e
EmEditor起動

[無変換]+v
GVim起動

[無変換]+f
Everything検索

[無変換]+w
Wordの文字カウント

[無変換]+p
pcdコマンド※peco
         )

   Msgbox, 0, 使い方, % Message,
   Return
}

vk1Dsc07B & F1::
{
    Run, "C:\Program Files\Microsoft VS Code\Code.exe" "D:\tool\AutoHotKey\Search_L\Search_L.ahk"
    Return
}

vk1Dsc07B & r::
{
    Reload
    Return
}

; Google search
vk1Dsc07B & 1::
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

; アルク search
vk1Dsc07B & 2::
{
   backup = %Clipboard%
   Clipboard =
    Send, ^c
    ClipWait,1
    Clipboard_keyword = %Clipboard%
    Clipboard = %backup%

    Clipboard_keyword := RegExReplace( Clipboard_keyword, "&", "`%26" )
    Clipboard_keyword := RegExReplace( Clipboard_keyword, """", "`%22" )

    Run, "http://eow.alc.co.jp/search?q=%Clipboard_keyword%&ref=sa"
    Return
}

; 連想類語辞典 search
vk1Dsc07B & 3::
{
    backup = %Clipboard%
    Clipboard =
    Send, ^c
    ClipWait,1
    Clipboard_keyword = %Clipboard%
    Clipboard = %backup%

    Clipboard_keyword := RegExReplace( Clipboard_keyword, "&", "`%26" )
    Clipboard_keyword := RegExReplace( Clipboard_keyword, """", "`%22" )

    Run, "http://renso-ruigo.com/word/%Clipboard_keyword%"
    Return
}

; Google翻訳（英->日）
vk1Dsc07B & 4::
{
    backup = %Clipboard%
    Clipboard =
    Send, ^c
    ClipWait,1
    Clipboard_keyword = %Clipboard%
    Clipboard = %backup%

    Clipboard_keyword := RegExReplace( Clipboard_keyword, "&", "`%26" )
    Clipboard_keyword := RegExReplace( Clipboard_keyword, """", "`%22" )

    Run, "https://translate.google.co.jp/#en/ja/%Clipboard_keyword%"
    Return
}

; YOMIKATA
vk1Dsc07B & 5::
{
    backup = %Clipboard%
    Clipboard =
    Send, ^c
    ClipWait,1
    Clipboard_keyword = %Clipboard%
    Clipboard = %backup%

    Clipboard_keyword := RegExReplace( Clipboard_keyword, "&", "`%26" )
    Clipboard_keyword := RegExReplace( Clipboard_keyword, """", "`%22" )

    Run, "http://yomikata.org/word/%Clipboard_keyword%"
    Return
}

; pcdコマンド※peco
vk1Dsc07B & p::
{
   SetWorkingDir, C:\Users\kenta-goto
   Run, "pcd"
   Sleep, 100
   Return
}

; EmEditor
vk1Dsc07B & e::
{
   Run, "C:\Users\kenta-goto\AppData\Local\Programs\EmEditor\EmEditor.exe"
   Sleep, 500
   Send, ^n
   Return
}

; GVim
vk1Dsc07B & v::
{
   SetWorkingDir, C:\vim82-kaoriya-win64
   Run, "C:\vim82-kaoriya-win64\gvim.exe"
   Sleep, 500
   Return
}

; Everything
vk1Dsc07B & f::
{
   backup = %Clipboard%
   Clipboard =
    Send, ^c
    ClipWait,1
    Clipboard_keyword = %Clipboard%
    Clipboard = %backup%

    cmd = %comspec% /c Everything -search %Clipboard_keyword%
    Run, %cmd%
    Sleep, 500
    Return
}

; Wordの文字カウント
vk1Dsc07B & w::
{
   ; クリップボード処理
   backup = %Clipboard% ; クリップボードの中身をバックアップ
    Send, ^c
    ClipWait,1
    Clipboard_keyword = %Clipboard%

   Clipboard = %Clipboard_keyword%

   Run, "C:\Program Files (x86)\Microsoft Office\root\Office16\WINWORD.EXE"
   sleep 3000
   Send, ^n
   WinWait, 文書 1 [互換モード] - Word, , 3
   If ErrorLevel = 0
   {
      MsgBox, WinWait timed out.
      Return
   }
   Else
      sleep 100
      Send, ^v
      sleep 100
      Send, !rw

   ; バックアップしたクリップボードの中身を戻す
    Clipboard = %backup%
    Return
}