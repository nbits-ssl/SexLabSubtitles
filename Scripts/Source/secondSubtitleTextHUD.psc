﻿ScriptName secondSubtitleTextHUD Extends Quest
{ SexLab用 字幕＆メニューHUD }

Quest Property SubtitletextControl auto ; 汎用字幕クエスト
secondSubtitleText SSC ; 汎用字幕コントロールスクリプト
SubtitleSetSetting SSetting ; 字幕セットの設定

float Property interval = 6.0 auto ; 汎用字幕表示の間隔
int Property menuKey = 48 auto ; メニューの呼び出しキー　デフォルト「B」
string[] Property SetMenu auto ; 字幕のセット名のリスト
bool Property isControlFin = false auto ; 汎用字幕クエストを完全終了させた場合、ONにする

string Property pr_currentAnimName auto
string Property pr_stageInfo auto
string Property pr_tags auto

Function SetMenuInit() ; メニューリストの登録
	; debug.trace("# SetMenuInit開始")
	SSetting = SubtitletextControl as SubtitleSetSetting
	SSC = SubtitletextControl as secondSubtitleText
	string[] emptySet
	SetMenu = emptySet
	int len
	If (SSetting.IS_name) == emptySet
		; debug.trace("# インポート用の字幕ファイルが存在しません")
		len = 0
	else
		len = (SSetting.IS_name).length
		; debug.trace("# インポートした字幕ファイルの数は" + len)
	endif
	SetMenu =	Utility.CreateStringArray(len + 1) ; v2.4 fix

	SetMenu[0]  = "$SMENU_disble" ; 字幕を表示しない
	If len > 0
		int i = 1
		while (i < (len + 1))
			SetMenu[i] = SSetting.IS_name[i - 1]
			; debug.trace("# SetMenu[" + i + "]は" + SetMenu[i] + "です")
			i += 1
		endwhile
	endIf
EndFunction


; 字幕メニューリストが表示された時の処理
Event OnKeyDown(Int KeyCode)
	If KeyCode == menuKey
;		debug.trace("# Subtitle HUD - OnKeyDown - メニュー用のキーが押されました！")
		If (!Utility.isinmenumode()) && SSC.isRunningSubtitle
			int situation = SSC.situation ; 稼働中のSEXのシチュエーション
			string stype = SSC.situationType
			string currentsetname = SSetting.getCSName(situation, stype, SSC.isAggressive) ; 現在適用されている字幕セット名
			int currentnum = SetMenu.find(currentsetname)
			string currentSituation = SSetting.common_situation[situation] ; 現在のシチュエーションの汎用名
			string title = "$SMENU_title"
			string info = "$SMENU_info"
			string shead = "$SMENU_SHead"
			string chead = "$SMENU_CHead"
			string pr_animTitle = "$menu_animTitle"
			string pr_headAnim = "$menu_headAnim"
			string pr_headStage = "$menu_headStage"
			string pr_headTag = "$menu_headTag"

			int choice = ShowMenuList(info, title, shead, currentSituation, chead, SetMenu, currentnum, 0, pr_animTitle, pr_headAnim, pr_currentAnimName, pr_headStage, pr_stageInfo, pr_headTag, pr_tags)
			; debug.trace("# choiceは" + choice)
			If choice == 0
				; 2016/1fix =====================================
				; 別modのカスタムメニューと同時に開くとキャンセル扱いになるため
				; 字幕オフになるのではなく現状維持となるよう、処理を削除
				; SSC.repeatUpdate = false
				; SSetting.setName(situation, "$SMENU_disble")
				;; SSetting.intoCSempty(situation)
				; SSetting.updateIndex(situation, 0)
			else
				choice = choice - 1 ; 実際の選択は非表示の選択肢の分を抜いた数になる
				string setname = SSetting.IS_name[choice] ;選択したセット名
				int setindex = SSetting.IS_index[choice] ;選択したセットのインポート元（ver2.1）
				; debug.trace("# setnameは" + setname)
				;選択したセット
				string[] set1 = SSetting.getStorageSubtitles(choice, 1)
				string[] set2 = SSetting.getStorageSubtitles(choice, 2)
				string[] set3 = SSetting.getStorageSubtitles(choice, 3)
				string[] set4 = SSetting.getStorageSubtitles(choice, 4)
				string[] set5 = SSetting.getStorageSubtitles(choice, 5)
				;選択したセットを現在のシチュエーションの汎用字幕としてセット
				SSetting.updateSubtitles(situation, stype, SSC.isAggressive, setname, setindex, set1, set2, set3, set4, set5)
				
				;字幕表示の更新
				string[] SSet = SSetting.getSubtitles(situation, stype, SSC.isAggressive, SSC.getSexLabStage())
				SSC.SSet = SSet
				SSC.Temp = 0
				SSC.repeatUpdate = true
				SSC.ShowSubtitlesAuto()
			endIf
		endif
	EndIf
