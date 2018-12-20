Scriptname SubtitleConfigMenu extends SKI_ConfigBase
; SexLab Subtitles MCMコンフィグメニュー

secondSubtitleTextHUD property ssHUD auto ; 字幕＆メニューHUD
secondSubtitleText property SSC auto ; 字幕のコントロール
SubtitleSetSetting property SSetting auto ; 字幕のセッティング

int[] _csdefault ; デフォルトボタンで選択される字幕セット（初期値「字幕を表示しない」）

int stypeID
int[] SubtitleIDS
string[] CModeInfo

string[] GenderSettingOptions

Event OnConfigInit()
	ModName = "$MCM_modName"
	
	Pages = new string[5]
	Pages[0] = "$MCM_page1_subtitleSetting"
	Pages[1] = "$MCM_page2_masturbation"
	Pages[2] = "$MCM_page2_stype1"
	Pages[3] = "$MCM_page2_stype2"
	Pages[4] = "$MCM_page2_stype3"
	
	SubtitleIDS = new int[24] ; 12*2
	
	CModeInfo = new string[12]
	CModeInfo[0] = "$MCM_cmode0_info"
	CModeInfo[1] = "$MCM_cmode1_info"
	CModeInfo[2] = "$MCM_cmode2_info"
	CModeInfo[3] = "$MCM_cmode3_info"
	CModeInfo[4] = "$MCM_cmode4_info"
	CModeInfo[5] = "$MCM_cmode5_info"
	CModeInfo[6] = "$MCM_cmode6_info"
	CModeInfo[7] = "$MCM_cmode7_info"
	CModeInfo[8] = "$MCM_cmode8_info"
	CModeInfo[9] = "$MCM_cmode9_info"
	CModeInfo[10] = "$MCM_cmode10_info"
	CModeInfo[11] = "$MCM_cmode11_info"
	
	GenderSettingOptions = new string[2]
	GenderSettingOptions[0] = "$MCM_GenderMale"
	GenderSettingOptions[1] = "$MCM_GenderFemale"
	
	_csdefault = new int[3]
	_csdefault[0] = 0
	_csdefault[1] = 0
	_csdefault[2] = 0
EndEvent

event OnGameReload()
	parent.OnGameReload()
	Quest hudQuest = Game.GetFormFromFile(0x1829, "SexLabSubtitles.esp") as Quest
	Quest SControlQuest = Game.GetFormFromFile(0x12C4, "SexLabSubtitles.esp") as Quest

	ssHUD = hudQuest as secondSubtitleTextHUD
	SSC = SControlQuest as secondSubtitleText
	SSetting = SControlQuest as SubtitleSetSetting
endEvent

int function GetVersion()
	return ssubtitletextUtil.GetVersion()
endFunction

Event OnVersionUpdate(int a_version)
	debug.trace("# [SexLab Subtitles] - Update - ver." + CurrentVersion + " >> ver." + a_version)
	self.OnConfigInit()
EndEvent

; ==============================================
event OnPageReset(string page)
	; 表紙
	if page == ""
		SetTitleText("$MCM_modCatchCopy")
		LoadCustomContent("exported/obachan/S_Subtitles_Logo.swf", 95, 30)
		return
	endIf
	UnloadCustomContent()
	; 1ページ目
	if page == "$MCM_page1_subtitleSetting"
		Page1Settings()
	elseif page == "$MCM_page2_stype1"
		stypeID = 0
		SituationPageSettings(stypeID)
	elseif page == "$MCM_page2_stype2"
		stypeID = 1
		SituationPageSettings(stypeID)
	elseif page == "$MCM_page2_stype3"
		stypeID = 2
		SituationPageSettings(stypeID)
	endif
endEvent

Event OnConfigOpen()
endEvent

