ScriptName MCS_FortifyEnergyResistanceScript Extends ActiveMagicEffect

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
ActorValue Property EnergyResist Auto Const Mandatory


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
  ; VPI_Debug.DebugMessage(Venpi_ModName, "MCS_FortifyEnergyResistanceScript", "OnEffectStart", akTarget + ": OnEffectStart triggered - Scale NPC Energy Resistance based on player level.", 0, Venpi_DebugEnabled.GetValueInt())
  RealMe = akTarget as Actor
  Int playerLevel = Game.GetPlayer().GetLevel()
  Int currentEnergyResist = RealMe.GetValueInt(EnergyResist)
  Int scaledEnergyResist = Math.Round((currentEnergyResist + (playerLevel * 0.7)) * afMagnitude)
  VPI_Debug.DebugMessage(Venpi_ModName, "MCS_FortifyDamageResistanceScript", "OnEffectStart", akTarget + ": ([currentEnergyResist:" + currentEnergyResist + "] + ([playerLevel:" + playerLevel + "] * 0.7)) * [afMagnitude:" + afMagnitude + "] = " + scaledEnergyResist, 0, Venpi_DebugEnabled.GetValueInt())

  ;; 700 Energy resist is cap and god mod so adjust back so player can Energy them
  If (scaledEnergyResist > 600)
    scaledEnergyResist = 600
  EndIf

  VPI_Debug.DebugMessage(Venpi_ModName, "MCS_FortifyEnergyResistanceScript", "OnEffectStart", akTarget + ": Current Energy Resistance was " + currentEnergyResist + " scaled is now " + scaledEnergyResist + ".", 0, Venpi_DebugEnabled.GetValueInt())
  RealMe.SetValue(EnergyResist, scaledEnergyResist as Float)
EndEvent

Event OnEffectFinish(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  ; VPI_Debug.DebugMessage(Venpi_ModName, "MCS_FortifyEnergyResistanceScript", "OnEffectFinish", akTarget + ": OnEffectFinish triggered - This is a persistent buff so this shouldn't be called.", 0, Venpi_DebugEnabled.GetValueInt())
EndEvent