EndEvent


; 汎用字幕表示コントロールクエストの終了（Modのアンインストール用）
Function stopSubtitleControl()
	_sMode = false
	isControlFin = true
	SubtitletextControl.stop()
	; debug.trace("# SubtitlesHUD - 汎用字幕処理クエストを完全終了させました")
EndFunction

; 汎用字幕表示関連のリセット
Function resetSubtitleControl()
	_sMode = true
	isControlFin = false
	SubtitletextControl.start()
	; If (SubtitletextControl as Quest).isrunning()
	; 	; debug.trace("# SubtitlesHUD - 汎用字幕処理クエストを再開しました")
	; endif
EndFunction

; ---------------------------------------------------------------------------------
bool _sMode = true ; SubtitlesModの字幕表示のオンオフ（外部Mod用）
bool Property SMode
	bool function get()
		return _sMode
	endFunction
	function set(bool a_val)
		If !a_val
			If SubtitletextControl.isrunning()
				(SubtitletextControl as secondSubtitleText).repeatUpdate = false
				; debug.trace("# SubtitlesHUD - 汎用字幕処理をオフにしました")
			endif
			UnregisterForKey(menuKey)
		else
			RegisterForKey(menuKey)
		endif
		_sMode = a_val
	endFunction
endProperty
; 字幕エリアの表示・非表示
bool _visible = true
bool Property Visible
	bool function get()
		return _visible
	endFunction
	function set(bool a_val)
		_visible = a_val
		UI.SetBool("HUD Menu", "_root.HUDMovieBaseInstance.SubtitleHUD_container.SubtitleHUD._visible", _visible)
	endFunction
endProperty
Int _iMode = 0 ; v2.0以降不使用
Int Property IMode
	int function get()
		return _iMode
	endFunction
	function set(int a_val)
		_iMode = a_val
	endFunction
endProperty

;/ ===============================================
	字幕セットの選択メニューの処理
/;
Bool bMenuOpen
String sTitle
String sInfo
String situationHead
String situationM
String commonHead
String sInitialText
String sInput
String[] sOptions
Int iStartIndex
Int iDefaultIndex
Int iInput
String animTitle
String headAnim
String sAnim
String headStage
String sStage
String headTag
String sTag

; メニューリストの表示
Int Function ShowMenuList(String asInfo, String asTitle, String asSituHead, String asSitu, String asCommonHead, String[] asOptions, Int aiStartIndex, Int aiDefaultIndex, String asAnimTitle, String asHeadAnim, String asAnim, String asHeadStage,String asStage,String asHeadTag,String asTag)
	If(bMenuOpen)
		Return -1
	EndIf
	bMenuOpen = True
	iInput = -1
	sInfo = asInfo
	sTitle = asTitle
	situationHead = asSituHead
	situationM = asSitu
	commonHead = asCommonHead
	sOptions = asOptions
	iStartIndex = aiStartIndex
	iDefaultIndex = aiDefaultIndex
	SubtitleMenuList_Open(Self as Form)
	animTitle = asAnimTitle
	headAnim = asHeadAnim
	sAnim = asAnim
	headStage = asHeadStage
	sStage = asStage
	headTag = asHeadTag
	sTag = asTag
	While(bMenuOpen)
		Utility.WaitMenuMode(0.1)
	EndWhile
	SubtitleMenuList_Release(Self)
	Return iInput
