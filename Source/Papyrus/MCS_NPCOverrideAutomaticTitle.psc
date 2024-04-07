ScriptName MCS_NPCOverrideAutomaticTitle Extends Actor

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;
GlobalVariable Property Venpi_DebugEnabled Auto Const Mandatory
String Property Venpi_ModName="VenworksHumanCreationSystem" Auto Const


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;

;; Combat Role Flags
Keyword Property CombatRole_Assault_Keyword Auto Const Mandatory
Keyword Property CombatRole_Boss_Keyword Auto Const Mandatory
Keyword Property CombatRole_Charger_Keyword Auto Const Mandatory
Keyword Property CombatRole_Heavy_Keyword Auto Const Mandatory
Keyword Property CombatRole_Officer_Keyword Auto Const Mandatory
Keyword Property CombatRole_Recruit_Keyword Auto Const Mandatory
Keyword Property CombatRole_Sniper_Keyword Auto Const Mandatory
Keyword Property CombatRole_Support_Keyword Auto Const Mandatory

;; Crimson Fleet/Pirate Stuff
Keyword Property FactionTypeCrimsonFleet Auto Const Mandatory
FormList Property MCS_ClassTitles_CrimsonFleet Auto Const Mandatory

;; Ecliptic Stuff
Keyword Property FactionTypeEcliptic Auto Const Mandatory
FormList Property MCS_ClassTitles_Ecliptic Auto Const Mandatory

;; House Va'ruun Stuff
Keyword Property FactionTypeHouseVaruun Auto Const Mandatory
FormList Property MCS_ClassTitles_HouseVaruun Auto Const Mandatory

;; Spacer Stuff
Keyword Property FactionTypeSpacer Auto Const Mandatory
FormList Property MCS_ClassTitles_Spacer Auto Const Mandatory

;; Starborn Stuff
Keyword Property FactionTypeStarborn Auto Const Mandatory
FormList Property MCS_ClassTitles_Starborn Auto Const Mandatory

;; Syndicate Stuff
Keyword Property FactionTypeSyndicate Auto Const Mandatory
FormList Property MCS_ClassTitles_Syndicate Auto Const Mandatory

;; The First Stuff
Keyword Property FactionTypeTheFirst Auto Const Mandatory
FormList Property MCS_ClassTitles_TheFirst Auto Const Mandatory

;; Unhandled Factions
Keyword Property FactionTypeFreestarCollective Auto Const Mandatory
Keyword Property FactionTypeRyujinIndustries Auto Const Mandatory
Keyword Property FactionTypeUnitedColonies Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Variables
;;;
Faction Property MyCrimeFaction Auto
Faction Property MyGroupFaction Auto
VPI_SharedObjectManager:FactionClasses Property EnumFactionClasses Auto

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnLoad()
  VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "OnLoad", "OnLoad triggered - Generate and apply random name for the NPC.", 0, Venpi_DebugEnabled.GetValueInt())
  MyCrimeFaction = Self.GetCrimeFaction()
  MyGroupFaction = Self.GetGroupFaction()
  enumFactionClasses = VPI_SharedObjectManager.GetEnumFactionClasses()

  VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "OnLoad", "NPC " + Self + " generating a title.", 0, Venpi_DebugEnabled.GetValueInt())
  Message title = GenerateAutoTitle()
  if (title == None)
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "OnLoad", "NPC " + Self + " failed to generate a title.", 0, Venpi_DebugEnabled.GetValueInt())
    Return
  EndIf

  VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "OnLoad", "NPC " + Self + " overriding title to " + title + ".", 0, Venpi_DebugEnabled.GetValueInt())
  self.SetOverrideName(title)
EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
Message Function GenerateAutoTitle()


  If (Self.HasKeyword(FactionTypeCrimsonFleet))
    Return GenerateCrimsonFleetTitle()
  ElseIf (Self.HasKeyword(FactionTypeEcliptic))
    Return GenerateEclipticTitle()
  ElseIf (Self.HasKeyword(FactionTypeFreestarCollective))
    Return None ;; NOT IMPLEMENTED YET
  ElseIf (Self.HasKeyword(FactionTypeHouseVaruun))
    Return GenerateHouseVaruunTitle()
  ElseIf (Self.HasKeyword(FactionTypeRyujinIndustries))
    Return None ;; NOT IMPLEMENTED YET
  ElseIf (Self.HasKeyword(FactionTypeSpacer))
    Return GenerateSpacerTitle()
  ElseIf (Self.HasKeyword(FactionTypeStarborn))
    Return GenerateStarbornTitle()
  ElseIf (Self.HasKeyword(FactionTypeSyndicate))
    Return GenerateSyndicateTitle()
  ElseIf (Self.HasKeyword(FactionTypeTheFirst))
    Return GenerateTheFirstTitle()
  ElseIf (Self.HasKeyword(FactionTypeUnitedColonies))
    Return None ;; NOT IMPLEMENTED YET
  Else
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateAutoTitle", "Failed to find title for NPC " + Self + ".", 0, Venpi_DebugEnabled.GetValueInt())
    Return None
  EndIf
EndFunction

Message Function GenerateCrimsonFleetTitle()
  Message title = None
  If (Self.HasKeyword(FactionTypeCrimsonFleet) && Self.HasKeyword(CombatRole_Assault_Keyword))
    title = MCS_ClassTitles_CrimsonFleet.GetAt(enumFactionClasses.Assault) as Message
  ElseIf (Self.HasKeyword(FactionTypeCrimsonFleet) && Self.HasKeyword(CombatRole_Boss_Keyword))
    title = MCS_ClassTitles_CrimsonFleet.GetAt(enumFactionClasses.Boss) as Message
  ElseIf (Self.HasKeyword(FactionTypeCrimsonFleet) && Self.HasKeyword(CombatRole_Charger_Keyword))
    title = MCS_ClassTitles_CrimsonFleet.GetAt(enumFactionClasses.Charger) as Message
  ElseIf (Self.HasKeyword(FactionTypeCrimsonFleet) && Self.HasKeyword(CombatRole_Heavy_Keyword))
    title = MCS_ClassTitles_CrimsonFleet.GetAt(enumFactionClasses.Heavy) as Message
  ElseIf (Self.HasKeyword(FactionTypeCrimsonFleet) && Self.HasKeyword(CombatRole_Officer_Keyword))
    title = MCS_ClassTitles_CrimsonFleet.GetAt(enumFactionClasses.Officer) as Message
  ElseIf (Self.HasKeyword(FactionTypeCrimsonFleet) && Self.HasKeyword(CombatRole_Recruit_Keyword))
    title = MCS_ClassTitles_CrimsonFleet.GetAt(enumFactionClasses.Recruit) as Message
  ElseIf (Self.HasKeyword(FactionTypeCrimsonFleet) && Self.HasKeyword(CombatRole_Sniper_Keyword))
    title = MCS_ClassTitles_CrimsonFleet.GetAt(enumFactionClasses.Sniper) as Message
  ElseIf (Self.HasKeyword(FactionTypeCrimsonFleet) && Self.HasKeyword(CombatRole_Support_Keyword))
    title = MCS_ClassTitles_CrimsonFleet.GetAt(enumFactionClasses.Support) as Message
  EndIf

  If (title == None)
    title = MCS_ClassTitles_CrimsonFleet.GetAt(enumFactionClasses.Generic) as Message
  EndIf

  return title
EndFunction

