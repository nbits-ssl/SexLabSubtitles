Scriptname SubtitleStorage extends Quest  

string endcode = "#ssend" ; 終了タグ

; ファイルパス（filePath）の末尾数字startnumからmaxnumのファイルの有無を調べ総数をカウントする
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

; ファイルの有無に関わらず1-50番までのファイルの字幕セットを取得する
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

	IS31_1 = self._importSSet(31,1)
	IS31_2 = self._importSSet(31,2)
	IS31_3 = self._importSSet(31,3)
	IS31_4 = self._importSSet(31,4)
	IS31_5 = self._importSSet(31,5)
	IS32_1 = self._importSSet(32,1)
	IS32_2 = self._importSSet(32,2)
	IS32_3 = self._importSSet(32,3)
	IS32_4 = self._importSSet(32,4)
	IS32_5 = self._importSSet(32,5)
	IS33_1 = self._importSSet(33,1)
	IS33_2 = self._importSSet(33,2)
	IS33_3 = self._importSSet(33,3)
	IS33_4 = self._importSSet(33,4)
	IS33_5 = self._importSSet(33,5)
	IS34_1 = self._importSSet(34,1)
	IS34_2 = self._importSSet(34,2)
	IS34_3 = self._importSSet(34,3)
	IS34_4 = self._importSSet(34,4)
	IS34_5 = self._importSSet(34,5)
	IS35_1 = self._importSSet(35,1)
	IS35_2 = self._importSSet(35,2)
	IS35_3 = self._importSSet(35,3)
	IS35_4 = self._importSSet(35,4)
	IS35_5 = self._importSSet(35,5)
	IS36_1 = self._importSSet(36,1)
	IS36_2 = self._importSSet(36,2)
	IS36_3 = self._importSSet(36,3)
	IS36_4 = self._importSSet(36,4)
	IS36_5 = self._importSSet(36,5)
	IS37_1 = self._importSSet(37,1)
	IS37_2 = self._importSSet(37,2)
	IS37_3 = self._importSSet(37,3)
	IS37_4 = self._importSSet(37,4)
	IS37_5 = self._importSSet(37,5)
	IS38_1 = self._importSSet(38,1)
	IS38_2 = self._importSSet(38,2)
	IS38_3 = self._importSSet(38,3)
	IS38_4 = self._importSSet(38,4)
	IS38_5 = self._importSSet(38,5)
	IS39_1 = self._importSSet(39,1)
	IS39_2 = self._importSSet(39,2)
	IS39_3 = self._importSSet(39,3)
	IS39_4 = self._importSSet(39,4)
	IS39_5 = self._importSSet(39,5)
	IS40_1 = self._importSSet(40,1)
	IS40_2 = self._importSSet(40,2)
	IS40_3 = self._importSSet(40,3)
	IS40_4 = self._importSSet(40,4)
	IS40_5 = self._importSSet(40,5)
	
	IS41_1 = self._importSSet(41,1)
	IS41_2 = self._importSSet(41,2)
	IS41_3 = self._importSSet(41,3)
	IS41_4 = self._importSSet(41,4)
	IS41_5 = self._importSSet(41,5)
	IS42_1 = self._importSSet(42,1)
	IS42_2 = self._importSSet(42,2)
	IS42_3 = self._importSSet(42,3)
	IS42_4 = self._importSSet(42,4)
	IS42_5 = self._importSSet(42,5)
	IS43_1 = self._importSSet(43,1)
	IS43_2 = self._importSSet(43,2)
	IS43_3 = self._importSSet(43,3)
	IS43_4 = self._importSSet(43,4)
	IS43_5 = self._importSSet(43,5)
	IS44_1 = self._importSSet(44,1)
	IS44_2 = self._importSSet(44,2)
	IS44_3 = self._importSSet(44,3)
	IS44_4 = self._importSSet(44,4)
	IS44_5 = self._importSSet(44,5)
	IS45_1 = self._importSSet(45,1)
	IS45_2 = self._importSSet(45,2)
	IS45_3 = self._importSSet(45,3)
	IS45_4 = self._importSSet(45,4)
	IS45_5 = self._importSSet(45,5)
	IS46_1 = self._importSSet(46,1)
	IS46_2 = self._importSSet(46,2)
	IS46_3 = self._importSSet(46,3)
	IS46_4 = self._importSSet(46,4)
	IS46_5 = self._importSSet(46,5)
	IS47_1 = self._importSSet(47,1)
	IS47_2 = self._importSSet(47,2)
	IS47_3 = self._importSSet(47,3)
	IS47_4 = self._importSSet(47,4)
	IS47_5 = self._importSSet(47,5)
	IS48_1 = self._importSSet(48,1)
	IS48_2 = self._importSSet(48,2)
	IS48_3 = self._importSSet(48,3)
	IS48_4 = self._importSSet(48,4)
	IS48_5 = self._importSSet(48,5)
	IS49_1 = self._importSSet(49,1)
	IS49_2 = self._importSSet(49,2)
	IS49_3 = self._importSSet(49,3)
	IS49_4 = self._importSSet(49,4)
	IS49_5 = self._importSSet(49,5)
	IS50_1 = self._importSSet(50,1)
	IS50_2 = self._importSSet(50,2)
	IS50_3 = self._importSSet(50,3)
	IS50_4 = self._importSSet(50,4)
	IS50_5 = self._importSSet(50,5)

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
		;--------------------------------------------------------
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
		;--------------------------------------------------------
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
		;--------------------------------------------------------
	elseif index == 31
		If stage == 1
			return IS31_1
		elseif stage == 2
			return IS31_2
		elseif stage == 3
			return IS31_3
		elseif stage == 4
			return IS31_4
		elseif stage == 5
			return IS31_5
		endif
	elseif index == 32
		If stage == 1
			return IS32_1
		elseif stage == 2
			return IS32_2
		elseif stage == 3
			return IS32_3
		elseif stage == 4
			return IS32_4
		elseif stage == 5
			return IS32_5
		endif
	elseif index == 33
		If stage == 1
			return IS33_1
		elseif stage == 2
			return IS33_2
		elseif stage == 3
			return IS33_3
		elseif stage == 4
			return IS33_4
		elseif stage == 5
			return IS33_5
		endif
	elseif index == 34
		If stage == 1
			return IS34_1
		elseif stage == 2
			return IS34_2
		elseif stage == 3
			return IS34_3
		elseif stage == 4
			return IS34_4
		elseif stage == 5
			return IS34_5
		endif
	elseif index == 35
		If stage == 1
			return IS35_1
		elseif stage == 2
			return IS35_2
		elseif stage == 3
			return IS35_3
		elseif stage == 4
			return IS35_4
		elseif stage == 5
			return IS35_5
		endif
	elseif index == 36
		If stage == 1
			return IS36_1
		elseif stage == 2
			return IS36_2
		elseif stage == 3
			return IS36_3
		elseif stage == 4
			return IS36_4
		elseif stage == 5
			return IS36_5
		endif
	elseif index == 37
		If stage == 1
			return IS37_1
		elseif stage == 2
			return IS37_2
		elseif stage == 3
			return IS37_3
		elseif stage == 4
			return IS37_4
		elseif stage == 5
			return IS37_5
		endif
	elseif index == 38
		If stage == 1
			return IS38_1
		elseif stage == 2
			return IS38_2
		elseif stage == 3
			return IS38_3
		elseif stage == 4
			return IS38_4
		elseif stage == 5
			return IS38_5
		endif
	elseif index == 39
		If stage == 1
			return IS39_1
		elseif stage == 2
			return IS39_2
		elseif stage == 3
			return IS39_3
		elseif stage == 4
			return IS39_4
		elseif stage == 5
			return IS39_5
		endif
	elseif index == 40
		If stage == 1
			return IS40_1
		elseif stage == 2
			return IS40_2
		elseif stage == 3
			return IS40_3
		elseif stage == 4
			return IS40_4
		elseif stage == 5
			return IS40_5
		endif
		;--------------------------------------------------------
	elseif index == 41
		If stage == 1
			return IS41_1
		elseif stage == 2
			return IS41_2
		elseif stage == 3
			return IS41_3
		elseif stage == 4
			return IS41_4
		elseif stage == 5
			return IS41_5
		endif
	elseif index == 42
		If stage == 1
			return IS42_1
		elseif stage == 2
			return IS42_2
		elseif stage == 3
			return IS42_3
		elseif stage == 4
			return IS42_4
		elseif stage == 5
			return IS42_5
		endif
	elseif index == 43
		If stage == 1
			return IS43_1
		elseif stage == 2
			return IS43_2
		elseif stage == 3
			return IS43_3
		elseif stage == 4
			return IS43_4
		elseif stage == 5
			return IS43_5
		endif
	elseif index == 44
		If stage == 1
			return IS44_1
		elseif stage == 2
			return IS44_2
		elseif stage == 3
			return IS44_3
		elseif stage == 4
			return IS44_4
		elseif stage == 5
			return IS44_5
		endif
	elseif index == 45
		If stage == 1
			return IS45_1
		elseif stage == 2
			return IS45_2
		elseif stage == 3
			return IS45_3
		elseif stage == 4
			return IS45_4
		elseif stage == 5
			return IS45_5
		endif
	elseif index == 46
		If stage == 1
			return IS46_1
		elseif stage == 2
			return IS46_2
		elseif stage == 3
			return IS46_3
		elseif stage == 4
			return IS46_4
		elseif stage == 5
			return IS46_5
		endif
	elseif index == 47
		If stage == 1
			return IS47_1
		elseif stage == 2
			return IS47_2
		elseif stage == 3
			return IS47_3
		elseif stage == 4
			return IS47_4
		elseif stage == 5
			return IS47_5
		endif
	elseif index == 48
		If stage == 1
			return IS48_1
		elseif stage == 2
			return IS48_2
		elseif stage == 3
			return IS48_3
		elseif stage == 4
			return IS48_4
		elseif stage == 5
			return IS48_5
		endif
	elseif index == 49
		If stage == 1
			return IS49_1
		elseif stage == 2
			return IS49_2
		elseif stage == 3
			return IS49_3
		elseif stage == 4
			return IS49_4
		elseif stage == 5
			return IS49_5
		endif
	elseif index == 50
		If stage == 1
			return IS50_1
		elseif stage == 2
			return IS50_2
		elseif stage == 3
			return IS50_3
		elseif stage == 4
			return IS50_4
		elseif stage == 5
			return IS50_5
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

	string[] IS31_1
	string[] IS31_2
	string[] IS31_3
	string[] IS31_4
	string[] IS31_5
	string[] IS32_1
	string[] IS32_2
	string[] IS32_3
	string[] IS32_4
	string[] IS32_5
	string[] IS33_1
	string[] IS33_2
	string[] IS33_3
	string[] IS33_4
	string[] IS33_5
	string[] IS34_1
	string[] IS34_2
	string[] IS34_3
	string[] IS34_4
	string[] IS34_5
	string[] IS35_1
	string[] IS35_2
	string[] IS35_3
	string[] IS35_4
	string[] IS35_5
	string[] IS36_1
	string[] IS36_2
	string[] IS36_3
	string[] IS36_4
	string[] IS36_5
	string[] IS37_1
	string[] IS37_2
	string[] IS37_3
	string[] IS37_4
	string[] IS37_5
	string[] IS38_1
	string[] IS38_2
	string[] IS38_3
	string[] IS38_4
	string[] IS38_5
	string[] IS39_1
	string[] IS39_2
	string[] IS39_3
	string[] IS39_4
	string[] IS39_5
	string[] IS40_1
	string[] IS40_2
	string[] IS40_3
	string[] IS40_4
	string[] IS40_5

	string[] IS41_1
	string[] IS41_2
	string[] IS41_3
	string[] IS41_4
	string[] IS41_5
	string[] IS42_1
	string[] IS42_2
	string[] IS42_3
	string[] IS42_4
	string[] IS42_5
	string[] IS43_1
	string[] IS43_2
	string[] IS43_3
	string[] IS43_4
	string[] IS43_5
	string[] IS44_1
	string[] IS44_2
	string[] IS44_3
	string[] IS44_4
	string[] IS44_5
	string[] IS45_1
	string[] IS45_2
	string[] IS45_3
	string[] IS45_4
	string[] IS45_5
	string[] IS46_1
	string[] IS46_2
	string[] IS46_3
	string[] IS46_4
	string[] IS46_5
	string[] IS47_1
	string[] IS47_2
	string[] IS47_3
	string[] IS47_4
	string[] IS47_5
	string[] IS48_1
	string[] IS48_2
	string[] IS48_3
	string[] IS48_4
	string[] IS48_5
	string[] IS49_1
	string[] IS49_2
	string[] IS49_3
	string[] IS49_4
	string[] IS49_5
	string[] IS50_1
	string[] IS50_2
	string[] IS50_3
	string[] IS50_4
	string[] IS50_5