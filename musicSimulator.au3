#include <Misc.au3>
#include <Array.au3>

Global $g_bPaused = False

HotKeySet("{ESC}", "Terminate") ; остановить 
HotKeySet("{UP}", "TempUp") ; стрелка вверх - увеличить темп
HotKeySet("{DOWN}", "TempDown") ; стрелка вниз - уменьшить темп
HotKeySet("{LEFT}", "ToneDown") ; опустить тональность (мелодии, октава только 1)
HotKeySet("{RIGHT}", "ToneUp") ; поднять тональность
HotKeySet("0", "SetDefaults") ; сброс настроек по умолчанию
HotKeySet("{SPACE}", "PlayMelody")


; константы длительности нот
Global $w_dur
Global $h_dur
Global $f_dur
Global $e_dur
Global $s_dur

Global $temp ; темп мелодии, удар/мин
Global $notes ;ноты на нампаде, с NUM1 начинается Do
SetDefaults()


Func getDefaultTemp()
	Return 50
	EndFunc

Func getDefaultNotes()
	Local $arr = ["NUMPAD1", "NUMPAD2", "NUMPAD3", "NUMPAD4", "NUMPAD5", "NUMPAD6", "NUMPAD7"]
	Return $arr
	EndFunc


Func Terminate()
	Global $g_bPaused = True
EndFunc

Func TempUp()
	$temp = $temp + 5
	RefreshNotesDuration()
	ConsoleWrite('temp set to ' & $temp & @CRLF)
EndFunc

Func TempDown()
	$temp = $temp - 5
	If $temp < 20 Then 
		$temp = 20
	EndIf
	RefreshNotesDuration()
	ConsoleWrite('temp set to ' & $temp & @CRLF)
EndFunc

Func ToneDown()
	Local $newArray[6] = _ArrayExtract($notes, 1, 6)
	Local $shiftedArray[1] = [ $notes[0] ]
	_ArrayConcatenate($newArray, $shiftedArray)
	Global $notes = $newArray
	RefreshNoteKeys()
	ConsoleWrite('tone decreased' & @CRLF)
EndFunc

Func ToneUp()
	Local $newArray[1] = [ $notes[6] ]
	Local $shiftedArray[6] = _ArrayExtract($notes, 0, 5)
	_ArrayConcatenate($newArray, $shiftedArray)
	Global $notes = $newArray
	RefreshNoteKeys()
	ConsoleWrite('tone increased' & @CRLF)
EndFunc


; настройки по умолчанию
Func SetDefaults()
	$temp = getDefaultTemp()
	$notes = getDefaultNotes()
	RefreshNoteKeys()
	RefreshNotesDuration()
	ConsoleWrite('defaults restored' & @CRLF)
	ConsoleWrite('temp: ' & $temp & @CRLF)
EndFunc

; обновляем константы назначенных нот на клавишу
Func RefreshNoteKeys()
	Global $n_Do = $notes[0]
	Global $n_Re = $notes[1]
	Global $n_Mi = $notes[2]
	Global $n_Fa = $notes[3]
	Global $n_Sol = $notes[4]
	Global $n_La = $notes[5]
	Global $n_Si = $notes[6]
EndFunc

Func RefreshNotesDuration()
	$w_dur = (60/$temp)*1000 		; целая нота
	$h_dur = ((60/$temp)/2)*1000  	; половинная нота
	$f_dur = ((60/$temp)/4)*1000  	; четвертная нота
	$e_dur = ((60/$temp)/8)*1000     ; восьмая нота
	$s_dur = ((60/$temp)/16)*1000   ; шеснадцатая нота
EndFunc

Func playSingleNote($name, $duration)
	If $g_bPaused Then 
		$g_bPaused = False
		Return
	EndIf
	Send(StringFormat("{%s down}", $name))
	Sleep($duration)
	Send(StringFormat("{%s up}", $name))
	Sleep(20)
EndFunc

