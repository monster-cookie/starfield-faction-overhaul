ScriptName MCS_FortifyHealthScript Extends ActiveMagicEffect

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
ActorValue Property Health Auto Const Mandatory


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
  ; VPI_Debug.DebugMessage(Venpi_ModName, "MCS_FortifyHealthScript", "OnEffectStart", akTarget + ": OnEffectStart triggered - Scale NPC Health based on player level.", 0, Venpi_DebugEnabled.GetValueInt())
  RealMe = akTarget as Actor
  Int playerLevel = Game.GetPlayer().GetLevel()
  Int currentHealth = RealMe.GetValueInt(Health)
  Int scaledHealth = Math.Round((currentHealth + (playerLevel * 20)) * afMagnitude)

  VPI_Debug.DebugMessage(Venpi_ModName, "MCS_FortifyHealthScript", "OnEffectStart", akTarget + ": ([currentHealth:" + currentHealth + "] + ([playerLevel:" + playerLevel + "] * 20)) * [afMagnitude:" + afMagnitude + "] = " + scaledHealth, 0, Venpi_DebugEnabled.GetValueInt())
  VPI_Debug.DebugMessage(Venpi_ModName, "MCS_FortifyHealthScript", "OnEffectStart", akTarget + ": Current Health was " + currentHealth + " scaled is now " + scaledHealth + ".", 0, Venpi_DebugEnabled.GetValueInt())
  RealMe.SetValue(Health, scaledHealth as Float)
EndEvent

Event OnEffectFinish(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  ; VPI_Debug.DebugMessage(Venpi_ModName, "MCS_FortifyHealthScript", "OnEffectFinish", akTarget + ": OnEffectFinish triggered - This is a persistent buff so this shouldn't be called.", 0, Venpi_DebugEnabled.GetValueInt())
EndEvent