Message Function GenerateEclipticTitle()
  Message title = None
  If (Self.HasKeyword(FactionTypeEcliptic) && Self.HasKeyword(CombatRole_Assault_Keyword))
    title = MCS_ClassTitles_Ecliptic.GetAt(enumFactionClasses.Assault) as Message
  ElseIf (Self.HasKeyword(FactionTypeEcliptic) && Self.HasKeyword(CombatRole_Boss_Keyword))
    title = MCS_ClassTitles_Ecliptic.GetAt(enumFactionClasses.Boss) as Message
  ElseIf (Self.HasKeyword(FactionTypeEcliptic) && Self.HasKeyword(CombatRole_Charger_Keyword))
    title = MCS_ClassTitles_Ecliptic.GetAt(enumFactionClasses.Charger) as Message
  ElseIf (Self.HasKeyword(FactionTypeEcliptic) && Self.HasKeyword(CombatRole_Heavy_Keyword))
    title = MCS_ClassTitles_Ecliptic.GetAt(enumFactionClasses.Heavy) as Message
  ElseIf (Self.HasKeyword(FactionTypeEcliptic) && Self.HasKeyword(CombatRole_Officer_Keyword))
    title = MCS_ClassTitles_Ecliptic.GetAt(enumFactionClasses.Officer) as Message
  ElseIf (Self.HasKeyword(FactionTypeEcliptic) && Self.HasKeyword(CombatRole_Recruit_Keyword))
    title = MCS_ClassTitles_Ecliptic.GetAt(enumFactionClasses.Recruit) as Message
  ElseIf (Self.HasKeyword(FactionTypeEcliptic) && Self.HasKeyword(CombatRole_Sniper_Keyword))
    title = MCS_ClassTitles_Ecliptic.GetAt(enumFactionClasses.Sniper) as Message
  ElseIf (Self.HasKeyword(FactionTypeEcliptic) && Self.HasKeyword(CombatRole_Support_Keyword))
    title = MCS_ClassTitles_Ecliptic.GetAt(enumFactionClasses.Support) as Message
  EndIf

  If (title == None)
    title = MCS_ClassTitles_Ecliptic.GetAt(enumFactionClasses.Generic) as Message
  EndIf

  return title
EndFunction

Message Function GenerateHouseVaruunTitle()
  Message title = None
  If (Self.HasKeyword(FactionTypeHouseVaruun) && Self.HasKeyword(CombatRole_Assault_Keyword))
    title = MCS_ClassTitles_HouseVaruun.GetAt(enumFactionClasses.Assault) as Message
  ElseIf (Self.HasKeyword(FactionTypeHouseVaruun) && Self.HasKeyword(CombatRole_Boss_Keyword))
    title = MCS_ClassTitles_HouseVaruun.GetAt(enumFactionClasses.Boss) as Message
  ElseIf (Self.HasKeyword(FactionTypeHouseVaruun) && Self.HasKeyword(CombatRole_Charger_Keyword))
    title = MCS_ClassTitles_HouseVaruun.GetAt(enumFactionClasses.Charger) as Message
  ElseIf (Self.HasKeyword(FactionTypeHouseVaruun) && Self.HasKeyword(CombatRole_Heavy_Keyword))
    title = MCS_ClassTitles_HouseVaruun.GetAt(enumFactionClasses.Heavy) as Message
  ElseIf (Self.HasKeyword(FactionTypeHouseVaruun) && Self.HasKeyword(CombatRole_Officer_Keyword))
    title = MCS_ClassTitles_HouseVaruun.GetAt(enumFactionClasses.Officer) as Message
  ElseIf (Self.HasKeyword(FactionTypeHouseVaruun) && Self.HasKeyword(CombatRole_Recruit_Keyword))
    title = MCS_ClassTitles_HouseVaruun.GetAt(enumFactionClasses.Recruit) as Message
  ElseIf (Self.HasKeyword(FactionTypeHouseVaruun) && Self.HasKeyword(CombatRole_Sniper_Keyword))
    title = MCS_ClassTitles_HouseVaruun.GetAt(enumFactionClasses.Sniper) as Message
  ElseIf (Self.HasKeyword(FactionTypeHouseVaruun) && Self.HasKeyword(CombatRole_Support_Keyword))
    title = MCS_ClassTitles_HouseVaruun.GetAt(enumFactionClasses.Support) as Message
  EndIf

  If (title == None)
    title = MCS_ClassTitles_HouseVaruun.GetAt(enumFactionClasses.Generic) as Message
  EndIf

  return title
EndFunction

