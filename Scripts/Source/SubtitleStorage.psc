Scriptname SubtitleStorage extends Quest  

string endcode = "#ssend" ; 終了タグ

; ファイルパス（filePath）の末尾数字startnumからmaxnumのファイルの有無を調べ総数をカウントする
; int Function importJSONfileCount(int startnum, int maxnum, string filePath)
int Function fileCount(int startnum, int maxnum, string filePath)
	int i = startnum
	int count = 0
	while (i < maxnum + 1)
		string file = filePath + i + ".json"
		If JsonUtil.Load(file)
			count += 1
		endIf
		i += 1
	endwhile
	return count
EndFunction

;ファイルパス（filePath）の末尾数字startnum-maxnumのファイルからセット名とファイル番号を指定の配列に取得する
; Function importSSetToNameAndIndex(int startnum, int maxnum, string filePath, string[] names, int[] ids)
Function updateLists(int startnum, int maxnum, string filePath, string[] names, int[] ids)
	int i = startnum
	int r = 0
	while (i < maxnum + 1)
		string file = filePath + i + ".json"
		If JsonUtil.Load(file)
			names[r] = JsonUtil.StringListGet(file, "import_name", 0)
			ids[r] = i
			r += 1
		endIf
		i += 1
	endwhile
EndFunction

