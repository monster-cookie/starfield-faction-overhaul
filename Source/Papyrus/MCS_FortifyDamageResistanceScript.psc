ScriptName MCS_FortifyDamageResistanceScript Extends ActiveMagicEffect

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
ActorValue Property DamageResist Auto Const Mandatory


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
  ; VPI_Debug.DebugMessage(Venpi_ModName, "MCS_FortifyDamageResistanceScript", "OnEffectStart", akTarget + ": OnEffectStart triggered - Scale NPC Damage Resistance based on player level.", 0, Venpi_DebugEnabled.GetValueInt())
  RealMe = akTarget as Actor
  Int playerLevel = Game.GetPlayer().GetLevel()
  Int currentDamageResist = RealMe.GetValueInt(DamageResist)
  Int scaledDamageResist = Math.Round((currentDamageResist + (playerLevel * 0.7)) * afMagnitude)
  VPI_Debug.DebugMessage(Venpi_ModName, "MCS_FortifyDamageResistanceScript", "OnEffectStart", akTarget + ": ([currentDamageResist:" + currentDamageResist + "] + ([playerLevel:" + playerLevel + "] * 0.7)) * [afMagnitude:" + afMagnitude + "] = " + scaledDamageResist, 0, Venpi_DebugEnabled.GetValueInt())

  ;; 700 damage resist is cap and god mod so adjust back so player can damage them
  If (scaledDamageResist > 600)
    scaledDamageResist = 600
  EndIf

  VPI_Debug.DebugMessage(Venpi_ModName, "MCS_FortifyDamageResistanceScript", "OnEffectStart", akTarget + ": Current Damage Resistance was " + currentDamageResist + " scaled is now " + scaledDamageResist + ".", 0, Venpi_DebugEnabled.GetValueInt())
  RealMe.SetValue(DamageResist, scaledDamageResist as Float)
EndEvent

Event OnEffectFinish(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  ; VPI_Debug.DebugMessage(Venpi_ModName, "MCS_FortifyDamageResistanceScript", "OnEffectFinish", akTarget + ": OnEffectFinish triggered - This is a persistent buff so this shouldn't be called.", 0, Venpi_DebugEnabled.GetValueInt())
EndEvent
