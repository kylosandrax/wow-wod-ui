sh_Local = {}
sh_local_shield = {}

local VERSION = 2.35
local mylocale = GetLocale()
--[[
	If you want to help to localise this addon, just change the right text, and send me this these few lines.  azwentry(at)gmail(dot)com
	Or go to http://wow.curseforge.com/addons/shieldhealth/localization/
	key = 							"Translate it !"
----------------------------------------------------------------------]]
sh_Local = {
	Transparence = 					OPACITY,
	
	Couleur_des_Boucliers = 		"Colors",
	Apparence_barre_boucliers = 	"Appearance of the bar",
	Texture_barre_boucliers = 		"Texture of the bar",
	Police_vie_boucliers = 			"Fonts of the life",
	Contour =						"Outline",
	Taille_texte = 					"Text Size",
	Apparence_generale = 			"General Appearance",
	Largeur_globale = 				"Width",
	Hauteur_globale = 				"Height",
	Texture_bordure_generale = 		"Border's texture",
	Texture_fond = 					"Background texture",
	Couleur_fond = 					"Background color",
	Taille_icones = 				"Icon size",
	Options = 						"General options",
	Activer = 						"Enable",
	Icone =							"Icon",
	Deverouiller = 					"Unlock",
	Verouiller = 					"Lock",
	Couleur_texte = 				"Text color",
	Joueur = 						"Player's bar",
	Ordre = 						"Shield order",
	diverspanel = 					"Miscellaneous",
	integrpanel = 					"Integration",
	Cooldown = 						"Cooldown",
	Taille_bordure =				"Border width",
	insets =						"Padding",
	top =							"Top",
	left =							"Left",
	right =							"Rigth",
	bottom =						"Botttom",
	Cible = 						"Target's Bar",
	short = 						"Short number format",
	test = 							"Test mode",
	player = 						"Player",
	target = 						"Target",
	level = 						"Frame level",
	targettoplayer =				"Copy settings : Target => Player",
	playertotarget =				"Copy settings : Player => Target",
	plus = 							"More ...",
	blink = 						"Blinking",
	show_only_in_combat = 			"Only in combat",
	below_lvl_10 = 					"none",
	othershield = 					"Other Shield",
	
	
	cooldown_enable = 				"Toggle all timers",
	cooldown_border = 				"Enable border display",
	cooldown_inset = 				"Inset padding",
	cooldown_anchor = 				"Anchored",
	cooldown_module_rapture = 		"Rapture timer",
	
	Profile = 						"Profiles",
	Profile_appliquer_spe1 = 		"Apply for spec1",
	Profile_appliquer_spe2 = 		"Apply for spec2",
	Profile_rename = 				"Rename",
	Profile_saveas = 				"Save as",
	Profile_nouveau = 				"New",
	Profile_delete = 				"Delete",
	Profile_Popup_rename =			"Rename the selected profile.",
	Profile_Popup_saveas =			"Create a new profile with same settings as the selected profile.",
	Profile_Popup_new =				"Create a new profile with default setting.",
	Profile_Popup_reset = 			"Are you sure to want to reset this profile ? (your settings will be lost for ever)",
	Profile_Popup_delete = 			"Are you sure to want to delete this profile ? (your settings will be lost for ever)",
	
	addon_Popup_reset = 			"Are you sure to want to reset ShieldHealth ? (User interface will be reloaded)",
	addon_Popup_reset2 = 			"Are you really sure ?",
	
	
	
	
	reset_addon = 					"Reset all",
	reset = 						"Reset",
	reset3 = 						"The profile \"",
	reset4 = 						"\" has been set to default.",
	SVcleaned = 					"Saved variable has been cleaned.",
	cleanSV = 						"Clean DB",
	
	
	tooltip_profile_list_titre = 	"This profile is used by :"
}
sh_Local["tooltip_appliquer_spe1"] = {
	"Profile spec 1",
	"Set the currently selected profile to the first talent specialization.",
}	
sh_Local["tooltip_appliquer_spe2"] = { 
	"Profile spec 2",
	"Set the currently selected profile to the second talent specialization.",
}
sh_Local["tooltip_rename"] = {  	
	"Rename profile",
	"Rename the selected profile.",
	"The name should not already exists and can't be blank."
}
sh_Local["tooltip_saveas"] = {  	
	"Save the profile as ...",
	"Copy all the settings of the selected profile to a new profile.",
}
sh_Local["tooltip_new"] = {  	
	"New profile",
	"Create a new profile with default settings",
}
sh_Local["tooltip_delete"] = {  
	"Delete profile",
	"Delete the selected profile.",
	"You can't delete an active profile.",
}
sh_Local["tooltip_reset"] = {  	
	"Reset profile",
	"Set the selected profile to default, all settings  will be lost.",
}


