; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

; This script has a special filename and path because it is automatically
; launched when you run the program directly.  Also, any text file whose
; name ends in .ahk is associated with the program, which means that it
; can be launched simply by double-clicking it.  You can have as many .ahk
; files as you want, located in any folder.  You can also run more than
; one ahk file simultaneously and each will get its own tray icon.

; When the cpu is running at >90%, pressing the caps lock key enables
; caps lock and later, when CPU is idle the caps lock is on and
; there's no way to disable it.  The below command disables CapsLock
; so restarting AutoHotKey fixes the problem.
SetCapsLockState, AlwaysOff

; Set capslock to function as a Ctrl.
Capslock::Ctrl

; Make F1 work as Escape.  Opening Help is rarely done but pressing F1
; when I mean to press Escape happens very often.  And typically,
; everything blocks for a few seconds while Windows opens the help
; file.
F1::Escape

; Disable left windows key
Lwin::return

; Disable the Insert key
Insert::return
