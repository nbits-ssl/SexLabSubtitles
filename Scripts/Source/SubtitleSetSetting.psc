Scriptname SubtitleSetSetting extends Quest
{sexLab用 字幕セットのインポート・汎用字幕の設定}

SubtitleStorage Property Storage auto

string[] Property common_setname auto;シチュエーションに適用されているセット名
string[] Property common_situation auto; シチュエーション名
int[] Property CS_index auto ; シチュエーションに適用されているセットのインポート元番号

string[] Property IS_name auto ; インポートした字幕のセット名
int[] Property IS_index auto ; インポートした字幕のファイル番号

; 汎用字幕ファイルの初期化
Function commonSetInit()
	common_setname = sslUtility.EmptyStringArray()
	common_situation = sslUtility.EmptyStringArray()
	common_setname = new string[21]
	common_situation = new string[21]
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
	common_situation[12] = "$CMODE_12"
	common_situation[13] = "$CMODE_13"
	common_situation[14] = "$CMODE_14"
	common_situation[15] = "$CMODE_15"
	common_situation[16] = "$CMODE_16"
	common_situation[17] = "$CMODE_17"
	common_situation[18] = "$CMODE_18"
	common_situation[19] = "$CMODE_19"
	common_situation[20] = "$CMODE_20"

	CS_index = sslUtility.EmptyIntArray()
	CS_index = new int[21]
	int num = 0
	while (num < 21)
		common_setname[num] = "$SMENU_disble"
		CS_index[num] = 0
		intoCSempty(num)
		num += 1
	endwhile
EndFunction

; 字幕セットの準備
bool Function importSubtitleSetInit()
	int filecount = Storage.fileCount(1, 30, "../sexlabSubtitles/importSet")
	; debug.trace("# インポートするJSONファイルは合計" + filecount + "個存在しています")
	IS_name = sslUtility.EmptyStringArray()
	IS_index = sslUtility.EmptyIntArray()
	
	If filecount > 0
		; IS_name =	PapyrusUtil.StringArray(filecount)
		; IS_index =	PapyrusUtil.IntArray(filecount)
		IS_name =	Utility.CreateStringArray(filecount)
		IS_index =	Utility.CreateIntArray(filecount)
	endif
	
	Storage.updateLists(1, 30, "../sexlabSubtitles/importSet", IS_name, IS_index)
	
	return Storage.importAll()
EndFunction