EndFunction

Function SubtitleMenuList_Open(Form akClient) Global
	akClient.RegisterForModEvent("SubtitleMenuList_Open", "OnSubtitleMenuListOpen")
	akClient.RegisterForModEvent("SubtitleMenuList_Close", "OnSubtitleMenuListClose")
	; UI.OpenCustomMenu("exported/Widgets/obachan/SubtitleMenuList")
	; ver1.1 修正
	UI.OpenCustomMenu("skyui/SubtitleMenuList")
EndFunction

Function SubtitleMenuList_SetData(String asInfo, String asTitle, String asSituHead, String asSitu, String asCommonHead, String[] asOptions, Int aiStartIndex, Int aiDefaultIndex, String asAnimTitle, String asHeadAnim, String asAnim, String asHeadStage,  String asStage, String asHeadTag, String asTag) Global
	UI.InvokeNumber("CustomMenu", "_root.SubtitleMenuList.setPlatform", (Game.UsingGamepad() as Int))
	UI.InvokeStringA("CustomMenu", "_root.SubtitleMenuList.initListData", asOptions)
	Int iHandle = UICallback.Create("CustomMenu", "_root.SubtitleMenuList.initListParams")
	If(iHandle)
		UICallback.PushString(iHandle, asInfo)
		UICallback.PushString(iHandle, asTitle)
		UICallback.PushString(iHandle, asSituHead)
		UICallback.PushString(iHandle, asSitu)
		UICallback.PushString(iHandle, asCommonHead)
		UICallback.PushInt(iHandle, aiStartIndex)
		UICallback.PushInt(iHandle, aiDefaultIndex)
		UICallback.PushString(iHandle, asAnimTitle)
		UICallback.PushString(iHandle, asHeadAnim)
		UICallback.PushString(iHandle, asAnim)
		UICallback.PushString(iHandle, asHeadStage)
		UICallback.PushString(iHandle, asStage)
		UICallback.PushString(iHandle, asHeadTag)
		UICallback.PushString(iHandle, asTag)
		UICallback.Send(iHandle)
	EndIf
EndFunction

Function SubtitleMenuList_Release(Form akClient) Global
	akClient.UnregisterForModEvent("SubtitleMenuList_Open")
	akClient.UnregisterForModEvent("SubtitleMenuList_Close")
EndFunction

Event OnSubtitleMenuListOpen(String asEventName, String asStringArg, Float afNumArg, Form akSender)
	If(asEventName == "SubtitleMenuList_Open")
		SubtitleMenuList_SetData(sInfo, sTitle, situationHead, situationM, commonHead, sOptions, iStartIndex, iDefaultIndex, animTitle, headAnim, sAnim, headStage, sStage, headTag, sTag)
	EndIf
EndEvent

Event OnSubtitleMenuListClose(String asEventName, String asStringArg, Float afInput, Form akSender)
	If(asEventName == "SubtitleMenuList_Close")
		iInput = afInput as Int
		bMenuOpen = False
	EndIf
EndEvent

;/ ==============================================
	字幕エリアHUD の処理
/;
; エリア1スーパー　テキスト先頭の#u、#sで名前を自動判別
Function ShowSubtitleSuper(String asName1, String asName2, String asMessage)
	; Debug.Trace("# ShowSubtitleSuper - 1." + asName1 + " , 2. " +asName2 + " , " + asMessage)
	If(!Subtitle_Prepare())
		; Debug.Trace(" ShowSubtitleSuper - Not Prepare")
		Return
	EndIf
	Int iHandle = UICallback.Create("HUD Menu", "_root.HUDMovieBaseInstance.SubtitleHUD_container.SubtitleHUD.ShowSubtitleSuper")
	If(iHandle)
		UICallback.PushString(iHandle, asName1)
		UICallback.PushString(iHandle, asName2)
		UICallback.PushString(iHandle, asMessage)
		UICallback.Send(iHandle)
	EndIf