Event OnConfigClose()
	; 字幕SEXが稼働中なら字幕を更新する
	If SSC.isRunningSubtitle ;字幕sex稼働中の場合
		; debug.trace("# [Subtitles MCM] - 字幕稼働中 -MCMの変更を適用します...")
		int situation = SSC.situation
		string stype = SSC.situationType
		int sstage = SSC.getSexLabStage()
		string[] SSet = SSetting.getSubtitles(situation, stype, SSC.isAggressive, sstage) ; 変更後の字幕
		string sname = SSetting.getCSName(situation, stype, SSC.isAggressive)

		If sname == "$SMENU_disble" ; 字幕非表示を選んでいた場合
			SSC.repeatUpdate = false
		else
			If SSC.SSet == SSet ; 実行中の字幕と変更後の字幕が同じ場合
				; debug.trace("# [MCM]  - 現在実行中の字幕に変更はありませんでした")
			else
				SSC.SSet = SSet
				SSC.Temp = 0
				SSC.repeatUpdate = true
				SSC.ShowSubtitlesAuto()
			endif
		endIf
	endif
EndEvent

Function Page1Settings()
	SetTitleText("$MCM_page1info")
	SetCursorFillMode(TOP_TO_BOTTOM)

	int flags
	if ssHUD.isControlFin
		flags = OPTION_FLAG_DISABLED
	else
		flags = OPTION_FLAG_NONE
	endIf

	AddHeaderOption("$MCM_page1head1")
	AddKeyMapOptionST("keymap_menuKey", "$MCM_page1menukey", ssHUD.menuKey, flags)
	AddSliderOptionST("slider_interval","$MCM_page1interval", ssHUD.interval, "$MCM_Seconds", flags)
	AddToggleOptionST("toggle_randommode","$MCM_page1randommode", SSC.repeatRandom, flags) ; v2.2 added
	AddEmptyOption()

	AddHeaderOption("$MCM_page1head2")
	AddTextOptionST("text_importAgain", "$MCM_page1importAgain", "$MCM_shareAction", flags)
	AddToggleOptionST("toggle_smode","$MCM_page1smode", ssHUD.SMode, flags)
	AddTextOptionST("text_uninstall", "$MCM_page1shutdown", "$MCM_page1valth", flags)

	if ssHUD.isControlFin
		AddTextOptionST("text_reset", "$MCM_page1reset", "$MCM_shareAction")
	else
		AddTextOptionST("text_reset", "$MCM_page1reset", "$MCM_shareAction", OPTION_FLAG_DISABLED)
	endIf

	SetCursorPosition(1)
	AddHeaderOption("$MCM_page1head4")
	AddMenuOptionST("gender_setting_homo", "$MCM_page1genderHomo", GenderSettingOptions[SSC.HomoSSGender], flags)
	AddMenuOptionST("gender_setting_creature", "$MCM_page1genderCreature", GenderSettingOptions[SSC.CreatureSSGender], flags)
	AddEmptyOption()
	AddEmptyOption()

	AddHeaderOption("$MCM_page1head_version")
	AddTextOption("$ModVersion", SSC.ModVersion)
	AddTextOption("$HUDVersion", SSC.HUDstringVersion)
	AddEmptyOption()
	AddTextOption("$SSLVersion", SSC.SSLversion)
EndFunction

Function SituationPageSettings(int _stypeID)
	int flags
	if ssHUD.isControlFin
		flags = OPTION_FLAG_DISABLED
	else
		flags = OPTION_FLAG_NONE
	endIf
	SetCursorFillMode(LEFT_TO_RIGHT)
	
	AddMenuOptionST("menu_cmode_default", "$CMODE_default", ssHUD.SetMenu[_csdefault[stypeID]], flags)
	AddTextOptionST("text_forcedAll", "$CMODE_forcedall", "$CMODE_forcedall_btn", flags)
	
	AddHeaderOption("$MCM_page2head2")
	AddHeaderOption("$MCM_page2head2rape")
	
	string stype = SSetting.CS_type[_stypeID]
	string[] common_situation = SSetting.common_situation
	int situationLength = common_situation.length

	int i = 0
	int stdidx
	int aggridx
	while (i < situationLength)
		if (i != 4) ; masturbation
			stdidx = i * 2
			aggridx = stdidx + 1
			SubtitleIDS[stdidx]  = AddMenuOption(common_situation[i], SSetting.getCSName(i, stype, false), flags)
			SubtitleIDS[aggridx] = AddMenuOption(common_situation[i], SSetting.getCSName(i, stype, true), flags)
		endif
		i += 1
	endwhile
