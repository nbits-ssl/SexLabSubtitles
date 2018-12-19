Scriptname secondSubtitleText extends Quest
{sexLab用 汎用字幕コントロールスクリプト}

SexLabFramework Property SexLab auto ; SexLab様
secondSubtitleTextHUD Property SS auto ; 字幕HUD
SubtitleSetSetting Property SSetting auto ; 字幕セットのインポート、汎用字幕の設定など

; 汎用字幕表示の状態プロパティ（外部からのアクセス用）
bool Property isRunningSubtitle auto; 字幕表示しているSexシーンが現在稼働中かどうか
int Property currentStage auto; 現在稼働中のアニメーションのステージ
int Property maxStage auto; 現在稼働中のアニメーションの総ステージ数
int Property situation = 10 auto ; 現在のアニメーションの字幕のシチュエーション
string Property situationType = "hetero" auto
bool Property isAggressive = false auto ; 強姦かどうか

int defaultSituation = 10
string defaultSituationType = "hetero"

string sexlabID ; 現在稼働中のSexシーンのID
bool isSameSex ; 受と攻が同性かどうか（v2.2）
bool isCreature

Actor Player ; プレイヤー
Actor Uke ; 受役のアクター
Actor Seme ; 攻役のアクター
string name_Uke ; 受の名前
string name_Seme ; 攻の名前
; bool _samesex ; 受と攻が同性かどうか（v2.2）
int _temp_r ; ランダム表示の再生番号（v2.2）

int _temp = 0 ; 字幕表示の順番を記憶しておく
int Property Temp ; 外部アクセス用
	int function get()
		return _temp
	endFunction
	function set(int a_val)
		_temp = a_val
	endFunction
endProperty

float stageChangeTime = 0.0 ; 前回ステージが切り替わった時間
string[] _sset ; 表示させる字幕セット
string[] Property SSet ; 外部アクセス用
	string[] function get()
		return _sset
	endFunction
	function set(string[] a_val)
		_sset = a_val
	endFunction
endProperty

bool property repeatUpdate = false auto ; true中のみOnUpdateし字幕を表示する
bool property repeatRandom = false auto ; true中はランダムで字幕表示 (v2.2)

; v2.3 Version check
string Property ModVersion auto
string Property SSLversion auto
int Property iSSLversion auto
int Property HUDversion auto
string Property HUDstringVersion auto

; forked
int RegistDistance = 1750

;/======================================================/;

Function Initialize() ; ゲームがロードされるたびに呼び出し
	sexlabID = ""
	Player = Game.GetPlayer()
	SSetting = (self as Quest) as SubtitleSetSetting
	registerEvent()
	ModVersion = ssubtitletextUtil.GetVersionString()
	SSLversion = SexLabUtil.GetStringVer()
	iSSLversion = SexLabUtil.GetVersion()
	HUDversion = secondSubtitleTextHUD.Subtitle_GetVersion()
	If HUDversion == 0
		HUDstringVersion = "$VersionFail"
	else
		HUDstringVersion = "v" + (HUDversion * 0.1)
	endIf
EndFunction

Function CommonSetInit() ; 汎用字幕の準備（Mod導入初回＆更新時）
	SSetting.init() ; シチュエーションのセット
	bool importOK = SSetting.importAll() ; 字幕セットの準備とインポート
	
	int i = 0
	while !(importOK) && (i < 10)
		utility.wait(0.1)
		i += 1
	endwhile
	
	SSetting.defaultSet() ; 初回限定設定
	SS.SetMenuInit() ; HUDメニューの準備（セット名の登録）
EndFunction

Function RegisterMenukey() ; 字幕メニューリスト呼び出しキーの登録
	SS.Registerforkey(SS.menuKey)
EndFunction

Function UnregisterSubtitles() ; 関連処理の登録を削除
	unregisterEvent()
	SS.Unregisterforkey(SS.menuKey)
EndFunction

;/======================================================
	SexLab用イベント
/;

Function registerEvent()
	RegisterForModEvent("AnimationStart", "startAnim")
	RegisterForModEvent("AnimationEnd", "endAnim")
	RegisterForModEvent("StageStart", "startStage")
	RegisterForModEvent("AnimationChange", "startStage")
	RegisterForModEvent("StageEnd", "endStage")
	RegisterForModEvent("OrgasmStart", "startStage")
	RegisterForModEvent("OrgasmEnd", "endStage")
EndFunction
Function unregisterEvent()
	UnregisterForModEvent("AnimationStart")
	UnregisterForModEvent("AnimationChange")
	UnregisterForModEvent("AnimationEnd")
	UnregisterForModEvent("StageStart")
	UnregisterForModEvent("StageEnd")
	UnregisterForModEvent("OrgasmStart")
	UnregisterForModEvent("OrgasmEnd")
EndFunction

