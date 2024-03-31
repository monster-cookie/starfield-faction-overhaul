ScriptName MCS_FortifyElectromagneticResistanceScript Extends ActiveMagicEffect

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
ActorValue Property ElectromagneticDamageResist Auto Const Mandatory


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Variables
;;;
Actor RealMe


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnEffectStart(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  ; VPI_Debug.DebugMessage(Venpi_ModName, "MCS_FortifyElectromagneticResistanceScript", "OnEffectStart", akTarget + ": OnEffectStart triggered - Scale NPC Electromagnetic Resistance based on player level.", 0, Venpi_DebugEnabled.GetValueInt())
  RealMe = akTarget as Actor
  Int playerLevel = Game.GetPlayer().GetLevel()
  Int currentElectromagneticDamageResist = RealMe.GetValueInt(ElectromagneticDamageResist)
  Int scaledElectromagneticDamageResist = Math.Round((currentElectromagneticDamageResist + (playerLevel * 0.7)) * afMagnitude)
  VPI_Debug.DebugMessage(Venpi_ModName, "MCS_FortifyDamageResistanceScript", "OnEffectStart", akTarget + ": ([currentElectromagneticDamageResist:" + currentElectromagneticDamageResist + "] + ([playerLevel:" + playerLevel + "] * 0.7)) * [afMagnitude:" + afMagnitude + "] = " + scaledElectromagneticDamageResist, 0, Venpi_DebugEnabled.GetValueInt())

  ;; 700 Electromagnetic resist is cap and god mod so adjust back so player can Electromagnetic them
  If (scaledElectromagneticDamageResist > 600)
    scaledElectromagneticDamageResist = 600
  EndIf

  VPI_Debug.DebugMessage(Venpi_ModName, "MCS_FortifyElectromagneticResistanceScript", "OnEffectStart", akTarget + ": Current Electromagnetic Resistance was " + currentElectromagneticDamageResist + " scaled is now " + scaledElectromagneticDamageResist + ".", 0, Venpi_DebugEnabled.GetValueInt())
  RealMe.SetValue(ElectromagneticDamageResist, scaledElectromagneticDamageResist as Float)
EndEvent

Event OnEffectFinish(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  ; VPI_Debug.DebugMessage(Venpi_ModName, "MCS_FortifyElectromagneticResistanceScript", "OnEffectFinish", akTarget + ": OnEffectFinish triggered - This is a persistent buff so this shouldn't be called.", 0, Venpi_DebugEnabled.GetValueInt())
EndEvent