Message Function GenerateSpacerTitle()
  Message title = None
  If (Self.HasKeyword(FactionTypeSpacer) && Self.HasKeyword(CombatRole_Assault_Keyword))
    title = MCS_ClassTitles_Spacer.GetAt(enumFactionClasses.Assault) as Message
  ElseIf (Self.HasKeyword(FactionTypeSpacer) && Self.HasKeyword(CombatRole_Boss_Keyword))
    title = MCS_ClassTitles_Spacer.GetAt(enumFactionClasses.Boss) as Message
  ElseIf (Self.HasKeyword(FactionTypeSpacer) && Self.HasKeyword(CombatRole_Charger_Keyword))
    title = MCS_ClassTitles_Spacer.GetAt(enumFactionClasses.Charger) as Message
  ElseIf (Self.HasKeyword(FactionTypeSpacer) && Self.HasKeyword(CombatRole_Heavy_Keyword))
    title = MCS_ClassTitles_Spacer.GetAt(enumFactionClasses.Heavy) as Message
  ElseIf (Self.HasKeyword(FactionTypeSpacer) && Self.HasKeyword(CombatRole_Officer_Keyword))
    title = MCS_ClassTitles_Spacer.GetAt(enumFactionClasses.Officer) as Message
  ElseIf (Self.HasKeyword(FactionTypeSpacer) && Self.HasKeyword(CombatRole_Recruit_Keyword))
    title = MCS_ClassTitles_Spacer.GetAt(enumFactionClasses.Recruit) as Message
  ElseIf (Self.HasKeyword(FactionTypeSpacer) && Self.HasKeyword(CombatRole_Sniper_Keyword))
    title = MCS_ClassTitles_Spacer.GetAt(enumFactionClasses.Sniper) as Message
  ElseIf (Self.HasKeyword(FactionTypeSpacer) && Self.HasKeyword(CombatRole_Support_Keyword))
    title = MCS_ClassTitles_Spacer.GetAt(enumFactionClasses.Support) as Message
  EndIf

  If (title == None)
    title = MCS_ClassTitles_Spacer.GetAt(enumFactionClasses.Generic) as Message
  EndIf

  return title
EndFunction

Message Function GenerateStarbornTitle()
  Message title = None
  If (Self.HasKeyword(FactionTypeStarborn) && Self.HasKeyword(CombatRole_Assault_Keyword))
    title = MCS_ClassTitles_Starborn.GetAt(enumFactionClasses.Assault) as Message
  ElseIf (Self.HasKeyword(FactionTypeStarborn) && Self.HasKeyword(CombatRole_Boss_Keyword))
    title = MCS_ClassTitles_Starborn.GetAt(enumFactionClasses.Boss) as Message
  ElseIf (Self.HasKeyword(FactionTypeStarborn) && Self.HasKeyword(CombatRole_Charger_Keyword))
    title = MCS_ClassTitles_Starborn.GetAt(enumFactionClasses.Charger) as Message
  ElseIf (Self.HasKeyword(FactionTypeStarborn) && Self.HasKeyword(CombatRole_Heavy_Keyword))
    title = MCS_ClassTitles_Starborn.GetAt(enumFactionClasses.Heavy) as Message
  ElseIf (Self.HasKeyword(FactionTypeStarborn) && Self.HasKeyword(CombatRole_Officer_Keyword))
    title = MCS_ClassTitles_Starborn.GetAt(enumFactionClasses.Officer) as Message
  ElseIf (Self.HasKeyword(FactionTypeStarborn) && Self.HasKeyword(CombatRole_Recruit_Keyword))
    title = MCS_ClassTitles_Starborn.GetAt(enumFactionClasses.Recruit) as Message
  ElseIf (Self.HasKeyword(FactionTypeStarborn) && Self.HasKeyword(CombatRole_Sniper_Keyword))
    title = MCS_ClassTitles_Starborn.GetAt(enumFactionClasses.Sniper) as Message
  ElseIf (Self.HasKeyword(FactionTypeStarborn) && Self.HasKeyword(CombatRole_Support_Keyword))
    title = MCS_ClassTitles_Starborn.GetAt(enumFactionClasses.Support) as Message
  EndIf

  If (title == None)
    title = MCS_ClassTitles_Starborn.GetAt(enumFactionClasses.Generic) as Message
  EndIf

  return title
EndFunction