sh_Local["tooltip_targettoplayer"] = {
	"Target to player",
	"Copy all the settings of the target's bar to the player's bar",
}
sh_Local["tooltip_playertotarget"] = {
	"Player to target",
	"Copy all the settings of the player's bar to the target's bar",
}
sh_Local["tooltip_lock"] = {
	"Lock",
	"Lock all ShieldHealth's bars.",
}
sh_Local["tooltip_unlock"] = {
	"Unlock",
	"Make all ShielHealth's bars movable",
}
sh_Local["tooltip_test"] = {
	"Test mode",
	"Enable testing mode, bars will show up with exemple values.",
}
sh_Local["tooltip_resetall"] = {
	"Reset all",
	"Delete the saved variable : all settings will be lost, but it may fix some bugs.",
	"Ui will reload.",
}


sh_Local["tooltip_slider1"] = {
	"Opacity",
	"Set the opacity of the shield bar.",
}
sh_Local["tooltip_slider2"] = {
	"Text Size",
	"Set the size of the shield's value text.",
}
sh_Local["tooltip_slider3"] = {
	"Width",
	"Set the global width of the bar.",
}
sh_Local["tooltip_slider4"] = {
	"Height",
	"Set the global height of the bar.",
}
sh_Local["tooltip_slider5"] = {
	"Border width",
	"Set the width of the border texture.",
}
sh_Local["tooltip_slider6"] = {
	"Icon size",
	"Set the size of shield's icons.",
	"(If you use an other addon to display the time reamaning it may not show if the size is less than 18.)",
}
sh_Local["tooltip_slider7"] = {
	"Frame level",
	"If some other frames are on the same level, you can make Shieldhealth to be above or below these frames.",
}
sh_Local["tooltip_slider10"] = {
	"Insets",
	"Set the LEFT distance between border and contant of the bar.",
}
sh_Local["tooltip_slider11"] = {
	"Insets",
	"Set the RIGHT distance between border and contant of the bar.",
}
sh_Local["tooltip_slider12"] = {
	"Insets",
	"Set the TOP distance between border and contant of the bar.",
}
sh_Local["tooltip_slider13"] = {
	"Insets",
	"Set the BOTTOM distance between border and contant of the bar.",
}


sh_Local["tooltip_DDM1"] = {
	"Texture of the bar",
	"Set the texture of the shields bars.",
}
sh_Local["tooltip_DDM2"] = {
	"Shield value's font",
	"Set the font of the shield's life value.",
}
sh_Local["tooltip_DDM3"] = {
	"Border texture",
	"Set the texture of the border.",
}
sh_Local["tooltip_DDM4"] = {
	"Backdrop texture",
	"Set the backdrop texture.",
}

sh_Local["tooltip_CP1"] = {
	"Text color",
	"Set the color of the shield's value text.",
}
sh_Local["tooltip_CP2"] = {
	"Background color",
	"Set the color and the opacity of the background.",
	"You may not be able to set that, it will depend of the backdrop texture.",
}


sh_Local["tooltip_CB1"] = {
	"Enable",
	"Toggle this bar.",
}
sh_Local["tooltip_CB3"] = {
	"Short number",
	"Toggle the short format of the shield's value.",
	"For exemple, if  activated the value will be 42k instead of 42 524.",
}
sh_Local["tooltip_CB4"] = {
	"Blinking",
	"Enable a red blinking when the shield current value is below 20% of it's max value.",
}
sh_Local["tooltip_CB5"] = {
	"Outline",
	"Show the outline around the text for maximum visibility.",
}


sh_Local["tooltip_cleanSV"] = {
	"Clean saved variales",
	"Delete all character who are below level 10 or not connected since more than 2 weeks from the database.",
}
sh_Local["tooltip_CB6"] = {
	"Show only in combat",
	"Display this bar only when the player is in combat.",
}
sh_Local["tooltip_CB7"] = {
	"Auto",
	"Enable auto size of icons.",
}


sh_Local["tooltip_cooldown_slider_60"] = {
	"Height",
	"Set the height of cooldown's icon.",
}
sh_Local["tooltip_cooldown_slider_61"] = {
	"Width",
	"Set the width of cooldown's icon.",
}
sh_Local["tooltip_cooldown_slider_62"] = {
	"Border width",
	"Set the width of cooldown icon border.",
}
sh_Local["tooltip_cooldown_slider_63"] = {
	"Cooldown inset",
	"Set the spacing between the cooldown animation and the edge of the frame.",
}
sh_Local["tooltip_cooldown_slider_64"] = {
	"Anchor",
	"Set the spacing between the cooldown timer and the player bar.",
}