;デフォルト字幕のセット（Mod導入初回時のみ）
Function defaultSSet()
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
		string[] set1 = self.getSubtitles(startset1, 1)
		string[] set2 = self.getSubtitles(startset1, 2)
		string[] set3 = self.getSubtitles(startset1, 3)
		string[] set4 = self.getSubtitles(startset1, 4)
		string[] set5 = self.getSubtitles(startset1, 5)
		intoSSetToCS(12, set1, set2, set3, set4, set5)
		intoCSindex(12, startindex1)
		setNameCSname(12, "汎用和姦男女")
		intoSSetToCS(14, set1, set2, set3, set4, set5)
		intoCSindex(14, startindex1)
		setNameCSname(14, "汎用和姦男女")
	endif
	If startset2 >= 0
		string[] set1 = self.getSubtitles(startset2, 1)
		string[] set2 = self.getSubtitles(startset2, 2)
		string[] set3 = self.getSubtitles(startset2, 3)
		string[] set4 = self.getSubtitles(startset2, 4)
		string[] set5 = self.getSubtitles(startset2, 5)
		intoSSetToCS(9, set1, set2, set3, set4, set5)
		intoSSetToCS(10, set1, set2, set3, set4, set5)
		intoCSindex(9, startindex2)
		intoCSindex(10, startindex2)
		setNameCSname(9, "汎用オーラル受")
		setNameCSname(10, "汎用オーラル受")
	endif
	If startset3 >= 0
		string[] set1 = self.getSubtitles(startset3, 1)
		string[] set2 = self.getSubtitles(startset3, 2)
		string[] set3 = self.getSubtitles(startset3, 3)
		string[] set4 = self.getSubtitles(startset3, 4)
		string[] set5 = self.getSubtitles(startset3, 5)
		intoSSetToCS(1, set1, set2, set3, set4, set5)
		intoSSetToCS(5, set1, set2, set3, set4, set5)
		intoCSindex(1, startindex3)
		intoCSindex(5, startindex3)
		setNameCSname(1, "汎用喘ぎ女性のみ")
		setNameCSname(5, "汎用喘ぎ女性のみ")
	endif
	If startset4 >= 0
		string[] set1 = self.getSubtitles(startset4, 1)
		string[] set2 = self.getSubtitles(startset4, 2)
		string[] set3 = self.getSubtitles(startset4, 3)
		string[] set4 = self.getSubtitles(startset4, 4)
		string[] set5 = self.getSubtitles(startset4, 5)
		intoSSetToCS(0, set1, set2, set3, set4, set5)
		intoSSetToCS(6, set1, set2, set3, set4, set5)
		intoSSetToCS(11, set1, set2, set3, set4, set5)
		intoSSetToCS(13, set1, set2, set3, set4, set5)
		intoCSindex(0, startindex4)
		intoCSindex(6, startindex4)
		intoCSindex(11, startindex4)
		intoCSindex(13, startindex4)
		setNameCSname(0, "喘ぎ女性ハード")
		setNameCSname(6, "喘ぎ女性ハード")
		setNameCSname(11, "喘ぎ女性ハード")
		setNameCSname(13, "喘ぎ女性ハード")
	endif
	If startset5 >= 0
		string[] set1 = self.getSubtitles(startset5, 1)
		string[] set2 = self.getSubtitles(startset5, 2)
		string[] set3 = self.getSubtitles(startset5, 3)
		string[] set4 = self.getSubtitles(startset5, 4)
		string[] set5 = self.getSubtitles(startset5, 5)
		intoSSetToCS(2, set1, set2, set3, set4, set5)
		intoSSetToCS(3, set1, set2, set3, set4, set5)
		intoSSetToCS(4, set1, set2, set3, set4, set5)
		intoSSetToCS(7, set1, set2, set3, set4, set5)
		intoSSetToCS(8, set1, set2, set3, set4, set5)
		intoCSindex(2, startindex5)
		intoCSindex(3, startindex5)
		intoCSindex(4, startindex5)
		intoCSindex(7, startindex5)
		intoCSindex(8, startindex5)
		setNameCSname(2, "男喘ぎ・女性積極的")
		setNameCSname(3, "男喘ぎ・女性積極的")
		setNameCSname(4, "男喘ぎ・女性積極的")
		setNameCSname(7, "男喘ぎ・女性積極的")
		setNameCSname(8, "男喘ぎ・女性積極的")
	endif
	If startset6 >= 0
		string[] set1 = self.getSubtitles(startset6, 1)
		string[] set2 = self.getSubtitles(startset6, 2)
		string[] set3 = self.getSubtitles(startset6, 3)
		string[] set4 = self.getSubtitles(startset6, 4)
		string[] set5 = self.getSubtitles(startset6, 5)
		intoSSetToCS(15, set1, set2, set3, set4, set5)
		intoSSetToCS(16, set1, set2, set3, set4, set5)
		intoSSetToCS(17, set1, set2, set3, set4, set5)
		intoSSetToCS(18, set1, set2, set3, set4, set5)
		intoSSetToCS(19, set1, set2, set3, set4, set5)
		intoSSetToCS(20, set1, set2, set3, set4, set5)
		intoCSindex(15, startindex6)
		intoCSindex(16, startindex6)
		intoCSindex(17, startindex6)
		intoCSindex(18, startindex6)
		intoCSindex(19, startindex6)
		intoCSindex(20, startindex6)
		setNameCSname(15, "状況描写・女女")
		setNameCSname(16, "状況描写・女女")
		setNameCSname(17, "状況描写・女女")
		setNameCSname(18, "状況描写・女女")
		setNameCSname(19, "状況描写・女女")
		setNameCSname(20, "状況描写・女女")
	endif
EndFunction

;汎用字幕セットの再セット（新しくインポートした字幕ファイルの内容を更新する）
Function CSetAgain()
	int i = 0
	while (i < 21)
		string d_situation = 	common_situation[i]
		int d_index = CS_index[i]
		If !(d_index == 0)
			string[] set1 = Storage.getSubtitles(d_index, 1)
			string[] set2 = Storage.getSubtitles(d_index, 2)
			string[] set3 = Storage.getSubtitles(d_index, 3)
			string[] set4 = Storage.getSubtitles(d_index, 4)
			string[] set5 = Storage.getSubtitles(d_index, 5)
			intoSSetToCS(i, set1, set2, set3, set4, set5)
			intoCSindex(i, d_index)
			common_setname[i] = getSetnameImportNum(d_index)
		endif
		; debug.trace("# " + d_situation + "の字幕のインポート元：importSet" + d_index + "を" + common_setname[i] + "に更新しました")
		i += 1
	endwhile
