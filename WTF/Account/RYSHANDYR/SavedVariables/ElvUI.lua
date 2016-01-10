
ElvDB = {
	["profileKeys"] = {
		["Zapunzel - Aggramar"] = "Zapunzel - Aggramar",
		["Greenthorn - Aggramar"] = "Greenthorn - Aggramar",
		["Ryjax - Aggramar"] = "Ryjax - Aggramar",
		["Kylosandrax - Aggramar"] = "Kylosandrax - Aggramar",
		["Stormslinger - Aggramar"] = "Stormslinger - Aggramar",
		["Feldspar - Aggramar"] = "Feldspar - Aggramar",
		["Kylozandrax - Earthen Ring"] = "Kylozandrax - Earthen Ring",
		["Ryvok - Terokkar"] = "Ryvok - Terokkar",
		["Kyloc - Aggramar"] = "Kyloc - Aggramar",
		["Banjax - Aggramar"] = "Banjax - Aggramar",
		["Kylosandrix - Aggramar"] = "Kylosandrix - Aggramar",
		["Ryvok - Aggramar"] = "Ryvok - Aggramar",
		["Bronin - Aggramar"] = "Bronin - Aggramar",
	},
	["gold"] = {
		["Aggramar"] = {
			["Bronin"] = 115428291,
			["Ryjax"] = 64176001,
			["Zapunzel"] = 706384548,
			["Kylosandrax"] = 111449400,
			["Greenthorn"] = 22790595,
			["Kylosandrix"] = 119,
			["Banjax"] = 1372708,
			["Stormslinger"] = 103458911,
			["Ryvok"] = 141046714,
			["Feldspar"] = 23127311,
			["Kyloc"] = 0,
		},
		["Earthen Ring"] = {
			["Kylozandrax"] = 22373801,
		},
		["Terokkar"] = {
			["Ryvok"] = 124,
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
		["Zapunzel - Aggramar"] = {
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
				["ElvUF_RaidMover"] = "TOPLEFTElvUIParentBOTTOMLEFT1711236",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-132427",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentBOTTOMLEFT4736",
				["ShiftAB"] = "TOPLEFTElvUIParentBOTTOMLEFT41076",
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
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
		["Greenthorn - Aggramar"] = {
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
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentBOTTOMLEFT4736",
				["ShiftAB"] = "TOPLEFTElvUIParentBOTTOMLEFT41076",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
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
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
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
						["debuffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
							["sizeOverride"] = 60,
						},
						["buffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
						},
						["aurabar"] = {
							["anchorPoint"] = "BELOW",
							["enable"] = false,
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
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentBOTTOMLEFT4736",
				["ShiftAB"] = "TOPLEFTElvUIParentBOTTOMLEFT41076",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT17124",
				["LootFrameMover"] = "TOPLEFTElvUIParentTOPLEFT268-190",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
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
		["Stormslinger - Aggramar"] = {
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
				["ElvUF_RaidMover"] = "TOPLEFTElvUIParentBOTTOMLEFT1713279",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-132427",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentBOTTOMLEFT4736",
				["ShiftAB"] = "TOPLEFTElvUIParentBOTTOMLEFT41076",
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
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
		["Feldspar - Aggramar"] = {
			["currentTutorial"] = 1,
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
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
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
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4834",
				["LootFrameMover"] = "TOPLEFTElvUIParentTOPLEFT268-190",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM300300",
			},
			["layoutSet"] = "tank",
			["datatexts"] = {
				["fontSize"] = 12,
				["font"] = "ElvUI Font",
				["time24"] = true,
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
		["Ryvok - Terokkar"] = {
			["currentTutorial"] = 1,
			["general"] = {
				["valuecolor"] = {
					["b"] = 0.819,
					["g"] = 0.513,
					["r"] = 0.09,
				},
				["bottomPanel"] = false,
				["interruptAnnounce"] = "SAY",
				["autoAcceptInvite"] = true,
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
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentBOTTOMLEFT4736",
				["ShiftAB"] = "TOPLEFTElvUIParentBOTTOMLEFT41076",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
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
		["Kyloc - Aggramar"] = {
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
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
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
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
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
			["hideTutorial"] = true,
			["layoutSet"] = "tank",
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
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
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
			["unitframe"] = {
				["fontSize"] = 12,
				["statusbar"] = "Armory",
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
							["sizeOverride"] = 60,
							["anchorPoint"] = "TOPRIGHT",
							["perrow"] = 8,
							["fontSize"] = 22,
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
							["sizeOverride"] = 60,
						},
						["aurabar"] = {
							["enable"] = false,
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
				["font"] = "ElvUI Font",
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
			["general"] = {
				["autoAcceptInvite"] = true,
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
				["interruptAnnounce"] = "SAY",
			},
		},
		["Ryvok - Aggramar"] = {
			["currentTutorial"] = 1,
			["bagsOffsetFixed"] = true,
			["movers"] = {
				["ElvUF_Raid40Mover"] = "TOPLEFTElvUIParentBOTTOMLEFT1720233",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-300360",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-69230",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM68230",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-3154",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-630300",
				["ElvUF_RaidMover"] = "TOPLEFTElvUIParentBOTTOMLEFT1721283",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-132427",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentBOTTOMLEFT4736",
				["ShiftAB"] = "TOPLEFTElvUIParentBOTTOMLEFT41076",
				["ArenaHeaderMover"] = "TOPLEFTElvUIParentTOPLEFT353-154",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["BossHeaderMover"] = "TOPLEFTElvUIParentTOPLEFT353-154",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT413243",
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
		["Bronin - Aggramar"] = {
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
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-69230",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM68230",
				["BossButton"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT522215",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-3154",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM300300",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["LootFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-685-158",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["ElvUF_RaidpetMover"] = "TOPLEFTElvUIParentBOTTOMLEFT4736",
				["ShiftAB"] = "TOPLEFTElvUIParentBOTTOMLEFT41076",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
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
		["Zapunzel - Aggramar"] = "Zapunzel - Aggramar",
		["Greenthorn - Aggramar"] = "Greenthorn - Aggramar",
		["Ryjax - Aggramar"] = "Ryjax - Aggramar",
		["Kylosandrax - Aggramar"] = "Kylosandrax - Aggramar",
		["Stormslinger - Aggramar"] = "Stormslinger - Aggramar",
		["Feldspar - Aggramar"] = "Feldspar - Aggramar",
		["Kylozandrax - Earthen Ring"] = "Kylozandrax - Earthen Ring",
		["Ryvok - Terokkar"] = "Ryvok - Terokkar",
		["Kyloc - Aggramar"] = "Kyloc - Aggramar",
		["Banjax - Aggramar"] = "Banjax - Aggramar",
		["Kylosandrix - Aggramar"] = "Kylosandrix - Aggramar",
		["Ryvok - Aggramar"] = "Ryvok - Aggramar",
		["Bronin - Aggramar"] = "Bronin - Aggramar",
	},
	["profiles"] = {
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
				["SkadaSkin"] = false,
				["PostalSkin"] = false,
				["CliqueSkin"] = false,
			},
			["install_complete"] = "7.14",
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
		["Ryvok - Terokkar"] = {
			["nameplate"] = {
				["enable"] = false,
			},
			["theme"] = "classic",
			["install_complete"] = "8.10",
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
				["PostalSkin"] = false,
				["OverachieverSkin"] = false,
				["TradeSkillDWSkin"] = false,
				["CliqueSkin"] = false,
				["TomTomSkin"] = false,
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
			["install_complete"] = "7.18",
		},
		["Kylosandrix - Aggramar"] = {
			["bags"] = {
				["enable"] = false,
			},
			["skins"] = {
				["blizzard"] = {
					["enable"] = false,
				},
				["ace3"] = {
					["enable"] = false,
				},
			},
			["install_complete"] = "8.10",
		},
		["Ryvok - Aggramar"] = {
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
