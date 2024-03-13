ScriptName HCS_NPCOverrideName Extends Actor

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
  VPI_Debug.DebugMessage(Venpi_ModName, "HCS_NPCOverrideName", "OnLoad", "OnLoad triggered - Generate and apply random name for the NPC.", 0, Venpi_DebugEnabled.GetValueInt())
  If (Self.IsDead() == False)
    self.SetOverrideName(GetFullName())
  EndIf
EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
Message Function GetFullName()
  Int sex = self.GetLeveledActorBase().GetSex()
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
  Return LIST_NAMES_MALE.GetAt(Utility.RandomInt(0, LIST_NAMES_MALE.GetSize() - 1)) as Message
EndFunction

Message Function GetFemaleName()
  Return LIST_NAMES_FEMALE.GetAt(Utility.RandomInt(0, LIST_NAMES_FEMALE.GetSize() - 1)) as Message
EndFunction