EndFunction

;/===========================================================
	【汎用字幕21種】v2.2

	; 0 - creature
	; 1 - arrok69
	; 2 - handjob
	; 3 - footjob
	; 4 - boobjob
	; 5 - masturbation
	; 6 - fisting
	; 7 - cowgirl
	; 8 - foreplay

	; 15 - agg_oral_s (samesex)
	; 16 - oral_s (samesex)
	; 17 - agg_anal_s (samesex)
	; 18 - anal_s (samesex)
	; 19 - agg_missionary_s (samesex)
	; 20 - missonary_s (samesex)

	; 9 - agg_oral
	; 10 - oral
	; 13 - agg_anal
	; 14 - anal
	; 11 - agg_missionary
	; 12 - missonary

/;
; 汎用字幕セット
	;v2.2 added
	string[] common_agg_oral_s_1
	string[] common_agg_oral_s_2
	string[] common_agg_oral_s_3
	string[] common_agg_oral_s_4
	string[] common_agg_oral_s_5
	string[] common_oral_s_1
	string[] common_oral_s_2
	string[] common_oral_s_3
	string[] common_oral_s_4
	string[] common_oral_s_5
	string[] common_agg_anal_s_1
	string[] common_agg_anal_s_2
	string[] common_agg_anal_s_3
	string[] common_agg_anal_s_4
	string[] common_agg_anal_s_5
	string[] common_anal_s_1
	string[] common_anal_s_2
	string[] common_anal_s_3
	string[] common_anal_s_4
	string[] common_anal_s_5
	string[] common_agg_missionary_s_1
	string[] common_agg_missionary_s_2
	string[] common_agg_missionary_s_3
	string[] common_agg_missionary_s_4
	string[] common_agg_missionary_s_5
	string[] common_missionary_s_1
	string[] common_missionary_s_2
	string[] common_missionary_s_3
	string[] common_missionary_s_4
	string[] common_missionary_s_5
	string[] common_agg_anal_1
	string[] common_agg_anal_2
	string[] common_agg_anal_3
	string[] common_agg_anal_4
	string[] common_agg_anal_5
	string[] common_anal_1
	string[] common_anal_2
	string[] common_anal_3
	string[] common_anal_4
	string[] common_anal_5
	;v2.0
	string[] common_creature_1
	string[] common_creature_2
	string[] common_creature_3
	string[] common_creature_4
	string[] common_creature_5
	string[] common_69_1
	string[] common_69_2
	string[] common_69_3
	string[] common_69_4
	string[] common_69_5
	string[] common_handjob_1
	string[] common_handjob_2
	string[] common_handjob_3
	string[] common_handjob_4
	string[] common_handjob_5
	string[] common_footjob_1
	string[] common_footjob_2
	string[] common_footjob_3
	string[] common_footjob_4
	string[] common_footjob_5
	string[] common_boobjob_1
	string[] common_boobjob_2
	string[] common_boobjob_3
	string[] common_boobjob_4
	string[] common_boobjob_5
	string[] common_masturbation_1
	string[] common_masturbation_2
	string[] common_masturbation_3
	string[] common_masturbation_4
	string[] common_masturbation_5
	string[] common_fisting_1
	string[] common_fisting_2
	string[] common_fisting_3
	string[] common_fisting_4
	string[] common_fisting_5
	string[] common_cowgirl_1
	string[] common_cowgirl_2
	string[] common_cowgirl_3
	string[] common_cowgirl_4
	string[] common_cowgirl_5
	string[] common_agg_oral_1
	string[] common_agg_oral_2
	string[] common_agg_oral_3
	string[] common_agg_oral_4
	string[] common_agg_oral_5
	string[] common_oral_1
	string[] common_oral_2
	string[] common_oral_3
	string[] common_oral_4
	string[] common_oral_5
	string[] common_foreplay_1
	string[] common_foreplay_2
	string[] common_foreplay_3
	string[] common_foreplay_4
	string[] common_foreplay_5
	string[] common_agg_missionary_1
	string[] common_agg_missionary_2
	string[] common_agg_missionary_3
	string[] common_agg_missionary_4
	string[] common_agg_missionary_5
	string[] common_missionary_1
	string[] common_missionary_2
	string[] common_missionary_3
	string[] common_missionary_4
	string[] common_missionary_5

