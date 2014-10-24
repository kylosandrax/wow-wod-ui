
ElvDB = {
	["profileKeys"] = {
		["Stormslinger - Aggramar"] = "Stormslinger - Aggramar",
		["Zapunzel - Aggramar"] = "Zapunzel - Aggramar",
		["Feldspar - Aggramar"] = "Feldspar - Aggramar",
		["Greenthorn - Aggramar"] = "Greenthorn - Aggramar",
		["Ryjax - Aggramar"] = "Ryjax - Aggramar",
		["Kylosandrax - Aggramar"] = "Kylosandrax - Aggramar",
		["Ryvok - Aggramar"] = "Ryvok - Aggramar",
		["Bronin - Aggramar"] = "Bronin - Aggramar",
	},
	["gold"] = {
		["Aggramar"] = {
			["Ryvok"] = 94770338,
			["Feldspar"] = 17165522,
			["Ryjax"] = 108628274,
			["Zapunzel"] = 637932214,
			["Stormslinger"] = 48747369,
			["Bronin"] = 43522590,
			["Kylosandrax"] = 79396837,
			["Greenthorn"] = 22256407,
		},
	},
	["namespaces"] = {
		["LibDualSpec-1.0"] = {
		},
	},
	["profiles"] = {
		["Stormslinger - Aggramar"] = {
		},
		["Zapunzel - Aggramar"] = {
		},
		["Feldspar - Aggramar"] = {
		},
		["Greenthorn - Aggramar"] = {
		},
		["Ryjax - Aggramar"] = {
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
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-547300",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-300360",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-69230",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM045",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-3154",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM68230",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM300300",
			},
			["layoutSet"] = "tank",
			["unitframe"] = {
				["fontSize"] = 12,
				["fontOutline"] = "NONE",
				["font"] = "ElvUI Font",
				["statusbar"] = "Armory",
				["units"] = {
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
					["targettarget"] = {
						["threatStyle"] = "GLOW",
						["debuffs"] = {
							["anchorPoint"] = "TOPRIGHT",
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
						["width"] = 270,
					},
					["focus"] = {
						["buffs"] = {
							["enable"] = true,
						},
					},
				},
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
		["Kylosandrax - Aggramar"] = {
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
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM-300360",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM-69230",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM68230",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM045",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-3154",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-630300",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-132427",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM300300",
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
		["Ryvok - Aggramar"] = {
		},
		["Bronin - Aggramar"] = {
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
				["vendorGrays"] = true,
				["bordercolor"] = {
					["b"] = 0.31,
					["g"] = 0.31,
					["r"] = 0.31,
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
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM300300",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3154",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT638301",
				["LootFrameMover"] = "TOPLEFTElvUIParentTOPLEFT268-190",
				["ElvAB_6"] = "BOTTOMElvUIParentBOTTOM04",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-329423",
				["ElvUF_TargetCastbarMover"] = "BOTTOMElvUIParentBOTTOM300360",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-328307",
				["BossHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-451-236",
				["MicrobarMover"] = "TOPElvUIParentTOP0-4",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-300300",
				["ArenaHeaderMover"] = "TOPRIGHTElvUIParentTOPRIGHT-427-155",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4834",
				["ElvUF_RaidMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4374",
				["ElvUF_FocusTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-132427",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-630300",
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
							["sizeOverride"] = 60,
							["fontSize"] = 22,
						},
						["buffs"] = {
							["enable"] = true,
						},
					},
					["target"] = {
						["debuffs"] = {
							["attachTo"] = "FRAME",
							["anchorPoint"] = "TOPLEFT",
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
		["Stormslinger - Aggramar"] = "Stormslinger - Aggramar",
		["Zapunzel - Aggramar"] = "Zapunzel - Aggramar",
		["Feldspar - Aggramar"] = "Feldspar - Aggramar",
		["Greenthorn - Aggramar"] = "Greenthorn - Aggramar",
		["Ryjax - Aggramar"] = "Ryjax - Aggramar",
		["Kylosandrax - Aggramar"] = "Kylosandrax - Aggramar",
		["Ryvok - Aggramar"] = "Ryvok - Aggramar",
		["Bronin - Aggramar"] = "Bronin - Aggramar",
	},
	["profiles"] = {
		["Stormslinger - Aggramar"] = {
			["addonskins"] = {
				["Blizzard_WorldStateCaptureBar"] = true,
			},
		},
		["Zapunzel - Aggramar"] = {
			["addonskins"] = {
				["Blizzard_WorldStateCaptureBar"] = true,
			},
		},
		["Feldspar - Aggramar"] = {
			["addonskins"] = {
				["Blizzard_WorldStateCaptureBar"] = true,
			},
		},
		["Greenthorn - Aggramar"] = {
			["addonskins"] = {
				["Blizzard_WorldStateCaptureBar"] = true,
			},
		},
		["Ryjax - Aggramar"] = {
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
				["AskMrRobotSkin"] = false,
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
			["addonskins"] = {
				["Blizzard_WorldStateCaptureBar"] = false,
				["AuctionatorSkin"] = false,
				["BugSackSkin"] = false,
				["AskMrRobotSkin"] = false,
				["BagnonSkin"] = false,
				["DBMSkin"] = false,
				["PostalSkin"] = false,
				["OverachieverSkin"] = false,
				["TradeSkillDWSkin"] = false,
				["CliqueSkin"] = false,
				["SkadaSkin"] = false,
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
		["Ryvok - Aggramar"] = {
			["addonskins"] = {
				["Blizzard_WorldStateCaptureBar"] = true,
			},
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