EndFunction

; 字幕表示の準備
Bool Function Subtitle_Prepare() global
	Int iVersion = UI.GetInt("HUD Menu", "_global.oba.SubtitleHUD.SubtitleHUD_VERSION")
	If(iVersion == 0)
		Int iHandle = UICallback.Create("HUD Menu", "_root.HUDMovieBaseInstance.createEmptyMovieClip")
		If(!iHandle)
			Return False
		EndIf
		UICallback.PushString(iHandle, "SubtitleHUD_container")
		UICallback.PushInt(iHandle, -998)
		If(!UICallback.Send(iHandle))
			Return False
		EndIf
		UI.InvokeString("HUD Menu", "_root.HUDMovieBaseInstance.SubtitleHUD_container.loadMovie", "obachan/SubtitleHUD.swf")
		Utility.Wait(0.5)
		iVersion = UI.GetInt("HUD Menu", "_global.oba.SubtitleHUD.SubtitleHUD_VERSION")
		If(iVersion == 0)
			UI.InvokeString("HUD Menu", "_root.HUDMovieBaseInstance.SubtitleHUD_container.loadMovie", "exported/obachan/SubtitleHUD.swf")
			Utility.Wait(0.5)
			iVersion = UI.GetInt("HUD Menu", "_global.oba.SubtitleHUD.SubtitleHUD_VERSION")
			If(iVersion == 0)
				Debug.Trace("@ SubtitleHUD - HUDの割り込みに失敗しました")
				Return False
			EndIf
			UI.InvokeString("HUD Menu", "_root.HUDMovieBaseInstance.SubtitleHUD_container.SetRootPath", "exported/")
		EndIf
	EndIf
	Return True
EndFunction

; 字幕表示用swfのバージョンジェック
int Function Subtitle_GetVersion() global
	Int iVersion = 0
	iVersion = UI.GetInt("HUD Menu", "_global.oba.SubtitleHUD.SubtitleHUD_VERSION")
	If(iVersion == 0)
		Int iHandle = UICallback.Create("HUD Menu", "_root.HUDMovieBaseInstance.createEmptyMovieClip")
		If(!iHandle)
			Return iVersion
		EndIf
		UICallback.PushString(iHandle, "SubtitleHUD_container")
		UICallback.PushInt(iHandle, -998)
		If(!UICallback.Send(iHandle))
			Return iVersion
		EndIf
		UI.InvokeString("HUD Menu", "_root.HUDMovieBaseInstance.SubtitleHUD_container.loadMovie", "obachan/SubtitleHUD.swf")
		Utility.Wait(0.5)
		iVersion = UI.GetInt("HUD Menu", "_global.oba.SubtitleHUD.SubtitleHUD_VERSION")
		If(iVersion == 0)
			UI.InvokeString("HUD Menu", "_root.HUDMovieBaseInstance.SubtitleHUD_container.loadMovie", "exported/obachan/SubtitleHUD.swf")
			Utility.Wait(0.5)
			iVersion = UI.GetInt("HUD Menu", "_global.oba.SubtitleHUD.SubtitleHUD_VERSION")
			If(iVersion == 0)
				Debug.Trace("@ SubtitleHUD - HUDの割り込みに失敗しました")
			Return iVersion
			EndIf
			UI.InvokeString("HUD Menu", "_root.HUDMovieBaseInstance.SubtitleHUD_container.SetRootPath", "exported/")
			Return iVersion
		else
			Return iVersion
		EndIf
	else
		Return iVersion
	EndIf
EndFunction