Message Function GenerateSyndicateTitle()
  Message title = None
  If (Self.HasKeyword(FactionTypeSyndicate) && Self.HasKeyword(CombatRole_Assault_Keyword))
    title = MCS_ClassTitles_Syndicate.GetAt(enumFactionClasses.Assault) as Message
  ElseIf (Self.HasKeyword(FactionTypeSyndicate) && Self.HasKeyword(CombatRole_Boss_Keyword))
    title = MCS_ClassTitles_Syndicate.GetAt(enumFactionClasses.Boss) as Message
  ElseIf (Self.HasKeyword(FactionTypeSyndicate) && Self.HasKeyword(CombatRole_Charger_Keyword))
    title = MCS_ClassTitles_Syndicate.GetAt(enumFactionClasses.Charger) as Message
  ElseIf (Self.HasKeyword(FactionTypeSyndicate) && Self.HasKeyword(CombatRole_Heavy_Keyword))
    title = MCS_ClassTitles_Syndicate.GetAt(enumFactionClasses.Heavy) as Message
  ElseIf (Self.HasKeyword(FactionTypeSyndicate) && Self.HasKeyword(CombatRole_Officer_Keyword))
    title = MCS_ClassTitles_Syndicate.GetAt(enumFactionClasses.Officer) as Message
  ElseIf (Self.HasKeyword(FactionTypeSyndicate) && Self.HasKeyword(CombatRole_Recruit_Keyword))
    title = MCS_ClassTitles_Syndicate.GetAt(enumFactionClasses.Recruit) as Message
  ElseIf (Self.HasKeyword(FactionTypeSyndicate) && Self.HasKeyword(CombatRole_Sniper_Keyword))
    title = MCS_ClassTitles_Syndicate.GetAt(enumFactionClasses.Sniper) as Message
  ElseIf (Self.HasKeyword(FactionTypeSyndicate) && Self.HasKeyword(CombatRole_Support_Keyword))
    title = MCS_ClassTitles_Syndicate.GetAt(enumFactionClasses.Support) as Message
  EndIf

  If (title == None)
    title = MCS_ClassTitles_Syndicate.GetAt(enumFactionClasses.Generic) as Message
  EndIf

  return title
EndFunction

Message Function GenerateTheFirstTitle()
  Message title = None
  If (Self.HasKeyword(FactionTypeTheFirst) && Self.HasKeyword(CombatRole_Assault_Keyword))
    title = MCS_ClassTitles_TheFirst.GetAt(enumFactionClasses.Assault) as Message
  ElseIf (Self.HasKeyword(FactionTypeTheFirst) && Self.HasKeyword(CombatRole_Boss_Keyword))
    title = MCS_ClassTitles_TheFirst.GetAt(enumFactionClasses.Boss) as Message
  ElseIf (Self.HasKeyword(FactionTypeTheFirst) && Self.HasKeyword(CombatRole_Charger_Keyword))
    title = MCS_ClassTitles_TheFirst.GetAt(enumFactionClasses.Charger) as Message
  ElseIf (Self.HasKeyword(FactionTypeTheFirst) && Self.HasKeyword(CombatRole_Heavy_Keyword))
    title = MCS_ClassTitles_TheFirst.GetAt(enumFactionClasses.Heavy) as Message
  ElseIf (Self.HasKeyword(FactionTypeTheFirst) && Self.HasKeyword(CombatRole_Officer_Keyword))
    title = MCS_ClassTitles_TheFirst.GetAt(enumFactionClasses.Officer) as Message
  ElseIf (Self.HasKeyword(FactionTypeTheFirst) && Self.HasKeyword(CombatRole_Recruit_Keyword))
    title = MCS_ClassTitles_TheFirst.GetAt(enumFactionClasses.Recruit) as Message
  ElseIf (Self.HasKeyword(FactionTypeTheFirst) && Self.HasKeyword(CombatRole_Sniper_Keyword))
    title = MCS_ClassTitles_TheFirst.GetAt(enumFactionClasses.Sniper) as Message
  ElseIf (Self.HasKeyword(FactionTypeTheFirst) && Self.HasKeyword(CombatRole_Support_Keyword))
    title = MCS_ClassTitles_TheFirst.GetAt(enumFactionClasses.Support) as Message
  EndIf

  If (title == None)
    title = MCS_ClassTitles_TheFirst.GetAt(enumFactionClasses.Generic) as Message
  EndIf

  return title
EndFunction
