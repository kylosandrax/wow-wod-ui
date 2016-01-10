
ElvDB = {
	["profileKeys"] = {
		["Ryjax - Aggramar"] = "Ryjax - Aggramar",
		["Zapunzel - Aggramar"] = "Zapunzel - Aggramar",
		["Stormslinger - Aggramar"] = "Stormslinger - Aggramar",
		["Greenthorn - Aggramar"] = "Greenthorn - Aggramar",
		["Ryvok - Terokkar"] = "Ryvok - Terokkar",
		["Kromethious - Aggramar"] = "Kromethious - Aggramar",
		["Kylosandrax - Aggramar"] = "Kylosandrax - Aggramar",
		["Kxtrader - Aggramar"] = "Kxtrader - Aggramar",
		["Feldspar - Aggramar"] = "Feldspar - Aggramar",
		["Kylozandrax - Earthen Ring"] = "Kylozandrax - Earthen Ring",
		["Kxchanter - Aggramar"] = "Kxchanter - Aggramar",
		["Kyloc - Aggramar"] = "Kyloc - Aggramar",
		["Banjax - Aggramar"] = "Banjax - Aggramar",
		["Kylosandrix - Aggramar"] = "Kylosandrix - Aggramar",
		["Ryvok - Aggramar"] = "Ryvok - Aggramar",
		["Bronin - Aggramar"] = "Bronin - Aggramar",
	},
	["gold"] = {
		["Aggramar"] = {
			["Ryvok"] = 1000000,
			["Kromethious"] = 4509302,
			["Ryjax"] = 0,
			["Kxtrader"] = 149655352,
			["Kylosandrax"] = 1034044,
			["Kxchanter"] = 918628,
		},
	},
	["namespaces"] = {
		["LibDualSpec-1.0"] = {
		},
	},
	["global"] = {
		["unitframe"] = {
			["ChannelTicks"] = {
				["Insanity"] = 3,
				["Mind Flay"] = 3,
			},
		},
	},
	["profiles"] = {
		["Ryjax - Aggramar"] = {
			["currentTutorial"] = 1,
			["bagsOffsetFixed"] = true,
			["movers"] = {
				["ElvUF_Raid40Mover"] = "TOPLEFTElvUIParentBOTTOMLEFT1711233",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-300360",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-69230",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM68230",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-3154",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-630300",
				["ElvUF_RaidMover"] = "TOPLEFTElvUIParentBOTTOMLEFT1713279",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-132427",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentBOTTOMLEFT4736",
				["ShiftAB"] = "TOPLEFTElvUIParentBOTTOMLEFT41076",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT17124",
				["LootFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-685-158",
				["BossButton"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT522215",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM300300",
			},
			["tooltip"] = {
				["inspectInfo"] = false,
				["itemCount"] = "BOTH",
				["spellID"] = false,
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
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["debuffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
							["sizeOverride"] = 60,
						},
						["aurabar"] = {
							["enable"] = false,
							["anchorPoint"] = "BELOW",
						},
					},
					["focus"] = {
						["buffs"] = {
							["enable"] = true,
						},
						["debuffs"] = {
							["fontSize"] = 22,
							["sizeOverride"] = 60,
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
							["sizeOverride"] = 60,
							["fontSize"] = 22,
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
			["datatexts"] = {
				["fontSize"] = 12,
				["font"] = "ElvUI Font",
				["time24"] = true,
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
		},
		["Zapunzel - Aggramar"] = {
			["currentTutorial"] = 1,
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
			["movers"] = {
				["ElvUF_Raid40Mover"] = "TOPLEFTElvUIParentBOTTOMLEFT1711233",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-300360",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-69230",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM68230",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-3154",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-630300",
				["ElvUF_RaidMover"] = "TOPLEFTElvUIParentBOTTOMLEFT1711236",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-132427",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentBOTTOMLEFT4736",
				["ShiftAB"] = "TOPLEFTElvUIParentBOTTOMLEFT41076",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4834",
				["LootFrameMover"] = "TOPLEFTElvUIParentTOPLEFT268-190",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM045",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM300300",
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
							["fontSize"] = 22,
							["sizeOverride"] = 60,
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
			["datatexts"] = {
				["fontSize"] = 12,
				["font"] = "ElvUI Font",
				["time24"] = true,
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
			["bagsOffsetFixed"] = true,
		},
		["Stormslinger - Aggramar"] = {
			["currentTutorial"] = 1,
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
			["movers"] = {
				["ElvUF_Raid40Mover"] = "TOPLEFTElvUIParentBOTTOMLEFT1711233",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-300360",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-69230",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM68230",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-3154",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-630300",
				["ElvUF_RaidMover"] = "TOPLEFTElvUIParentBOTTOMLEFT1713279",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-132427",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentBOTTOMLEFT4736",
				["ShiftAB"] = "TOPLEFTElvUIParentBOTTOMLEFT41076",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT17124",
				["LootFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-685-158",
				["BossButton"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT522215",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM300300",
			},
			["tooltip"] = {
				["inspectInfo"] = false,
				["itemCount"] = "BOTH",
				["spellID"] = false,
			},
			["hideTutorial"] = true,
			["unitframe"] = {
				["fontSize"] = 12,
				["fontOutline"] = "NONE",
				["font"] = "ElvUI Font",
				["statusbar"] = "Armory",
				["units"] = {
					["player"] = {
						["aurabar"] = {
							["enable"] = false,
							["anchorPoint"] = "BELOW",
						},
						["debuffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
							["sizeOverride"] = 60,
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
			["bagsOffsetFixed"] = true,
		},
		["Greenthorn - Aggramar"] = {
			["currentTutorial"] = 1,
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
			["movers"] = {
				["ElvUF_Raid40Mover"] = "TOPLEFTElvUIParentBOTTOMLEFT1711233",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-300360",
				["ElvUF_RaidMover"] = "TOPLEFTElvUIParentBOTTOMLEFT1713279",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-132427",
				["BossButton"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT522215",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-3154",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-630300",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM68230",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-69230",
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentBOTTOMLEFT4736",
				["ShiftAB"] = "TOPLEFTElvUIParentBOTTOMLEFT41076",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT17124",
				["LootFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-685-158",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM300300",
			},
			["tooltip"] = {
				["inspectInfo"] = false,
				["itemCount"] = "BOTH",
				["spellID"] = false,
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
							["sizeOverride"] = 60,
						},
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["aurabar"] = {
							["enable"] = false,
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
							["attachTo"] = "FRAME",
							["anchorPoint"] = "TOPLEFT",
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
			["datatexts"] = {
				["fontSize"] = 12,
				["font"] = "ElvUI Font",
				["time24"] = true,
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
			["bagsOffsetFixed"] = true,
		},
		["Ryvok - Terokkar"] = {
			["currentTutorial"] = 1,
			["general"] = {
				["autoAcceptInvite"] = true,
				["bottomPanel"] = false,
				["interruptAnnounce"] = "SAY",
				["vendorGrays"] = true,
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
				["ElvUF_Raid40Mover"] = "TOPLEFTElvUIParentBOTTOMLEFT1711233",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-300360",
				["ElvUF_RaidMover"] = "TOPLEFTElvUIParentBOTTOMLEFT1713279",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-132427",
				["BossButton"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT522215",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-3154",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-630300",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM68230",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-69230",
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentBOTTOMLEFT4736",
				["ShiftAB"] = "TOPLEFTElvUIParentBOTTOMLEFT41076",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT17124",
				["LootFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-685-158",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM300300",
			},
			["tooltip"] = {
				["inspectInfo"] = false,
				["itemCount"] = "BOTH",
				["spellID"] = false,
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
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["debuffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
							["sizeOverride"] = 60,
						},
						["aurabar"] = {
							["enable"] = false,
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
			["datatexts"] = {
				["time24"] = true,
				["fontSize"] = 12,
				["font"] = "ElvUI Font",
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
			["bagsOffsetFixed"] = true,
		},
		["Kromethious - Aggramar"] = {
			["nameplate"] = {
				["threat"] = {
					["badScale"] = 1.5,
				},
				["colorNameByValue"] = false,
				["targetIndicator"] = {
					["style"] = "arrow",
				},
			},
			["currentTutorial"] = 1,
			["general"] = {
				["stickyFrames"] = false,
				["interruptAnnounce"] = "SAY",
				["autoAcceptInvite"] = true,
				["afk"] = false,
				["autoRepair"] = "PLAYER",
				["bottomPanel"] = false,
				["valuecolor"] = {
					["b"] = 0.819,
					["g"] = 0.513,
					["r"] = 0.09,
				},
				["vendorGrays"] = true,
				["bordercolor"] = {
					["b"] = 0.31,
					["g"] = 0.31,
					["r"] = 0.31,
				},
			},
			["movers"] = {
				["ElvUF_Raid40Mover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,1722,233",
				["ElvUF_PlayerCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,-300,238",
				["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,-70,80",
				["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,67,80",
				["ElvUF_TargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,300,180",
				["BossButton"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,522,215",
				["ElvAB_5"] = "BOTTOM,ElvUIParent,BOTTOM,-315,4",
				["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,315,4",
				["LootFrameMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,268,-190",
				["ElvUF_PlayerMover"] = "BOTTOM,ElvUIParent,BOTTOM,-300,180",
				["ElvAB_6"] = "BOTTOM,ElvUIParent,BOTTOM,0,4",
				["ElvUF_RaidpetMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,736",
				["ShiftAB"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,1076",
				["ElvUF_BodyGuardMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,492,316",
				["ElvUF_FocusMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-329,423",
				["ElvUF_TargetCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,300,238",
				["TooltipMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-328,307",
				["BossHeaderMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-451,-236",
				["MicrobarMover"] = "TOP,ElvUIParent,TOP,0,-4",
				["ElvUF_PetMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,638,301",
				["ArenaHeaderMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-427,-155",
				["ElvUF_PartyMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,481,412",
				["ElvUF_RaidMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,1723,279",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-132,427",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-630,300",
			},
			["bossAuraFiltersConverted"] = true,
			["hideTutorial"] = true,
			["unitframe"] = {
				["fontSize"] = 12,
				["fontOutline"] = "NONE",
				["statusbar"] = "Armory",
				["font"] = "ElvUI Font",
				["units"] = {
					["player"] = {
						["aurabar"] = {
							["enable"] = false,
						},
						["buffs"] = {
							["noDuration"] = false,
							["attachTo"] = "FRAME",
						},
						["debuffs"] = {
							["attachTo"] = "BUFFS",
						},
						["castbar"] = {
							["enable"] = false,
						},
					},
					["focus"] = {
						["debuffs"] = {
							["sizeOverride"] = 60,
						},
					},
					["target"] = {
						["debuffs"] = {
							["attachTo"] = "FRAME",
						},
						["smartAuraDisplay"] = "DISABLED",
						["buffs"] = {
							["enable"] = false,
						},
						["castbar"] = {
							["enable"] = false,
						},
						["aurabar"] = {
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
			["bagsOffsetFixed"] = true,
		},
		["Kylosandrax - Aggramar"] = {
			["nameplate"] = {
				["threat"] = {
					["badScale"] = 1.5,
				},
				["colorNameByValue"] = false,
				["targetIndicator"] = {
					["style"] = "arrow",
				},
			},
			["currentTutorial"] = 1,
			["general"] = {
				["stickyFrames"] = false,
				["interruptAnnounce"] = "SAY",
				["autoAcceptInvite"] = true,
				["afk"] = false,
				["autoRepair"] = "PLAYER",
				["bottomPanel"] = false,
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
				["vendorGrays"] = true,
			},
			["movers"] = {
				["ElvUF_Raid40Mover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,1722,233",
				["ElvUF_PlayerCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,-300,238",
				["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,-70,80",
				["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,67,80",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-630,300",
				["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,315,4",
				["ElvAB_5"] = "BOTTOM,ElvUIParent,BOTTOM,-315,4",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-132,427",
				["ElvUF_RaidMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,1723,279",
				["ElvUF_BodyGuardMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,492,316",
				["ArenaHeaderMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-427,-155",
				["ElvUF_RaidpetMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,736",
				["ShiftAB"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,1076",
				["ElvUF_PetMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,638,301",
				["ElvUF_FocusMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-329,423",
				["ElvAB_6"] = "BOTTOM,ElvUIParent,BOTTOM,0,4",
				["TooltipMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-328,307",
				["MicrobarMover"] = "TOP,ElvUIParent,TOP,0,-4",
				["BossHeaderMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-451,-236",
				["ElvUF_PlayerMover"] = "BOTTOM,ElvUIParent,BOTTOM,-300,180",
				["ElvUF_TargetCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,300,238",
				["ElvUF_PartyMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,481,412",
				["LootFrameMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,268,-190",
				["BossButton"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,522,215",
				["ElvUF_TargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,300,180",
			},
			["bossAuraFiltersConverted"] = true,
			["hideTutorial"] = true,
			["unitframe"] = {
				["fontSize"] = 12,
				["fontOutline"] = "NONE",
				["statusbar"] = "Armory",
				["font"] = "ElvUI Font",
				["units"] = {
					["player"] = {
						["castbar"] = {
							["enable"] = false,
						},
						["buffs"] = {
							["noDuration"] = false,
							["attachTo"] = "FRAME",
						},
						["debuffs"] = {
							["attachTo"] = "BUFFS",
						},
						["aurabar"] = {
							["enable"] = false,
						},
					},
					["focus"] = {
						["debuffs"] = {
							["sizeOverride"] = 60,
						},
					},
					["target"] = {
						["debuffs"] = {
							["attachTo"] = "FRAME",
						},
						["smartAuraDisplay"] = "DISABLED",
						["buffs"] = {
							["enable"] = false,
						},
						["castbar"] = {
							["enable"] = false,
						},
						["aurabar"] = {
							["enable"] = false,
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
			["datatexts"] = {
				["fontSize"] = 12,
				["font"] = "ElvUI Font",
				["time24"] = true,
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
			["bagsOffsetFixed"] = true,
		},
		["Kxtrader - Aggramar"] = {
			["nameplate"] = {
				["targetIndicator"] = {
					["style"] = "arrow",
				},
			},
			["currentTutorial"] = 1,
			["general"] = {
				["autoAcceptInvite"] = true,
				["autoRepair"] = "PLAYER",
				["bottomPanel"] = false,
				["valuecolor"] = {
					["b"] = 0.819,
					["g"] = 0.513,
					["r"] = 0.09,
				},
				["stickyFrames"] = false,
				["vendorGrays"] = true,
				["bordercolor"] = {
					["b"] = 0.31,
					["g"] = 0.31,
					["r"] = 0.31,
				},
				["interruptAnnounce"] = "SAY",
			},
			["hideTutorial"] = true,
			["layoutSet"] = "tank",
			["bagsOffsetFixed"] = true,
			["movers"] = {
				["ElvUF_Raid40Mover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,1722,233",
				["ElvUF_PlayerCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,-300,238",
				["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,-70,100",
				["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,67,100",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-630,300",
				["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,315,4",
				["ElvAB_5"] = "BOTTOM,ElvUIParent,BOTTOM,-315,4",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-132,427",
				["ElvUF_RaidMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,1723,243",
				["ElvUF_BodyGuardMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,492,316",
				["ElvUF_TargetCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,300,238",
				["ElvUF_RaidpetMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,736",
				["ShiftAB"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,1076",
				["ElvUF_PetMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,638,301",
				["ElvUF_FocusMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-329,423",
				["ArenaHeaderMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-427,-155",
				["TooltipMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-328,307",
				["MicrobarMover"] = "TOP,ElvUIParent,TOP,0,-4",
				["BossHeaderMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-451,-236",
				["ElvUF_PlayerMover"] = "BOTTOM,ElvUIParent,BOTTOM,-300,180",
				["ElvAB_6"] = "BOTTOM,ElvUIParent,BOTTOM,0,4",
				["ElvUF_PartyMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,481,412",
				["LootFrameMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,268,-190",
				["BossButton"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,522,215",
				["ElvUF_TargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,300,180",
			},
			["unitframe"] = {
				["fontSize"] = 12,
				["font"] = "ElvUI Font",
				["units"] = {
					["focus"] = {
						["debuffs"] = {
							["sizeOverride"] = 60,
							["fontSize"] = 22,
						},
						["buffs"] = {
							["enable"] = true,
						},
					},
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
							["enable"] = true,
							["perrow"] = 8,
						},
					},
					["player"] = {
						["debuffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["aurabar"] = {
							["anchorPoint"] = "BELOW",
						},
						["castbar"] = {
							["enable"] = false,
						},
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
					},
					["target"] = {
						["debuffs"] = {
							["anchorPoint"] = "TOPLEFT",
							["attachTo"] = "FRAME",
						},
						["aurabar"] = {
							["anchorPoint"] = "BELOW",
							["attachTo"] = "BUFFS",
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
			["bossAuraFiltersConverted"] = true,
		},
		["Feldspar - Aggramar"] = {
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
			["movers"] = {
				["ElvUF_Raid40Mover"] = "TOPLEFTElvUIParentBOTTOMLEFT1711233",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-300360",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-69230",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM68230",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-3154",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-630300",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-132427",
				["ElvUF_RaidMover"] = "TOPLEFTElvUIParentBOTTOMLEFT1711236",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentBOTTOMLEFT4736",
				["ShiftAB"] = "TOPLEFTElvUIParentBOTTOMLEFT41076",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4834",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM045",
				["LootFrameMover"] = "TOPLEFTElvUIParentTOPLEFT268-190",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM300300",
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
							["fontSize"] = 22,
							["sizeOverride"] = 60,
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
							["attachTo"] = "FRAME",
							["anchorPoint"] = "TOPLEFT",
						},
						["aurabar"] = {
							["attachTo"] = "BUFFS",
							["anchorPoint"] = "BELOW",
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
							["sizeOverride"] = 60,
							["fontSize"] = 22,
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
			["datatexts"] = {
				["fontSize"] = 12,
				["font"] = "ElvUI Font",
				["time24"] = true,
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
			["bagsOffsetFixed"] = true,
		},
		["Kylozandrax - Earthen Ring"] = {
			["movers"] = {
				["ElvUF_Raid40Mover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4374",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-300360",
				["ElvUF_RaidMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4374",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-132427",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM045",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-3154",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-630300",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM68230",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-69230",
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4834",
				["LootFrameMover"] = "TOPLEFTElvUIParentTOPLEFT268-190",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM300300",
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
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["debuffs"] = {
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
		["Kxchanter - Aggramar"] = {
			["nameplate"] = {
				["targetIndicator"] = {
					["style"] = "arrow",
				},
			},
			["currentTutorial"] = 1,
			["general"] = {
				["stickyFrames"] = false,
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
				["ElvUF_Raid40Mover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,1722,233",
				["ElvUF_PlayerCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,-300,238",
				["ElvUF_RaidMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,1723,243",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-132,427",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-630,300",
				["BossButton"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,522,215",
				["ElvAB_5"] = "BOTTOM,ElvUIParent,BOTTOM,-315,4",
				["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,67,100",
				["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,-70,100",
				["ElvUF_PlayerMover"] = "BOTTOM,ElvUIParent,BOTTOM,-300,180",
				["ElvUF_TargetCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,300,238",
				["ElvUF_RaidpetMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,736",
				["ShiftAB"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,1076",
				["ElvUF_PetMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,638,301",
				["ElvUF_FocusMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-329,423",
				["ArenaHeaderMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-427,-155",
				["TooltipMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-328,307",
				["MicrobarMover"] = "TOP,ElvUIParent,TOP,0,-4",
				["BossHeaderMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-451,-236",
				["ElvUF_BodyGuardMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,492,316",
				["ElvAB_6"] = "BOTTOM,ElvUIParent,BOTTOM,0,4",
				["ElvUF_PartyMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,481,412",
				["LootFrameMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,268,-190",
				["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,315,4",
				["ElvUF_TargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,300,180",
			},
			["bossAuraFiltersConverted"] = true,
			["hideTutorial"] = true,
			["unitframe"] = {
				["fontSize"] = 12,
				["fontOutline"] = "NONE",
				["statusbar"] = "Armory",
				["font"] = "ElvUI Font",
				["units"] = {
					["player"] = {
						["castbar"] = {
							["enable"] = false,
						},
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["debuffs"] = {
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
							["fontSize"] = 22,
							["sizeOverride"] = 60,
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
			["datatexts"] = {
				["fontSize"] = 12,
				["font"] = "ElvUI Font",
				["time24"] = true,
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
			["bagsOffsetFixed"] = true,
		},
		["Kyloc - Aggramar"] = {
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
				["ElvUF_Raid40Mover"] = "TOPLEFTElvUIParentBOTTOMLEFT1711233",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-300360",
				["ElvUF_RaidMover"] = "TOPLEFTElvUIParentBOTTOMLEFT1713279",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-132427",
				["BossButton"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT522215",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-3154",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-630300",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM68230",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-69230",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentBOTTOMLEFT4736",
				["ShiftAB"] = "TOPLEFTElvUIParentBOTTOMLEFT41076",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT17124",
				["LootFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-685-158",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM300300",
			},
			["tooltip"] = {
				["inspectInfo"] = false,
				["itemCount"] = "BOTH",
				["spellID"] = false,
			},
			["hideTutorial"] = true,
			["unitframe"] = {
				["fontSize"] = 12,
				["fontOutline"] = "NONE",
				["font"] = "ElvUI Font",
				["statusbar"] = "Armory",
				["units"] = {
					["player"] = {
						["aurabar"] = {
							["anchorPoint"] = "BELOW",
							["enable"] = false,
						},
						["debuffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
							["sizeOverride"] = 60,
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
			["bagsOffsetFixed"] = true,
		},
		["Banjax - Aggramar"] = {
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
				["ElvUF_Raid40Mover"] = "TOPLEFTElvUIParentBOTTOMLEFT1711233",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-300360",
				["ElvUF_RaidMover"] = "TOPLEFTElvUIParentBOTTOMLEFT1713279",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-132427",
				["BossButton"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT522215",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-3154",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-630300",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM68230",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-69230",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentBOTTOMLEFT4736",
				["ShiftAB"] = "TOPLEFTElvUIParentBOTTOMLEFT41076",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT17124",
				["LootFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-685-158",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM300300",
			},
			["tooltip"] = {
				["inspectInfo"] = false,
				["itemCount"] = "BOTH",
				["spellID"] = false,
			},
			["hideTutorial"] = true,
			["unitframe"] = {
				["fontSize"] = 12,
				["fontOutline"] = "NONE",
				["font"] = "ElvUI Font",
				["statusbar"] = "Armory",
				["units"] = {
					["player"] = {
						["aurabar"] = {
							["enable"] = false,
							["anchorPoint"] = "BELOW",
						},
						["debuffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
							["sizeOverride"] = 60,
						},
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["castbar"] = {
							["enable"] = false,
						},
					},
					["raid40"] = {
						["enable"] = false,
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
			["bagsOffsetFixed"] = true,
		},
		["Kylosandrix - Aggramar"] = {
			["currentTutorial"] = 1,
			["bagsOffsetFixed"] = true,
			["movers"] = {
				["ElvUF_Raid40Mover"] = "TOPLEFTElvUIParentBOTTOMLEFT1711233",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-300360",
				["ElvUF_RaidMover"] = "TOPLEFTElvUIParentBOTTOMLEFT1713279",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-132427",
				["BossButton"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT522215",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-3154",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-630300",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM68230",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-69230",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentBOTTOMLEFT4736",
				["ShiftAB"] = "TOPLEFTElvUIParentBOTTOMLEFT41076",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT17124",
				["LootFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-685-158",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM300300",
			},
			["tooltip"] = {
				["inspectInfo"] = false,
				["itemCount"] = "BOTH",
				["spellID"] = false,
			},
			["hideTutorial"] = true,
			["unitframe"] = {
				["fontSize"] = 12,
				["fontOutline"] = "NONE",
				["font"] = "ElvUI Font",
				["statusbar"] = "Armory",
				["units"] = {
					["player"] = {
						["aurabar"] = {
							["enable"] = false,
							["anchorPoint"] = "BELOW",
						},
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["debuffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
							["sizeOverride"] = 60,
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
		},
		["Ryvok - Aggramar"] = {
			["nameplate"] = {
				["targetIndicator"] = {
					["style"] = "arrow",
				},
			},
			["currentTutorial"] = 1,
			["general"] = {
				["stickyFrames"] = false,
				["interruptAnnounce"] = "SAY",
				["autoAcceptInvite"] = true,
				["afk"] = false,
				["autoRepair"] = "PLAYER",
				["bottomPanel"] = false,
				["valuecolor"] = {
					["b"] = 0.819,
					["g"] = 0.513,
					["r"] = 0.09,
				},
				["vendorGrays"] = true,
				["bordercolor"] = {
					["b"] = 0.31,
					["g"] = 0.31,
					["r"] = 0.31,
				},
			},
			["movers"] = {
				["ElvUF_Raid40Mover"] = "TOPLEFTElvUIParentBOTTOMLEFT1722233",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-300238",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-7080",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM6780",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-630300",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-3154",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-132427",
				["ElvUF_RaidMover"] = "TOPLEFTElvUIParentBOTTOMLEFT1723243",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300238",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentBOTTOMLEFT4736",
				["ShiftAB"] = "TOPLEFTElvUIParentBOTTOMLEFT41076",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300180",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_BodyGuardMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT492316",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT481412",
				["LootFrameMover"] = "TOPLEFTElvUIParentTOPLEFT268-190",
				["BossButton"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT522215",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM300180",
			},
			["hideTutorial"] = true,
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
							["sizeOverride"] = 60,
							["fontSize"] = 22,
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
							["sizeOverride"] = 60,
							["fontSize"] = 22,
							["perrow"] = 8,
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:current-percent]",
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
						["name"] = {
							["text_format"] = "[namecolor][name:medium] [difficultycolor][smartlevel] [shortclassification]",
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
			["bagsOffsetFixed"] = true,
		},
		["Bronin - Aggramar"] = {
			["currentTutorial"] = 1,
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
				["ElvUF_Raid40Mover"] = "TOPLEFTElvUIParentBOTTOMLEFT1711233",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-300360",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-69230",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM68230",
				["BossButton"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT522215",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-3154",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM300300",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["LootFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-685-158",
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentBOTTOMLEFT4736",
				["ShiftAB"] = "TOPLEFTElvUIParentBOTTOMLEFT41076",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT17124",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-132427",
				["ElvUF_RaidMover"] = "TOPLEFTElvUIParentBOTTOMLEFT1713279",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-630300",
			},
			["tooltip"] = {
				["inspectInfo"] = false,
				["itemCount"] = "BOTH",
				["spellID"] = false,
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
							["sizeOverride"] = 60,
						},
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["aurabar"] = {
							["enable"] = false,
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
							["attachTo"] = "FRAME",
							["anchorPoint"] = "TOPLEFT",
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
							["sizeOverride"] = 60,
							["fontSize"] = 22,
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
			["datatexts"] = {
				["fontSize"] = 12,
				["font"] = "ElvUI Font",
				["time24"] = true,
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
			["bagsOffsetFixed"] = true,
		},
	},
}
ElvPrivateDB = {
	["profileKeys"] = {
		["Ryjax - Aggramar"] = "Ryjax - Aggramar",
		["Zapunzel - Aggramar"] = "Zapunzel - Aggramar",
		["Stormslinger - Aggramar"] = "Stormslinger - Aggramar",
		["Greenthorn - Aggramar"] = "Greenthorn - Aggramar",
		["Ryvok - Terokkar"] = "Ryvok - Terokkar",
		["Kromethious - Aggramar"] = "Kromethious - Aggramar",
		["Kylosandrax - Aggramar"] = "Kylosandrax - Aggramar",
		["Kxtrader - Aggramar"] = "Kxtrader - Aggramar",
		["Feldspar - Aggramar"] = "Feldspar - Aggramar",
		["Kylozandrax - Earthen Ring"] = "Kylozandrax - Earthen Ring",
		["Kxchanter - Aggramar"] = "Kxchanter - Aggramar",
		["Kyloc - Aggramar"] = "Kyloc - Aggramar",
		["Banjax - Aggramar"] = "Banjax - Aggramar",
		["Kylosandrix - Aggramar"] = "Kylosandrix - Aggramar",
		["Ryvok - Aggramar"] = "Ryvok - Aggramar",
		["Bronin - Aggramar"] = "Bronin - Aggramar",
	},
	["profiles"] = {
		["Ryjax - Aggramar"] = {
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
			["addonskins"] = {
				["WeakAurasSkin"] = false,
				["AuctionatorSkin"] = false,
				["BugSackSkin"] = false,
				["BagnonSkin"] = false,
				["DBMSkin"] = false,
				["AskMrRobotSkin"] = false,
				["OverachieverSkin"] = false,
				["TradeSkillDWSkin"] = false,
				["CliqueSkin"] = false,
				["PostalSkin"] = false,
				["SkadaSkin"] = false,
			},
			["install_complete"] = "7.74",
		},
		["Zapunzel - Aggramar"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["addonskins"] = {
				["WeakAurasSkin"] = false,
				["AuctionatorSkin"] = false,
				["BugSackSkin"] = false,
				["BagnonSkin"] = false,
				["DBMSkin"] = false,
				["PostalSkin"] = false,
				["OverachieverSkin"] = false,
				["TradeSkillDWSkin"] = false,
				["QuartzSkin"] = false,
				["CliqueSkin"] = false,
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
		["Stormslinger - Aggramar"] = {
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
			["addonskins"] = {
				["WeakAurasSkin"] = false,
				["AuctionatorSkin"] = false,
				["BugSackSkin"] = false,
				["BagnonSkin"] = false,
				["DBMSkin"] = false,
				["PostalSkin"] = false,
				["OverachieverSkin"] = false,
				["TradeSkillDWSkin"] = false,
				["SkadaSkin"] = false,
				["CliqueSkin"] = false,
				["QuartzSkin"] = false,
			},
			["install_complete"] = "7.18",
		},
		["Greenthorn - Aggramar"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["addonskins"] = {
				["WeakAurasSkin"] = false,
				["AuctionatorSkin"] = false,
				["BugSackSkin"] = false,
				["BagnonSkin"] = false,
				["DBMSkin"] = false,
				["PostalSkin"] = false,
				["OverachieverSkin"] = false,
				["TradeSkillDWSkin"] = false,
				["QuartzSkin"] = false,
				["CliqueSkin"] = false,
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
			["install_complete"] = "7.18",
		},
		["Ryvok - Terokkar"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["theme"] = "classic",
			["install_complete"] = "8.10",
		},
		["Kromethious - Aggramar"] = {
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
			["install_complete"] = "8.38",
		},
		["Kylosandrax - Aggramar"] = {
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
			["addonskins"] = {
				["WeakAurasSkin"] = false,
				["AuctionatorSkin"] = false,
				["BugSackSkin"] = false,
				["BagnonSkin"] = false,
				["DBMSkin"] = false,
				["AskMrRobotSkin"] = false,
				["OverachieverSkin"] = false,
				["TradeSkillDWSkin"] = false,
				["CliqueSkin"] = false,
				["PostalSkin"] = false,
				["SkadaSkin"] = false,
			},
			["install_complete"] = "8.38",
		},
		["Kxtrader - Aggramar"] = {
			["bags"] = {
				["enable"] = false,
			},
			["theme"] = "class",
			["install_complete"] = "8.38",
		},
		["Feldspar - Aggramar"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["addonskins"] = {
				["WeakAurasSkin"] = false,
				["AuctionatorSkin"] = false,
				["BugSackSkin"] = false,
				["BagnonSkin"] = false,
				["DBMSkin"] = false,
				["PostalSkin"] = false,
				["OverachieverSkin"] = false,
				["TradeSkillDWSkin"] = false,
				["QuartzSkin"] = false,
				["CliqueSkin"] = false,
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
			["tooltip"] = {
				["enable"] = false,
			},
			["bags"] = {
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
		["Kxchanter - Aggramar"] = {
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
			["install_complete"] = "8.38",
		},
		["Kyloc - Aggramar"] = {
			["install_complete"] = "7.74",
		},
		["Banjax - Aggramar"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["addonskins"] = {
				["WeakAurasSkin"] = false,
				["AuctionatorSkin"] = false,
				["BugSackSkin"] = false,
				["SkadaSkin"] = false,
				["BagnonSkin"] = false,
				["DBMSkin"] = false,
				["QuartzSkin"] = false,
				["OverachieverSkin"] = false,
				["TradeSkillDWSkin"] = false,
				["CliqueSkin"] = false,
				["TomTomSkin"] = false,
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
			["install_complete"] = "7.18",
		},
		["Kylosandrix - Aggramar"] = {
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
			["install_complete"] = "8.10",
		},
		["Ryvok - Aggramar"] = {
			["addonskins"] = {
				["WeakAurasSkin"] = false,
				["AuctionatorSkin"] = false,
				["BugSackSkin"] = false,
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
			["bags"] = {
				["enable"] = false,
			},
			["theme"] = "class",
			["install_complete"] = "8.38",
		},
		["Bronin - Aggramar"] = {
			["addonskins"] = {
				["WeakAurasSkin"] = false,
				["AuctionatorSkin"] = false,
				["BugSackSkin"] = false,
				["DBMFont"] = "ElvUI Alt-Font",
				["BagnonSkin"] = false,
				["DBMSkin"] = false,
				["PostalSkin"] = false,
				["OverachieverSkin"] = false,
				["TradeSkillDWSkin"] = false,
				["CliqueSkin"] = false,
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
			["theme"] = "classic",
			["install_complete"] = "7.14",
		},
	},
}
