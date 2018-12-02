﻿Scriptname SubtitleSetSetting extends Quest
{sexLab用 字幕セットのインポート・汎用字幕の設定}

; string[] Property common_setname auto;シチュエーションに適用されているセット名
string[] Property common_situation auto; シチュエーション名

string[] Property CS_type auto ; ["hetero", "homo", "creature"]
int[] Property CS_index auto ; シチュエーションに適用されているセットのインポート元番号
Quest[] Property CS_quest auto

string[] Property IS_name auto ; インポートした字幕のセット名
int[] Property IS_index auto ; インポートした字幕のファイル番号

int SituationLength = 12 ; but search this number in codes when you hope change

;/======================================
             【汎用字幕12種】

	0 69		1 Hand			2 Foot
	3 Boob		4 Masturbation	5 Fist
	6 Cowgirl	7 Foreplay		8 Oral
	9 Anal		10 Vaginal		11 Etc
/;

; 汎用字幕ファイルの初期化
; Function commonSetInit()

Function init()
	; why call EnmptyArray ?
	;common_setname = Utility.CreateStringArray(0)
	;common_setname = new string[12]
	;common_situation = Utility.CreateStringArray(0)
	;common_situation = new string[12]
	;CS_index = Utility.CreateIntArray(0)
	;CS_index = new int[12]
	; CS_index = Utility.CreateIntArray(SituationLength * stypeLength)
	; common_setname = Utility.CreateStringArray(SituationLength)
	
	common_situation = Utility.CreateStringArray(SituationLength)
	common_situation[0] = "$CMODE_0"
	common_situation[1] = "$CMODE_1"
	common_situation[2] = "$CMODE_2"
	common_situation[3] = "$CMODE_3"
	common_situation[4] = "$CMODE_4"
	common_situation[5] = "$CMODE_5"
	common_situation[6] = "$CMODE_6"
	common_situation[7] = "$CMODE_7"
	common_situation[8] = "$CMODE_8"
	common_situation[9] = "$CMODE_9"
	common_situation[10] = "$CMODE_10"
	common_situation[11] = "$CMODE_11"
	
	CS_type = Utility.CreateStringArray(3)
	CS_type[0] = "hetero"
	CS_type[1] = "homo"
	CS_type[2] = "creature"
	
	CS_quest = new Quest[12]
	CS_quest[0] = SubtitlesSituation69
	CS_quest[1] = SubtitlesSituationHand
	CS_quest[2] = SubtitlesSituationFoot
	CS_quest[3] = SubtitlesSituationBoob
	CS_quest[4] = SubtitlesSituationMasturbation
	CS_quest[5] = SubtitlesSituationFist
	CS_quest[6] = SubtitlesSituationCowgirl
	CS_quest[7] = SubtitlesSituationForeplay
	CS_quest[8] = SubtitlesSituationOral
	CS_quest[9] = SubtitlesSituationAnal
	CS_quest[10] = SubtitlesSituationVaginal
	CS_quest[11] = SubtitlesSituationEtc
	
	int num = 0
	while (num < SituationLength)
		(CS_quest[num] as SubtitleSituation).ClearAll()
		num += 1
	endwhile
EndFunction

; 字幕セットの準備
; bool Function importSubtitleSetInit()

bool Function importAll()
	int filecount = Storage.fileCount(1, 30, "../sexlabSubtitles/importSet")
	; debug.trace("# インポートするJSONファイルは合計" + filecount + "個存在しています")
	
	IS_name = Utility.CreateStringArray(0)
	IS_index = Utility.CreateIntArray(0)
	
	int stypeLength = CS_type.length
	If filecount > 0
		IS_name = Utility.CreateStringArray(filecount * stypeLength)
		IS_index = Utility.CreateIntArray(filecount * stypeLength)
	endif
	
	Storage.updateLists(1, 30, "../sexlabSubtitles/importSet", IS_name, IS_index)
	return Storage.importAll()
EndFunction

;デフォルト字幕のセット（Mod導入初回時のみ）
; Function defaultSSet()