bool Function _isPlayerNear(sslThreadController controller)
	return (controller.Positions[0].GetDistance(Player) < RegistDistance)
EndFunction

string[] Function _cleanSubtitles(string[] stsets, sslThreadController controller)
	bool _hasPlayer = controller.HasPlayer
	bool _hasCreature = controller.HasCreature
	
	int len = stsets.length
	string[] _stsets = Utility.CreateStringArray(len)
	string line
	string char2
	
	while len > 0
		len -= 1
		line = stsets[len]
		char2 = StringUtil.Substring(line, 0, 2)
		
		if (_hasCreature && char2 == "s#")
			; pass
		elseif (!_hasPlayer && char2 != "s#" && char2 != "u#")
			; pass
		else
			_stsets[len] = line
		endif
	endwhile
	
	return PapyrusUtil.ClearEmpty(_stsets)
EndFunction

;SexLabアニメ開始時の処理 -------------------------------------
event startAnim(string eventName, string argString, float argNum, form sender)
	sslThreadController controller = SexLab.HookController(argString)

	If (SS.SMode && self._isPlayerNear(controller)) ; 汎用字幕システムが有効の場合
		_temp = 0 ; order subtitle's current number
		situation = defaultSituation
		situationType = defaultSituationType
		sexlabID = argString
		
		; debug.trace("# SexLab Subtitles - アニメ開始 - スレッドID : " + sexlabID)
	endif
endEvent

; ステージ毎の開始時の処理
event startStage(string eventName, string argString, float argNum, form sender)
	sslThreadController controller = SexLab.HookController(argString)
	; debug.trace("SexLabSubtitles: Stage start")

	If (SS.SMode && self._isPlayerNear(controller))
		; debug.trace("SexLabSubtitles: Stage start, success")
		isRunningSubtitle = true
		
		; セリフの表示番号をリセットするかどうかの判定
		float now = utility.getcurrentrealtime()
		If ((now - stageChangeTime) < (SS.interval * 1.2) && sexlabID == argString)
			; debug.trace("# 前回から" + ((now - stageChangeTime) as int) + "秒しか経っていないためセリフをリセットしません")
		else
			_temp = 0
		endIf
		stageChangeTime = now ; 時刻の更新
		
		sexlabID = argString
		currentStage = controller.Stage
		sslBaseAnimation animation = controller.Animation
		maxStage = animation.StageCount
		
		; for menu v2.3 Animation Info
		SS.pr_currentAnimName = animation.name
		SS.pr_stageInfo = currentStage + " / " + maxStage
		SS.pr_tags = self._getTagInfo(animation)
		
		Actor[] member = controller.Positions
		If (member.length == 1)
			Uke = member[0]
			Seme = member[0]
		else
			Uke = member[0]
			Seme = member[1]
		endIf
		
		; ver2.2 ディスプレイネームを優先的に取得（NPCのみ）
		name_Uke = self._getDisplayName(Uke)
		name_Seme = self._getDisplayName(Seme)
		
		string currentTag = self._getCurrentTag(animation)

		; set Property 
		isSameSex = (Uke.GetLeveledActorBase().GetSex() == Seme.GetLeveledActorBase().GetSex())
		isCreature = animation.IsCreature
		isAggressive = controller.IsAggressive
		
		situation = self._getSituation(animation.name, currentTag)
		situationType = self._getSituationType()
		
		If SSetting.isDisable(situation, situationType, isAggressive) ; 字幕が非表示の場合
			repeatUpdate = false
		else
			_sset = SSetting.getSubtitles(situation, situationType, isAggressive, self.getSexLabStage())
			if (!controller.HasPlayer || controller.HasCreature)
				_sset = self._cleanSubtitles(_sset, controller)
			endif
			if !(repeatUpdate)
				repeatUpdate = true
				ShowSubtitlesAuto()
			endif
		endif
	endIf
endEvent

; ステージ終了時の処理
event endStage(string eventName, string argString, float argNum, form sender)
	If (argString == sexlabID)
		repeatUpdate = false
		isRunningSubtitle = false
	endif
endEvent

;SexLabアニメ全体完了時の処理
event endAnim(string eventName, string argString, float argNum, form sender)
	If (argString == sexlabID)
		repeatUpdate = false
		_temp = 0
		sexlabID = ""
		situation = defaultSituation
		situationType = defaultSituationType
		Uke = none
		Seme = none
		isRunningSubtitle = false
		name_Uke = ""
		name_Seme = ""
		; _samesex = false
	endif
endEvent


string Function _getDisplayName(Actor act)
	string dn_act = ""
	string n_act = ""
	
	If act == Player
		return act.getactorbase().getName()
	else
		dn_act = (act as objectreference).GetDisplayName()
		n_act = act.getactorbase().getName()
		If !(dn_act == "")
			return dn_act
		else
			If !(n_act == "")
				return n_act
			else
				return "$unknown"
			endIf
		endif
	endif