; ファイルの有無に関わらず1-30番までのファイルの字幕セットを取得する
; bool Function setImportSSet()
bool Function importAll()
	IS1_1 = self._importSSet(1,1)
	IS1_2 = self._importSSet(1,2)
	IS1_3 = self._importSSet(1,3)
	IS1_4 = self._importSSet(1,4)
	IS1_5 = self._importSSet(1,5)
	IS2_1 = self._importSSet(2,1)
	IS2_2 = self._importSSet(2,2)
	IS2_3 = self._importSSet(2,3)
	IS2_4 = self._importSSet(2,4)
	IS2_5 = self._importSSet(2,5)
	IS3_1 = self._importSSet(3,1)
	IS3_2 = self._importSSet(3,2)
	IS3_3 = self._importSSet(3,3)
	IS3_4 = self._importSSet(3,4)
	IS3_5 = self._importSSet(3,5)
	IS4_1 = self._importSSet(4,1)
	IS4_2 = self._importSSet(4,2)
	IS4_3 = self._importSSet(4,3)
	IS4_4 = self._importSSet(4,4)
	IS4_5 = self._importSSet(4,5)
	IS5_1 = self._importSSet(5,1)
	IS5_2 = self._importSSet(5,2)
	IS5_3 = self._importSSet(5,3)
	IS5_4 = self._importSSet(5,4)
	IS5_5 = self._importSSet(5,5)
	IS6_1 = self._importSSet(6,1)
	IS6_2 = self._importSSet(6,2)
	IS6_3 = self._importSSet(6,3)
	IS6_4 = self._importSSet(6,4)
	IS6_5 = self._importSSet(6,5)
	IS7_1 = self._importSSet(7,1)
	IS7_2 = self._importSSet(7,2)
	IS7_3 = self._importSSet(7,3)
	IS7_4 = self._importSSet(7,4)
	IS7_5 = self._importSSet(7,5)
	IS8_1 = self._importSSet(8,1)
	IS8_2 = self._importSSet(8,2)
	IS8_3 = self._importSSet(8,3)
	IS8_4 = self._importSSet(8,4)
	IS8_5 = self._importSSet(8,5)
	IS9_1 = self._importSSet(9,1)
	IS9_2 = self._importSSet(9,2)
	IS9_3 = self._importSSet(9,3)
	IS9_4 = self._importSSet(9,4)
	IS9_5 = self._importSSet(9,5)
	IS10_1 = self._importSSet(10,1)
	IS10_2 = self._importSSet(10,2)
	IS10_3 = self._importSSet(10,3)
	IS10_4 = self._importSSet(10,4)
	IS10_5 = self._importSSet(10,5)
	IS11_1 = self._importSSet(11,1)
	IS11_2 = self._importSSet(11,2)
	IS11_3 = self._importSSet(11,3)
	IS11_4 = self._importSSet(11,4)
	IS11_5 = self._importSSet(11,5)
	IS12_1 = self._importSSet(12,1)
	IS12_2 = self._importSSet(12,2)
	IS12_3 = self._importSSet(12,3)
	IS12_4 = self._importSSet(12,4)
	IS12_5 = self._importSSet(12,5)
	IS13_1 = self._importSSet(13,1)
	IS13_2 = self._importSSet(13,2)
	IS13_3 = self._importSSet(13,3)
	IS13_4 = self._importSSet(13,4)
	IS13_5 = self._importSSet(13,5)
	IS14_1 = self._importSSet(14,1)
	IS14_2 = self._importSSet(14,2)
	IS14_3 = self._importSSet(14,3)
	IS14_4 = self._importSSet(14,4)
	IS14_5 = self._importSSet(14,5)
	IS15_1 = self._importSSet(15,1)
	IS15_2 = self._importSSet(15,2)
	IS15_3 = self._importSSet(15,3)
	IS15_4 = self._importSSet(15,4)
	IS15_5 = self._importSSet(15,5)
	IS16_1 = self._importSSet(16,1)
	IS16_2 = self._importSSet(16,2)
	IS16_3 = self._importSSet(16,3)
	IS16_4 = self._importSSet(16,4)
	IS16_5 = self._importSSet(16,5)
	IS17_1 = self._importSSet(17,1)
	IS17_2 = self._importSSet(17,2)
	IS17_3 = self._importSSet(17,3)
	IS17_4 = self._importSSet(17,4)
	IS17_5 = self._importSSet(17,5)
	IS18_1 = self._importSSet(18,1)
	IS18_2 = self._importSSet(18,2)
	IS18_3 = self._importSSet(18,3)
	IS18_4 = self._importSSet(18,4)
	IS18_5 = self._importSSet(18,5)
	IS19_1 = self._importSSet(19,1)
	IS19_2 = self._importSSet(19,2)
	IS19_3 = self._importSSet(19,3)
	IS19_4 = self._importSSet(19,4)
	IS19_5 = self._importSSet(19,5)
	IS20_1 = self._importSSet(20,1)
	IS20_2 = self._importSSet(20,2)
	IS20_3 = self._importSSet(20,3)
	IS20_4 = self._importSSet(20,4)
	IS20_5 = self._importSSet(20,5)
	IS21_1 = self._importSSet(21,1)
	IS21_2 = self._importSSet(21,2)
	IS21_3 = self._importSSet(21,3)
	IS21_4 = self._importSSet(21,4)
	IS21_5 = self._importSSet(21,5)
	IS22_1 = self._importSSet(22,1)
	IS22_2 = self._importSSet(22,2)
	IS22_3 = self._importSSet(22,3)
	IS22_4 = self._importSSet(22,4)
	IS22_5 = self._importSSet(22,5)
	IS23_1 = self._importSSet(23,1)
	IS23_2 = self._importSSet(23,2)
	IS23_3 = self._importSSet(23,3)
	IS23_4 = self._importSSet(23,4)
	IS23_5 = self._importSSet(23,5)
	IS24_1 = self._importSSet(24,1)
	IS24_2 = self._importSSet(24,2)
	IS24_3 = self._importSSet(24,3)
	IS24_4 = self._importSSet(24,4)
	IS24_5 = self._importSSet(24,5)
	IS25_1 = self._importSSet(25,1)
	IS25_2 = self._importSSet(25,2)
	IS25_3 = self._importSSet(25,3)
	IS25_4 = self._importSSet(25,4)
	IS25_5 = self._importSSet(25,5)
	IS26_1 = self._importSSet(26,1)
	IS26_2 = self._importSSet(26,2)
	IS26_3 = self._importSSet(26,3)
	IS26_4 = self._importSSet(26,4)
	IS26_5 = self._importSSet(26,5)
	IS27_1 = self._importSSet(27,1)
	IS27_2 = self._importSSet(27,2)
	IS27_3 = self._importSSet(27,3)
	IS27_4 = self._importSSet(27,4)
	IS27_5 = self._importSSet(27,5)
	IS28_1 = self._importSSet(28,1)
	IS28_2 = self._importSSet(28,2)
	IS28_3 = self._importSSet(28,3)
	IS28_4 = self._importSSet(28,4)
	IS28_5 = self._importSSet(28,5)
	IS29_1 = self._importSSet(29,1)
	IS29_2 = self._importSSet(29,2)
	IS29_3 = self._importSSet(29,3)
	IS29_4 = self._importSSet(29,4)
	IS29_5 = self._importSSet(29,5)
	IS30_1 = self._importSSet(30,1)
	IS30_2 = self._importSSet(30,2)
	IS30_3 = self._importSSet(30,3)
	IS30_4 = self._importSSet(30,4)
	IS30_5 = self._importSSet(30,5)
	return true
