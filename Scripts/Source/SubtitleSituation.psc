Scriptname SubtitleSituation extends Quest  

Function init()
	int iempty
	string sempty = "$SMENU_disble"
	
	self._updateHetero(true, sempty, iempty, new string[5], new string[5], new string[5], new string[5], new string[5])
	self._updateHetero(false, sempty, iempty, new string[5], new string[5], new string[5], new string[5], new string[5])
	self._updateHomo(true, sempty, iempty, new string[5], new string[5], new string[5], new string[5], new string[5])
	self._updateHomo(false, sempty, iempty, new string[5], new string[5], new string[5], new string[5], new string[5])
	self._updateCreature(true, sempty, iempty, new string[5], new string[5], new string[5], new string[5], new string[5])
	self._updateCreature(false, sempty, iempty, new string[5], new string[5], new string[5], new string[5], new string[5])
EndFunction

Function clearAll()
	int iempty
	string sempty = "$SMENU_disble"
	string[] empty
	
	self._updateHetero(true, sempty, iempty, empty, empty, empty, empty, empty)
	self._updateHetero(false, sempty, iempty, empty, empty, empty, empty, empty)
	self._updateHomo(true, sempty, iempty, empty, empty, empty, empty, empty)
	self._updateHomo(false, sempty, iempty, empty, empty, empty, empty, empty)
	self._updateCreature(true, sempty, iempty, empty, empty, empty, empty, empty)
	self._updateCreature(false, sempty, iempty, empty, empty, empty, empty, empty)
EndFunction

int Function getSubtitlesStorage(string stype, bool aggressive = false)
	if (stype == "hetero")
		if (aggressive)
			return HeteroAggrStorageID
		else
			return HeteroStorageID
		endif
	elseif (stype == "homo")
		if (aggressive)
			return HomoAggrStorageID
		else
			return HomoStorageID
		endif
	elseif (stype == "creature" || stype == "Creature") ; why automatic upper at Property array ?
		if (aggressive)
			return CreatureAggrStorageID
		else
			return CreatureStorageID
		endif
	endif
EndFunction


string Function getSubtitlesName(string stype, bool aggressive = false)
	if (stype == "hetero")
		if (aggressive)
			return HeteroAggrName
		else
			return HeteroName
		endif
	elseif (stype == "homo")
		if (aggressive)
			return HomoAggrName
		else
			return HomoName
		endif
	elseif (stype == "creature" || stype == "Creature")
		if (aggressive)
			return CreatureAggrName
		else
			return CreatureName
		endif
	endif
EndFunction

Function updateSubtitles(string stype, bool aggressive, string title, int sid, \
						 string[] set1, string[] set2, string[] set3, string[] set4, string[] set5)
	
	 if (stype == "hetero")
		self._updateHetero(aggressive, title, sid, set1, set2, set3, set4, set5)
	elseif (stype == "homo")
		self._updateHomo(aggressive, title, sid, set1, set2, set3, set4, set5)
	elseif (stype == "creature" || stype == "Creature")
		self._updateCreature(aggressive, title, sid, set1, set2, set3, set4, set5)
	endif
EndFunction

string[] Function getSubtitles(string stype, bool aggressive = false, int stage)
	if (stype == "hetero")
		return self._getHetero(aggressive, stage)
	elseif (stype == "homo")
		return self._getHomo(aggressive, stage)
	elseif (stype == "creature" || stype == "Creature")
		return self._getCreature(aggressive, stage)
	endif
EndFunction

Function clearSubtitles(string stype, bool aggressive = false)
	int iempty
	string sempty = "$SMENU_disble"
	string[] empty
	
	if (stype == "hetero")
		self._updateHetero(aggressive, sempty, iempty, empty, empty, empty, empty, empty)
	elseif (stype == "homo")
		self._updateHomo(aggressive, sempty, iempty, empty, empty, empty, empty, empty)
	elseif (stype == "creature" || stype == "Creature")
		self._updateCreature(aggressive, sempty, iempty, empty, empty, empty, empty, empty)
	endif
EndFunction


string[] Function _getHetero(bool aggressive, int stage)
	if (aggressive)
		if (stage == 1)
			return HeteroAggr1
		elseif (stage == 2)
			return HeteroAggr2
		elseif (stage == 3)
			return HeteroAggr3
		elseif (stage == 4)
			return HeteroAggr4
		elseif (stage == 5)
			return HeteroAggr5
		endif
	else
		if (stage == 1)
			return Hetero1
		elseif (stage == 2)
			return Hetero2
		elseif (stage == 3)
			return Hetero3
		elseif (stage == 4)
			return Hetero4
		elseif (stage == 5)
			return Hetero5
		endif
	endif