Func PlayMelody()
	ConsoleWrite("melody")
	playSingleNote($n_La, $f_dur)
	
	playSingleNote($n_Mi, $f_dur)
	playSingleNote($n_La, $f_dur)
	playSingleNote($n_Mi, $f_dur)
	playSingleNote($n_La, $f_dur)
	
	playSingleNote($n_Sol, $f_dur)
	playSingleNote($n_Sol, $h_dur)
	playSingleNote($n_Sol, $f_dur)
	
	playSingleNote($n_Mi, $f_dur)
	playSingleNote($n_Sol, $f_dur)
	playSingleNote($n_Mi, $f_dur)
	playSingleNote($n_Sol, $f_dur)
	
	If $g_bPaused Then 
		$g_bPaused = False
		Return
	EndIf
	
	playSingleNote($n_La, $f_dur)
	playSingleNote($n_La, $h_dur)
	playSingleNote($n_La, $f_dur)
	
	playSingleNote($n_Mi, $f_dur)
	playSingleNote($n_La, $f_dur)
	playSingleNote($n_Mi, $f_dur)
	playSingleNote($n_La, $f_dur)
	
	playSingleNote($n_Sol, $f_dur)
	playSingleNote($n_Sol, $h_dur)
	playSingleNote($n_Sol, $f_dur)
	
	playSingleNote($n_Mi, $f_dur)
	playSingleNote($n_Sol, $f_dur)
	playSingleNote($n_Mi, $f_dur)
	playSingleNote($n_Sol, $f_dur)
	
	playSingleNote($n_La, $h_dur + $f_dur)
	playSingleNote($n_La, $f_dur)
	
	If $g_bPaused Then 
		$g_bPaused = False
		Return
	EndIf	
	
	playSingleNote($n_Si, $f_dur)
	playSingleNote($n_Si, $e_dur)
	playSingleNote($n_Si, $e_dur)
	playSingleNote($n_Si, $f_dur)
	playSingleNote($n_Si, $f_dur)

	playSingleNote($n_Do, $f_dur)
	playSingleNote($n_Do, $e_dur)
	playSingleNote($n_Do, $e_dur)
	playSingleNote($n_Do, $f_dur)
	playSingleNote($n_Do, $f_dur)
	
	playSingleNote($n_Do, $f_dur)
	playSingleNote($n_Si, $f_dur)
	playSingleNote($n_La, $f_dur)
	playSingleNote($n_Sol, $f_dur)
	
	playSingleNote($n_La, $f_dur)
	playSingleNote($n_La, $h_dur)
	playSingleNote($n_La, $f_dur)
	
	If $g_bPaused Then 
		$g_bPaused = False
		Return
	EndIf
	
	playSingleNote($n_Si, $f_dur)
	playSingleNote($n_Si, $e_dur)
	playSingleNote($n_Si, $e_dur)
	playSingleNote($n_Si, $f_dur)
	playSingleNote($n_Si, $f_dur)
	
	playSingleNote($n_Do, $f_dur)
	playSingleNote($n_Do, $e_dur)
	playSingleNote($n_Do, $e_dur)
	playSingleNote($n_Do, $f_dur)
	playSingleNote($n_Do, $f_dur)
	
	playSingleNote($n_Do, $f_dur)
	playSingleNote($n_Si, $f_dur)
	playSingleNote($n_La, $f_dur)
	playSingleNote($n_Sol, $f_dur)
	
	playSingleNote($n_La, $w_dur)
	
EndFunc

While 1
	Sleep(100)
	If _IsPressed('1B ') Then
		$g_bPaused = True
	ElseIf _IsPressed('26') Then
		TempUp()
	ElseIf _IsPressed('28') Then
		TempDown()
	ElseIf _IsPressed('25') Then
		ToneDown()
	ElseIf _IsPressed('27') Then
		ToneUp()
	ElseIf _IsPressed(30) Then
		SetDefaults()
	EndIf
WEnd










#comments-start




Sleep(3000)
While 1
	melody3()
	WEnd
	