; 汎用字幕のセットのインポート元を保管する（ver2.1 インポート更新用）
Function intoCSindex(int csnum, int importnum)
	; debug.trace("# intoCSindex処理 - シチュエーション" + csnum + "はimportSet" + importnum)
	CS_index[csnum] = importnum
EndFunction

; 字幕セットを汎用セットの枠にセットする処理（5ステージ分まとめて）
Function intoSSetToCS(int csnum, string[] set1, string[] set2, string[] set3, string[] set4, string[] set5)
	; debug.trace("# intoSSetToCS開始")
	If csnum == 0
		common_creature_1 = set1
		common_creature_2 = set2
		common_creature_3 = set3
		common_creature_4 = set4
		common_creature_5 = set5
	elseif csnum == 1
		common_69_1 = set1
		common_69_2 = set2
		common_69_3 = set3
		common_69_4 = set4
		common_69_5 = set5
	elseif csnum == 2
		common_handjob_1 = set1
		common_handjob_2 = set2
		common_handjob_3 = set3
		common_handjob_4 = set4
		common_handjob_5 = set5
	elseif csnum == 3
		common_footjob_1 = set1
		common_footjob_2 = set2
		common_footjob_3 = set3
		common_footjob_4 = set4
		common_footjob_5 = set5
	elseif csnum == 4
		common_boobjob_1 = set1
		common_boobjob_2 = set2
		common_boobjob_3 = set3
		common_boobjob_4 = set4
		common_boobjob_5 = set5
	elseif csnum == 5
		common_masturbation_1 = set1
		common_masturbation_2 = set2
		common_masturbation_3 = set3
		common_masturbation_4 = set4
		common_masturbation_5 = set5
	elseif csnum == 6
		common_fisting_1 = set1
		common_fisting_2 = set2
		common_fisting_3 = set3
		common_fisting_4 = set4
		common_fisting_5 = set5
	elseif csnum == 7
		common_cowgirl_1 = set1
		common_cowgirl_2 = set2
		common_cowgirl_3 = set3
		common_cowgirl_4 = set4
		common_cowgirl_5 = set5
	elseif csnum == 8
		common_foreplay_1 = set1
		common_foreplay_2 = set2
		common_foreplay_3 = set3
		common_foreplay_4 = set4
		common_foreplay_5 = set5
	elseif csnum == 9
		common_agg_oral_1 = set1
		common_agg_oral_2 = set2
		common_agg_oral_3 = set3
		common_agg_oral_4 = set4
		common_agg_oral_5 = set5
	elseif csnum == 10
		common_oral_1 = set1
		common_oral_2 = set2
		common_oral_3 = set3
		common_oral_4 = set4
		common_oral_5 = set5
	elseif csnum == 11
		common_agg_missionary_1 = set1
		common_agg_missionary_2 = set2
		common_agg_missionary_3 = set3
		common_agg_missionary_4 = set4
		common_agg_missionary_5 = set5
	elseif csnum == 12
		common_missionary_1 = set1
		common_missionary_2 = set2
		common_missionary_3 = set3
		common_missionary_4 = set4
		common_missionary_5 = set5
	elseif csnum == 13
		common_agg_anal_1 = set1
		common_agg_anal_2 = set2
		common_agg_anal_3 = set3
		common_agg_anal_4 = set4
		common_agg_anal_5 = set5
	elseif csnum == 14
		common_anal_1 = set1
		common_anal_2 = set2
		common_anal_3 = set3
		common_anal_4 = set4
		common_anal_5 = set5
	elseif csnum == 15
		common_agg_oral_s_1= set1
		common_agg_oral_s_2= set2
		common_agg_oral_s_3= set3
		common_agg_oral_s_4= set4
		common_agg_oral_s_5= set5
	elseif csnum == 16
		common_oral_s_1= set1
		common_oral_s_2= set2
		common_oral_s_3= set3
		common_oral_s_4= set4
		common_oral_s_5= set5
	elseif csnum == 17
		common_agg_anal_s_1= set1
		common_agg_anal_s_2= set2
		common_agg_anal_s_3= set3
		common_agg_anal_s_4= set4
		common_agg_anal_s_5= set5
	elseif csnum == 18
		common_anal_s_1= set1
		common_anal_s_2= set2
		common_anal_s_3= set3
		common_anal_s_4= set4
		common_anal_s_5= set5
	elseif csnum == 19
		common_agg_missionary_s_1= set1
		common_agg_missionary_s_2= set2
		common_agg_missionary_s_3= set3
		common_agg_missionary_s_4= set4
		common_agg_missionary_s_5= set5
	elseif csnum == 20
		common_missionary_s_1= set1
		common_missionary_s_2= set2
		common_missionary_s_3= set3
		common_missionary_s_4= set4
		common_missionary_s_5= set5
	else
		debug.trace("@  intoCommonSetByNum - 指定の汎用セット名が不正です")
	endIf