EndFunction

string[] Function _getHomo(bool aggressive, int stage)
	if (aggressive)
		if (stage == 1)
			return HomoAggr1
		elseif (stage == 2)
			return HomoAggr2
		elseif (stage == 3)
			return HomoAggr3
		elseif (stage == 4)
			return HomoAggr4
		elseif (stage == 5)
			return HomoAggr5
		endif
	else
		if (stage == 1)
			return Homo1
		elseif (stage == 2)
			return Homo2
		elseif (stage == 3)
			return Homo3
		elseif (stage == 4)
			return Homo4
		elseif (stage == 5)
			return Homo5
		endif
	endif
EndFunction

string[] Function _getCreature(bool aggressive, int stage)
	if (aggressive)
		if (stage == 1)
			return CreatureAggr1
		elseif (stage == 2)
			return CreatureAggr2
		elseif (stage == 3)
			return CreatureAggr3
		elseif (stage == 4)
			return CreatureAggr4
		elseif (stage == 5)
			return CreatureAggr5
		endif
	else
		if (stage == 1)
			return Creature1
		elseif (stage == 2)
			return Creature2
		elseif (stage == 3)
			return Creature3
		elseif (stage == 4)
			return Creature4
		elseif (stage == 5)
			return Creature5
		endif
	endif
EndFunction


Function _updateHetero(bool aggressive, string title, int sid, string[] set1, string[] set2, string[] set3, string[] set4, string[] set5)
	if (aggressive)
		HeteroAggrName = title
		HeteroAggrStorageID = sid
		HeteroAggr1 = set1
		HeteroAggr2 = set2
		HeteroAggr3 = set3
		HeteroAggr4 = set4
		HeteroAggr5 = set5
	else
		HeteroName = title
		HeteroStorageID = sid
		Hetero1 = set1
		Hetero2 = set2
		Hetero3 = set3
		Hetero4 = set4
		Hetero5 = set5
	endif
EndFunction

Function _updateHomo(bool aggressive, string title, int sid, string[] set1, string[] set2, string[] set3, string[] set4, string[] set5)
	if (aggressive)
		HomoAggrName = title
		HomoAggrStorageID = sid
		HomoAggr1 = set1
		HomoAggr2 = set2
		HomoAggr3 = set3
		HomoAggr4 = set4
		HomoAggr5 = set5
	else
		HomoName = title
		HomoStorageID = sid
		Homo1 = set1
		Homo2 = set2
		Homo3 = set3
		Homo4 = set4
		Homo5 = set5
	endif
EndFunction

Function _updateCreature(bool aggressive, string title, int sid, string[] set1, string[] set2, string[] set3, string[] set4, string[] set5)
	if (aggressive)
		CreatureAggrName = title
		CreatureAggrStorageID = sid
		CreatureAggr1 = set1
		CreatureAggr2 = set2
		CreatureAggr3 = set3
		CreatureAggr4 = set4
		CreatureAggr5 = set5
	else
		CreatureName = title
		CreatureStorageID = sid
		Creature1 = set1
		Creature2 = set2
		Creature3 = set3
		Creature4 = set4
		Creature5 = set5
	endif
EndFunction

; Subtitles variables

string HeteroName
string HeteroAggrName
int HeteroStorageID
int HeteroAggrStorageID
string[] Hetero1
string[] Hetero2
string[] Hetero3
string[] Hetero4
string[] Hetero5
string[] HeteroAggr1
string[] HeteroAggr2
string[] HeteroAggr3
string[] HeteroAggr4
string[] HeteroAggr5

string HomoName
string HomoAggrName
int HomoStorageID
int HomoAggrStorageID
string[] Homo1
string[] Homo2
string[] Homo3
string[] Homo4
string[] Homo5
string[] HomoAggr1
string[] HomoAggr2
string[] HomoAggr3
string[] HomoAggr4
string[] HomoAggr5

string CreatureName
string CreatureAggrName
int CreatureStorageID
int CreatureAggrStorageID
string[] Creature1
string[] Creature2
string[] Creature3
string[] Creature4
string[] Creature5
string[] CreatureAggr1
string[] CreatureAggr2
string[] CreatureAggr3
string[] CreatureAggr4
string[] CreatureAggr5