EndFunction

; AddMenuOptionST("gender_setting_homo", "$MCM_page1genderHomo", GenderSettingOptions[SSC.HomoSSGender], flags)
;
; added from forked

state gender_setting_homo
	event OnHighlightST()
		SetInfoText("$MCM_page1genderHomoInfo")
	endEvent
	event OnMenuOpenST()
		SetMenuDialogStartIndex(SSC.HomoSSGender)
		SetMenuDialogOptions(GenderSettingOptions)
	endEvent
	event OnMenuAcceptST(int i)
		SetMenuOptionValueST(GenderSettingOptions[i])
		SSC.HomoSSGender = i
	endEvent
endState

state gender_setting_creature
	event OnHighlightST()
		SetInfoText("$MCM_page1genderCreatureInfo")
	endEvent
	event OnMenuOpenST()
		SetMenuDialogStartIndex(SSC.CreatureSSGender)
		SetMenuDialogOptions(GenderSettingOptions)
	endEvent
	event OnMenuAcceptST(int i)
		SetMenuOptionValueST(GenderSettingOptions[i])
		SSC.CreatureSSGender = i
	endEvent
endState

;/---------------------------------------------------------------------------
	1ページ目の設定（字幕Mod全体の設定）
/;

; 字幕セット変更メニューの呼び出しキー
state keymap_menuKey
	event OnHighlightST()
		SetInfoText("$MCM_page1menukeyInfo")
	endEvent
	event OnKeyMapChangeST(int newKeyCode, string conflictControl, string conflictName)
		if !KeyConflict(newKeyCode, conflictControl, conflictName)
			ssHUD.UnregisterForKey(ssHUD.menuKey)
			ssHUD.menuKey = newKeyCode
			ssHUD.RegisterForKey(ssHUD.menuKey)
			SetKeyMapOptionValueST(ssHUD.menuKey)
		endIf
	endEvent
	event OnDefaultST()
		ssHUD.UnregisterForKey(ssHUD.menuKey)
		ssHUD.menuKey = 48 ; デフォルト「B」
		ssHUD.RegisterForKey(ssHUD.menuKey)
		SetKeyMapOptionValueST(ssHUD.menuKey)
	endEvent
endState

; キーがカブった時の処理
bool function KeyConflict(int newKeyCode, string conflictControl, string conflictName)
	bool continue = true
	if (conflictControl != "")
		string msg
		if (conflictName != "")
			msg = "$MCM_page1menukeyWarn1{$" + conflictName + "}{$" + conflictControl + "}"
		else
			msg = "$MCM_page1menukeyWarn2{$" + conflictControl + "}"
		endIf
		continue = ShowMessage(msg, true, "$Yes", "$No")
	endIf
	return !continue
endFunction

; 割り当てたキーをMCMに登録（競合メッセージ用）
String Function GetCustomControl(int keyCode)
	if(keyCode == ssHUD.menuKey)
		return "$MCM_page1menukeyMessage"
	endIf
EndFunction

; 字幕表示の間隔の調整
state slider_interval
	event OnHighlightST()
		SetInfoText("$MCM_page1intervalInfo")
	endEvent
	event OnSliderOpenST()
		SetSliderDialogStartValue(ssHUD.interval)
		SetSliderDialogDefaultValue(6)
		SetSliderDialogRange(4, 8)
		SetSliderDialogInterval(1)
	endEvent
	event OnSliderAcceptST(float value)
		ssHUD.interval = value
		SetSliderOptionValueST(ssHUD.interval, "$MCM_Seconds")
	endEvent
	event OnDefaultST()
		ssHUD.interval = 6.0
		SetToggleOptionValueST(ssHUD.interval, "$MCM_Seconds")
	endEvent
endState

