#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
SetBatchLines, -1

user = %A_UserName%

; Adjust path to location of Chrome.ahk
#Include C:\Program Files\AutoHotkey\Chrome.ahk_v1.2\Chrome.ahk
#Include C:\Users\Harminder Nijjar\Desktop\AHK\FindText.ahk

; Close all Chrome processes
Process, Close, chrome.exe


; Connect to the newly opened tab and navigate to another website
; Note: If your first action is to navigate away, it may be just as
; effective to provide the target URL when instantiating the Chrome class


ChromeProfile := "C:\\Users\\"  user "\\AppData\\Local\\Google\\Chrome\\User Data"
ChromeInst := new Chrome(ChromeProfile)


; Connect to the newly opened tab and navigate to another website
; Note: If your first action is to navigate away, it may be just as
; effective to provide the target URL when instantiating the Chrome class
PageInst := ChromeInst.GetPage()
PageInst.Call("Page.navigate", {"url": "https://chat.openai.com/chat/"})

; Wait for 5 seconds
sleep 5000

;  Check if a captcha is present
If PageInst.FindText("captcha") = 1
{
    MsgBox, Captcha is present
    ; Click on the captcha
    PageInst.Click("captcha")
    ; Wait for 5 seconds
    sleep 5000
}
















 







