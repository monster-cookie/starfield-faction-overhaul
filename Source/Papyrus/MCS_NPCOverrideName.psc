ScriptName MCS_NPCOverrideName Extends Actor

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
FormList Property LIST_NAMES_MALE Auto Const Mandatory
FormList Property LIST_NAMES_FEMALE Auto Const Mandatory


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Variables
;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnLoad()
  VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideName", "OnLoad", "OnLoad triggered - Generate and apply random name for the NPC.", 0, Venpi_DebugEnabled.GetValueInt())
  self.SetOverrideName(GetFullName())
EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
Message Function GetFullName()
  Int sex = self.GetLeveledActorBase().GetSex()
  VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideName", "GetFullName", "Generating full name for a sex type " + sex + "(0=Male, 1=Female).", 0, Venpi_DebugEnabled.GetValueInt())
  If (sex == 0)
    ;; Male
    return GetMaleName()
  ElseIf(sex == 1)
    ;; Female
    return GetFemaleName()
  Else
    If (Game.GetDieRollSuccess(50, 1, 100, -1, -1))
      return GetMaleName()
    Else
      return GetFemaleName()
    EndIf
  EndIf
EndFunction

Message Function GetMaleName()
  Int nameIndex = Utility.RandomInt(0, LIST_NAMES_MALE.GetSize() - 1)
  VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideName", "GetMaleName", "Generating full name for a male using index position " + " of " + LIST_NAMES_MALE.GetSize() + ".", 0, Venpi_DebugEnabled.GetValueInt())
  Return LIST_NAMES_MALE.GetAt(nameIndex) as Message
EndFunction

Message Function GetFemaleName()
  Int nameIndex = Utility.RandomInt(0, LIST_NAMES_FEMALE.GetSize() - 1)
  VPI_Debug.DebugMessage(Venpi_ModName, "MCS_NPCOverrideName", "GetFemaleName", "Generating full name for a female using index position " + nameIndex + " of " + LIST_NAMES_FEMALE.GetSize() + ".", 0, Venpi_DebugEnabled.GetValueInt())
  Return LIST_NAMES_FEMALE.GetAt(nameIndex) as Message
EndFunction