Func melody3()
	playSingleNote($n_La, $f_dur)
	
	playSingleNote($n_Mi, $f_dur)
	playSingleNote($n_La, $f_dur)
	playSingleNote($n_Mi, $f_dur)
	playSingleNote($n_La, $f_dur)
	
	playSingleNote($n_Sol, $f_dur)
	playSingleNote($n_Sol, $h_dur)
	playSingleNote($n_Sol, $f_dur)
	
	playSingleNote($n_Mi, $f_dur)
	playSingleNote($n_Sol, $f_dur)
	playSingleNote($n_Mi, $f_dur)
	playSingleNote($n_Sol, $f_dur)
	
	playSingleNote($n_La, $f_dur)
	playSingleNote($n_La, $h_dur)
	playSingleNote($n_La, $f_dur)
	
	playSingleNote($n_Mi, $f_dur)
	playSingleNote($n_La, $f_dur)
	playSingleNote($n_Mi, $f_dur)
	playSingleNote($n_La, $f_dur)
	
	playSingleNote($n_Sol, $f_dur)
	playSingleNote($n_Sol, $h_dur)
	playSingleNote($n_Sol, $f_dur)
	
	playSingleNote($n_Mi, $f_dur)
	playSingleNote($n_Sol, $f_dur)
	playSingleNote($n_Mi, $f_dur)
	playSingleNote($n_Sol, $f_dur)
	
	playSingleNote($n_La, $h_dur + $f_dur)
	playSingleNote($n_La, $f_dur)
	
	playSingleNote($n_Si, $f_dur)
	playSingleNote($n_Si, $e_dur)
	playSingleNote($n_Si, $e_dur)
	playSingleNote($n_Si, $f_dur)
	playSingleNote($n_Si, $f_dur)

	playDoubleNote($n_Do, $f_dur)
	playDoubleNote($n_Do, $e_dur)
	playDoubleNote($n_Do, $e_dur)
	playDoubleNote($n_Do, $f_dur)
	playDoubleNote($n_Do, $f_dur)
	
	playSingleNote($n_Si, $f_dur)
	playSingleNote($n_Si, $f_dur)
	playSingleNote($n_La, $f_dur)
	playSingleNote($n_Sol, $f_dur)
	
	playSingleNote($n_La, $f_dur)
	playSingleNote($n_La, $h_dur)
	playSingleNote($n_La, $f_dur)
	
	playSingleNote($n_Si, $f_dur)
	playSingleNote($n_Si, $e_dur)
	playSingleNote($n_Si, $e_dur)
	playSingleNote($n_Si, $f_dur)
	playSingleNote($n_Si, $f_dur)
	
	playDoubleNote($n_Do, $n_Mi, $f_dur)
	playDoubleNote($n_Do, $n_Mi, $e_dur)
	playDoubleNote($n_Do, $n_Mi, $e_dur)
	playDoubleNote($n_Do, $n_Mi, $f_dur)
	playDoubleNote($n_Do, $n_Mi, $f_dur)
	
	playSingleNote($n_Do, $f_dur)
	playSingleNote($n_Si, $f_dur)
	playSingleNote($n_La, $f_dur)
	playSingleNote($n_Sol, $f_dur)
	
	playSingleNote($n_La, $f_dur)
	
EndFunc

Func show($str)
	MsgBox('', 'Func show', $str)
	EndFunc
	

Func melody1()
	$interval_1 = 150
	$interval_2 = 300
	$multp = 4
	
	Send("{NUMPAD3}")
	Send("{NUMPAD6}")
	Sleep(150*$multp)
	Send("{NUMPAD3}")
	Send("{NUMPAD6}")
	Sleep(150*$multp)
	Send("{NUMPAD2}")
	Send("{NUMPAD5}")
	Sleep(150*$multp)
	Send("{NUMPAD2}")
	Send("{NUMPAD5}")
	Sleep(150*$multp)
	Send("{NUMPAD1}")
	Send("{NUMPAD4}")
	Send("{NUMPAD7}")
	Sleep(150*$multp)
	Send("{NUMPAD1}")
	Send("{NUMPAD4}")
	Send("{NUMPAD7}")
	Sleep(150*$multp)
	Send("{NUMPAD5 down}")
	Send("{NUMPAD2 down}")
	Sleep(300*$multp)
	Send("{NUMPAD5 up}")
	Send("{NUMPAD2 up}")
	Sleep($interval_1)
EndFunc

Func melody2()
	$interval_1 = 150
	$interval_2 = 300
	$multp = 4
	
	Send("{NUMPAD3 down}")
	Send("{NUMPAD6 down}")
	Sleep($interval_2*$multp)
	Send("{NUMPAD3 up}")
	Send("{NUMPAD6 up}")
	
	#Sleep(200)
	
	Send("{NUMPAD5 down}")
	Send("{NUMPAD2 down}")
	Sleep($interval_2*$multp)
	Send("{NUMPAD5 up}")
	Send("{NUMPAD2 up}")
	
	#Sleep(200)
	
	Send("{NUMPAD1 down}")
	Send("{NUMPAD4 down}")
	Send("{NUMPAD7 down}")
	Sleep($interval_2*$multp)
	Send("{NUMPAD1 up}")
	Send("{NUMPAD4 up}")
	Send("{NUMPAD7 up}")
	
	#Sleep(200)
	
	Send("{NUMPAD5 down}")
	Send("{NUMPAD2 down}")
	Sleep($interval_2*$multp)
	Send("{NUMPAD5 up}")
	Send("{NUMPAD2 up}")
	
    #Sleep(200)
EndFunc

Func ShowMessage()
        MsgBox($MB_SYSTEMMODAL, "", "This is a message.")
EndFunc   ;==>ShowMessage

#comments-end