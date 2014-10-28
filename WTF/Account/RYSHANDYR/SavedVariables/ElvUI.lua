
ElvDB = {
	["profileKeys"] = {
		["Zapunzel - Aggramar"] = "Zapunzel - Aggramar",
		["Greenthorn - Aggramar"] = "Greenthorn - Aggramar",
		["Ryjax - Aggramar"] = "Ryjax - Aggramar",
		["Kylosandrax - Aggramar"] = "Kylosandrax - Aggramar",
		["Feldspar - Aggramar"] = "Feldspar - Aggramar",
		["Kylozandrax - Earthen Ring"] = "Kylozandrax - Earthen Ring",
		["Stormslinger - Aggramar"] = "Stormslinger - Aggramar",
		["Ryvok - Aggramar"] = "Ryvok - Aggramar",
		["Bronin - Aggramar"] = "Bronin - Aggramar",
	},
	["gold"] = {
		["Earthen Ring"] = {
			["Kylozandrax"] = 22373801,
		},
		["Aggramar"] = {
			["Ryvok"] = 93250609,
			["Greenthorn"] = 21256407,
			["Ryjax"] = 108628274,
			["Stormslinger"] = 49122840,
			["Zapunzel"] = 636932214,
			["Bronin"] = 48009395,
			["Kylosandrax"] = 86255370,
			["Feldspar"] = 16164892,
		},
	},
	["namespaces"] = {
		["LibDualSpec-1.0"] = {
		},
	},
	["profiles"] = {
		["Zapunzel - Aggramar"] = {
			["movers"] = {
				["ElvUF_Raid40Mover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4374",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-300360",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-69230",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM68230",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-3154",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM300300",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM045",
				["LootFrameMover"] = "TOPLEFTElvUIParentTOPLEFT268-190",
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4834",
				["ElvUF_RaidMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4374",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-132427",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-630300",
			},
			["unitframe"] = {
				["fontSize"] = 12,
				["fontOutline"] = "NONE",
				["font"] = "ElvUI Font",
				["statusbar"] = "Armory",
				["units"] = {
					["player"] = {
						["castbar"] = {
							["enable"] = false,
						},
						["debuffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["aurabar"] = {
							["anchorPoint"] = "BELOW",
						},
					},
					["focus"] = {
						["buffs"] = {
							["enable"] = true,
						},
						["debuffs"] = {
							["sizeOverride"] = 60,
							["fontSize"] = 22,
						},
					},
					["target"] = {
						["castbar"] = {
							["enable"] = false,
						},
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["debuffs"] = {
							["anchorPoint"] = "TOPLEFT",
							["attachTo"] = "FRAME",
						},
						["aurabar"] = {
							["anchorPoint"] = "BELOW",
							["attachTo"] = "BUFFS",
						},
					},
					["raid"] = {
						["raidWideSorting"] = false,
					},
					["targettarget"] = {
						["name"] = {
							["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel] [shortclassification]",
						},
						["debuffs"] = {
							["anchorPoint"] = "TOPRIGHT",
							["fontSize"] = 22,
							["sizeOverride"] = 60,
							["perrow"] = 8,
						},
						["threatStyle"] = "GLOW",
						["power"] = {
							["height"] = 10,
							["hideonnpc"] = true,
							["text_format"] = "[powercolor][power:current]",
						},
						["height"] = 54,
						["buffs"] = {
							["enable"] = true,
							["perrow"] = 8,
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:current-percent]",
						},
						["width"] = 200,
					},
					["focustarget"] = {
						["enable"] = true,
					},
				},
			},
			["general"] = {
				["valuecolor"] = {
					["b"] = 0.819,
					["g"] = 0.513,
					["r"] = 0.09,
				},
				["bottomPanel"] = false,
				["interruptAnnounce"] = "SAY",
				["vendorGrays"] = true,
				["bordercolor"] = {
					["b"] = 0.31,
					["g"] = 0.31,
					["r"] = 0.31,
				},
				["autoRepair"] = "PLAYER",
				["autoAcceptInvite"] = true,
			},
			["actionbar"] = {
				["bar3"] = {
					["buttons"] = 12,
				},
				["bar6"] = {
					["enabled"] = true,
				},
				["bar2"] = {
					["enabled"] = true,
					["buttonsPerRow"] = 4,
				},
				["bar1"] = {
					["buttonsPerRow"] = 4,
				},
				["bar5"] = {
					["buttons"] = 12,
				},
				["microbar"] = {
					["enabled"] = true,
					["mouseover"] = true,
				},
				["bar4"] = {
					["backdrop"] = false,
				},
			},
			["layoutSet"] = "tank",
			["datatexts"] = {
				["fontSize"] = 12,
				["font"] = "ElvUI Font",
				["time24"] = true,
			},
			["hideTutorial"] = true,
			["currentTutorial"] = 1,
		},
		["Greenthorn - Aggramar"] = {
			["currentTutorial"] = 1,
			["unitframe"] = {
				["fontSize"] = 12,
				["fontOutline"] = "NONE",
				["font"] = "ElvUI Font",
				["statusbar"] = "Armory",
				["units"] = {
					["player"] = {
						["aurabar"] = {
							["anchorPoint"] = "BELOW",
						},
						["debuffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["castbar"] = {
							["enable"] = false,
						},
					},
					["focus"] = {
						["debuffs"] = {
							["sizeOverride"] = 60,
							["fontSize"] = 22,
						},
						["buffs"] = {
							["enable"] = true,
						},
					},
					["target"] = {
						["aurabar"] = {
							["attachTo"] = "BUFFS",
							["anchorPoint"] = "BELOW",
						},
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["debuffs"] = {
							["attachTo"] = "FRAME",
							["anchorPoint"] = "TOPLEFT",
						},
						["castbar"] = {
							["enable"] = false,
						},
					},
					["raid"] = {
						["raidWideSorting"] = false,
					},
					["targettarget"] = {
						["threatStyle"] = "GLOW",
						["debuffs"] = {
							["anchorPoint"] = "TOPRIGHT",
							["sizeOverride"] = 60,
							["fontSize"] = 22,
							["perrow"] = 8,
						},
						["name"] = {
							["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel] [shortclassification]",
						},
						["power"] = {
							["height"] = 10,
							["hideonnpc"] = true,
							["text_format"] = "[powercolor][power:current]",
						},
						["height"] = 54,
						["buffs"] = {
							["enable"] = true,
							["perrow"] = 8,
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:current-percent]",
						},
						["width"] = 200,
					},
					["focustarget"] = {
						["enable"] = true,
					},
				},
			},
			["general"] = {
				["vendorGrays"] = true,
				["bottomPanel"] = false,
				["interruptAnnounce"] = "SAY",
				["autoAcceptInvite"] = true,
				["bordercolor"] = {
					["b"] = 0.31,
					["g"] = 0.31,
					["r"] = 0.31,
				},
				["autoRepair"] = "PLAYER",
				["valuecolor"] = {
					["b"] = 0.819,
					["g"] = 0.513,
					["r"] = 0.09,
				},
			},
			["movers"] = {
				["ElvUF_Raid40Mover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4374",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-300360",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-69230",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM68230",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-3154",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM300300",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM045",
				["LootFrameMover"] = "TOPLEFTElvUIParentTOPLEFT268-190",
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4834",
				["ElvUF_RaidMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4374",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-132427",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-630300",
			},
			["layoutSet"] = "tank",
			["datatexts"] = {
				["fontSize"] = 12,
				["time24"] = true,
				["font"] = "ElvUI Font",
			},
			["hideTutorial"] = true,
			["actionbar"] = {
				["bar3"] = {
					["buttons"] = 12,
				},
				["bar6"] = {
					["enabled"] = true,
				},
				["bar2"] = {
					["enabled"] = true,
					["buttonsPerRow"] = 4,
				},
				["bar1"] = {
					["buttonsPerRow"] = 4,
				},
				["microbar"] = {
					["enabled"] = true,
					["mouseover"] = true,
				},
				["bar5"] = {
					["buttons"] = 12,
				},
				["bar4"] = {
					["backdrop"] = false,
				},
			},
		},
		["Ryjax - Aggramar"] = {
			["currentTutorial"] = 1,
			["unitframe"] = {
				["fontSize"] = 12,
				["fontOutline"] = "NONE",
				["font"] = "ElvUI Font",
				["statusbar"] = "Armory",
				["units"] = {
					["player"] = {
						["aurabar"] = {
							["anchorPoint"] = "BELOW",
						},
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["debuffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["castbar"] = {
							["enable"] = false,
						},
					},
					["focus"] = {
						["debuffs"] = {
							["fontSize"] = 22,
							["sizeOverride"] = 60,
						},
						["buffs"] = {
							["enable"] = true,
						},
					},
					["target"] = {
						["aurabar"] = {
							["anchorPoint"] = "BELOW",
							["attachTo"] = "BUFFS",
						},
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["debuffs"] = {
							["anchorPoint"] = "TOPLEFT",
							["attachTo"] = "FRAME",
						},
						["castbar"] = {
							["enable"] = false,
						},
					},
					["raid"] = {
						["raidWideSorting"] = false,
					},
					["targettarget"] = {
						["threatStyle"] = "GLOW",
						["debuffs"] = {
							["anchorPoint"] = "TOPRIGHT",
							["fontSize"] = 22,
							["sizeOverride"] = 60,
							["perrow"] = 8,
						},
						["name"] = {
							["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel] [shortclassification]",
						},
						["power"] = {
							["height"] = 10,
							["hideonnpc"] = true,
							["text_format"] = "[powercolor][power:current]",
						},
						["height"] = 54,
						["buffs"] = {
							["enable"] = true,
							["perrow"] = 8,
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:current-percent]",
						},
						["width"] = 200,
					},
					["focustarget"] = {
						["enable"] = true,
					},
				},
			},
			["datatexts"] = {
				["fontSize"] = 12,
				["time24"] = true,
				["font"] = "ElvUI Font",
			},
			["movers"] = {
				["ElvUF_Raid40Mover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4374",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-300360",
				["ElvUF_RaidMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4374",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-132427",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM045",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-3154",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM300300",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["LootFrameMover"] = "TOPLEFTElvUIParentTOPLEFT268-190",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4834",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-69230",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM68230",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-630300",
			},
			["layoutSet"] = "tank",
			["actionbar"] = {
				["bar3"] = {
					["buttons"] = 12,
				},
				["bar6"] = {
					["enabled"] = true,
				},
				["bar2"] = {
					["enabled"] = true,
					["buttonsPerRow"] = 4,
				},
				["bar1"] = {
					["buttonsPerRow"] = 4,
				},
				["microbar"] = {
					["enabled"] = true,
					["mouseover"] = true,
				},
				["bar5"] = {
					["buttons"] = 12,
				},
				["bar4"] = {
					["backdrop"] = false,
				},
			},
			["hideTutorial"] = true,
			["general"] = {
				["valuecolor"] = {
					["r"] = 0.09,
					["g"] = 0.513,
					["b"] = 0.819,
				},
				["bottomPanel"] = false,
				["interruptAnnounce"] = "SAY",
				["vendorGrays"] = true,
				["bordercolor"] = {
					["r"] = 0.31,
					["g"] = 0.31,
					["b"] = 0.31,
				},
				["autoRepair"] = "PLAYER",
				["autoAcceptInvite"] = true,
			},
		},
		["Kylosandrax - Aggramar"] = {
			["currentTutorial"] = 1,
			["general"] = {
				["autoAcceptInvite"] = true,
				["bottomPanel"] = false,
				["interruptAnnounce"] = "SAY",
				["valuecolor"] = {
					["b"] = 0.819,
					["g"] = 0.513,
					["r"] = 0.09,
				},
				["bordercolor"] = {
					["b"] = 0.31,
					["g"] = 0.31,
					["r"] = 0.31,
				},
				["autoRepair"] = "PLAYER",
				["vendorGrays"] = true,
			},
			["movers"] = {
				["ElvUF_Raid40Mover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4374",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-300360",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-69230",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM68230",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-3154",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM300300",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM045",
				["LootFrameMover"] = "TOPLEFTElvUIParentTOPLEFT268-190",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4834",
				["ElvUF_RaidMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4374",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-132427",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-630300",
			},
			["layoutSet"] = "tank",
			["actionbar"] = {
				["bar3"] = {
					["buttons"] = 12,
				},
				["bar6"] = {
					["enabled"] = true,
				},
				["bar2"] = {
					["enabled"] = true,
					["buttonsPerRow"] = 4,
				},
				["bar1"] = {
					["paging"] = {
						["WARRIOR"] = "",
					},
					["buttonsPerRow"] = 4,
				},
				["bar5"] = {
					["buttons"] = 12,
				},
				["microbar"] = {
					["enabled"] = true,
					["mouseover"] = true,
				},
				["bar4"] = {
					["backdrop"] = false,
				},
			},
			["hideTutorial"] = true,
			["unitframe"] = {
				["fontSize"] = 12,
				["fontOutline"] = "NONE",
				["font"] = "ElvUI Font",
				["statusbar"] = "Armory",
				["units"] = {
					["player"] = {
						["castbar"] = {
							["enable"] = false,
						},
						["debuffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["aurabar"] = {
							["anchorPoint"] = "BELOW",
						},
					},
					["focus"] = {
						["buffs"] = {
							["enable"] = true,
						},
						["debuffs"] = {
							["sizeOverride"] = 60,
							["fontSize"] = 22,
						},
					},
					["target"] = {
						["castbar"] = {
							["enable"] = false,
						},
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["debuffs"] = {
							["anchorPoint"] = "TOPLEFT",
							["attachTo"] = "FRAME",
						},
						["aurabar"] = {
							["anchorPoint"] = "BELOW",
							["attachTo"] = "BUFFS",
						},
					},
					["raid"] = {
						["raidWideSorting"] = false,
					},
					["targettarget"] = {
						["name"] = {
							["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel] [shortclassification]",
						},
						["debuffs"] = {
							["anchorPoint"] = "TOPRIGHT",
							["fontSize"] = 22,
							["sizeOverride"] = 60,
							["perrow"] = 8,
						},
						["threatStyle"] = "GLOW",
						["power"] = {
							["height"] = 10,
							["hideonnpc"] = true,
							["text_format"] = "[powercolor][power:current]",
						},
						["height"] = 54,
						["buffs"] = {
							["enable"] = true,
							["perrow"] = 8,
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:current-percent]",
						},
						["width"] = 200,
					},
					["focustarget"] = {
						["enable"] = true,
					},
				},
			},
		},
		["Feldspar - Aggramar"] = {
			["movers"] = {
				["ElvUF_Raid40Mover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4374",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-300360",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-69230",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM68230",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-3154",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM300300",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM045",
				["LootFrameMover"] = "TOPLEFTElvUIParentTOPLEFT268-190",
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4834",
				["ElvUF_RaidMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4374",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-132427",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-630300",
			},
			["unitframe"] = {
				["fontSize"] = 12,
				["fontOutline"] = "NONE",
				["font"] = "ElvUI Font",
				["statusbar"] = "Armory",
				["units"] = {
					["player"] = {
						["castbar"] = {
							["enable"] = false,
						},
						["debuffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["aurabar"] = {
							["anchorPoint"] = "BELOW",
						},
					},
					["focus"] = {
						["buffs"] = {
							["enable"] = true,
						},
						["debuffs"] = {
							["sizeOverride"] = 60,
							["fontSize"] = 22,
						},
					},
					["target"] = {
						["castbar"] = {
							["enable"] = false,
						},
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["debuffs"] = {
							["anchorPoint"] = "TOPLEFT",
							["attachTo"] = "FRAME",
						},
						["aurabar"] = {
							["anchorPoint"] = "BELOW",
							["attachTo"] = "BUFFS",
						},
					},
					["raid"] = {
						["raidWideSorting"] = false,
					},
					["targettarget"] = {
						["name"] = {
							["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel] [shortclassification]",
						},
						["debuffs"] = {
							["anchorPoint"] = "TOPRIGHT",
							["fontSize"] = 22,
							["sizeOverride"] = 60,
							["perrow"] = 8,
						},
						["threatStyle"] = "GLOW",
						["power"] = {
							["height"] = 10,
							["hideonnpc"] = true,
							["text_format"] = "[powercolor][power:current]",
						},
						["height"] = 54,
						["buffs"] = {
							["enable"] = true,
							["perrow"] = 8,
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:current-percent]",
						},
						["width"] = 200,
					},
					["focustarget"] = {
						["enable"] = true,
					},
				},
			},
			["general"] = {
				["autoAcceptInvite"] = true,
				["bottomPanel"] = false,
				["interruptAnnounce"] = "SAY",
				["valuecolor"] = {
					["b"] = 0.819,
					["g"] = 0.513,
					["r"] = 0.09,
				},
				["bordercolor"] = {
					["b"] = 0.31,
					["g"] = 0.31,
					["r"] = 0.31,
				},
				["autoRepair"] = "PLAYER",
				["vendorGrays"] = true,
			},
			["actionbar"] = {
				["bar3"] = {
					["buttons"] = 12,
				},
				["bar6"] = {
					["enabled"] = true,
				},
				["bar2"] = {
					["enabled"] = true,
					["buttonsPerRow"] = 4,
				},
				["bar1"] = {
					["buttonsPerRow"] = 4,
				},
				["bar5"] = {
					["buttons"] = 12,
				},
				["microbar"] = {
					["enabled"] = true,
					["mouseover"] = true,
				},
				["bar4"] = {
					["backdrop"] = false,
				},
			},
			["layoutSet"] = "tank",
			["datatexts"] = {
				["fontSize"] = 12,
				["font"] = "ElvUI Font",
				["time24"] = true,
			},
			["hideTutorial"] = true,
			["currentTutorial"] = 1,
		},
		["Kylozandrax - Earthen Ring"] = {
			["unitframe"] = {
				["fontSize"] = 12,
				["fontOutline"] = "NONE",
				["font"] = "ElvUI Font",
				["statusbar"] = "Armory",
				["units"] = {
					["player"] = {
						["aurabar"] = {
							["anchorPoint"] = "BELOW",
						},
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["debuffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["castbar"] = {
							["enable"] = false,
						},
					},
					["focus"] = {
						["debuffs"] = {
							["fontSize"] = 22,
							["sizeOverride"] = 60,
						},
						["buffs"] = {
							["enable"] = true,
						},
					},
					["target"] = {
						["aurabar"] = {
							["anchorPoint"] = "BELOW",
							["attachTo"] = "BUFFS",
						},
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["debuffs"] = {
							["anchorPoint"] = "TOPLEFT",
							["attachTo"] = "FRAME",
						},
						["castbar"] = {
							["enable"] = false,
						},
					},
					["raid"] = {
						["raidWideSorting"] = false,
					},
					["targettarget"] = {
						["threatStyle"] = "GLOW",
						["debuffs"] = {
							["anchorPoint"] = "TOPRIGHT",
							["fontSize"] = 22,
							["sizeOverride"] = 60,
							["perrow"] = 8,
						},
						["name"] = {
							["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel] [shortclassification]",
						},
						["power"] = {
							["height"] = 10,
							["hideonnpc"] = true,
							["text_format"] = "[powercolor][power:current]",
						},
						["height"] = 54,
						["buffs"] = {
							["enable"] = true,
							["perrow"] = 8,
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:current-percent]",
						},
						["width"] = 200,
					},
					["focustarget"] = {
						["enable"] = true,
					},
				},
			},
			["currentTutorial"] = 1,
			["general"] = {
				["autoAcceptInvite"] = true,
				["bottomPanel"] = false,
				["interruptAnnounce"] = "SAY",
				["valuecolor"] = {
					["r"] = 0.09,
					["g"] = 0.513,
					["b"] = 0.819,
				},
				["bordercolor"] = {
					["r"] = 0.31,
					["g"] = 0.31,
					["b"] = 0.31,
				},
				["autoRepair"] = "PLAYER",
				["vendorGrays"] = true,
			},
			["actionbar"] = {
				["bar3"] = {
					["buttons"] = 12,
				},
				["bar6"] = {
					["enabled"] = true,
				},
				["bar2"] = {
					["enabled"] = true,
					["buttonsPerRow"] = 4,
				},
				["bar1"] = {
					["buttonsPerRow"] = 4,
				},
				["microbar"] = {
					["enabled"] = true,
					["mouseover"] = true,
				},
				["bar5"] = {
					["buttons"] = 12,
				},
				["bar4"] = {
					["backdrop"] = false,
				},
			},
			["layoutSet"] = "tank",
			["datatexts"] = {
				["fontSize"] = 12,
				["time24"] = true,
				["font"] = "ElvUI Font",
			},
			["hideTutorial"] = true,
			["movers"] = {
				["ElvUF_Raid40Mover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4374",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-300360",
				["ElvUF_RaidMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4374",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-132427",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM045",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-3154",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM300300",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["LootFrameMover"] = "TOPLEFTElvUIParentTOPLEFT268-190",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4834",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-69230",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM68230",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-630300",
			},
		},
		["Stormslinger - Aggramar"] = {
			["currentTutorial"] = 1,
			["unitframe"] = {
				["fontSize"] = 12,
				["fontOutline"] = "NONE",
				["font"] = "ElvUI Font",
				["statusbar"] = "Armory",
				["units"] = {
					["player"] = {
						["aurabar"] = {
							["anchorPoint"] = "BELOW",
						},
						["debuffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["castbar"] = {
							["enable"] = false,
						},
					},
					["focus"] = {
						["debuffs"] = {
							["fontSize"] = 22,
							["sizeOverride"] = 60,
						},
						["buffs"] = {
							["enable"] = true,
						},
					},
					["target"] = {
						["aurabar"] = {
							["anchorPoint"] = "BELOW",
							["attachTo"] = "BUFFS",
						},
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["debuffs"] = {
							["anchorPoint"] = "TOPLEFT",
							["attachTo"] = "FRAME",
						},
						["castbar"] = {
							["enable"] = false,
						},
					},
					["raid"] = {
						["raidWideSorting"] = false,
					},
					["targettarget"] = {
						["threatStyle"] = "GLOW",
						["debuffs"] = {
							["anchorPoint"] = "TOPRIGHT",
							["fontSize"] = 22,
							["sizeOverride"] = 60,
							["perrow"] = 8,
						},
						["name"] = {
							["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel] [shortclassification]",
						},
						["power"] = {
							["height"] = 10,
							["hideonnpc"] = true,
							["text_format"] = "[powercolor][power:current]",
						},
						["height"] = 54,
						["buffs"] = {
							["enable"] = true,
							["perrow"] = 8,
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:current-percent]",
						},
						["width"] = 200,
					},
					["focustarget"] = {
						["enable"] = true,
					},
				},
			},
			["general"] = {
				["vendorGrays"] = true,
				["bottomPanel"] = false,
				["interruptAnnounce"] = "SAY",
				["autoAcceptInvite"] = true,
				["bordercolor"] = {
					["r"] = 0.31,
					["g"] = 0.31,
					["b"] = 0.31,
				},
				["autoRepair"] = "PLAYER",
				["valuecolor"] = {
					["r"] = 0.09,
					["g"] = 0.513,
					["b"] = 0.819,
				},
			},
			["movers"] = {
				["ElvUF_Raid40Mover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4374",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-300360",
				["ElvUF_RaidMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4374",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-132427",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM045",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-3154",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM300300",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["LootFrameMover"] = "TOPLEFTElvUIParentTOPLEFT268-190",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4834",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-69230",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM68230",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-630300",
			},
			["layoutSet"] = "tank",
			["datatexts"] = {
				["fontSize"] = 12,
				["time24"] = true,
				["font"] = "ElvUI Font",
			},
			["hideTutorial"] = true,
			["actionbar"] = {
				["bar3"] = {
					["buttons"] = 12,
				},
				["bar6"] = {
					["enabled"] = true,
				},
				["bar2"] = {
					["enabled"] = true,
					["buttonsPerRow"] = 4,
				},
				["bar1"] = {
					["buttonsPerRow"] = 4,
				},
				["microbar"] = {
					["enabled"] = true,
					["mouseover"] = true,
				},
				["bar5"] = {
					["buttons"] = 12,
				},
				["bar4"] = {
					["backdrop"] = false,
				},
			},
		},
		["Ryvok - Aggramar"] = {
			["currentTutorial"] = 1,
			["unitframe"] = {
				["fontSize"] = 12,
				["fontOutline"] = "NONE",
				["font"] = "ElvUI Font",
				["statusbar"] = "Armory",
				["units"] = {
					["player"] = {
						["aurabar"] = {
							["anchorPoint"] = "BELOW",
						},
						["debuffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["castbar"] = {
							["enable"] = false,
						},
					},
					["focus"] = {
						["debuffs"] = {
							["sizeOverride"] = 60,
							["fontSize"] = 22,
						},
						["buffs"] = {
							["enable"] = true,
						},
					},
					["target"] = {
						["aurabar"] = {
							["attachTo"] = "BUFFS",
							["anchorPoint"] = "BELOW",
						},
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["debuffs"] = {
							["attachTo"] = "FRAME",
							["anchorPoint"] = "TOPLEFT",
						},
						["castbar"] = {
							["enable"] = false,
						},
					},
					["raid"] = {
						["raidWideSorting"] = false,
					},
					["targettarget"] = {
						["threatStyle"] = "GLOW",
						["debuffs"] = {
							["anchorPoint"] = "TOPRIGHT",
							["sizeOverride"] = 60,
							["fontSize"] = 22,
							["perrow"] = 8,
						},
						["name"] = {
							["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel] [shortclassification]",
						},
						["power"] = {
							["height"] = 10,
							["hideonnpc"] = true,
							["text_format"] = "[powercolor][power:current]",
						},
						["height"] = 54,
						["buffs"] = {
							["enable"] = true,
							["perrow"] = 8,
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:current-percent]",
						},
						["width"] = 200,
					},
					["focustarget"] = {
						["enable"] = true,
					},
				},
			},
			["general"] = {
				["vendorGrays"] = true,
				["bottomPanel"] = false,
				["interruptAnnounce"] = "SAY",
				["autoAcceptInvite"] = true,
				["bordercolor"] = {
					["b"] = 0.31,
					["g"] = 0.31,
					["r"] = 0.31,
				},
				["autoRepair"] = "PLAYER",
				["valuecolor"] = {
					["b"] = 0.819,
					["g"] = 0.513,
					["r"] = 0.09,
				},
			},
			["movers"] = {
				["ElvUF_Raid40Mover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4374",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-300360",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-69230",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM68230",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-3154",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM300300",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM045",
				["LootFrameMover"] = "TOPLEFTElvUIParentTOPLEFT268-190",
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4834",
				["ElvUF_RaidMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4374",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-132427",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-630300",
			},
			["layoutSet"] = "tank",
			["datatexts"] = {
				["fontSize"] = 12,
				["time24"] = true,
				["font"] = "ElvUI Font",
			},
			["hideTutorial"] = true,
			["actionbar"] = {
				["bar3"] = {
					["buttons"] = 12,
				},
				["bar6"] = {
					["enabled"] = true,
				},
				["bar2"] = {
					["enabled"] = true,
					["buttonsPerRow"] = 4,
				},
				["bar1"] = {
					["buttonsPerRow"] = 4,
				},
				["microbar"] = {
					["enabled"] = true,
					["mouseover"] = true,
				},
				["bar5"] = {
					["buttons"] = 12,
				},
				["bar4"] = {
					["backdrop"] = false,
				},
			},
		},
		["Bronin - Aggramar"] = {
			["currentTutorial"] = 1,
			["general"] = {
				["autoAcceptInvite"] = true,
				["autoRepair"] = "PLAYER",
				["bottomPanel"] = false,
				["valuecolor"] = {
					["r"] = 0.09,
					["g"] = 0.513,
					["b"] = 0.819,
				},
				["vendorGrays"] = true,
				["bordercolor"] = {
					["r"] = 0.31,
					["g"] = 0.31,
					["b"] = 0.31,
				},
				["interruptAnnounce"] = "SAY",
			},
			["movers"] = {
				["ElvUF_Raid40Mover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4374",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-300360",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-69230",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM68230",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM045",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-3154",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-630300",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-132427",
				["ElvUF_RaidMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4354",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_PartyMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-6684",
				["LootFrameMover"] = "TOPLEFTElvUIParentTOPLEFT268-190",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM300300",
			},
			["hideTutorial"] = true,
			["unitframe"] = {
				["fontSize"] = 12,
				["units"] = {
					["raid"] = {
						["raidWideSorting"] = false,
					},
					["focustarget"] = {
						["enable"] = true,
					},
					["targettarget"] = {
						["debuffs"] = {
							["fontSize"] = 22,
							["anchorPoint"] = "TOPRIGHT",
							["perrow"] = 8,
							["sizeOverride"] = 60,
						},
						["threatStyle"] = "GLOW",
						["power"] = {
							["text_format"] = "[powercolor][power:current]",
							["height"] = 10,
							["hideonnpc"] = true,
						},
						["width"] = 200,
						["health"] = {
							["text_format"] = "[healthcolor][health:current-percent]",
						},
						["name"] = {
							["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel] [shortclassification]",
						},
						["height"] = 54,
						["buffs"] = {
							["perrow"] = 8,
							["enable"] = true,
						},
					},
					["player"] = {
						["debuffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["aurabar"] = {
							["anchorPoint"] = "BELOW",
						},
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["castbar"] = {
							["enable"] = false,
						},
					},
					["focus"] = {
						["debuffs"] = {
							["fontSize"] = 22,
							["sizeOverride"] = 60,
						},
						["buffs"] = {
							["enable"] = true,
						},
					},
					["target"] = {
						["debuffs"] = {
							["anchorPoint"] = "TOPLEFT",
							["attachTo"] = "FRAME",
						},
						["aurabar"] = {
							["attachTo"] = "BUFFS",
							["anchorPoint"] = "BELOW",
						},
						["castbar"] = {
							["enable"] = false,
						},
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
					},
				},
				["statusbar"] = "Armory",
				["fontOutline"] = "NONE",
				["font"] = "ElvUI Font",
			},
			["datatexts"] = {
				["fontSize"] = 12,
				["time24"] = true,
				["font"] = "ElvUI Font",
			},
			["actionbar"] = {
				["bar3"] = {
					["buttons"] = 12,
				},
				["bar6"] = {
					["enabled"] = true,
				},
				["microbar"] = {
					["enabled"] = true,
					["mouseover"] = true,
				},
				["bar2"] = {
					["enabled"] = true,
					["buttonsPerRow"] = 4,
				},
				["bar5"] = {
					["buttons"] = 12,
				},
				["bar1"] = {
					["buttonsPerRow"] = 4,
				},
				["bar4"] = {
					["backdrop"] = false,
				},
			},
			["layoutSet"] = "tank",
		},
	},
}
ElvPrivateDB = {
	["profileKeys"] = {
		["Zapunzel - Aggramar"] = "Zapunzel - Aggramar",
		["Greenthorn - Aggramar"] = "Greenthorn - Aggramar",
		["Ryjax - Aggramar"] = "Ryjax - Aggramar",
		["Kylosandrax - Aggramar"] = "Kylosandrax - Aggramar",
		["Feldspar - Aggramar"] = "Feldspar - Aggramar",
		["Kylozandrax - Earthen Ring"] = "Kylozandrax - Earthen Ring",
		["Stormslinger - Aggramar"] = "Stormslinger - Aggramar",
		["Ryvok - Aggramar"] = "Ryvok - Aggramar",
		["Bronin - Aggramar"] = "Bronin - Aggramar",
	},
	["profiles"] = {
		["Zapunzel - Aggramar"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["addonskins"] = {
				["Blizzard_WorldStateCaptureBar"] = false,
				["AuctionatorSkin"] = false,
				["BugSackSkin"] = false,
				["SkadaSkin"] = false,
				["BagnonSkin"] = false,
				["DBMSkin"] = false,
				["PostalSkin"] = false,
				["OverachieverSkin"] = false,
				["TradeSkillDWSkin"] = false,
				["QuartzSkin"] = false,
				["CliqueSkin"] = false,
				["WeakAurasSkin"] = false,
			},
			["skins"] = {
				["blizzard"] = {
					["enable"] = false,
				},
				["ace3"] = {
					["enable"] = false,
				},
			},
			["bags"] = {
				["enable"] = false,
			},
			["tooltip"] = {
				["enable"] = false,
			},
			["install_complete"] = "7.18",
		},
		["Greenthorn - Aggramar"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["addonskins"] = {
				["Blizzard_WorldStateCaptureBar"] = false,
				["AuctionatorSkin"] = false,
				["BugSackSkin"] = false,
				["WeakAurasSkin"] = false,
				["BagnonSkin"] = false,
				["DBMSkin"] = false,
				["PostalSkin"] = false,
				["OverachieverSkin"] = false,
				["TradeSkillDWSkin"] = false,
				["SkadaSkin"] = false,
				["CliqueSkin"] = false,
				["QuartzSkin"] = false,
			},
			["skins"] = {
				["blizzard"] = {
					["enable"] = false,
				},
				["ace3"] = {
					["enable"] = false,
				},
			},
			["tooltip"] = {
				["enable"] = false,
			},
			["bags"] = {
				["enable"] = false,
			},
			["install_complete"] = "7.18",
		},
		["Ryjax - Aggramar"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["addonskins"] = {
				["Blizzard_WorldStateCaptureBar"] = false,
				["AuctionatorSkin"] = false,
				["BugSackSkin"] = false,
				["WeakAurasSkin"] = false,
				["BagnonSkin"] = false,
				["DBMSkin"] = false,
				["AskMrRobotSkin"] = false,
				["OverachieverSkin"] = false,
				["TradeSkillDWSkin"] = false,
				["CliqueSkin"] = false,
				["SkadaSkin"] = false,
				["PostalSkin"] = false,
			},
			["skins"] = {
				["blizzard"] = {
					["enable"] = false,
				},
				["ace3"] = {
					["enable"] = false,
				},
			},
			["bags"] = {
				["enable"] = false,
			},
			["tooltip"] = {
				["enable"] = false,
			},
			["install_complete"] = "7.14",
		},
		["Kylosandrax - Aggramar"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["addonskins"] = {
				["Blizzard_WorldStateCaptureBar"] = false,
				["AuctionatorSkin"] = false,
				["Ovale"] = true,
				["BugSackSkin"] = false,
				["PostalSkin"] = false,
				["BagnonSkin"] = false,
				["DBMSkin"] = false,
				["AskMrRobotSkin"] = false,
				["OverachieverSkin"] = false,
				["TradeSkillDWSkin"] = false,
				["SkadaSkin"] = false,
				["CliqueSkin"] = false,
				["WeakAurasSkin"] = false,
			},
			["skins"] = {
				["blizzard"] = {
					["enable"] = false,
				},
				["ace3"] = {
					["enable"] = false,
				},
			},
			["bags"] = {
				["enable"] = false,
			},
			["tooltip"] = {
				["enable"] = false,
			},
			["install_complete"] = "7.14",
		},
		["Feldspar - Aggramar"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["addonskins"] = {
				["Blizzard_WorldStateCaptureBar"] = false,
				["AuctionatorSkin"] = false,
				["BugSackSkin"] = false,
				["SkadaSkin"] = false,
				["BagnonSkin"] = false,
				["DBMSkin"] = false,
				["PostalSkin"] = false,
				["OverachieverSkin"] = false,
				["TradeSkillDWSkin"] = false,
				["QuartzSkin"] = false,
				["CliqueSkin"] = false,
				["WeakAurasSkin"] = false,
			},
			["skins"] = {
				["blizzard"] = {
					["enable"] = false,
				},
				["ace3"] = {
					["enable"] = false,
				},
			},
			["bags"] = {
				["enable"] = false,
			},
			["tooltip"] = {
				["enable"] = false,
			},
			["install_complete"] = "7.18",
		},
		["Kylozandrax - Earthen Ring"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["addonskins"] = {
				["Blizzard_WorldStateCaptureBar"] = true,
			},
			["install_complete"] = "7.18",
		},
		["Stormslinger - Aggramar"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["addonskins"] = {
				["Blizzard_WorldStateCaptureBar"] = false,
				["AuctionatorSkin"] = false,
				["Ovale"] = true,
				["BugSackSkin"] = false,
				["WeakAurasSkin"] = false,
				["BagnonSkin"] = false,
				["DBMSkin"] = false,
				["PostalSkin"] = false,
				["OverachieverSkin"] = false,
				["TradeSkillDWSkin"] = false,
				["CliqueSkin"] = false,
				["QuartzSkin"] = false,
				["SkadaSkin"] = false,
			},
			["skins"] = {
				["blizzard"] = {
					["enable"] = false,
				},
				["ace3"] = {
					["enable"] = false,
				},
			},
			["bags"] = {
				["enable"] = false,
			},
			["tooltip"] = {
				["enable"] = false,
			},
			["install_complete"] = "7.18",
		},
		["Ryvok - Aggramar"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["addonskins"] = {
				["Blizzard_WorldStateCaptureBar"] = false,
				["AuctionatorSkin"] = false,
				["BugSackSkin"] = false,
				["WeakAurasSkin"] = false,
				["BagnonSkin"] = false,
				["DBMSkin"] = false,
				["PostalSkin"] = false,
				["OverachieverSkin"] = false,
				["TradeSkillDWSkin"] = false,
				["CliqueSkin"] = false,
				["SkadaSkin"] = false,
				["QuartzSkin"] = false,
			},
			["skins"] = {
				["blizzard"] = {
					["enable"] = false,
				},
				["ace3"] = {
					["enable"] = false,
				},
			},
			["tooltip"] = {
				["enable"] = false,
			},
			["bags"] = {
				["enable"] = false,
			},
			["install_complete"] = "7.18",
		},
		["Bronin - Aggramar"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["bags"] = {
				["enable"] = false,
			},
			["addonskins"] = {
				["Blizzard_WorldStateCaptureBar"] = false,
				["AuctionatorSkin"] = false,
				["BagnonSkin"] = false,
				["TradeSkillDWSkin"] = false,
				["WeakAurasSkin"] = false,
				["SkadaSkin"] = false,
				["DBMSkin"] = false,
				["CliqueSkin"] = false,
				["BugSackSkin"] = false,
				["OverachieverSkin"] = false,
				["PostalSkin"] = false,
			},
			["skins"] = {
				["blizzard"] = {
					["enable"] = false,
				},
				["ace3"] = {
					["enable"] = false,
				},
			},
			["tooltip"] = {
				["enable"] = false,
			},
			["theme"] = "classic",
			["install_complete"] = "7.14",
		},
	},
}
