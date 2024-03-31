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
Keyword Property CombatRole_Recruit_Keyword Auto Const Mandatory
Keyword Property CombatRole_Sniper_Keyword Auto Const Mandatory
Keyword Property CombatRole_Support_Keyword Auto Const Mandatory

;; Crimson Fleet/Pirate Stuff
Keyword Property FactionTypeCrimsonFleet Auto Const Mandatory
Message Property MCS_AUTONAME_CrimsonFleet_Assault Auto Const Mandatory
Message Property MCS_AUTONAME_CrimsonFleet_Boss Auto Const Mandatory
Message Property MCS_AUTONAME_CrimsonFleet_Charger Auto Const Mandatory
Message Property MCS_AUTONAME_CrimsonFleet_Heavy Auto Const Mandatory
Message Property MCS_AUTONAME_CrimsonFleet_Recruit Auto Const Mandatory
Message Property MCS_AUTONAME_CrimsonFleet_Sniper Auto Const Mandatory
Message Property MCS_AUTONAME_CrimsonFleet_Support Auto Const Mandatory

;; Ecliptic Stuff
Keyword Property FactionTypeEcliptic Auto Const Mandatory
Message Property MCS_AUTONAME_Ecliptic_Assault Auto Const Mandatory
Message Property MCS_AUTONAME_Ecliptic_Boss Auto Const Mandatory
Message Property MCS_AUTONAME_Ecliptic_Charger Auto Const Mandatory
Message Property MCS_AUTONAME_Ecliptic_Heavy Auto Const Mandatory
Message Property MCS_AUTONAME_Ecliptic_Recruit Auto Const Mandatory
Message Property MCS_AUTONAME_Ecliptic_Sniper Auto Const Mandatory
Message Property MCS_AUTONAME_Ecliptic_Support Auto Const Mandatory

;; Spacer Stuff
Keyword Property FactionTypeSpacer Auto Const Mandatory
Message Property MCS_AUTONAME_Spacer_Assault Auto Const Mandatory
Message Property MCS_AUTONAME_Spacer_Boss Auto Const Mandatory
Message Property MCS_AUTONAME_Spacer_Charger Auto Const Mandatory
Message Property MCS_AUTONAME_Spacer_Heavy Auto Const Mandatory
Message Property MCS_AUTONAME_Spacer_Recruit Auto Const Mandatory
Message Property MCS_AUTONAME_Spacer_Sniper Auto Const Mandatory
Message Property MCS_AUTONAME_Spacer_Support Auto Const Mandatory

;; 1st Cav Stuff
Keyword Property FactionTypeTheFirst Auto Const Mandatory
Message Property MCS_AUTONAME_TheFirst_Assault Auto Const Mandatory
Message Property MCS_AUTONAME_TheFirst_Boss Auto Const Mandatory
Message Property MCS_AUTONAME_TheFirst_Charger Auto Const Mandatory
Message Property MCS_AUTONAME_TheFirst_Heavy Auto Const Mandatory
Message Property MCS_AUTONAME_TheFirst_Recruit Auto Const Mandatory
Message Property MCS_AUTONAME_TheFirst_Sniper Auto Const Mandatory
Message Property MCS_AUTONAME_TheFirst_Support Auto Const Mandatory

