; Recommended for performance and compatibility with future AutoHotkey releases.
#NoEnv 
SetBatchLines, -1

;  Define the user name which will be used to find the Chrome profile
user = %A_UserName%

; Adjust path to location of Chrome.ahk
#Include C:\Program Files\AutoHotkey\Chrome.ahk_v1.2\Chrome.ahk

; Close all Chrome processes
Process, Close, chrome.exe

; Open a Chrome instance using a specific profile so that you don't have to log in every time
; This should theoretically work as an anti-bot measure
ChromeProfile := "C:\\Users\\" user "\\AppData\\Local\\Google\\Chrome\\User Data"
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

; Wait for the page to load
PageInst.WaitForLoad("complete")

UserInput := "Hello, how are you?"

;  Run the following JavaScript code to enter the text in the chat box
PageInst.Call("Runtime.evaluate", {"expression": "document.querySelector('textarea').value = '" userInput "'"})

; Wait for 2 seconds
sleep 2000

;  Run the following JavaScript code to click the send button
PageInst.Call("Runtime.evaluate", {"expression": "document.querySelectorAll('button')[3].click()"})


; Discontinued since OpenAI has a limited the number of times you can use their service on their website every hour