;/
Function defaultSet()
	; debug.trace("# defaultSSet開始")
	int startset1 = IS_name.find("汎用和姦男女")
	int startset2 = IS_name.find("汎用オーラル受")
	int startset3 = IS_name.find("汎用喘ぎ女性のみ")
	int startset4 = IS_name.find("喘ぎ女性ハード")
	int startset5 = IS_name.find("男喘ぎ・女性積極的")
	int startset6 = IS_name.find("状況描写・女女")

	; インポート元のファイル番号
	int startindex1
	int startindex2
	int startindex3
	int startindex4
	int startindex5
	int startindex6
	
	If startset1 < 0
		startindex1 = 0
	else
		startindex1 = IS_index[startset1]
	endif
	If startset2 < 0
		startindex2 = 0
	else
		startindex2 = IS_index[startset2]
	endif
	If startset3 < 0
		startindex3 = 0
	else
		startindex3 = IS_index[startset3]
	endif
	If startset4 < 0
		startindex4 = 0
	else
		startindex4 = IS_index[startset4]
	endif
	If startset5 < 0
		startindex5 = 0
	else
		startindex5 = IS_index[startset5]
	endif
	If startset6 < 0
		startindex6 = 0
	else
		startindex6 = IS_index[startset6]
	endif

	; debug.trace("# 【汎用和姦男女】はimportSet" + startindex1)
	; debug.trace("# 【汎用オーラル受】はimportSet" + startindex2)
	; debug.trace("# 【汎用喘ぎ女性のみ】はimportSet" + startindex3)
	; debug.trace("# 【喘ぎ女性ハード】はimportSet" + startindex4)
	; debug.trace("# 【男喘ぎ・女性積極的】はimportSet" + startindex5)
	; debug.trace("# 【状況描写・女女】はimportSet" + startindex6)

	If startset1 >= 0
		string[] set1 = self.getStorageSubtitles(startset1, 1)
		string[] set2 = self.getStorageSubtitles(startset1, 2)
		string[] set3 = self.getStorageSubtitles(startset1, 3)
		string[] set4 = self.getStorageSubtitles(startset1, 4)
		string[] set5 = self.getStorageSubtitles(startset1, 5)
		self.updateSubtitles(12, set1, set2, set3, set4, set5)
		self.updateIndex(12, startindex1)
		self.setCSName(12, "汎用和姦男女")
		self.updateSubtitles(14, set1, set2, set3, set4, set5)
		self.updateIndex(14, startindex1)
		self.setCSName(14, "汎用和姦男女")
	endif
	If startset2 >= 0
		string[] set1 = self.getStorageSubtitles(startset2, 1)
		string[] set2 = self.getStorageSubtitles(startset2, 2)
		string[] set3 = self.getStorageSubtitles(startset2, 3)
		string[] set4 = self.getStorageSubtitles(startset2, 4)
		string[] set5 = self.getStorageSubtitles(startset2, 5)
		self.updateSubtitles(9, set1, set2, set3, set4, set5)
		self.updateSubtitles(10, set1, set2, set3, set4, set5)
		self.updateIndex(9, startindex2)
		self.updateIndex(10, startindex2)
		self.setCSName(9, "汎用オーラル受")
		self.setCSName(10, "汎用オーラル受")
	endif
	If startset3 >= 0
		string[] set1 = self.getStorageSubtitles(startset3, 1)
		string[] set2 = self.getStorageSubtitles(startset3, 2)
		string[] set3 = self.getStorageSubtitles(startset3, 3)
		string[] set4 = self.getStorageSubtitles(startset3, 4)
		string[] set5 = self.getStorageSubtitles(startset3, 5)
		self.updateSubtitles(1, set1, set2, set3, set4, set5)
		self.updateSubtitles(5, set1, set2, set3, set4, set5)
		self.updateIndex(1, startindex3)
		self.updateIndex(5, startindex3)
		self.setCSName(1, "汎用喘ぎ女性のみ")
		self.setCSName(5, "汎用喘ぎ女性のみ")
	endif
	If startset4 >= 0
		string[] set1 = self.getStorageSubtitles(startset4, 1)
		string[] set2 = self.getStorageSubtitles(startset4, 2)
		string[] set3 = self.getStorageSubtitles(startset4, 3)
		string[] set4 = self.getStorageSubtitles(startset4, 4)
		string[] set5 = self.getStorageSubtitles(startset4, 5)
		self.updateSubtitles(0, set1, set2, set3, set4, set5)
		self.updateSubtitles(6, set1, set2, set3, set4, set5)
		self.updateSubtitles(11, set1, set2, set3, set4, set5)
		self.updateSubtitles(13, set1, set2, set3, set4, set5)
		self.updateIndex(0, startindex4)
		self.updateIndex(6, startindex4)
		self.updateIndex(11, startindex4)
		self.updateIndex(13, startindex4)
		self.setCSName(0, "喘ぎ女性ハード")
		self.setCSName(6, "喘ぎ女性ハード")
		self.setCSName(11, "喘ぎ女性ハード")
		self.setCSName(13, "喘ぎ女性ハード")
	endif
	If startset5 >= 0
		string[] set1 = self.getStorageSubtitles(startset5, 1)
		string[] set2 = self.getStorageSubtitles(startset5, 2)
		string[] set3 = self.getStorageSubtitles(startset5, 3)
		string[] set4 = self.getStorageSubtitles(startset5, 4)
		string[] set5 = self.getStorageSubtitles(startset5, 5)
		self.updateSubtitles(2, set1, set2, set3, set4, set5)
		self.updateSubtitles(3, set1, set2, set3, set4, set5)
		self.updateSubtitles(4, set1, set2, set3, set4, set5)
		self.updateSubtitles(7, set1, set2, set3, set4, set5)
		self.updateSubtitles(8, set1, set2, set3, set4, set5)
		self.updateIndex(2, startindex5)
		self.updateIndex(3, startindex5)
		self.updateIndex(4, startindex5)
		self.updateIndex(7, startindex5)
		self.updateIndex(8, startindex5)
		self.setCSName(2, "男喘ぎ・女性積極的")
		self.setCSName(3, "男喘ぎ・女性積極的")
		self.setCSName(4, "男喘ぎ・女性積極的")
		self.setCSName(7, "男喘ぎ・女性積極的")
		self.setCSName(8, "男喘ぎ・女性積極的")
	endif
	If startset6 >= 0
		string[] set1 = self.getStorageSubtitles(startset6, 1)
		string[] set2 = self.getStorageSubtitles(startset6, 2)
		string[] set3 = self.getStorageSubtitles(startset6, 3)
		string[] set4 = self.getStorageSubtitles(startset6, 4)
		string[] set5 = self.getStorageSubtitles(startset6, 5)
		self.updateSubtitles(15, set1, set2, set3, set4, set5)
		self.updateSubtitles(16, set1, set2, set3, set4, set5)
		self.updateSubtitles(17, set1, set2, set3, set4, set5)
		self.updateSubtitles(18, set1, set2, set3, set4, set5)
		self.updateSubtitles(19, set1, set2, set3, set4, set5)
		self.updateSubtitles(20, set1, set2, set3, set4, set5)
		self.updateIndex(15, startindex6)
		self.updateIndex(16, startindex6)
		self.updateIndex(17, startindex6)
		self.updateIndex(18, startindex6)
		self.updateIndex(19, startindex6)
		self.updateIndex(20, startindex6)
		self.setCSName(15, "状況描写・女女")
		self.setCSName(16, "状況描写・女女")
		self.setCSName(17, "状況描写・女女")
		self.setCSName(18, "状況描写・女女")
		self.setCSName(19, "状況描写・女女")
		self.setCSName(20, "状況描写・女女")
	endif