;; Unhandled Factions
Keyword Property FactionTypeFreestarCollective Auto Const Mandatory
Keyword Property FactionTypeHouseVaruun Auto Const Mandatory
Keyword Property FactionTypeRyujinIndustries Auto Const Mandatory
Keyword Property FactionTypeStarborn Auto Const Mandatory
Keyword Property FactionTypeSyndicate Auto Const Mandatory
Keyword Property FactionTypeUnitedColonies Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Variables
;;;
Faction Property MyCrimeFaction Auto
Faction Property MyGroupFaction Auto

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnLoad()
  VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "OnLoad", "OnLoad triggered - Generate and apply random name for the NPC.", 0, Venpi_DebugEnabled.GetValueInt())
  MyCrimeFaction = Self.GetCrimeFaction()
  MyGroupFaction = Self.GetGroupFaction()

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
    Return None ;; NOT IMPLEMENTED YET
  ElseIf (Self.HasKeyword(FactionTypeRyujinIndustries))
    Return None ;; NOT IMPLEMENTED YET
  ElseIf (Self.HasKeyword(FactionTypeSpacer))
    Return GenerateSpacerTitle()
  ElseIf (Self.HasKeyword(FactionTypeStarborn))
    Return None ;; NOT IMPLEMENTED YET
  ElseIf (Self.HasKeyword(FactionTypeSyndicate))
    Return None ;; NOT IMPLEMENTED YET
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
  If (Self.HasKeyword(FactionTypeCrimsonFleet) && Self.HasKeyword(CombatRole_Assault_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateCrimsonFleetTitle", "Returning title for a Crimson Fleet faction Assault class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_CrimsonFleet_Assault
  ElseIf (Self.HasKeyword(FactionTypeCrimsonFleet) && Self.HasKeyword(CombatRole_Boss_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateCrimsonFleetTitle", "Returning title for a Crimson Fleet faction Boss class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_CrimsonFleet_Boss
  ElseIf (Self.HasKeyword(FactionTypeCrimsonFleet) && Self.HasKeyword(CombatRole_Charger_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateCrimsonFleetTitle", "Returning title for a Crimson Fleet faction Charger class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_CrimsonFleet_Charger
  ElseIf (Self.HasKeyword(FactionTypeCrimsonFleet) && Self.HasKeyword(CombatRole_Heavy_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateCrimsonFleetTitle", "Returning title for a Crimson Fleet faction Heavy class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_CrimsonFleet_Heavy
  ElseIf (Self.HasKeyword(FactionTypeCrimsonFleet) && Self.HasKeyword(CombatRole_Recruit_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateCrimsonFleetTitle", "Returning title for a Crimson Fleet faction Recruit class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_CrimsonFleet_Recruit
  ElseIf (Self.HasKeyword(FactionTypeCrimsonFleet) && Self.HasKeyword(CombatRole_Sniper_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateCrimsonFleetTitle", "Returning title for a Crimson Fleet faction Sniper class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_CrimsonFleet_Sniper
  ElseIf (Self.HasKeyword(FactionTypeCrimsonFleet) && Self.HasKeyword(CombatRole_Support_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateCrimsonFleetTitle", "Returning title for a Crimson Fleet faction Support class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_CrimsonFleet_Support
  Else
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateCrimsonFleetTitle", "Failed to find title for NPC " + Self + ".", 0, Venpi_DebugEnabled.GetValueInt())
    Return None
  EndIf
EndFunction

Message Function GenerateEclipticTitle()
  If (Self.HasKeyword(FactionTypeEcliptic) && Self.HasKeyword(CombatRole_Assault_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateEclipticTitle", "Returning title for a Ecliptic faction Assault class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_Ecliptic_Assault
  ElseIf (Self.HasKeyword(FactionTypeEcliptic) && Self.HasKeyword(CombatRole_Boss_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateEclipticTitle", "Returning title for a Ecliptic faction Boss class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_Ecliptic_Boss
  ElseIf (Self.HasKeyword(FactionTypeEcliptic) && Self.HasKeyword(CombatRole_Charger_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateEclipticTitle", "Returning title for a Ecliptic faction Charger class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_Ecliptic_Charger
  ElseIf (Self.HasKeyword(FactionTypeEcliptic) && Self.HasKeyword(CombatRole_Heavy_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateEclipticTitle", "Returning title for a Ecliptic faction Heavy class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_Ecliptic_Heavy
  ElseIf (Self.HasKeyword(FactionTypeEcliptic) && Self.HasKeyword(CombatRole_Recruit_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateEclipticTitle", "Returning title for a Ecliptic faction Recruit class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_Ecliptic_Recruit
  ElseIf (Self.HasKeyword(FactionTypeEcliptic) && Self.HasKeyword(CombatRole_Sniper_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateEclipticTitle", "Returning title for a Ecliptic faction Sniper class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_Ecliptic_Sniper
  ElseIf (Self.HasKeyword(FactionTypeEcliptic) && Self.HasKeyword(CombatRole_Support_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateEclipticTitle", "Returning title for a Ecliptic faction Support class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_Ecliptic_Support
  Else
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateEclipticTitle", "Failed to find title for NPC " + Self + ".", 0, Venpi_DebugEnabled.GetValueInt())
    Return None
  EndIf
EndFunction

Message Function GenerateSpacerTitle()
  If (Self.HasKeyword(FactionTypeSpacer) && Self.HasKeyword(CombatRole_Assault_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateSpacerTitle", "Returning title for a Spacer faction Assault class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_Spacer_Assault
  ElseIf (Self.HasKeyword(FactionTypeSpacer) && Self.HasKeyword(CombatRole_Boss_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateSpacerTitle", "Returning title for a Spacer faction Boss class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_Spacer_Boss
  ElseIf (Self.HasKeyword(FactionTypeSpacer) && Self.HasKeyword(CombatRole_Charger_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateSpacerTitle", "Returning title for a Spacer faction Charger class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_Spacer_Charger
  ElseIf (Self.HasKeyword(FactionTypeSpacer) && Self.HasKeyword(CombatRole_Heavy_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateSpacerTitle", "Returning title for a Spacer faction Heavy class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_Spacer_Heavy
  ElseIf (Self.HasKeyword(FactionTypeSpacer) && Self.HasKeyword(CombatRole_Recruit_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateSpacerTitle", "Returning title for a Spacer faction Recruit class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_Spacer_Recruit
  ElseIf (Self.HasKeyword(FactionTypeSpacer) && Self.HasKeyword(CombatRole_Sniper_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateSpacerTitle", "Returning title for a Spacer faction Sniper class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_Spacer_Sniper
  ElseIf (Self.HasKeyword(FactionTypeSpacer) && Self.HasKeyword(CombatRole_Support_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateSpacerTitle", "Returning title for a Spacer faction Support class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_Spacer_Support
  Else
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateSpacerTitle", "Failed to find title for NPC " + Self + ".", 0, Venpi_DebugEnabled.GetValueInt())
    Return None
  EndIf
EndFunction

Message Function GenerateTheFirstTitle()
  If (Self.HasKeyword(FactionTypeTheFirst) && Self.HasKeyword(CombatRole_Assault_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateTheFirstTitle", "Returning title for a 1st Cav faction Assault class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_TheFirst_Assault
  ElseIf (Self.HasKeyword(FactionTypeTheFirst) && Self.HasKeyword(CombatRole_Boss_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateTheFirstTitle", "Returning title for a 1st Cav faction Boss class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_TheFirst_Boss
  ElseIf (Self.HasKeyword(FactionTypeTheFirst) && Self.HasKeyword(CombatRole_Charger_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateTheFirstTitle", "Returning title for a 1st Cav faction Charger class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_TheFirst_Charger
  ElseIf (Self.HasKeyword(FactionTypeTheFirst) && Self.HasKeyword(CombatRole_Heavy_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateTheFirstTitle", "Returning title for a 1st Cav faction Heavy class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_TheFirst_Heavy
  ElseIf (Self.HasKeyword(FactionTypeTheFirst) && Self.HasKeyword(CombatRole_Recruit_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateTheFirstTitle", "Returning title for a 1st Cav faction Recruit class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_TheFirst_Recruit
  ElseIf (Self.HasKeyword(FactionTypeTheFirst) && Self.HasKeyword(CombatRole_Sniper_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateTheFirstTitle", "Returning title for a 1st Cav faction Sniper class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_TheFirst_Sniper
  ElseIf (Self.HasKeyword(FactionTypeTheFirst) && Self.HasKeyword(CombatRole_Support_Keyword))
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateTheFirstTitle", "Returning title for a 1st Cav faction Support class.", 0, Venpi_DebugEnabled.GetValueInt())
    Return MCS_AUTONAME_TheFirst_Support
  Else
    VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideAutomaticTitle", "GenerateTheFirstTitle", "Failed to find title for NPC " + Self + ".", 0, Venpi_DebugEnabled.GetValueInt())
    Return None
  EndIf
EndFunction