; 字幕機能全体のオン・オフ
state toggle_smode
	event OnHighlightST()
		SetInfoText("$MCM_page1smodeInfo")
	endEvent
	event OnSelectST()
		ssHUD.SMode = !(ssHUD.SMode)
		SetToggleOptionValueST(ssHUD.SMode)
	endEvent
	event OnDefaultST()
		ssHUD.SMode = true
		SetToggleOptionValueST(ssHUD.SMode)
	endEvent
endState

; 字幕ランダム表示のオン・オフ
state toggle_randommode
	event OnHighlightST()
		SetInfoText("$MCM_page1randommodeInfo")
	endEvent
	event OnSelectST()
		SSC.repeatRandom = !(SSC.repeatRandom)
		SetToggleOptionValueST(SSC.repeatRandom)
	endEvent
	event OnDefaultST()
		SSC.repeatRandom = false
		SetToggleOptionValueST(SSC.repeatRandom)
	endEvent
endState

; Modを外す場合
state text_uninstall
	event OnHighlightST()
		SetInfoText("$MCM_page1shutdownInfo")
	endEvent
	event OnSelectST()
		ssHUD.stopSubtitleControl()
		ForcePageReset()
	endEvent
endState

; Modの手動リセット
state text_reset
	event OnHighlightST()
		SetInfoText("$MCM_page1resetInfo")
	endEvent
	event OnSelectST()
		ssHUD.resetSubtitleControl()
		ForcePageReset()
	endEvent
endState

; 字幕のインポート
state text_importAgain
	event OnHighlightST()
		SetInfoText("$MCM_page1importAgainInfo")
	endEvent
	event OnSelectST()
		bool importOK = SSetting.importAll() ; 字幕セットの準備とインポート
		int i = 0
		while !(importOK) && (i < 10)
			utility.wait(0.1)
			i += 1
		endwhile
		ssHUD.SetMenuInit() ; HUDメニューの準備（セット名の登録）
		int len = (SSetting.IS_name).length
		ShowMessage("$MCM_page1importMessage{" + len + "}", false, "$Yes")
		SSetting.refresh()
		ForcePageReset()
	endEvent
endState

;/---------------------------------------------------------------------------
	2ページ目の設定（汎用字幕の割り当て）
/;

; デフォルトの字幕セットの設定
state menu_cmode_default
	event OnHighlightST()
		SetInfoText("$MCM_cmode_default_info")
	endEvent
	event OnMenuOpenST()
		SetMenuDialogStartIndex(_csdefault[stypeID])
		SetMenuDialogDefaultIndex(_csdefault[stypeID])
		SetMenuDialogOptions(ssHUD.SetMenu)
	endEvent
	event OnMenuAcceptST(int i)
		if i < 0
			SetMenuOptionValueST(ssHUD.SetMenu[_csdefault[stypeID]])
		else
			_csdefault[stypeID] = i
			If _csdefault[stypeID] == 0
				SetMenuOptionValueST("$SMENU_disble")
			else
				; debug.trace("# setnameは" + SSetting.IS_name)
				string changename = SSetting.IS_name[_csdefault[stypeID] - 1]
				SetMenuOptionValueST(changename)
			endif
		endIf
	endEvent
	event OnDefaultST()
		SetMenuOptionValueST(ssHUD.SetMenu[_csdefault[stypeID]])
	endEvent
endState