endfunction

; 「字幕を表示しない」設定にした場合、該当の汎用セットを空にする
Function intoCSempty(int csnum)
	string[] empty
	intoSSetToCS(csnum, empty, empty, empty, empty, empty)
EndFunction

;字幕のセット名を汎用字幕のセット名配列に格納する
Function setNameCSname(int situation, string name)
	common_setname[situation] = name
EndFunction

;シチュエーション番号から現在の字幕セット名を取得する
string Function getNameCSname(int situation)
	return common_setname[situation]
EndFunction

;字幕が非表示設定かどうかを調べる
bool Function isCSdisable(int situation)
	If common_setname[situation] == "$SMENU_disble"
		return true
	else
		return false
	endIf
EndFunction

;シチュエーション番号と指定のステージ数から登録されている汎用の字幕セットを返す
string[] Function getCSsetBySituation(int situation, int stage)
	If situation == 0
		If stage == 1
			return common_creature_1
		elseIf stage == 2
			return common_creature_2
		elseIf stage == 3
			return common_creature_3
		elseIf stage == 4
			return common_creature_4
		elseIf stage == 5
			return common_creature_5
		endIf
	elseif situation == 1
		If stage == 1
			return common_69_1
		elseIf stage == 2
			return common_69_2
		elseIf stage == 3
			return common_69_3
		elseIf stage == 4
			return common_69_4
		elseIf stage == 5
			return common_69_5
		endIf
	elseif situation == 2
		If stage == 1
			return common_handjob_1
		elseIf stage == 2
			return common_handjob_2
		elseIf stage == 3
			return common_handjob_3
		elseIf stage == 4
			return common_handjob_4
		elseIf stage == 5
			return common_handjob_5
		endIf
	elseif situation == 3
		If stage == 1
			return common_footjob_1
		elseIf stage == 2
			return common_footjob_2
		elseIf stage == 3
			return common_footjob_3
		elseIf stage == 4
			return common_footjob_4
		elseIf stage == 5
			return common_footjob_5
		endIf
	elseif situation == 4
		If stage == 1
			return common_boobjob_1
		elseIf stage == 2
			return common_boobjob_2
		elseIf stage == 3
			return common_boobjob_3
		elseIf stage == 4
			return common_boobjob_4
		elseIf stage == 5
			return common_boobjob_5
		endIf
	elseif situation == 5
		If stage == 1
			return common_masturbation_1
		elseIf stage == 2
			return common_masturbation_2
		elseIf stage == 3
			return common_masturbation_3
		elseIf stage == 4
			return common_masturbation_4
		elseIf stage == 5
			return common_masturbation_5
		endIf
	elseif situation == 6
		If stage == 1
			return common_fisting_1
		elseIf stage == 2
			return common_fisting_2
		elseIf stage == 3
			return common_fisting_3
		elseIf stage == 4
			return common_fisting_4
		elseIf stage == 5
			return common_fisting_5
		endIf
	elseif situation == 7
		If stage == 1
			return common_cowgirl_1
		elseIf stage == 2
			return common_cowgirl_2
		elseIf stage == 3
			return common_cowgirl_3
		elseIf stage == 4
			return common_cowgirl_4
		elseIf stage == 5
			return common_cowgirl_5
		endIf
	elseif situation == 8
		If stage == 1
			return common_foreplay_1
		elseIf stage == 2
			return common_foreplay_2
		elseIf stage == 3
			return common_foreplay_3
		elseIf stage == 4
			return common_foreplay_4
		elseIf stage == 5
			return common_foreplay_5
		endIf
	elseif situation == 9
		If stage == 1
			return common_agg_oral_1
		elseIf stage == 2
			return common_agg_oral_2
		elseIf stage == 3
			return common_agg_oral_3
		elseIf stage == 4
			return common_agg_oral_4
		elseIf stage == 5
			return common_agg_oral_5
		endIf
	elseif situation == 10
		If stage == 1
			return common_oral_1
		elseIf stage == 2
			return common_oral_2
		elseIf stage == 3
			return common_oral_3
		elseIf stage == 4
			return common_oral_4
		elseIf stage == 5
			return common_oral_5
		endIf
	elseif situation == 11
		If stage == 1
			return common_agg_missionary_1
		elseIf stage == 2
			return common_agg_missionary_2
		elseIf stage == 3
			return common_agg_missionary_3
		elseIf stage == 4
			return common_agg_missionary_4
		elseIf stage == 5
			return common_agg_missionary_5
		endIf
	elseif situation == 12
		If stage == 1
			return common_missionary_1
		elseIf stage == 2
			return common_missionary_2
		elseIf stage == 3
			return common_missionary_3
		elseIf stage == 4
			return common_missionary_4
		elseIf stage == 5
			return common_missionary_5
		endIf
	elseif situation == 13
		If stage == 1
			return common_agg_anal_1
		elseIf stage == 2
			return common_agg_anal_2
		elseIf stage == 3
			return common_agg_anal_3
		elseIf stage == 4
			return common_agg_anal_4
		elseIf stage == 5
			return common_agg_anal_5
		endIf
	elseif situation == 14
		If stage == 1
			return common_anal_1
		elseIf stage == 2
			return common_anal_2
		elseIf stage == 3
			return common_anal_3
		elseIf stage == 4
			return common_anal_4
		elseIf stage == 5
			return common_anal_5
		endIf
	elseif situation == 15
		If stage == 1
			return common_agg_oral_s_1
		elseIf stage == 2
			return common_agg_oral_s_2
		elseIf stage == 3
			return common_agg_oral_s_3
		elseIf stage == 4
			return common_agg_oral_s_4
		elseIf stage == 5
			return common_agg_oral_s_5
		endIf
	elseif situation == 16
		If stage == 1
			return common_oral_s_1
		elseIf stage == 2
			return common_oral_s_2
		elseIf stage == 3
			return common_oral_s_3
		elseIf stage == 4
			return common_oral_s_4
		elseIf stage == 5
			return common_oral_s_5
		endIf
	elseif situation == 17
		If stage == 1
			return common_agg_anal_s_1
		elseIf stage == 2
			return common_agg_anal_s_2
		elseIf stage == 3
			return common_agg_anal_s_3
		elseIf stage == 4
			return common_agg_anal_s_4
		elseIf stage == 5
			return common_agg_anal_s_5
		endIf
	elseif situation == 18
		If stage == 1
			return common_anal_s_1
		elseIf stage == 2
			return common_anal_s_2
		elseIf stage == 3
			return common_anal_s_3
		elseIf stage == 4
			return common_anal_s_4
		elseIf stage == 5
			return common_anal_s_5
		endIf
	elseif situation == 19
		If stage == 1
			return common_agg_missionary_s_1
		elseIf stage == 2
			return common_agg_missionary_s_2
		elseIf stage == 3
			return common_agg_missionary_s_3
		elseIf stage == 4
			return common_agg_missionary_s_4
		elseIf stage == 5
			return common_agg_missionary_s_5
		endIf
	elseif situation == 20
		If stage == 1
			return common_missionary_s_1
		elseIf stage == 2
			return common_missionary_s_2
		elseIf stage == 3
			return common_missionary_s_3
		elseIf stage == 4
			return common_missionary_s_4
		elseIf stage == 5
			return common_missionary_s_5
		endIf
	else
		debug.trace("@  getCSsetBySituation - 指定の汎用セット名が不正です")
	endIf
EndFunction

;---------------------------------------------------------------------------
; 指定のインデックス番号（num）の指定ステージの字幕セットを取得する
; string[] Function getSSetByIndex(int num, int stage)
string[] Function getSubtitles(int num, int stage)
	return Storage.getSubtitles(IS_index[num], stage)
EndFunction

;インポート元の番号の字幕ファイルから字幕セットの名前を引き出す（ver2.1）
String Function getSetnameImportNum(int importnum)
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

