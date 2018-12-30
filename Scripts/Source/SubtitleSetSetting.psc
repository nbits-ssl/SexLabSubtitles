Scriptname SubtitleSetSetting extends Quest
{sexLab用 字幕セットのインポート・汎用字幕の設定}

string[] Property common_situation auto; シチュエーション名

string[] Property CS_type auto ; ["hetero", "homo", "creature"]
Quest[] Property CS_quest auto

string[] Property IS_name auto ; インポートした字幕のセット名
int[] Property IS_index auto ; インポートした字幕のファイル番号

int SituationLength = 12 ; but search this number in codes when you hope change

;/======================================
【汎用字幕12種】

0 69
1 Hand
2 Foot
3 Boob
4 Masturbation
5 Fist
6 Cowgirl
7 Foreplay
8 Oral
9 Anal
10 Vaginal
11 Etc
/;

; 汎用字幕ファイルの初期化
Function init()
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
bool Function importAll()
	int filecount = Storage.fileCount(1, 50, "../sexlabSubtitles/importSet")
	; debug.trace("# インポートするJSONファイルは合計" + filecount + "個存在しています")
	
	IS_name = Utility.CreateStringArray(0)
	IS_index = Utility.CreateIntArray(0)
	
	int stypeLength = CS_type.length
	If filecount > 0
		IS_name = Utility.CreateStringArray(filecount * stypeLength)
		IS_index = Utility.CreateIntArray(filecount * stypeLength)
	endif
	
	Storage.updateLists(1, 50, "../sexlabSubtitles/importSet", IS_name, IS_index)
	return Storage.importAll()
EndFunction

;デフォルト字幕のセット（Mod導入初回時のみ）
int Function _getDefaultSetStorageID(string title)
	int startset = IS_name.find(title)
	if (startset < 0)
		return 0
	else
		return IS_index[startset]
	endif
EndFunction

Function _setDefault(string title, int sid, string stype, bool aggressive)
	int setid = IS_name.Find(title)
	int strageid = self._getDefaultSetStorageID(setid)
	
	If setid >= 0
		string[] set1 = self.getStorageSubtitles(setid, 1)
		string[] set2 = self.getStorageSubtitles(setid, 2)
		string[] set3 = self.getStorageSubtitles(setid, 3)
		string[] set4 = self.getStorageSubtitles(setid, 4)
		string[] set5 = self.getStorageSubtitles(setid, 5)
		self.updateSubtitles(sid, stype, aggressive, title, strageid, set1, set2, set3, set4, set5)
	endif
EndFunction

