Scriptname ssubtitletextUtil hidden
{ 外部のModから字幕やメニューリストを使うためのユーティリティ }

int function GetVersion() global
	return 30
	; return 25 ; 2016.1.31 ver 2.5
	; return 24 ; 2015.8.25 ver 2.4
	; return 23 ; 2015.1.11 ver 2.3
	; return 22 ; 2015.1.11 ver 2.2
	; return 21 ; 2014.12.28 ver 2.1
	; return 20 ; 2014.12.15 ver 2.0
	; return 11 ; 2014.12.2 ver 1.1
	; return 10 ; 2014.12.1 ver 1.0
endFunction

string function GetVersionString() global
	return "v2.5p5 (forked)"
endFunction

bool function IsActiveSubtitle() global
	return GetAPI() != none
endFunction

secondSubtitleTextHUD function GetAPI() global
	return Game.GetFormFromFile(0x1829, "SexLabSubtitles.esp") as secondSubtitleTextHUD
endFunction
