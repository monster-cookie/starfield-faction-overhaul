ScriptName VFOH_Help

;;
;; MAJOR NOTE: ALL FUNCTIONS MUST BE GLOBAL WITHOUT CREATION KIT
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;

;; Call using: CGF "VFOH_Help.Show" 
Function Show() Global
  String message = "Cora is a completely stand alone companion based on the variant universe version of here combined with the hunter/emissary.\n" 
  message += "\n\nHow to use\n\n"
  message += "     Feature Flags status screen:\n\tCGF \"VFOH_Help.FeatureFlags\"\n"
  message += "To toggle debug mode and logging:\n\tCGF \"VFOH_Help.ToggleDebugMode\"\n"
  message += "\n\n"

  Debug.MessageBox(message)
EndFunction