sh_Local["tooltip_cooldown_cb_60"] = {
	"Toggle",
	"Global toggle for the cooldown's icon, regardless of witch timer is enabled.",
}
sh_Local["tooltip_cooldown_cb_61"] = {
	"Border",
	"Toggle the icon's border display.",
}
sh_Local["tooltip_cooldown_cb_62"] = {
	"Border Width",
	"Set the width of the border texture.",
}
sh_Local["tooltip_cooldown_cb_63"] = {
	"Border Width",
	"Anchor the cooldown timer with the player with the player bar.",
}

sh_Local["tooltip_cooldown_cb_65"] = {
	"Rapture timer",
	"Enable this timer for the discipline talent 'Rapture'.",
}



sh_Local["tooltip_pitbull_cb70"] = {
	"Pitbull",
	"Enable integration with Pitbull4.",
}
--[[
sh_Local["tooltip_"] = {
	
}
Sh_Tooltip(,L["tooltip_"])
------------------------------------------------------------------------]]

if mylocale == "-frFR" then
sh_Local = {
	Couleur_des_Boucliers = 		"Couleurs",
	Apparence_barre_boucliers = 	"Apparence de la barre des boucliers",
	Texture_barre_boucliers = 		"Texture de la barre des boucliers",
	Police_vie_boucliers = 			"Police de la vie des boucliers",
	Contour =						"Contour",
	Taille_texte = 					"Taille du texte",
	Apparence_generale = 			"Apparence générale",
	Largeur_globale =				"Largeur globale",
	Hauteur_globale = 				"Hauteur globale",
	Texture_bordure_generale = 		"Texture de la bordure globale",
	Texture_fond = 					"Texture du fond",
	Couleur_fond = 					"Couleur du fond",
	Taille_icones = 				"Taille des icones",
	Options = 						"Options Générales"	,
	Activer = 						"Activer",
	Icone =							"Icône",
	Deverouiller = 					"Dévérouiller",
	Verouiller = 					"Vérouiller",
	Couleur_texte = 				"Couleur du texte",
	Joueur = 						"Barre du joueur",
	Ordre = 						"Ordre des boucliers",
	Cooldown = 						"Afficher le timer Cooldown",
	Taille_bordure =				"Largeur de la bordure",
	insets =						"Marge intérieure :",
	top =							"Haut",
	left =							"Gauche",
	right =							"Droite",
	bottom =						"Bas",
	Cible = 						"Barre de la cible",
	short = 						"Nombres courts",
	test = 							"Mode de test",
	player = 						"Joueur",
	target = 						"Cible",
	level = 						"Niveau de la frame",
	targettoplayer =				"Copier les règlages : Cible => Joueur",
	playertotarget =				"Copier les règlages : Joueur => Cible",
	plus =							"Plus ...",
	blink = 						"Clignotement",
	ToggleSpe_1 =					"Activer en spe1",
	ToggleSpe_1 =					"Activer en spe2",
	
	Profile = 						"Profile",
	Profile_appliquer = 			"Appliquer",
	Profile_appliquer_spe1 = 		"Appliquer",
	Profile_appliquer_spe2 = 		"Appliquer",
	Profile_rename = 				"Renommer",
	Profile_saveas = 				"Copier",
	Profile_nouveau = 				"Nouveau",
	Profile_delete = 				"Supprimer",
	Profile_Popup_rename =			"Rennomer le profil sélectionné.",
	Profile_Popup_saveas =			"Créer un nouveau profile avec les même règlages que le profile sélectionné.",
	Profile_Popup_new =				"Créer un nouveau profile avec les règlages par défaut.",
	Profile_Popup_reset = 			"Êtes-vous sûrs de vouloir réinitialiser ce profile ? (vos règlages seront perdus pour toujours)",
	
	addon_Popup_reset = 			"Êtes-vous sûrs de vouloir réinitialiser ShieldHealth ? (L'interface utilisateur va se recharger)",
	addon_Popup_reset2 = 			"Êtes-vous vraiment certain de vouloir supprimer toutes les données de ShieldHeal ? Elles seront irrécupérables !",
	
	
	
	reset =							"Réinitialiser",
	reset_addon = 					"Reinit. tout",
	reset3 = 						"Le profile \"",
	reset4 = 						"\" a été réinitialisé !",
	SVcleaned = 					"La base de données a été nétoyée.",
	cleanSV = 						"Netoyer la DB",
}
end



--[[
deDE German
enUS American English
enGB British English
esES Spanish
esMX Spanish (Mexico)
frFR French
ruRU Russian
koKR Korean
zhCN Simplified Chinese
zhTW Traditional Chinese
--]]