EndFunction
/;

;汎用字幕セットの再セット（新しくインポートした字幕ファイルの内容を更新する）
; Function CSetAgain()

Function refresh()
	int i = 0
	string stype
	string title
	SubtitleSituation qstScript
	
	while (i < SituationLength)
		int stypeindex = CS_type.length
		
		while stypeindex >= 0
			stypeindex -= 1
			stype = CS_type[stypeindex]
			qstScript = CS_quest[i] as SubtitleSituation
			
			self._refreshSituation(i, qstScript, stype, false)
			self._refreshSituation(i, qstScript, stype, true)
		endwhile
		
		i += 1
	endwhile
EndFunction

Function _refreshSituation(int situation, SubtitleSituation qstScript, string stype, bool aggressive)
	int storageIndex = qstScript.getSubtitlesStorage(stype, aggressive)
	If (storageIndex != 0)
		string title = qstScript.getSubtitlesName(stype, aggressive)
		string[] set1 = Storage.getSubtitles(storageIndex, 1)
		string[] set2 = Storage.getSubtitles(storageIndex, 2)
		string[] set3 = Storage.getSubtitles(storageIndex, 3)
		string[] set4 = Storage.getSubtitles(storageIndex, 4)
		string[] set5 = Storage.getSubtitles(storageIndex, 5)
		self.updateSubtitles(situation, stype, aggressive, title, storageIndex, set1, set2, set3, set4, set5)
	endif