EndFunction

string Function _getCurrentTag(sslBaseAnimation animation)
	If animation.HasTag("Handjob")
		return "Handjob"
	elseIf animation.HasTag("Footjob")
		return "Footjob"
	elseIf animation.HasTag("Boobjob")
		return "Boobjob"
	elseIf animation.HasTag("Masturbation")
		return "Masturbation"
	elseIf animation.HasTag("Fisting")
		return "Fisting"
	elseIf animation.HasTag("Cowgirl")
		return "Cowgirl"
	elseIf animation.HasTag("Foreplay")
		return "Foreplay"
	elseIf animation.HasTag("Oral")
		return "Oral"
	elseIf animation.HasTag("Anal")
		return "Anal"
	elseIf animation.HasTag("Vaginal")
		return "Vaginal"
	endIf
	
	return ""
EndFunction

string Function _getTagInfo(sslBaseAnimation animation)
	string [] tags = animation.getTags()
	string tagInfo = ""
	int clen = 0
	while (clen < tags.length)
		If !(tags[clen] == "")
			tagInfo = tagInfo + tags[clen]
			If !(clen == (tags.length - 1))
				tagInfo += ", "
			endIf
		endIf
		clen += 1
	endwhile
	
	return tagInfo
EndFunction

;/======================================================
	字幕表示関連の処理
/;

string Function _getSituationType()
	if (isCreature)
		return "creature"
	elseif (isSameSex)
		return "homo"
	else
		return "hetero"
	endIf
EndFunction

; アニメ名、タグ名からシチュエーション番号を割り出し、situationプロパティにセットする
int Function _getSituation(string animname, string tagname)
	If animname == "Arrok 69"
		return 0
	elseIf tagname == "Handjob"
		return 1
	elseIf tagname == "Footjob"
		return 2
	elseIf tagname == "Boobjob"
		return 3
	elseIf tagname == "Masturbation"
		return 4
	elseIf tagname == "Fisting"
		return 5
	elseIf tagname == "Cowgirl"
		return 6
	elseIf tagname == "Foreplay"
		return 7
	elseIf tagname == "Oral"
		return 8
	elseIf tagname == "Anal"
		return 9
	elseIf tagname == "Vaginal"
		return 10
	else
		return 11
	endif
EndFunction

; 現在のステージから適用する字幕のステージを返す（5ステージ以上あるアニメーション対応）
int Function getSexLabStage()
	If currentStage == 1
		return 1
	elseif currentStage == 2
		return 2
	elseif currentStage == maxStage
		return 5
	elseif currentStage == (maxStage - 1)
		return 4
	else
		return 3
	endif
EndFunction

Event OnUpdate()
	If repeatUpdate
		; debug.trace("SexLabSubtitles: OnUpdate")
		ShowSubtitles(_sset)
	endif
EndEvent

; 字幕表示に使う関数
Function ShowSuper(String n_uke, String n_seme, String asMessage)
	SS.ShowSubtitleSuper(n_uke, n_seme, asMessage)
EndFunction

; 字幕セットの表示
Function ShowSubtitlesAuto()
	ShowSubtitles(_sset)
EndFunction

Function ShowSubtitles(string[] subtitleSet)
	; debug.trace("# ShowSubtitles処理開始")
	int len = subtitleSet.length
	
	if !(Uke && Seme)
		repeatUpdate = false
		isRunningSubtitle = false
		return ; the end, safe function
	endif
	
	If repeatRandom ; ランダムモード
		int choice = getRandomDifferent(0, (len - 1), _temp_r)
		; Debug.Trace("# ランダムモード：前回は" +_temp_r + " 結果は" + choice)
		
		If ((choice < 20) && (choice < subtitleSet.length))
			ShowSuper(name_Uke, name_Seme, subtitleSet[choice])
			_temp_r = choice
			If repeatUpdate
				registerforsingleupdate(SS.interval)
			endIf
		else	 ; ランダムの結果と字幕の個数が一致しない場合
			If repeatUpdate
				registerforsingleupdate(0.1)
			endIf
		endIf
	else ; リピートモード
		; debug.trace("SexLabSubtitles: # リピートモード 前回_tempは" + _temp)
		If temp >= subtitleSet.length ; 表示回数がセリフ数を越えたら0に戻す
			_temp = 0
		endif
		If (_temp < 20)
			ShowSuper(name_Uke, name_Seme, subtitleSet[_temp])
		endIf
		_temp += 1
		If repeatUpdate
			registerforsingleupdate(SS.interval)
		endIf
	endif
EndFunction

; ランダムで同じ数を二回続けて出さないようにする
int Function getRandomDifferent(int min, int max, int before)
	if (min == max) ; 0
		return min
	endif
	
	int n = Utility.randomInt(min, max)
	while (n == before)
		n = Utility.randomInt(min, max)
	endwhile
	return n
EndFunction