Function defaultSet()
	; debug.trace("# defaultSSet開始")
	self._setDefault("#和姦 男女・膣", 10, "hetero", false)
	self._setDefault("#和姦 男女・アナル", 9, "hetero", false)
	self._setDefault("#和姦 男女・オーラル", 8, "hetero", false)
	self._setDefault("#和姦 両女・女攻め汎用", 7, "hetero", false)
	self._setDefault("#和姦 男女・騎乗位", 6, "hetero", false)
	self._setDefault("#和姦 男女・女受け汎用", 5, "hetero", false)
	self._setDefault("#和姦 両女・女攻め汎用", 3, "hetero", false)
	self._setDefault("#和姦 両女・女攻め汎用", 2, "hetero", false)
	self._setDefault("#和姦 両女・女攻め汎用", 1, "hetero", false)
	self._setDefault("#和姦 男女・オーラル", 0, "hetero", false)

	self._setDefault("#レイプ 男女・挿入", 10, "hetero", true)
	self._setDefault("#レイプ 男女・挿入", 9, "hetero", true)
	self._setDefault("#レイプ 男女・オーラル", 8, "hetero", true)
	self._setDefault("#レイプ 男女・汎用喘ぎ", 7, "hetero", true)
	self._setDefault("#レイプ 男女・挿入", 6, "hetero", true)
	self._setDefault("#レイプ 男女・汎用喘ぎ", 5, "hetero", true)
	self._setDefault("#レイプ 男女・汎用喘ぎ", 3, "hetero", true)
	self._setDefault("#レイプ 男女・汎用喘ぎ", 2, "hetero", true)
	self._setDefault("#レイプ 男女・汎用喘ぎ", 1, "hetero", true)
	self._setDefault("#レイプ 男女・オーラル", 0, "hetero", true)

	self._setDefault("#和姦 女女・挿入", 10, "homo", false)
	self._setDefault("#和姦 女女・挿入", 9, "homo", false)
	self._setDefault("#和姦 女女・オーラル", 8, "homo", false)
	self._setDefault("#和姦 両女・女攻め汎用", 7, "homo", false)
	self._setDefault("#和姦 女女・騎乗位", 6, "homo", false)
	self._setDefault("#和姦 女女・女受け汎用", 5, "homo", false)
	self._setDefault("#和姦 両女・女攻め汎用", 3, "homo", false)
	self._setDefault("#和姦 両女・女攻め汎用", 2, "homo", false)
	self._setDefault("#和姦 両女・女攻め汎用", 1, "homo", false)
	self._setDefault("#和姦 女女・オーラル", 0, "homo", false)

	self._setDefault("#レイプ 女女・挿入", 10, "homo", true)
	self._setDefault("#レイプ 女女・挿入", 9, "homo", true)
	self._setDefault("#レイプ 女女・オーラル", 8, "homo", true)
	self._setDefault("#レイプ 女女・汎用喘ぎ", 7, "homo", true)
	self._setDefault("#レイプ 女女・挿入", 6, "homo", true)
	self._setDefault("#レイプ 女女・汎用喘ぎ", 5, "homo", true)
	self._setDefault("#レイプ 女女・汎用喘ぎ", 3, "homo", true)
	self._setDefault("#レイプ 女女・汎用喘ぎ", 2, "homo", true)
	self._setDefault("#レイプ 女女・汎用喘ぎ", 1, "homo", true)
	self._setDefault("#レイプ 女女・オーラル", 0, "homo", true)

	self._setDefault("#和姦 男女・膣", 10, "creature", false)
	self._setDefault("#和姦 男女・アナル", 9, "creature", false)
	self._setDefault("#和姦 男女・オーラル", 8, "creature", false)
	self._setDefault("#和姦 両女・女攻め汎用", 7, "creature", false)
	self._setDefault("#和姦 男女・騎乗位", 6, "creature", false)
	self._setDefault("#和姦 男女・女受け汎用", 5, "creature", false)
	self._setDefault("#和姦 両女・女攻め汎用", 3, "creature", false)
	self._setDefault("#和姦 両女・女攻め汎用", 2, "creature", false)
	self._setDefault("#和姦 両女・女攻め汎用", 1, "creature", false)
	self._setDefault("#和姦 男女・オーラル", 0, "creature", false)

	self._setDefault("#レイプ 男女・挿入", 10, "creature", true)
	self._setDefault("#レイプ 男女・挿入", 9, "creature", true)
	self._setDefault("#レイプ 男女・オーラル", 8, "creature", true)
	self._setDefault("#レイプ 男女・汎用喘ぎ", 7, "creature", true)
	self._setDefault("#レイプ 男女・挿入", 6, "creature", true)
	self._setDefault("#レイプ 男女・汎用喘ぎ", 5, "creature", true)
	self._setDefault("#レイプ 男女・汎用喘ぎ", 3, "creature", true)
	self._setDefault("#レイプ 男女・汎用喘ぎ", 2, "creature", true)
	self._setDefault("#レイプ 男女・汎用喘ぎ", 1, "creature", true)
	self._setDefault("#レイプ 男女・オーラル", 0, "creature", true)

	self._setDefault("#自慰 女", 4, "homo", true)
	
EndFunction

;汎用字幕セットの再セット（新しくインポートした字幕ファイルの内容を更新する）
Function refresh()
	int i = 0
	string stype
	string title
	Quest qst
	SubtitleSituation qstScript
	
	while (i < SituationLength)
		int stypeindex = CS_type.length
		
		while stypeindex > 0
			stypeindex -= 1
			stype = CS_type[stypeindex]
			qst = CS_quest[i]
			; qst.Start()
			qstScript = qst as SubtitleSituation
			
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

; 字幕セットを汎用セットの枠にセットする処理（5ステージ分まとめて）
Function updateSubtitles(int situation, string stype, bool aggressive = false, string title, int sid, \
						 string[] set1, string[] set2, string[] set3, string[] set4, string[] set5)
	; debug.trace("# intoSSetToCS開始 " + stype)
	
	Quest qst = CS_quest[situation]
	(qst as SubtitleSituation).updateSubtitles(stype, aggressive, title, sid, set1, set2, set3, set4, set5)
endfunction

; 「字幕を表示しない」設定にした場合、該当の汎用セットを空にする
Function clearSubtitles(int situation, string stype, bool aggressive = false)
	(CS_quest[situation] as SubtitleSituation).clearSubtitles(stype, aggressive)
EndFunction

;シチュエーション番号から現在の字幕セット名を取得する
string Function getCSName(int situation, string stype, bool aggressive = false)
	return (CS_quest[situation] as SubtitleSituation).getSubtitlesName(stype, aggressive)
EndFunction

;字幕が非表示設定かどうかを調べる
bool Function isDisable(int situation, string stype, bool aggressive = false)
	return (CS_quest[situation] as SubtitleSituation).getSubtitlesName(stype, aggressive) == "$SMENU_disble"
EndFunction

;シチュエーション番号と指定のステージ数から登録されている汎用の字幕セットを返す
string[] Function getSubtitles(int situation, string stype, bool aggressive = false, int stage)
	return (CS_quest[situation] as SubtitleSituation).getSubtitles(stype, aggressive, stage)
EndFunction

; 指定のインデックス番号（num）の指定ステージの字幕セットを取得する
string[] Function getStorageSubtitles(int num, int stage)
	return Storage.getSubtitles(IS_index[num], stage)
EndFunction

;インポート元の番号の字幕ファイルから字幕セットの名前を引き出す（ver2.1）
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
