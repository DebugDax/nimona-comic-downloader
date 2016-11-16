#include <inet.au3>
#include <string.au3>
#include <array.au3>

$url = 'http://gingerhaze.com/nimona/comic/nimona-chapter-'
Global $chapter[10] = [4,12,15,18,34,13,21,40,48,42]

DirCreate(@ScriptDir & "\comics")

while 1
	for $c = 0 to UBound($chapter) - 1
		for $p = 1 to $chapter[$c]
			TraySetToolTip("Nimona" & @CRLF & "Chapter " & $c & @CRLF & $p & "...")
			$source = _INetGetSource($url & $c+2 & "-page-" & $p, True)
			if stringinstr($source, 'typeof="foaf:Image"') Then
				$img = _StringBetween($source, 'typeof="foaf:Image" src="', '"')
				if IsArray($img) Then
					$name = $c+2 & "-" & $p & ".jpg"
					If Not FileExists(@ScriptDir & "\comics\" & $name) Then
						ConsoleWrite($c+2 & ":" & $p & " - " & $name & @CRLF)
						InetGet($img[0], @ScriptDir & "\comics\" & $name, 3, 0)
					Else
					ConsoleWrite($c+2 & ":" & $p & " - Skipping" & @CRLF)
					EndIf
				Else
					ConsoleWrite($c+2 & ":" & $p & " - Skipping" & @CRLF)
				EndIf
			Else
				ConsoleWrite($c+2 & ":" & $p & " - Skipping" & @CRLF)
			EndIf
		next
	Next
WEnd