EndFunction

;指定の番号（num）のファイルから、指定ステージの字幕テキストを配列として取得する
string [] Function _importSSet(int num, int stage)
	return self._importSSetFromFile(num, stage, "../sexlabSubtitles/importSet")
EndFunction
string [] Function _importSSetFromFile(int num, int stage, string filePath)
	string file = filePath + num + ".json"
	If !JsonUtil.Load(file)
		return sslUtility.EmptyStringArray()
	else
		if (0 < stage && stage <= 5)
			string stagekey = "import_stage" + stage as string
			int len = JsonUtil.StringListFind(file, stagekey, endcode)
			; debug.trace("# importSet" + num + "のstage1のセリフは" + len + "です")
			string[] isset = Utility.CreateStringArray(len) ; v2.4 fix
			int i = 0
			while (i < len)
				isset[i] = JsonUtil.StringListGet(file, stagekey, i)
				i += 1
			endwhile
			; debug.trace("# stage1は" + isset)
			return isset
		else
			debug.trace("@ [Sexlab Subtitles] - importSSet - stageの指定が不正です")
		endif
		; debug.trace("# importSet" + num + "のインポートが完了しました")
	endif
EndFunction

; 指定のインポート元（index）の指定ステージの字幕セットを取得する
; string[] Function getSSetByIndex2(int index, int stage)
string[] Function getSubtitles(int index, int stage)
	If index == 1
		If stage == 1
			return IS1_1
		elseif stage == 2
			return IS1_2
		elseif stage == 3
			return IS1_3
		elseif stage == 4
			return IS1_4
		elseif stage == 5
			return IS1_5
		endif
	elseif index == 2
		If stage == 1
			return IS2_1
		elseif stage == 2
			return IS2_2
		elseif stage == 3
			return IS2_3
		elseif stage == 4
			return IS2_4
		elseif stage == 5
			return IS2_5
		endif
	elseif index == 3
		If stage == 1
			return IS3_1
		elseif stage == 2
			return IS3_2
		elseif stage == 3
			return IS3_3
		elseif stage == 4
			return IS3_4
		elseif stage == 5
			return IS3_5
		endif
	elseif index == 4
		If stage == 1
			return IS4_1
		elseif stage == 2
			return IS4_2
		elseif stage == 3
			return IS4_3
		elseif stage == 4
			return IS4_4
		elseif stage == 5
			return IS4_5
		endif
	elseif index == 5
		If stage == 1
			return IS5_1
		elseif stage == 2
			return IS5_2
		elseif stage == 3
			return IS5_3
		elseif stage == 4
			return IS5_4
		elseif stage == 5
			return IS5_5
		endif
	elseif index == 6
		If stage == 1
			return IS6_1
		elseif stage == 2
			return IS6_2
		elseif stage == 3
			return IS6_3
		elseif stage == 4
			return IS6_4
		elseif stage == 5
			return IS6_5
		endif
	elseif index == 7
		If stage == 1
			return IS7_1
		elseif stage == 2
			return IS7_2
		elseif stage == 3
			return IS7_3
		elseif stage == 4
			return IS7_4
		elseif stage == 5
			return IS7_5
		endif
	elseif index == 8
		If stage == 1
			return IS8_1
		elseif stage == 2
			return IS8_2
		elseif stage == 3
			return IS8_3
		elseif stage == 4
			return IS8_4
		elseif stage == 5
			return IS8_5
		endif
	elseif index == 9
		If stage == 1
			return IS9_1
		elseif stage == 2
			return IS9_2
		elseif stage == 3
			return IS9_3
		elseif stage == 4
			return IS9_4
		elseif stage == 5
			return IS9_5
		endif
	elseif index == 10
		If stage == 1
			return IS10_1
		elseif stage == 2
			return IS10_2
		elseif stage == 3
			return IS10_3
		elseif stage == 4
			return IS10_4
		elseif stage == 5
			return IS10_5
		endif
	elseif index == 11
		If stage == 1
			return IS11_1
		elseif stage == 2
			return IS11_2
		elseif stage == 3
			return IS11_3
		elseif stage == 4
			return IS11_4
		elseif stage == 5
			return IS11_5
		endif
	elseif index == 12
		If stage == 1
			return IS12_1
		elseif stage == 2
			return IS12_2
		elseif stage == 3
			return IS12_3
		elseif stage == 4
			return IS12_4
		elseif stage == 5
			return IS12_5
		endif
	elseif index == 13
		If stage == 1
			return IS13_1
		elseif stage == 2
			return IS13_2
		elseif stage == 3
			return IS13_3
		elseif stage == 4
			return IS13_4
		elseif stage == 5
			return IS13_5
		endif
	elseif index == 14
		If stage == 1
			return IS14_1
		elseif stage == 2
			return IS14_2
		elseif stage == 3
			return IS14_3
		elseif stage == 4
			return IS14_4
		elseif stage == 5
			return IS14_5
		endif
	elseif index == 15
		If stage == 1
			return IS15_1
		elseif stage == 2
			return IS15_2
		elseif stage == 3
			return IS15_3
		elseif stage == 4
			return IS15_4
		elseif stage == 5
			return IS15_5
		endif
	elseif index == 16
		If stage == 1
			return IS16_1
		elseif stage == 2
			return IS16_2
		elseif stage == 3
			return IS16_3
		elseif stage == 4
			return IS16_4
		elseif stage == 5
			return IS16_5
		endif
	elseif index == 17
		If stage == 1
			return IS17_1
		elseif stage == 2
			return IS17_2
		elseif stage == 3
			return IS17_3
		elseif stage == 4
			return IS17_4
		elseif stage == 5
			return IS17_5
		endif
	elseif index == 18
		If stage == 1
			return IS18_1
		elseif stage == 2
			return IS18_2
		elseif stage == 3
			return IS18_3
		elseif stage == 4
			return IS18_4
		elseif stage == 5
			return IS18_5
		endif
	elseif index == 19
		If stage == 1
			return IS19_1
		elseif stage == 2
			return IS19_2
		elseif stage == 3
			return IS19_3
		elseif stage == 4
			return IS19_4
		elseif stage == 5
			return IS19_5
		endif
	elseif index == 20
		If stage == 1
			return IS20_1
		elseif stage == 2
			return IS20_2
		elseif stage == 3
			return IS20_3
		elseif stage == 4
			return IS20_4
		elseif stage == 5
			return IS20_5
		endif
	elseif index == 21
		If stage == 1
			return IS21_1
		elseif stage == 2
			return IS21_2
		elseif stage == 3
			return IS21_3
		elseif stage == 4
			return IS21_4
		elseif stage == 5
			return IS21_5
		endif
	elseif index == 22
		If stage == 1
			return IS22_1
		elseif stage == 2
			return IS22_2
		elseif stage == 3
			return IS22_3
		elseif stage == 4
			return IS22_4
		elseif stage == 5
			return IS22_5
		endif
	elseif index == 23
		If stage == 1
			return IS23_1
		elseif stage == 2
			return IS23_2
		elseif stage == 3
			return IS23_3
		elseif stage == 4
			return IS23_4
		elseif stage == 5
			return IS23_5
		endif
	elseif index == 24
		If stage == 1
			return IS24_1
		elseif stage == 2
			return IS24_2
		elseif stage == 3
			return IS24_3
		elseif stage == 4
			return IS24_4
		elseif stage == 5
			return IS24_5
		endif
	elseif index == 25
		If stage == 1
			return IS25_1
		elseif stage == 2
			return IS25_2
		elseif stage == 3
			return IS25_3
		elseif stage == 4
			return IS25_4
		elseif stage == 5
			return IS25_5
		endif
	elseif index == 26
		If stage == 1
			return IS26_1
		elseif stage == 2
			return IS26_2
		elseif stage == 3
			return IS26_3
		elseif stage == 4
			return IS26_4
		elseif stage == 5
			return IS26_5
		endif
	elseif index == 27
		If stage == 1
			return IS27_1
		elseif stage == 2
			return IS27_2
		elseif stage == 3
			return IS27_3
		elseif stage == 4
			return IS27_4
		elseif stage == 5
			return IS27_5
		endif
	elseif index == 28
		If stage == 1
			return IS28_1
		elseif stage == 2
			return IS28_2
		elseif stage == 3
			return IS28_3
		elseif stage == 4
			return IS28_4
		elseif stage == 5
			return IS28_5
		endif
	elseif index == 29
		If stage == 1
			return IS29_1
		elseif stage == 2
			return IS29_2
		elseif stage == 3
			return IS29_3
		elseif stage == 4
			return IS29_4
		elseif stage == 5
			return IS29_5
		endif
	elseif index == 30
		If stage == 1
			return IS30_1
		elseif stage == 2
			return IS30_2
		elseif stage == 3
			return IS30_3
		elseif stage == 4
			return IS30_4
		elseif stage == 5
			return IS30_5
		endif

	endif