EndFunction

; 汎用字幕のセットのインポート元を保管する（ver2.1 インポート更新用）
; Function intoCSindex(int csnum, int importnum)
; Function updateIndex(int csnum, int importnum)
;	; debug.trace("# intoCSindex処理 - シチュエーション" + csnum + "はimportSet" + importnum)
;	CS_index[csnum] = importnum
; EndFunction

; 字幕セットを汎用セットの枠にセットする処理（5ステージ分まとめて）
; Function intoSSetToCS(int csnum, string stype, bool aggressive = false, string[] set1, string[] set2, string[] set3, string[] set4, string[] set5)

Function updateSubtitles(int situation, string stype, bool aggressive = false, string title, int sid, \
						 string[] set1, string[] set2, string[] set3, string[] set4, string[] set5)
	; debug.trace("# intoSSetToCS開始 " + stype)
	
	Quest qst = CS_quest[situation]
	(qst as SubtitleSituation).updateSubtitles(stype, aggressive, title, sid, set1, set2, set3, set4, set5)
endfunction

; 「字幕を表示しない」設定にした場合、該当の汎用セットを空にする
; Function intoCSempty(int csnum)

Function clearSubtitles(int situation, string stype, bool aggressive = false)
	(CS_quest[situation] as SubtitleSituation).clearSubtitles(stype, aggressive)
EndFunction

;字幕のセット名を汎用字幕のセット名配列に格納する
; Function setCSname(int situation, string name)
; Function setCSName(int csnum, string stype, bool aggressive = false, string name)
; 	common_setname[situation] = name
; EndFunction
; unused, now with updateSubtitles()

;シチュエーション番号から現在の字幕セット名を取得する
; string Function getNameCSname(int situation)

string Function getCSName(int situation, string stype, bool aggressive = false)
	return (CS_quest[situation] as SubtitleSituation).getSubtitlesName(stype, aggressive)
EndFunction

;字幕が非表示設定かどうかを調べる
; bool Function isCSdisable(int situation)

bool Function isDisable(int situation, string stype, bool aggressive = false)
	return (CS_quest[situation] as SubtitleSituation).getSubtitlesName(stype, aggressive) == "$SMENU_disble"
EndFunction

;シチュエーション番号と指定のステージ数から登録されている汎用の字幕セットを返す
; string[] Function getCSsetBySituation(int situation, string stype, bool aggressive = false, int stage)

string[] Function getSubtitles(int situation, string stype, bool aggressive = false, int stage)
	(CS_quest[situation] as SubtitleSituation).getSubtitles(stype, aggressive, stage)
EndFunction

; 指定のインデックス番号（num）の指定ステージの字幕セットを取得する
; string[] Function getSSetByIndex(int num, int stage)

string[] Function getStorageSubtitles(int num, int stage)
	return Storage.getSubtitles(IS_index[num], stage)
EndFunction

;インポート元の番号の字幕ファイルから字幕セットの名前を引き出す（ver2.1）
; String Function getSetnameImportNum(int importnum)

String Function _getSetName(int importnum)
	If importnum == 0
		return "$SMENU_disble"
	else
		int index = IS_index.find(importnum)
		; debug.trace("# importSet" + importnum + "のindexは" + index)
		If index >= 0
			return IS_name[index]
		else
			; debug.trace("# 指定のインポート番号のセット名は登録されていません")
			return "$SMENU_disble"
		endif
	endif
EndFunction


SubtitleStorage Property Storage auto

Quest Property SubtitlesSituation69  Auto  
Quest Property SubtitlesSituationHand  Auto  
Quest Property SubtitlesSituationFoot  Auto  
Quest Property SubtitlesSituationBoob  Auto  
Quest Property SubtitlesSituationMasturbation  Auto  
Quest Property SubtitlesSituationFist  Auto  
Quest Property SubtitlesSituationCowgirl  Auto  
Quest Property SubtitlesSituationForeplay  Auto  
Quest Property SubtitlesSituationOral  Auto  
Quest Property SubtitlesSituationAnal  Auto  
Quest Property SubtitlesSituationVaginal  Auto  
Quest Property SubtitlesSituationEtc  Auto  