; デフォルトの字幕を全てのシチュエーションに適用する
state text_forcedAll
	event OnHighlightST()
		SetInfoText("$MCM_cmode_farcedall_info")
	endEvent
	event OnSelectST()
		string stype = SSetting.CS_type[stypeID]
		int situationLength = SSetting.common_situation.length
		
		If (_csdefault[stypeID] == 0)
			int num = 0
			while (num < situationLength) ; v2.4Fix
				SSetting.clearSubtitles(num, stype, false)
				SSetting.clearSubtitles(num, stype, true)
				num += 1
			endwhile
		else
			int choice = _csdefault[stypeID] - 1 ; 実際の選択は非表示の分を抜いた数
			string setname = SSetting.IS_name[choice] ;選択したセット名
			
			;選択したセット
			string[] set1 = SSetting.getStorageSubtitles(choice, 1)
			string[] set2 = SSetting.getStorageSubtitles(choice, 2)
			string[] set3 = SSetting.getStorageSubtitles(choice, 3)
			string[] set4 = SSetting.getStorageSubtitles(choice, 4)
			string[] set5 = SSetting.getStorageSubtitles(choice, 5)
			
			;選択したセットを全てのシチュエーションの汎用字幕としてセット
			int num2 = 0
			while (num2 < situationLength)
				SSetting.updateSubtitles(num2, stype, false, setname, choice, set1, set2, set3, set4, set5)
				SSetting.updateSubtitles(num2, stype, true,  setname, choice, set1, set2, set3, set4, set5)
				num2 += 1
			endwhile
		endIf
		ForcePageReset()
	endEvent
endState

; 選択した字幕に変更する処理（choiceは選択した字幕のメニュー順、cmodeは汎用字幕シチュエーション番号）
Function changeCmode(int option, int choice, string stype, int cmode, bool aggressive)
	; debug.trace("# メニューオプション" + ssHUD.SetMenu[choice] + "が選ばれました")
	string setname
	If choice < 1 ; 字幕非表示の場合
		setname = "$SMENU_disble"
		SSetting.clearSubtitles(cmode, stype, aggressive)
	else
		choice = choice - 1 ; 実際の選択は非表示の分を抜いた数になる
		setname = SSetting.IS_name[choice] ;選択したセット名
		int setindex = SSetting.IS_index[choice] ;選択したセットのインポート元（ver2.1）
		;選択したセット
		string[] set1 = SSetting.getStorageSubtitles(choice, 1)
		string[] set2 = SSetting.getStorageSubtitles(choice, 2)
		string[] set3 = SSetting.getStorageSubtitles(choice, 3)
		string[] set4 = SSetting.getStorageSubtitles(choice, 4)
		string[] set5 = SSetting.getStorageSubtitles(choice, 5)
		;選択したセットを現在のシチュエーションの汎用字幕としてセット
		SSetting.updateSubtitles(cmode, stype, aggressive, setname, setindex, set1, set2, set3, set4, set5)
	endIf
	;選択したセットの名前を現在のシチュエーションの字幕名としてセット
	SetMenuOptionValue(option, setname) ; メニューに反映
EndFunction

; ----------------------------------------------------------------------

Event OnOptionHighlight(int option)
	int ret = SubtitleIDS.find(option)
	if (ret >= 0)
		SetInfoText(CModeInfo[ret / 2])
	endif
EndEvent

Event OnOptionDefault(int option)
	int ret = SubtitleIDS.find(option)
	if (ret >= 0)
		string stype = SSetting.CS_type[stypeID]
		if (ret % 2 == 1)
			self.changeCmode(option, _csdefault[stypeID], stype, ret / 2, true)
		else
			self.changeCmode(option, _csdefault[stypeID], stype, ret / 2, false)
		endif
	endif
EndEvent

Event OnOptionMenuOpen(int option)
	int ret = SubtitleIDS.find(option)
	if (ret >= 0)
		string stype = SSetting.CS_type[stypeID]
		if (ret % 2 == 1)
			SetMenuDialogStartIndex(ssHUD.SetMenu.Find(SSetting.getCSName(ret / 2, stype, true)))
		else
			SetMenuDialogStartIndex(ssHUD.SetMenu.Find(SSetting.getCSName(ret / 2, stype, false)))
		endif
		SetMenuDialogDefaultIndex(_csdefault[stypeID])
		SetMenuDialogOptions(ssHUD.SetMenu)
	endif
EndEvent

Event OnOptionMenuAccept(int option, int index)
	int ret = SubtitleIDS.find(option)
	if (ret >= 0 && index >= 0)
		string stype = SSetting.CS_type[stypeID]
		if (ret % 2 == 1)
			self.changeCmode(option, index, stype, ret / 2, true)
		else
			self.changeCmode(option, index, stype, ret / 2, false)
		endif
	endif
EndEvent