EndFunction

; インポート用字幕セット
	string[] IS1_1
	string[] IS1_2
	string[] IS1_3
	string[] IS1_4
	string[] IS1_5
	string[] IS2_1
	string[] IS2_2
	string[] IS2_3
	string[] IS2_4
	string[] IS2_5
	string[] IS3_1
	string[] IS3_2
	string[] IS3_3
	string[] IS3_4
	string[] IS3_5
	string[] IS4_1
	string[] IS4_2
	string[] IS4_3
	string[] IS4_4
	string[] IS4_5
	string[] IS5_1
	string[] IS5_2
	string[] IS5_3
	string[] IS5_4
	string[] IS5_5
	string[] IS6_1
	string[] IS6_2
	string[] IS6_3
	string[] IS6_4
	string[] IS6_5
	string[] IS7_1
	string[] IS7_2
	string[] IS7_3
	string[] IS7_4
	string[] IS7_5
	string[] IS8_1
	string[] IS8_2
	string[] IS8_3
	string[] IS8_4
	string[] IS8_5
	string[] IS9_1
	string[] IS9_2
	string[] IS9_3
	string[] IS9_4
	string[] IS9_5
	string[] IS10_1
	string[] IS10_2
	string[] IS10_3
	string[] IS10_4
	string[] IS10_5
	string[] IS11_1
	string[] IS11_2
	string[] IS11_3
	string[] IS11_4
	string[] IS11_5
	string[] IS12_1
	string[] IS12_2
	string[] IS12_3
	string[] IS12_4
	string[] IS12_5
	string[] IS13_1
	string[] IS13_2
	string[] IS13_3
	string[] IS13_4
	string[] IS13_5
	string[] IS14_1
	string[] IS14_2
	string[] IS14_3
	string[] IS14_4
	string[] IS14_5
	string[] IS15_1
	string[] IS15_2
	string[] IS15_3
	string[] IS15_4
	string[] IS15_5
	string[] IS16_1
	string[] IS16_2
	string[] IS16_3
	string[] IS16_4
	string[] IS16_5
	string[] IS17_1
	string[] IS17_2
	string[] IS17_3
	string[] IS17_4
	string[] IS17_5
	string[] IS18_1
	string[] IS18_2
	string[] IS18_3
	string[] IS18_4
	string[] IS18_5
	string[] IS19_1
	string[] IS19_2
	string[] IS19_3
	string[] IS19_4
	string[] IS19_5
	string[] IS20_1
	string[] IS20_2
	string[] IS20_3
	string[] IS20_4
	string[] IS20_5
	string[] IS21_1
	string[] IS21_2
	string[] IS21_3
	string[] IS21_4
	string[] IS21_5
	string[] IS22_1
	string[] IS22_2
	string[] IS22_3
	string[] IS22_4
	string[] IS22_5
	string[] IS23_1
	string[] IS23_2
	string[] IS23_3
	string[] IS23_4
	string[] IS23_5
	string[] IS24_1
	string[] IS24_2
	string[] IS24_3
	string[] IS24_4
	string[] IS24_5
	string[] IS25_1
	string[] IS25_2
	string[] IS25_3
	string[] IS25_4
	string[] IS25_5
	string[] IS26_1
	string[] IS26_2
	string[] IS26_3
	string[] IS26_4
	string[] IS26_5
	string[] IS27_1
	string[] IS27_2
	string[] IS27_3
	string[] IS27_4
	string[] IS27_5
	string[] IS28_1
	string[] IS28_2
	string[] IS28_3
	string[] IS28_4
	string[] IS28_5
	string[] IS29_1
	string[] IS29_2
	string[] IS29_3
	string[] IS29_4
	string[] IS29_5
	string[] IS30_1
	string[] IS30_2
	string[] IS30_3
	string[] IS30_4
	string[] IS30_5
