
WeakAurasSaved = {
	["displays"] = {
		["Bladestorm CD"] = {
			["disjunctive"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["spellName"] = 46924,
				["use_remaining"] = false,
				["type"] = "status",
				["custom_type"] = "status",
				["use_matchedRune"] = true,
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["subeventPrefix"] = "SPELL",
				["unevent"] = "auto",
				["use_spellName"] = true,
				["custom_hide"] = "timed",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["names"] = {
				},
				["use_unit"] = true,
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = true,
			["progressPrecision"] = 0,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_never"] = false,
				["talent"] = 18,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
						["WARRIOR"] = true,
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						[3] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["stacksPoint"] = "BOTTOMRIGHT",
			["untrigger"] = {
				["spellName"] = 46924,
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["id"] = "Bladestorm CD",
			["additional_triggers"] = {
				{
					["trigger"] = {
						["subeventPrefix"] = "SPELL",
						["type"] = "aura",
						["inverse"] = true,
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["names"] = {
							"Bladestorm", -- [1]
						},
						["event"] = "Health",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["frameStrata"] = 1,
			["width"] = 40,
			["inverse"] = true,
			["xOffset"] = -45,
			["numTriggers"] = 2,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["stickyDuration"] = false,
			["selfPoint"] = "CENTER",
			["cooldown"] = true,
			["textColor"] = {
				1, -- [1]
				0, -- [2]
				0.8, -- [3]
				1, -- [4]
			},
		},
		["Charge"] = {
			["parent"] = "Warrior - Arms",
			["fontSize"] = 16,
			["displayStacks"] = "%s",
			["stacksPoint"] = "BOTTOMRIGHT",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["untrigger"] = {
				["spellName"] = 100,
			},
			["regionType"] = "icon",
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["use_inverse"] = true,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["spellName"] = 100,
				["use_spellName"] = true,
				["names"] = {
					"Charge", -- [1]
				},
				["custom_hide"] = "timed",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["numTriggers"] = 1,
			["selfPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["additional_triggers"] = {
			},
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["id"] = "Charge",
			["stickyDuration"] = false,
			["frameStrata"] = 1,
			["desaturate"] = false,
			["width"] = 40,
			["font"] = "ElvUI Alt-Font",
			["inverse"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["height"] = 40,
			["xOffset"] = 90,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["use_level"] = false,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["textColor"] = {
				1, -- [1]
				0, -- [2]
				0.780392156862745, -- [3]
				1, -- [4]
			},
		},
		["PvP Trinket CD"] = {
			["xOffset"] = 25,
			["yOffset"] = 45,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["itemName"] = 103531,
				["unevent"] = "auto",
				["spellName"] = 0,
				["event"] = "Cooldown Progress (Item)",
				["use_itemName"] = true,
				["subeventPrefix"] = "SPELL",
				["type"] = "status",
				["use_spellName"] = true,
				["custom_hide"] = "timed",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["names"] = {
				},
				["use_unit"] = true,
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["stacksPoint"] = "TOP",
			["stacksContainment"] = "OUTSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["id"] = "PvP Trinket CD",
			["untrigger"] = {
				["itemName"] = 103531,
			},
			["frameStrata"] = 1,
			["width"] = 40,
			["additional_triggers"] = {
			},
			["numTriggers"] = 1,
			["inverse"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.350000023841858, -- [4]
			},
			["stickyDuration"] = false,
			["selfPoint"] = "CENTER",
			["cooldown"] = true,
			["textColor"] = {
				1, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["Runic Power Aura"] = {
			["xOffset"] = -250,
			["mirror"] = false,
			["yOffset"] = -36,
			["regionType"] = "texture",
			["blendMode"] = "ADD",
			["untrigger"] = {
			},
			["color"] = {
				0, -- [1]
				0.815686274509804, -- [2]
				1, -- [3]
				0.850000008940697, -- [4]
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["texture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura73",
			["selfPoint"] = "CENTER",
			["trigger"] = {
				["spellId"] = "85247",
				["ownOnly"] = true,
				["use_unit"] = true,
				["powertype"] = 6,
				["use_powertype"] = true,
				["custom_hide"] = "timed",
				["subeventPrefix"] = "SPELL",
				["type"] = "status",
				["use_power"] = true,
				["unevent"] = "auto",
				["power_operator"] = ">=",
				["power"] = "1",
				["event"] = "Power",
				["useCount"] = true,
				["countOperator"] = "==",
				["use_spellId"] = true,
				["count"] = "1",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["debuffType"] = "HELPFUL",
				["names"] = {
				},
				["fullscan"] = true,
			},
			["id"] = "Runic Power Aura",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["additional_triggers"] = {
			},
			["rotation"] = 0,
			["frameStrata"] = 1,
			["desaturate"] = false,
			["discrete_rotation"] = 0,
			["anchorPoint"] = "CENTER",
			["numTriggers"] = 1,
			["width"] = 155,
			["height"] = 155,
			["rotate"] = true,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = true,
				["class"] = {
					["single"] = "DEATHKNIGHT",
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "Runic Power",
		},
		["Sweeping Strikes"] = {
			["textFlags"] = "OUTLINE",
			["stacksSize"] = 12,
			["user_x"] = 0,
			["xOffset"] = 0.00048828125,
			["stacksFlags"] = "None",
			["yOffset"] = -115,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["sameTexture"] = true,
			["rotateText"] = "NONE",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["selfPoint"] = "CENTER",
			["barColor"] = {
				0, -- [1]
				0.984313725490196, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["rotation"] = 0,
			["sparkOffsetY"] = 0,
			["crop_y"] = 0.41,
			["foregroundTexture"] = "Textures\\SpellActivationOverlays\\Art_of_War",
			["regionType"] = "aurabar",
			["stacks"] = true,
			["blendMode"] = "BLEND",
			["texture"] = "ElvUI Norm",
			["textFont"] = "ElvUI Font",
			["zoom"] = 0,
			["auto"] = true,
			["compress"] = false,
			["timerFont"] = "ElvUI Font",
			["alpha"] = 1,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["stacksPoint"] = "BOTTOMRIGHT",
			["textColor"] = {
				0, -- [1]
				0.984313725490196, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["sparkOffsetX"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["barInFront"] = true,
			["desaturateBackground"] = false,
			["backgroundOffset"] = 2,
			["stacksFont"] = "Friz Quadrata TT",
			["customTextUpdate"] = "update",
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["textSize"] = 15,
			["borderInset"] = 11,
			["untrigger"] = {
			},
			["numTriggers"] = 1,
			["progressPrecision"] = 0,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "aura",
				["spellId"] = "12328",
				["subeventSuffix"] = "_CAST_START",
				["ownOnly"] = true,
				["event"] = "Health",
				["names"] = {
					"Sweeping Strikes", -- [1]
				},
				["use_spellId"] = true,
				["custom_hide"] = "timed",
				["fullscan"] = true,
				["unit"] = "player",
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["text"] = true,
			["borderOffset"] = 5,
			["stickyDuration"] = false,
			["borderBackdrop"] = "Blizzard Tooltip",
			["desaturateForeground"] = false,
			["height"] = 25,
			["id"] = "Sweeping Strikes",
			["timer"] = true,
			["timerFlags"] = "None",
			["sparkRotationMode"] = "AUTO",
			["sparkBlendMode"] = "ADD",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["backgroundTexture"] = "Textures\\SpellActivationOverlays\\Eclipse_Sun",
			["displayStacks"] = "%p",
			["timerSize"] = 12,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["mirror"] = false,
			["border"] = false,
			["borderEdge"] = "None",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["borderSize"] = 16,
			["timerColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon_side"] = "LEFT",
			["user_y"] = 0,
			["displayTextLeft"] = "%n",
			["sparkHeight"] = 30,
			["foregroundColor"] = {
				1, -- [1]
				0.215686274509804, -- [2]
				0.109803921568628, -- [3]
				1, -- [4]
			},
			["stacksContainment"] = "INSIDE",
			["stacksColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayTextRight"] = "%p",
			["spark"] = false,
			["additional_triggers"] = {
			},
			["sparkWidth"] = 10,
			["frameStrata"] = 1,
			["width"] = 350,
			["borderColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["backgroundColor"] = {
				0.274509803921569, -- [1]
				0.537254901960784, -- [2]
				0.819607843137255, -- [3]
				0.5, -- [4]
			},
			["inverse"] = false,
			["sparkDesature"] = false,
			["orientation"] = "HORIZONTAL",
			["crop_x"] = 0.41,
			["cooldown"] = false,
			["parent"] = "Warrior - Arms",
		},
		["HPa"] = {
			["xOffset"] = -217.999389648438,
			["mirror"] = false,
			["yOffset"] = 34,
			["regionType"] = "texture",
			["blendMode"] = "ADD",
			["anchorPoint"] = "CENTER",
			["untrigger"] = {
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["texture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura75",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.75, -- [4]
			},
			["selfPoint"] = "CENTER",
			["id"] = "HPa",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "status",
				["power"] = "0",
				["power_operator"] = ">=",
				["use_power"] = true,
				["event"] = "Holy Power",
				["use_unit"] = true,
				["debuffType"] = "HELPFUL",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["unevent"] = "auto",
				["names"] = {
				},
				["subeventPrefix"] = "SPELL",
				["custom_hide"] = "timed",
			},
			["rotation"] = 0,
			["frameStrata"] = 1,
			["width"] = 75.0003356933594,
			["discrete_rotation"] = 0,
			["desaturate"] = false,
			["numTriggers"] = 1,
			["additional_triggers"] = {
			},
			["height"] = 120,
			["rotate"] = true,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = false,
				["use_combat"] = true,
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						[2] = true,
						[3] = true,
					},
				},
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "v0.91 Prot Pala Group",
		},
		["SW"] = {
			["parent"] = "Warrior - Arms",
			["fontSize"] = 16,
			["displayStacks"] = "%s",
			["stacksPoint"] = "BOTTOMRIGHT",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["untrigger"] = {
				["spellName"] = 46968,
			},
			["regionType"] = "icon",
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["use_inverse"] = true,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["spellName"] = 46968,
				["use_spellName"] = true,
				["names"] = {
					"Charge", -- [1]
				},
				["custom_hide"] = "timed",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["numTriggers"] = 1,
			["selfPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["additional_triggers"] = {
			},
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["id"] = "SW",
			["stickyDuration"] = false,
			["frameStrata"] = 1,
			["desaturate"] = false,
			["width"] = 40,
			["font"] = "ElvUI Alt-Font",
			["inverse"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["height"] = 40,
			["xOffset"] = 45,
			["load"] = {
				["use_level"] = false,
				["talent"] = 11,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["use_never"] = false,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["textColor"] = {
				1, -- [1]
				0, -- [2]
				0.780392156862745, -- [3]
				1, -- [4]
			},
		},
		["Charge CD"] = {
			["xOffset"] = 90,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["names"] = {
					"Charge", -- [1]
				},
				["spellName"] = 100,
				["use_spellName"] = true,
				["use_unit"] = true,
				["custom_hide"] = "timed",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_level"] = false,
				["use_spec"] = true,
				["use_never"] = false,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["cooldown"] = true,
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["additional_triggers"] = {
			},
			["selfPoint"] = "CENTER",
			["frameStrata"] = 1,
			["width"] = 40,
			["untrigger"] = {
				["spellName"] = 100,
			},
			["numTriggers"] = 1,
			["inverse"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.350000023841858, -- [4]
			},
			["id"] = "Charge CD",
			["stickyDuration"] = false,
			["stacksPoint"] = "BOTTOMRIGHT",
			["textColor"] = {
				1, -- [1]
				0, -- [2]
				0.780392156862745, -- [3]
				1, -- [4]
			},
		},
		["IV CD"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.350000023841858, -- [4]
			},
			["untrigger"] = {
				["spellName"] = 103840,
			},
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["spellName"] = 103840,
				["use_spellName"] = true,
				["custom_hide"] = "timed",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_never"] = false,
				["talent"] = 6,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["cooldown"] = true,
			["stacksContainment"] = "OUTSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["additional_triggers"] = {
			},
			["id"] = "IV CD",
			["frameStrata"] = 1,
			["width"] = 40,
			["yOffset"] = -65,
			["inverse"] = true,
			["numTriggers"] = 1,
			["xOffset"] = -150,
			["stickyDuration"] = false,
			["selfPoint"] = "CENTER",
			["stacksPoint"] = "BOTTOM",
			["textColor"] = {
				1, -- [1]
				0, -- [2]
				0.156862745098039, -- [3]
				1, -- [4]
			},
		},
		["Avatar Aura"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["preset"] = "alphaPulse",
					["type"] = "preset",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "aura",
				["unevent"] = "auto",
				["use_inverse"] = true,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["spellName"] = 107574,
				["use_spellName"] = true,
				["custom_hide"] = "timed",
				["names"] = {
					"Avatar", -- [1]
				},
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_never"] = false,
				["talent"] = 16,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["cooldown"] = false,
			["selfPoint"] = "CENTER",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["additional_triggers"] = {
			},
			["untrigger"] = {
				["spellName"] = 107574,
			},
			["frameStrata"] = 1,
			["width"] = 40,
			["numTriggers"] = 1,
			["id"] = "Avatar Aura",
			["inverse"] = false,
			["xOffset"] = -45,
			["stickyDuration"] = false,
			["displayIcon"] = "Interface\\Icons\\Spell_Nature_WispSplode",
			["stacksPoint"] = "CENTER",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Divine Protection"] = {
			["xOffset"] = -132,
			["untrigger"] = {
			},
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["actions"] = {
				["start"] = {
					["message_type"] = "COMBAT",
					["do_message"] = false,
					["message"] = "Test",
				},
				["finish"] = {
					["message_type"] = "COMBAT",
					["do_message"] = false,
					["message"] = "test",
				},
			},
			["fontFlags"] = "OUTLINE",
			["useTooltip"] = false,
			["selfPoint"] = "CENTER",
			["trigger"] = {
				["rem"] = "5",
				["subeventSuffix"] = "_CAST_START",
				["ownOnly"] = true,
				["event"] = "Health",
				["names"] = {
					"Divine Protection", -- [1]
				},
				["custom_hide"] = "timed",
				["unit"] = "player",
				["remOperator"] = "<",
				["type"] = "aura",
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["stickyDuration"] = false,
			["font"] = "Friz Quadrata TT",
			["height"] = 44,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						true, -- [1]
					},
				},
				["use_combat"] = true,
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 20,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["parent"] = "v0.91 Prot Pala Group",
			["additional_triggers"] = {
			},
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["frameStrata"] = 1,
			["width"] = 44,
			["desaturate"] = false,
			["icon"] = true,
			["inverse"] = false,
			["numTriggers"] = 1,
			["id"] = "Divine Protection",
			["yOffset"] = 0,
			["stacksPoint"] = "BOTTOM",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["PlagueLeechUseable"] = {
			["fontSize"] = 12,
			["displayStacks"] = " ",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["parent"] = "DK - Blood",
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["class"] = {
					["single"] = "DEATHKNIGHT",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["anchorPoint"] = "CENTER",
			["untrigger"] = {
				["spellName"] = 123693,
			},
			["regionType"] = "icon",
			["xOffset"] = -180,
			["selfPoint"] = "CENTER",
			["inverse"] = false,
			["customTextUpdate"] = "update",
			["id"] = "PlagueLeechUseable",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["fontFlags"] = "OUTLINE",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["preset"] = "pulse",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "status",
				["use_targetRequired"] = false,
				["event"] = "Action Usable",
				["unit"] = "player",
				["debuffType"] = "HELPFUL",
				["use_spellName"] = true,
				["names"] = {
				},
				["subeventPrefix"] = "SPELL",
				["unevent"] = "auto",
				["use_unit"] = true,
				["subeventSuffix"] = "_CAST_START",
				["spellName"] = 123693,
			},
			["desaturate"] = false,
			["frameStrata"] = 1,
			["stickyDuration"] = false,
			["width"] = 48,
			["font"] = "Friz Quadrata TT",
			["numTriggers"] = 1,
			["icon"] = true,
			["height"] = 48,
			["yOffset"] = -119.999938964844,
			["stacksPoint"] = "BOTTOMRIGHT",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["CS"] = {
			["parent"] = "Warrior - Arms",
			["fontSize"] = 16,
			["displayStacks"] = "%s",
			["stacksPoint"] = "BOTTOMRIGHT",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["untrigger"] = {
				["spellName"] = 167105,
			},
			["regionType"] = "icon",
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["use_inverse"] = true,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["spellName"] = 167105,
				["use_spellName"] = true,
				["names"] = {
					"Charge", -- [1]
				},
				["custom_hide"] = "timed",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["numTriggers"] = 1,
			["selfPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["additional_triggers"] = {
			},
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["id"] = "CS",
			["stickyDuration"] = false,
			["frameStrata"] = 1,
			["desaturate"] = false,
			["width"] = 40,
			["font"] = "ElvUI Alt-Font",
			["inverse"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["height"] = 40,
			["xOffset"] = -90,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["use_level"] = false,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["textColor"] = {
				1, -- [1]
				0, -- [2]
				0.780392156862745, -- [3]
				1, -- [4]
			},
		},
		["PvP Trinket"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 45,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["itemName"] = 103531,
				["custom_hide"] = "timed",
				["unevent"] = "auto",
				["event"] = "Cooldown Progress (Item)",
				["use_inverse"] = true,
				["use_itemName"] = true,
				["subeventPrefix"] = "SPELL",
				["type"] = "status",
				["use_spellName"] = true,
				["spellName"] = 0,
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["names"] = {
				},
				["use_unit"] = true,
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%s",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["selfPoint"] = "CENTER",
			["additional_triggers"] = {
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["frameStrata"] = 1,
			["width"] = 40,
			["untrigger"] = {
				["itemName"] = 103531,
			},
			["numTriggers"] = 1,
			["inverse"] = false,
			["stickyDuration"] = false,
			["xOffset"] = 25,
			["id"] = "PvP Trinket",
			["stacksPoint"] = "TOP",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["HPc"] = {
			["xOffset"] = -110,
			["mirror"] = false,
			["yOffset"] = 34,
			["regionType"] = "texture",
			["blendMode"] = "ADD",
			["anchorPoint"] = "CENTER",
			["untrigger"] = {
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["texture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura75",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.75, -- [4]
			},
			["selfPoint"] = "CENTER",
			["trigger"] = {
				["type"] = "status",
				["power"] = "0",
				["power_operator"] = ">=",
				["use_power"] = true,
				["event"] = "Holy Power",
				["use_unit"] = true,
				["debuffType"] = "HELPFUL",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["unevent"] = "auto",
				["names"] = {
				},
				["subeventPrefix"] = "SPELL",
				["custom_hide"] = "timed",
			},
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["id"] = "HPc",
			["rotation"] = 0,
			["frameStrata"] = 1,
			["width"] = 75.0003356933594,
			["discrete_rotation"] = 0,
			["desaturate"] = false,
			["numTriggers"] = 1,
			["additional_triggers"] = {
			},
			["height"] = 120,
			["rotate"] = true,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = false,
				["use_combat"] = true,
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						[2] = true,
						[3] = true,
					},
				},
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "v0.91 Prot Pala Group",
		},
		["SW CD"] = {
			["xOffset"] = 45,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["actions"] = {
				["start"] = {
					["do_sound"] = false,
				},
				["finish"] = {
					["sound"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Sounds\\chant2.ogg",
					["do_sound"] = false,
				},
			},
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "status",
				["custom_hide"] = "timed",
				["unevent"] = "auto",
				["subeventPrefix"] = "SPELL",
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["itemName"] = 0,
				["use_spellName"] = true,
				["use_itemName"] = true,
				["spellName"] = 46968,
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["names"] = {
					"Cascade", -- [1]
				},
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_level"] = false,
				["talent"] = 11,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["level_operator"] = ">=",
				["use_spec"] = true,
				["use_never"] = false,
				["level"] = "85",
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["cooldown"] = true,
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["id"] = "SW CD",
			["additional_triggers"] = {
			},
			["selfPoint"] = "CENTER",
			["frameStrata"] = 1,
			["width"] = 40,
			["icon"] = true,
			["inverse"] = true,
			["numTriggers"] = 1,
			["untrigger"] = {
				["spellName"] = 46968,
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["stickyDuration"] = false,
			["stacksPoint"] = "BOTTOMRIGHT",
			["textColor"] = {
				1, -- [1]
				0, -- [2]
				0.780392156862745, -- [3]
				1, -- [4]
			},
		},
		["Stance"] = {
			["xOffset"] = -0.0001220703125,
			["mirror"] = false,
			["untrigger"] = {
				["form"] = 2,
			},
			["regionType"] = "texture",
			["blendMode"] = "ADD",
			["color"] = {
				0.0980392156862745, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["yOffset"] = -75,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["texture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura16",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "preset",
					["preset"] = "pulse",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["use_form"] = true,
				["unevent"] = "auto",
				["form"] = 2,
				["event"] = "Stance/Form/Aura",
				["use_unit"] = true,
				["custom_hide"] = "timed",
				["type"] = "status",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["debuffType"] = "HELPFUL",
			},
			["id"] = "Stance",
			["selfPoint"] = "CENTER",
			["additional_triggers"] = {
			},
			["rotation"] = 0,
			["frameStrata"] = 1,
			["desaturate"] = false,
			["discrete_rotation"] = 0,
			["anchorPoint"] = "CENTER",
			["numTriggers"] = 1,
			["width"] = 600,
			["height"] = 600,
			["rotate"] = true,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "Warrior - Arms",
		},
		["Guardian of Ancient Kings"] = {
			["xOffset"] = -44,
			["untrigger"] = {
			},
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["actions"] = {
				["start"] = {
					["message_type"] = "PRINT",
					["message"] = "Shield Wall Active! 40% Reduction for 12 seconds.",
					["do_message"] = false,
					["message_dest"] = "Dimitar Cherkezov",
				},
				["finish"] = {
				},
			},
			["fontFlags"] = "OUTLINE",
			["useTooltip"] = false,
			["selfPoint"] = "CENTER",
			["trigger"] = {
				["rem"] = "5",
				["subeventSuffix"] = "_CAST_START",
				["ownOnly"] = true,
				["event"] = "Health",
				["names"] = {
					"Guardian of Ancient Kings", -- [1]
				},
				["custom_hide"] = "timed",
				["unit"] = "player",
				["remOperator"] = "<",
				["type"] = "aura",
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["stickyDuration"] = false,
			["font"] = "Friz Quadrata TT",
			["height"] = 44,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						true, -- [1]
					},
				},
				["use_combat"] = true,
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 20,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["parent"] = "v0.91 Prot Pala Group",
			["additional_triggers"] = {
			},
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["frameStrata"] = 1,
			["width"] = 44,
			["desaturate"] = false,
			["icon"] = true,
			["inverse"] = false,
			["numTriggers"] = 1,
			["id"] = "Guardian of Ancient Kings",
			["yOffset"] = 0,
			["stacksPoint"] = "BOTTOM",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Bloodbath Aura"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["actions"] = {
				["start"] = {
					["message_type"] = "YELL",
					["do_message"] = false,
					["do_sound"] = false,
				},
				["finish"] = {
					["sound"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Sounds\\chant2.ogg",
					["do_sound"] = false,
				},
			},
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "preset",
					["preset"] = "alphaPulse",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["itemName"] = 0,
				["unevent"] = "auto",
				["custom_hide"] = "timed",
				["subeventPrefix"] = "SPELL",
				["use_itemName"] = true,
				["use_unit"] = true,
				["event"] = "Cooldown Progress (Spell)",
				["use_spellName"] = true,
				["spellName"] = 1719,
				["type"] = "aura",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["names"] = {
					"Bloodbath", -- [1]
				},
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_never"] = false,
				["talent"] = 17,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_level"] = false,
				["use_spec"] = true,
				["level_operator"] = ">=",
				["level"] = "85",
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["stacksPoint"] = "CENTER",
			["selfPoint"] = "CENTER",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["icon"] = true,
			["additional_triggers"] = {
			},
			["untrigger"] = {
				["spellName"] = 1719,
			},
			["frameStrata"] = 1,
			["width"] = 40,
			["numTriggers"] = 1,
			["id"] = "Bloodbath Aura",
			["inverse"] = false,
			["xOffset"] = -45,
			["stickyDuration"] = false,
			["displayIcon"] = "Interface\\Icons\\Spell_Nature_WispSplode",
			["cooldown"] = true,
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["MS CD"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.350000023841858, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["names"] = {
					"Charge", -- [1]
				},
				["custom_hide"] = "timed",
				["use_spellName"] = true,
				["use_unit"] = true,
				["spellName"] = 12294,
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_level"] = false,
				["use_spec"] = true,
				["use_never"] = false,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["cooldown"] = true,
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["additional_triggers"] = {
			},
			["selfPoint"] = "CENTER",
			["frameStrata"] = 1,
			["width"] = 40,
			["untrigger"] = {
				["spellName"] = 12294,
			},
			["numTriggers"] = 1,
			["inverse"] = true,
			["xOffset"] = -135,
			["id"] = "MS CD",
			["stickyDuration"] = false,
			["stacksPoint"] = "BOTTOMRIGHT",
			["textColor"] = {
				1, -- [1]
				0, -- [2]
				0.780392156862745, -- [3]
				1, -- [4]
			},
		},
		["Fortitude Timer"] = {
			["outline"] = false,
			["fontSize"] = 14,
			["color"] = {
				0, -- [1]
				0.741176470588235, -- [2]
				1, -- [3]
				0.670000016689301, -- [4]
			},
			["displayText"] = "%p",
			["yOffset"] = -121.000366210938,
			["regionType"] = "text",
			["customTextUpdate"] = "update",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["xOffset"] = 259.000244140625,
			["untrigger"] = {
			},
			["trigger"] = {
				["fullscan"] = true,
				["name_operator"] = "==",
				["spellId"] = "137593",
				["tooltip_operator"] = "find('%s')",
				["autoclone"] = false,
				["tooltip"] = "Reduces",
				["event"] = "Health",
				["subeventPrefix"] = "SPELL",
				["custom_hide"] = "timed",
				["use_spellId"] = true,
				["name"] = "Fortitude",
				["type"] = "aura",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["names"] = {
					"Fortitude", -- [1]
				},
				["debuffType"] = "HELPFUL",
			},
			["justify"] = "CENTER",
			["selfPoint"] = "CENTER",
			["id"] = "Fortitude Timer",
			["anchorPoint"] = "CENTER",
			["frameStrata"] = 1,
			["width"] = 7.00003862380982,
			["progressPrecision"] = 0,
			["font"] = "DorisPP",
			["numTriggers"] = 1,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["height"] = 13.9999942779541,
			["additional_triggers"] = {
			},
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "Fortitude",
		},
		["B Rage CD"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.350000023841858, -- [4]
			},
			["untrigger"] = {
				["spellName"] = 18499,
			},
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["custom_hide"] = "timed",
				["use_spellName"] = true,
				["spellName"] = 18499,
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["stacksPoint"] = "TOP",
			["stacksContainment"] = "OUTSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["additional_triggers"] = {
			},
			["id"] = "B Rage CD",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["frameStrata"] = 1,
			["width"] = 40,
			["yOffset"] = 45,
			["inverse"] = true,
			["numTriggers"] = 1,
			["xOffset"] = -25,
			["stickyDuration"] = false,
			["selfPoint"] = "CENTER",
			["cooldown"] = true,
			["textColor"] = {
				1, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["DeathSiphonUseable"] = {
			["fontSize"] = 12,
			["displayStacks"] = " ",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["parent"] = "DK - Blood",
			["stacksPoint"] = "BOTTOMRIGHT",
			["anchorPoint"] = "CENTER",
			["untrigger"] = {
				["spellName"] = 108196,
			},
			["regionType"] = "icon",
			["xOffset"] = 180,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["type"] = "preset",
					["preset"] = "pulse",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["numTriggers"] = 1,
			["customTextUpdate"] = "update",
			["trigger"] = {
				["type"] = "status",
				["subeventSuffix"] = "_CAST_START",
				["event"] = "Action Usable",
				["unit"] = "player",
				["spellName"] = 108196,
				["use_spellName"] = true,
				["use_targetRequired"] = false,
				["use_unit"] = true,
				["unevent"] = "auto",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["debuffType"] = "HELPFUL",
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["fontFlags"] = "OUTLINE",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["selfPoint"] = "CENTER",
			["id"] = "DeathSiphonUseable",
			["width"] = 48,
			["frameStrata"] = 1,
			["stickyDuration"] = false,
			["desaturate"] = false,
			["font"] = "Friz Quadrata TT",
			["inverse"] = false,
			["icon"] = true,
			["height"] = 48,
			["yOffset"] = -119.999938964844,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DEATHKNIGHT",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Bloodbath"] = {
			["xOffset"] = -45,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["spellName"] = 12292,
				["use_remaining"] = false,
				["type"] = "status",
				["unevent"] = "auto",
				["use_matchedRune"] = true,
				["use_inverse"] = true,
				["event"] = "Cooldown Progress (Spell)",
				["subeventPrefix"] = "SPELL",
				["custom_type"] = "status",
				["use_spellName"] = true,
				["custom_hide"] = "timed",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["names"] = {
				},
				["use_unit"] = true,
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_never"] = false,
				["talent"] = 17,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						[3] = true,
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
						["WARRIOR"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%s",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["cooldown"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["id"] = "Bloodbath",
			["untrigger"] = {
				["spellName"] = 12292,
			},
			["frameStrata"] = 1,
			["width"] = 40,
			["numTriggers"] = 1,
			["stickyDuration"] = false,
			["inverse"] = false,
			["disjunctive"] = false,
			["additional_triggers"] = {
			},
			["selfPoint"] = "CENTER",
			["stacksPoint"] = "BOTTOMRIGHT",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["ShieldBlockUseable"] = {
			["fontSize"] = 12,
			["displayStacks"] = " ",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["parent"] = "Warrior - Prot",
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["untrigger"] = {
				["spellName"] = 2565,
			},
			["yOffset"] = -119.999938964844,
			["anchorPoint"] = "CENTER",
			["xOffset"] = 180,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "preset",
					["duration_type"] = "seconds",
					["preset"] = "pulse",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["inverse"] = false,
			["customTextUpdate"] = "update",
			["trigger"] = {
				["type"] = "status",
				["subeventSuffix"] = "_CAST_START",
				["use_charges"] = false,
				["event"] = "Action Usable",
				["unit"] = "player",
				["debuffType"] = "HELPFUL",
				["use_spellName"] = true,
				["names"] = {
				},
				["subeventPrefix"] = "SPELL",
				["unevent"] = "auto",
				["use_unit"] = true,
				["use_targetRequired"] = false,
				["spellName"] = 2565,
			},
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["selfPoint"] = "CENTER",
			["id"] = "ShieldBlockUseable",
			["width"] = 48,
			["frameStrata"] = 1,
			["stickyDuration"] = false,
			["desaturate"] = false,
			["font"] = "Friz Quadrata TT",
			["numTriggers"] = 1,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["height"] = 48,
			["regionType"] = "icon",
			["stacksPoint"] = "BOTTOMRIGHT",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Storm Bolt CD"] = {
			["xOffset"] = 45,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["custom_hide"] = "timed",
				["use_spellName"] = true,
				["spellName"] = 107570,
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_never"] = false,
				["talent"] = 10,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["stacksPoint"] = "TOP",
			["stacksContainment"] = "OUTSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["untrigger"] = {
				["spellName"] = 107570,
			},
			["id"] = "Storm Bolt CD",
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura",
						["unevent"] = "auto",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["inverse"] = true,
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["names"] = {
							"Avatar", -- [1]
						},
						["unit"] = "player",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["frameStrata"] = 1,
			["width"] = 40,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["numTriggers"] = 2,
			["inverse"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["stickyDuration"] = false,
			["selfPoint"] = "CENTER",
			["cooldown"] = true,
			["textColor"] = {
				1, -- [1]
				0.0313725490196078, -- [2]
				0.0745098039215686, -- [3]
				1, -- [4]
			},
		},
		["CS CD"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.350000023841858, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["custom_hide"] = "timed",
				["use_spellName"] = true,
				["spellName"] = 167105,
				["names"] = {
					"Charge", -- [1]
				},
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["use_level"] = false,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["cooldown"] = true,
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["id"] = "CS CD",
			["untrigger"] = {
				["spellName"] = 167105,
			},
			["frameStrata"] = 1,
			["width"] = 40,
			["additional_triggers"] = {
			},
			["numTriggers"] = 1,
			["inverse"] = true,
			["xOffset"] = -90,
			["stickyDuration"] = false,
			["selfPoint"] = "CENTER",
			["stacksPoint"] = "BOTTOMRIGHT",
			["textColor"] = {
				1, -- [1]
				0, -- [2]
				0.780392156862745, -- [3]
				1, -- [4]
			},
		},
		["I Shout"] = {
			["parent"] = "Warrior - Arms",
			["fontSize"] = 16,
			["displayStacks"] = "%s",
			["stacksPoint"] = "BOTTOMRIGHT",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["untrigger"] = {
				["spellName"] = 5246,
			},
			["anchorPoint"] = "CENTER",
			["yOffset"] = -65,
			["regionType"] = "icon",
			["icon"] = true,
			["numTriggers"] = 1,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["customTextUpdate"] = "update",
			["stickyDuration"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["fontFlags"] = "OUTLINE",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["selfPoint"] = "CENTER",
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["use_inverse"] = true,
				["event"] = "Cooldown Progress (Spell)",
				["names"] = {
					"Charge", -- [1]
				},
				["spellName"] = 5246,
				["use_spellName"] = true,
				["use_unit"] = true,
				["custom_hide"] = "timed",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["width"] = 40,
			["frameStrata"] = 1,
			["desaturate"] = false,
			["additional_triggers"] = {
			},
			["font"] = "ElvUI Alt-Font",
			["inverse"] = false,
			["id"] = "I Shout",
			["height"] = 40,
			["xOffset"] = 150,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_level"] = false,
				["use_spec"] = true,
				["use_never"] = false,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Devotion Aura"] = {
			["xOffset"] = -176,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["useTooltip"] = false,
			["selfPoint"] = "CENTER",
			["trigger"] = {
				["rem"] = "5",
				["subeventSuffix"] = "_CAST_START",
				["ownOnly"] = true,
				["event"] = "Health",
				["names"] = {
					"Devotion Aura", -- [1]
				},
				["custom_hide"] = "timed",
				["unit"] = "player",
				["remOperator"] = "<",
				["type"] = "aura",
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["stickyDuration"] = false,
			["font"] = "Friz Quadrata TT",
			["height"] = 44,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						true, -- [1]
					},
				},
				["use_combat"] = true,
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 20,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["parent"] = "v0.91 Prot Pala Group",
			["additional_triggers"] = {
			},
			["desaturate"] = false,
			["frameStrata"] = 1,
			["width"] = 44,
			["id"] = "Devotion Aura",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["inverse"] = false,
			["numTriggers"] = 1,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["untrigger"] = {
			},
			["stacksPoint"] = "BOTTOM",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["HP5"] = {
			["disjunctive"] = true,
			["mirror"] = false,
			["yOffset"] = 34,
			["regionType"] = "texture",
			["blendMode"] = "ADD",
			["untrigger"] = {
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.75, -- [4]
			},
			["xOffset"] = -2,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["texture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura74",
			["anchorPoint"] = "CENTER",
			["id"] = "HP5",
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura",
						["subeventSuffix"] = "_CAST_START",
						["ownOnly"] = true,
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["unit"] = "player",
						["names"] = {
							"Divine Purpose", -- [1]
						},
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["selfPoint"] = "CENTER",
			["trigger"] = {
				["type"] = "status",
				["power"] = "5",
				["power_operator"] = ">=",
				["use_power"] = true,
				["event"] = "Holy Power",
				["use_unit"] = true,
				["debuffType"] = "HELPFUL",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["unevent"] = "auto",
				["names"] = {
				},
				["subeventPrefix"] = "SPELL",
				["custom_hide"] = "timed",
			},
			["desaturate"] = false,
			["frameStrata"] = 1,
			["width"] = 100,
			["rotation"] = 0,
			["discrete_rotation"] = 0,
			["numTriggers"] = 2,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["height"] = 40,
			["rotate"] = true,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = false,
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						[2] = true,
						[3] = true,
					},
				},
				["use_combat"] = true,
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "v0.91 Prot Pala Group",
		},
		["RuneShield"] = {
			["xOffset"] = 0,
			["mirror"] = false,
			["yOffset"] = 0,
			["regionType"] = "texture",
			["blendMode"] = "ADD",
			["untrigger"] = {
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["texture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura16",
			["color"] = {
				0.188235294117647, -- [1]
				0.741176470588235, -- [2]
				0.105882352941176, -- [3]
				0.75, -- [4]
			},
			["selfPoint"] = "CENTER",
			["trigger"] = {
				["names"] = {
					"Rune Tap", -- [1]
				},
				["type"] = "aura",
				["subeventPrefix"] = "SPELL",
				["subeventSuffix"] = "_CAST_START",
				["debuffType"] = "HELPFUL",
				["ownOnly"] = true,
				["event"] = "Health",
				["unit"] = "player",
			},
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["id"] = "RuneShield",
			["anchorPoint"] = "CENTER",
			["frameStrata"] = 1,
			["width"] = 475,
			["rotation"] = 0,
			["discrete_rotation"] = 0,
			["numTriggers"] = 1,
			["desaturate"] = false,
			["height"] = 475,
			["rotate"] = true,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DEATHKNIGHT",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "DK - Blood",
		},
		["HP1"] = {
			["disjunctive"] = true,
			["mirror"] = false,
			["yOffset"] = 34,
			["regionType"] = "texture",
			["blendMode"] = "ADD",
			["untrigger"] = {
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.75, -- [4]
			},
			["xOffset"] = -218,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["texture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura74",
			["anchorPoint"] = "CENTER",
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["power_operator"] = ">=",
				["use_power"] = true,
				["event"] = "Holy Power",
				["use_unit"] = true,
				["custom_hide"] = "timed",
				["power"] = "1",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["debuffType"] = "HELPFUL",
			},
			["id"] = "HP1",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["additional_triggers"] = {
				{
					["trigger"] = {
						["subeventPrefix"] = "SPELL",
						["type"] = "aura",
						["debuffType"] = "HELPFUL",
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["ownOnly"] = true,
						["event"] = "Health",
						["names"] = {
							"Divine Purpose", -- [1]
						},
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["desaturate"] = false,
			["frameStrata"] = 1,
			["width"] = 100,
			["rotation"] = 0,
			["discrete_rotation"] = 0,
			["numTriggers"] = 2,
			["selfPoint"] = "CENTER",
			["height"] = 40,
			["rotate"] = true,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_talent"] = false,
				["use_spec"] = false,
				["use_combat"] = true,
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						[2] = true,
						[3] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "v0.91 Prot Pala Group",
		},
		["HP4"] = {
			["disjunctive"] = true,
			["mirror"] = false,
			["yOffset"] = 34,
			["regionType"] = "texture",
			["blendMode"] = "ADD",
			["untrigger"] = {
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.75, -- [4]
			},
			["xOffset"] = -56,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["texture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura74",
			["anchorPoint"] = "CENTER",
			["trigger"] = {
				["type"] = "status",
				["power"] = "4",
				["power_operator"] = ">=",
				["use_power"] = true,
				["event"] = "Holy Power",
				["use_unit"] = true,
				["debuffType"] = "HELPFUL",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["unevent"] = "auto",
				["names"] = {
				},
				["subeventPrefix"] = "SPELL",
				["custom_hide"] = "timed",
			},
			["id"] = "HP4",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura",
						["subeventSuffix"] = "_CAST_START",
						["ownOnly"] = true,
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["unit"] = "player",
						["names"] = {
							"Divine Purpose", -- [1]
						},
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["desaturate"] = false,
			["frameStrata"] = 1,
			["width"] = 100,
			["rotation"] = 0,
			["discrete_rotation"] = 0,
			["numTriggers"] = 2,
			["selfPoint"] = "CENTER",
			["height"] = 40,
			["rotate"] = true,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = false,
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						[2] = true,
						[3] = true,
					},
				},
				["use_combat"] = true,
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "v0.91 Prot Pala Group",
		},
		["ScentOfBlood-LT-Stacks"] = {
			["fontSize"] = 24,
			["displayStacks"] = "%s",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["parent"] = "GRP-ScentOfBlood",
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DEATHKNIGHT",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["yOffset"] = 0,
			["untrigger"] = {
			},
			["regionType"] = "icon",
			["xOffset"] = -130,
			["selfPoint"] = "CENTER",
			["inverse"] = false,
			["customTextUpdate"] = "update",
			["trigger"] = {
				["type"] = "aura",
				["subeventSuffix"] = "_CAST_START",
				["event"] = "Health",
				["unit"] = "player",
				["useCount"] = true,
				["count"] = "3",
				["custom_hide"] = "timed",
				["countOperator"] = "<=",
				["names"] = {
					"Scent of Blood", -- [1]
				},
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["id"] = "ScentOfBlood-LT-Stacks",
			["stickyDuration"] = false,
			["frameStrata"] = 4,
			["width"] = 48,
			["desaturate"] = true,
			["font"] = "Friz Quadrata TT",
			["numTriggers"] = 1,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["height"] = 48,
			["anchorPoint"] = "CENTER",
			["stacksPoint"] = "CENTER",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Bladestorm Aura"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["actions"] = {
				["start"] = {
					["message_type"] = "YELL",
					["do_message"] = false,
					["do_sound"] = false,
				},
				["finish"] = {
					["sound"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Sounds\\chant2.ogg",
					["do_sound"] = false,
				},
			},
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["preset"] = "alphaPulse",
					["type"] = "preset",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["itemName"] = 0,
				["unevent"] = "auto",
				["spellName"] = 1719,
				["event"] = "Cooldown Progress (Spell)",
				["use_itemName"] = true,
				["subeventPrefix"] = "SPELL",
				["custom_hide"] = "timed",
				["use_spellName"] = true,
				["names"] = {
					"Bladestorm", -- [1]
				},
				["type"] = "aura",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["use_unit"] = true,
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_never"] = false,
				["talent"] = 18,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
					},
				},
				["use_spec"] = true,
				["level_operator"] = ">=",
				["level"] = "85",
				["use_level"] = false,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["cooldown"] = true,
			["selfPoint"] = "CENTER",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["additional_triggers"] = {
			},
			["id"] = "Bladestorm Aura",
			["icon"] = true,
			["frameStrata"] = 1,
			["width"] = 40,
			["numTriggers"] = 1,
			["untrigger"] = {
				["spellName"] = 1719,
			},
			["inverse"] = false,
			["xOffset"] = -45,
			["stickyDuration"] = false,
			["displayIcon"] = "Interface\\Icons\\Spell_Nature_WispSplode",
			["stacksPoint"] = "CENTER",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["ShieldBlock"] = {
			["xOffset"] = 0,
			["mirror"] = false,
			["yOffset"] = 0,
			["regionType"] = "texture",
			["blendMode"] = "ADD",
			["untrigger"] = {
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["texture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura16",
			["color"] = {
				0.188235294117647, -- [1]
				0.741176470588235, -- [2]
				0.105882352941176, -- [3]
				0.75, -- [4]
			},
			["selfPoint"] = "CENTER",
			["trigger"] = {
				["names"] = {
					"Shield Block", -- [1]
				},
				["type"] = "aura",
				["subeventPrefix"] = "SPELL",
				["subeventSuffix"] = "_CAST_START",
				["debuffType"] = "HELPFUL",
				["ownOnly"] = true,
				["event"] = "Health",
				["unit"] = "player",
			},
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["id"] = "ShieldBlock",
			["anchorPoint"] = "CENTER",
			["frameStrata"] = 1,
			["desaturate"] = false,
			["rotation"] = 0,
			["discrete_rotation"] = 0,
			["numTriggers"] = 1,
			["width"] = 500,
			["height"] = 500,
			["rotate"] = true,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "Warrior - Prot",
		},
		["Argent Defender"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["untrigger"] = {
			},
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["fontFlags"] = "OUTLINE",
			["useTooltip"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["autoclone"] = false,
				["spellId"] = "55694",
				["ownOnly"] = true,
				["use_unit"] = true,
				["custom_hide"] = "timed",
				["type"] = "aura",
				["unevent"] = "auto",
				["rem"] = "5",
				["names"] = {
					"Ardent Defender", -- [1]
				},
				["event"] = "Health",
				["unit"] = "player",
				["use_name"] = true,
				["use_spellId"] = true,
				["name"] = "55694",
				["name_operator"] = "==",
				["remOperator"] = "<",
				["subeventSuffix"] = "_CAST_START",
				["debuffType"] = "HELPFUL",
				["subeventPrefix"] = "SPELL",
			},
			["desaturate"] = false,
			["font"] = "Friz Quadrata TT",
			["height"] = 44,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						true, -- [1]
					},
				},
				["use_combat"] = true,
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 20,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "v0.91 Prot Pala Group",
			["stacksPoint"] = "BOTTOM",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["icon"] = true,
			["additional_triggers"] = {
			},
			["stickyDuration"] = false,
			["frameStrata"] = 1,
			["width"] = 44,
			["yOffset"] = 0,
			["numTriggers"] = 1,
			["inverse"] = false,
			["xOffset"] = -88,
			["id"] = "Argent Defender",
			["selfPoint"] = "CENTER",
			["cooldown"] = false,
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Avatar"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["use_inverse"] = true,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["custom_hide"] = "timed",
				["use_spellName"] = true,
				["spellName"] = 107574,
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_never"] = false,
				["talent"] = 16,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%s",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["selfPoint"] = "CENTER",
			["additional_triggers"] = {
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["frameStrata"] = 1,
			["width"] = 40,
			["untrigger"] = {
				["spellName"] = 107574,
			},
			["numTriggers"] = 1,
			["inverse"] = false,
			["stickyDuration"] = false,
			["xOffset"] = -45,
			["id"] = "Avatar",
			["stacksPoint"] = "BOTTOMRIGHT",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Whirlwind"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.75, -- [4]
			},
			["fontSize"] = 12,
			["displayStacks"] = "%s",
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "Warrior - Arms",
			["xOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["yOffset"] = 0,
			["regionType"] = "icon",
			["trigger"] = {
				["type"] = "status",
				["use_targetRequired"] = false,
				["spellName"] = 1680,
				["event"] = "Action Usable",
				["subeventPrefix"] = "SPELL",
				["unevent"] = "auto",
				["use_spellName"] = true,
				["custom_hide"] = "timed",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["use_unit"] = true,
				["names"] = {
				},
				["debuffType"] = "HELPFUL",
			},
			["numTriggers"] = 1,
			["animation"] = {
				["start"] = {
					["preset"] = "fade",
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["preset"] = "pulse",
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["customTextUpdate"] = "update",
			["id"] = "Whirlwind",
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
					["glow_action"] = "show",
					["glow_frame"] = "WeakAuras:Execute",
				},
				["finish"] = {
				},
			},
			["fontFlags"] = "OUTLINE",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0.33,
			["auto"] = true,
			["selfPoint"] = "CENTER",
			["additional_triggers"] = {
			},
			["width"] = 35,
			["frameStrata"] = 1,
			["desaturate"] = false,
			["stickyDuration"] = false,
			["font"] = "Friz Quadrata TT",
			["inverse"] = false,
			["icon"] = true,
			["height"] = 35,
			["untrigger"] = {
				["spellName"] = 1680,
			},
			["stacksPoint"] = "BOTTOMRIGHT",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Dancing Rune Weapon Timer"] = {
			["outline"] = false,
			["fontSize"] = 14,
			["xOffset"] = -130,
			["displayText"] = "%p",
			["yOffset"] = -174,
			["regionType"] = "text",
			["customTextUpdate"] = "update",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["parent"] = "Dancing Rune Weapon",
			["color"] = {
				1, -- [1]
				0.894117647058824, -- [2]
				0, -- [3]
				0.719999998807907, -- [4]
			},
			["additional_triggers"] = {
			},
			["justify"] = "CENTER",
			["selfPoint"] = "CENTER",
			["trigger"] = {
				["name_operator"] = "==",
				["spellId"] = "31884",
				["subeventSuffix"] = "_CAST_START",
				["debuffType"] = "HELPFUL",
				["ownOnly"] = true,
				["event"] = "Health",
				["subeventPrefix"] = "SPELL",
				["use_name"] = true,
				["use_spellId"] = true,
				["name"] = "Avenging Wrath",
				["names"] = {
					"Dancing Rune Weapon", -- [1]
				},
				["unit"] = "player",
				["type"] = "aura",
				["autoclone"] = false,
				["custom_hide"] = "timed",
			},
			["anchorPoint"] = "CENTER",
			["frameStrata"] = 1,
			["width"] = 5.68888664245606,
			["progressPrecision"] = 0,
			["font"] = "DorisPP",
			["numTriggers"] = 1,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["height"] = 14.2222166061401,
			["id"] = "Dancing Rune Weapon Timer",
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DEATHKNIGHT",
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["untrigger"] = {
			},
		},
		["Shield of the Righteous"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["untrigger"] = {
			},
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["useTooltip"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["rem"] = "5",
				["subeventSuffix"] = "_CAST_START",
				["ownOnly"] = true,
				["event"] = "Health",
				["names"] = {
					"Shield of the Righteous", -- [1]
				},
				["custom_hide"] = "timed",
				["unit"] = "player",
				["remOperator"] = "<",
				["type"] = "aura",
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["font"] = "Friz Quadrata TT",
			["height"] = 44,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						true, -- [1]
					},
				},
				["use_combat"] = true,
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 20,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "v0.91 Prot Pala Group",
			["stacksPoint"] = "BOTTOM",
			["selfPoint"] = "CENTER",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = false,
			["id"] = "Shield of the Righteous",
			["additional_triggers"] = {
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["frameStrata"] = 1,
			["width"] = 44,
			["numTriggers"] = 1,
			["yOffset"] = 0,
			["inverse"] = false,
			["stickyDuration"] = false,
			["xOffset"] = -0.000244140625,
			["displayIcon"] = "Interface\\Icons\\Ability_Paladin_ShieldofVengeance",
			["cooldown"] = false,
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["ShieldBarrier"] = {
			["xOffset"] = 0,
			["mirror"] = false,
			["untrigger"] = {
			},
			["regionType"] = "texture",
			["blendMode"] = "ADD",
			["color"] = {
				0.741176470588235, -- [1]
				0.686274509803922, -- [2]
				0.474509803921569, -- [3]
				0.75, -- [4]
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["texture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura16",
			["yOffset"] = 0,
			["selfPoint"] = "CENTER",
			["trigger"] = {
				["unit"] = "player",
				["type"] = "aura",
				["subeventPrefix"] = "SPELL",
				["subeventSuffix"] = "_CAST_START",
				["debuffType"] = "HELPFUL",
				["ownOnly"] = true,
				["event"] = "Health",
				["names"] = {
					"Shield Barrier", -- [1]
				},
			},
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["id"] = "ShieldBarrier",
			["discrete_rotation"] = 0,
			["frameStrata"] = 1,
			["width"] = 475,
			["rotation"] = 0,
			["anchorPoint"] = "CENTER",
			["numTriggers"] = 1,
			["desaturate"] = false,
			["height"] = 475,
			["rotate"] = true,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "Warrior - Prot",
		},
		["Fortitude Aura"] = {
			["color"] = {
				0, -- [1]
				0.752941176470588, -- [2]
				1, -- [3]
				0.700000017881393, -- [4]
			},
			["mirror"] = false,
			["yOffset"] = -118.000091552734,
			["regionType"] = "texture",
			["blendMode"] = "ADD",
			["xOffset"] = 260.000244140625,
			["untrigger"] = {
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["texture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura50",
			["selfPoint"] = "CENTER",
			["trigger"] = {
				["name_operator"] = "==",
				["spellId"] = "137593",
				["tooltip_operator"] = "find('%s')",
				["fullscan"] = true,
				["tooltip"] = "Reduces",
				["event"] = "Health",
				["subeventPrefix"] = "SPELL",
				["custom_hide"] = "timed",
				["use_spellId"] = true,
				["name"] = "Fortitude",
				["type"] = "aura",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["names"] = {
					"Fortitude", -- [1]
				},
				["debuffType"] = "HELPFUL",
			},
			["id"] = "Fortitude Aura",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["additional_triggers"] = {
			},
			["rotation"] = 0,
			["frameStrata"] = 1,
			["desaturate"] = false,
			["discrete_rotation"] = 0,
			["anchorPoint"] = "CENTER",
			["numTriggers"] = 1,
			["width"] = 80,
			["height"] = 80,
			["rotate"] = true,
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "Fortitude",
		},
		["Dancing Rune Weapon"] = {
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["controlledChildren"] = {
				"Dancing Rune Weapon Aura", -- [1]
				"Dancing Rune Weapon Timer", -- [2]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = -120,
			["border"] = false,
			["yOffset"] = 80,
			["anchorPoint"] = "CENTER",
			["borderSize"] = 16,
			["borderColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["expanded"] = false,
			["borderOffset"] = 5,
			["selfPoint"] = "BOTTOMLEFT",
			["additional_triggers"] = {
			},
			["id"] = "Dancing Rune Weapon",
			["frameStrata"] = 1,
			["untrigger"] = {
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["borderInset"] = 11,
			["numTriggers"] = 1,
			["borderEdge"] = "None",
			["trigger"] = {
				["type"] = "aura",
				["subeventPrefix"] = "SPELL",
				["subeventSuffix"] = "_CAST_START",
				["debuffType"] = "HELPFUL",
				["names"] = {
				},
				["event"] = "Health",
				["unit"] = "player",
			},
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["load"] = {
				["class"] = {
					["multi"] = {
					},
				},
				["role"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["regionType"] = "group",
		},
		["Blood Shield Timer"] = {
			["outline"] = false,
			["fontSize"] = 14,
			["xOffset"] = -176.000366210938,
			["displayText"] = "%p",
			["customText"] = "function()\n    for i=1, 40 do\n        \n        if UnitBuff(\"player\",i) then\n            local _,_,_,_,_,_,_,_,_,_,spellID,_,_,_,absorbAmount,_ = UnitBuff(\"player\",i)\n            if spellID == 116849 then\n                absorbAmount = absorbAmount / 1000\n                return string.format(\"%i%c\",absorbAmount,75)\n            end\n        end\n        \n    end\n    \nend",
			["yOffset"] = -24,
			["regionType"] = "text",
			["customTextUpdate"] = "update",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["color"] = {
				1, -- [1]
				0.0509803921568627, -- [2]
				0, -- [3]
				0.840000003576279, -- [4]
			},
			["untrigger"] = {
			},
			["trigger"] = {
				["type"] = "aura",
				["subeventSuffix"] = "_CAST_START",
				["ownOnly"] = true,
				["event"] = "Health",
				["names"] = {
					"Blood Shield", -- [1]
				},
				["use_name"] = true,
				["subcount"] = true,
				["name"] = "Life Cocoon",
				["custom_hide"] = "timed",
				["unit"] = "player",
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["justify"] = "CENTER",
			["selfPoint"] = "CENTER",
			["id"] = "Blood Shield Timer",
			["anchorPoint"] = "CENTER",
			["frameStrata"] = 1,
			["width"] = 7.00003862380982,
			["progressPrecision"] = 0,
			["font"] = "DorisPP",
			["numTriggers"] = 1,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["height"] = 13.9999942779541,
			["additional_triggers"] = {
			},
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DEATHKNIGHT",
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "DK - Blood",
		},
		["S Reflect CD"] = {
			["xOffset"] = -50,
			["untrigger"] = {
				["spellName"] = 23920,
			},
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["spellName"] = 23920,
				["use_spellName"] = true,
				["custom_hide"] = "timed",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["stacksPoint"] = "BOTTOM",
			["stacksContainment"] = "OUTSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["id"] = "S Reflect CD",
			["additional_triggers"] = {
			},
			["frameStrata"] = 1,
			["width"] = 40,
			["yOffset"] = -65,
			["numTriggers"] = 1,
			["inverse"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.350000023841858, -- [4]
			},
			["stickyDuration"] = false,
			["selfPoint"] = "CENTER",
			["cooldown"] = true,
			["textColor"] = {
				1, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["Storm Bolt"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["use_inverse"] = true,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["spellName"] = 107570,
				["use_spellName"] = true,
				["custom_hide"] = "timed",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_never"] = false,
				["talent"] = 10,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%s",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["selfPoint"] = "CENTER",
			["additional_triggers"] = {
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["frameStrata"] = 1,
			["width"] = 40,
			["untrigger"] = {
				["spellName"] = 107570,
			},
			["numTriggers"] = 1,
			["inverse"] = false,
			["stickyDuration"] = false,
			["xOffset"] = 45,
			["id"] = "Storm Bolt",
			["stacksPoint"] = "BOTTOMRIGHT",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Current Haste"] = {
			["outline"] = true,
			["fontSize"] = 14,
			["xOffset"] = -270,
			["displayText"] = "%c",
			["customText"] = "function () \n    \n    -- Get Current Haste\n    local value = UnitSpellHaste(\"player\")\n    \n    if not value then\n        value = 0\n    end\n    \n    -- replace with short notation\n    value = math.floor(value*10)/10\n    \n    -- return string\n    return(value .. \"%%\")\nend",
			["untrigger"] = {
				["spellName"] = 96231,
			},
			["regionType"] = "text",
			["customTextUpdate"] = "update",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["yOffset"] = -70,
			["selfPoint"] = "CENTER",
			["justify"] = "LEFT",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["additional_triggers"] = {
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["frameStrata"] = 1,
			["width"] = 35.9999847412109,
			["trigger"] = {
				["use_unit"] = true,
				["spellName"] = 96231,
				["custom_hide"] = "timed",
				["type"] = "status",
				["use_health"] = false,
				["custom_type"] = "status",
				["debuffType"] = "HELPFUL",
				["percenthealth"] = "0",
				["event"] = "Health",
				["unevent"] = "auto",
				["subeventSuffix"] = "_CAST_START",
				["use_spellName"] = true,
				["names"] = {
					"Vengeance", -- [1]
					"Seal of Insight", -- [2]
					"Windsong", -- [3]
				},
				["unit"] = "player",
				["check"] = "update",
				["use_percenthealth"] = true,
				["percenthealth_operator"] = ">",
				["subeventPrefix"] = "SPELL",
			},
			["font"] = "Friz Quadrata TT",
			["numTriggers"] = 1,
			["anchorPoint"] = "CENTER",
			["height"] = 13.9999942779541,
			["id"] = "Current Haste",
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["use_combat"] = true,
				["class"] = {
					["single"] = "DEATHKNIGHT",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "Resolve, Haste Text",
		},
		["Bloodbath CD"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["custom_hide"] = "timed",
				["use_remaining"] = false,
				["unevent"] = "auto",
				["custom_type"] = "status",
				["use_matchedRune"] = true,
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["subeventPrefix"] = "SPELL",
				["type"] = "status",
				["use_spellName"] = true,
				["spellName"] = 12292,
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["names"] = {
				},
				["use_unit"] = true,
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = true,
			["progressPrecision"] = 0,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_never"] = false,
				["talent"] = 17,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
						["WARRIOR"] = true,
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						[3] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["stacksPoint"] = "BOTTOMRIGHT",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["untrigger"] = {
				["spellName"] = 12292,
			},
			["id"] = "Bloodbath CD",
			["selfPoint"] = "CENTER",
			["frameStrata"] = 1,
			["width"] = 40,
			["numTriggers"] = 2,
			["disjunctive"] = false,
			["inverse"] = true,
			["xOffset"] = -45,
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura",
						["spellId"] = "12292",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["names"] = {
							"Bloodbath", -- [1]
						},
						["use_spellId"] = true,
						["inverse"] = true,
						["debuffType"] = "HELPFUL",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["fullscan"] = true,
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["stickyDuration"] = false,
			["cooldown"] = true,
			["textColor"] = {
				1, -- [1]
				0, -- [2]
				0.8, -- [3]
				1, -- [4]
			},
		},
		["ScendOfBlood"] = {
			["sparkWidth"] = 10,
			["stacksSize"] = 12,
			["xOffset"] = 0,
			["stacksFlags"] = "None",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["rotateText"] = "NONE",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["fontFlags"] = "OUTLINE",
			["selfPoint"] = "CENTER",
			["barColor"] = {
				1, -- [1]
				0.913725490196078, -- [2]
				0.380392156862745, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["sparkOffsetY"] = 0,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DEATHKNIGHT",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["timerColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "aurabar",
			["stacks"] = true,
			["texture"] = "Blizzard",
			["textFont"] = "Friz Quadrata TT",
			["borderOffset"] = 5,
			["auto"] = true,
			["timerFont"] = "Friz Quadrata TT",
			["alpha"] = 1,
			["borderInset"] = 11,
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["sparkOffsetX"] = 0,
			["parent"] = "GRP-ScentOfBlood",
			["barInFront"] = true,
			["sparkRotationMode"] = "AUTO",
			["textSize"] = 12,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "aura",
				["subeventSuffix"] = "_CAST_START",
				["event"] = "Health",
				["unit"] = "player",
				["useCount"] = true,
				["count"] = "1",
				["custom_hide"] = "timed",
				["countOperator"] = ">=",
				["names"] = {
					"Scent of Blood", -- [1]
				},
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["text"] = true,
			["stickyDuration"] = false,
			["height"] = 20,
			["timerFlags"] = "None",
			["sparkBlendMode"] = "ADD",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["stacksFont"] = "Friz Quadrata TT",
			["textFlags"] = "None",
			["border"] = false,
			["borderEdge"] = "None",
			["borderBackdrop"] = "Blizzard Tooltip",
			["borderSize"] = 16,
			["spark"] = false,
			["icon_side"] = "LEFT",
			["timer"] = true,
			["inverse"] = false,
			["sparkHeight"] = 30,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["displayTextRight"] = "%p",
			["stacksColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["timerSize"] = 12,
			["icon"] = false,
			["id"] = "ScendOfBlood",
			["untrigger"] = {
			},
			["frameStrata"] = 1,
			["width"] = 200,
			["customTextUpdate"] = "update",
			["borderColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["numTriggers"] = 1,
			["sparkDesature"] = false,
			["orientation"] = "HORIZONTAL",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayTextLeft"] = "%n",
		},
		["GRP-ScentOfBlood"] = {
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["controlledChildren"] = {
				"ScendOfBlood", -- [1]
				"ScentOfBlood-GT-Stacks", -- [2]
				"ScentOfBlood-LT-Stacks", -- [3]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = 0,
			["border"] = false,
			["yOffset"] = -120,
			["anchorPoint"] = "CENTER",
			["borderSize"] = 16,
			["borderColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["borderOffset"] = 5,
			["selfPoint"] = "BOTTOMLEFT",
			["trigger"] = {
				["unit"] = "player",
				["type"] = "aura",
				["debuffType"] = "HELPFUL",
				["names"] = {
				},
			},
			["frameStrata"] = 1,
			["regionType"] = "group",
			["untrigger"] = {
			},
			["borderInset"] = 11,
			["numTriggers"] = 1,
			["id"] = "GRP-ScentOfBlood",
			["borderEdge"] = "None",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["load"] = {
				["class"] = {
					["multi"] = {
					},
				},
				["role"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["expanded"] = false,
		},
		["Blood Shield Absorb Size"] = {
			["outline"] = false,
			["fontSize"] = 14,
			["color"] = {
				1, -- [1]
				0.00784313725490196, -- [2]
				0, -- [3]
				0.820000007748604, -- [4]
			},
			["displayText"] = "%c",
			["customText"] = "function()\n    if UnitBuff(\"player\",\"Blood Shield\") then\n        local _,_,_,_,_,_,_,_,_,_,spellID,_,_,_,absorbAmount,_ = UnitBuff(\"player\",\"Blood Shield\")\n        if spellID == 77535 then\n            absorbAmount = absorbAmount / 1000\n            return string.format(\"%i%c\",absorbAmount,75)\n        end\n    end\n    \n    \nend",
			["yOffset"] = -46.9999694824219,
			["regionType"] = "text",
			["customTextUpdate"] = "update",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["untrigger"] = {
			},
			["id"] = "Blood Shield Absorb Size",
			["justify"] = "CENTER",
			["selfPoint"] = "CENTER",
			["trigger"] = {
				["type"] = "aura",
				["spellId"] = "124990",
				["subeventSuffix"] = "_CAST_START",
				["ownOnly"] = true,
				["event"] = "Health",
				["names"] = {
					"Blood Shield", -- [1]
				},
				["use_name"] = true,
				["subcount"] = true,
				["name"] = "Life Cocoon",
				["custom_hide"] = "timed",
				["use_spellId"] = true,
				["unit"] = "player",
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["frameStrata"] = 1,
			["width"] = 19.9999923706055,
			["additional_triggers"] = {
			},
			["font"] = "DorisPP",
			["numTriggers"] = 1,
			["anchorPoint"] = "CENTER",
			["height"] = 13.9999942779541,
			["xOffset"] = -176.000122070313,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["class"] = {
					["single"] = "DEATHKNIGHT",
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "DK - Blood",
		},
		["BloodCharges"] = {
			["fontSize"] = 24,
			["displayStacks"] = "%s",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["parent"] = "DK - Blood",
			["stacksPoint"] = "CENTER",
			["anchorPoint"] = "CENTER",
			["untrigger"] = {
			},
			["regionType"] = "icon",
			["xOffset"] = 129.999633789063,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["numTriggers"] = 1,
			["customTextUpdate"] = "update",
			["trigger"] = {
				["type"] = "aura",
				["subeventSuffix"] = "_CAST_START",
				["event"] = "Health",
				["unit"] = "player",
				["useCount"] = true,
				["count"] = "5",
				["countOperator"] = ">=",
				["subeventPrefix"] = "SPELL",
				["names"] = {
					"Blood Charge", -- [1]
				},
				["debuffType"] = "HELPFUL",
			},
			["actions"] = {
				["start"] = {
					["do_glow"] = true,
					["glow_frame"] = "WeakAuras:BloodCharges",
					["do_sound"] = false,
					["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Blast.mp3",
					["glow_action"] = "show",
				},
				["finish"] = {
				},
			},
			["fontFlags"] = "OUTLINE",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["selfPoint"] = "CENTER",
			["id"] = "BloodCharges",
			["width"] = 48,
			["frameStrata"] = 1,
			["stickyDuration"] = false,
			["desaturate"] = false,
			["font"] = "Friz Quadrata TT",
			["inverse"] = false,
			["icon"] = true,
			["height"] = 48,
			["yOffset"] = -120,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DEATHKNIGHT",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["No Rage"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.75, -- [4]
			},
			["fontSize"] = 12,
			["displayStacks"] = "%s",
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "Warrior - Arms",
			["xOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["yOffset"] = 0,
			["regionType"] = "icon",
			["icon"] = true,
			["numTriggers"] = 1,
			["selfPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["stickyDuration"] = false,
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
					["glow_frame"] = "WeakAuras:Execute",
					["glow_action"] = "show",
				},
				["finish"] = {
				},
			},
			["fontFlags"] = "OUTLINE",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0.33,
			["auto"] = true,
			["animation"] = {
				["start"] = {
					["preset"] = "fade",
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["preset"] = "pulse",
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["id"] = "No Rage",
			["width"] = 35,
			["frameStrata"] = 1,
			["desaturate"] = true,
			["trigger"] = {
				["type"] = "status",
				["use_targetRequired"] = false,
				["custom_hide"] = "timed",
				["use_inverse"] = true,
				["event"] = "Action Usable",
				["subeventPrefix"] = "SPELL",
				["unevent"] = "auto",
				["use_spellName"] = true,
				["spellName"] = 1680,
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["use_unit"] = true,
				["names"] = {
				},
				["debuffType"] = "HELPFUL",
			},
			["font"] = "Friz Quadrata TT",
			["inverse"] = false,
			["additional_triggers"] = {
			},
			["height"] = 35,
			["untrigger"] = {
				["spellName"] = 1680,
			},
			["stacksPoint"] = "BOTTOMRIGHT",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["BloodShield"] = {
			["color"] = {
				0.741176470588235, -- [1]
				0, -- [2]
				0.0196078431372549, -- [3]
				0.75, -- [4]
			},
			["mirror"] = false,
			["yOffset"] = 0,
			["regionType"] = "texture",
			["blendMode"] = "ADD",
			["xOffset"] = 0,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["texture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura16",
			["untrigger"] = {
			},
			["selfPoint"] = "CENTER",
			["trigger"] = {
				["unit"] = "player",
				["type"] = "aura",
				["subeventPrefix"] = "SPELL",
				["subeventSuffix"] = "_CAST_START",
				["debuffType"] = "HELPFUL",
				["ownOnly"] = true,
				["event"] = "Health",
				["names"] = {
					"Blood Shield", -- [1]
				},
			},
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["id"] = "BloodShield",
			["rotation"] = 0,
			["frameStrata"] = 1,
			["desaturate"] = false,
			["discrete_rotation"] = 0,
			["anchorPoint"] = "CENTER",
			["numTriggers"] = 1,
			["width"] = 500,
			["height"] = 500,
			["rotate"] = true,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DEATHKNIGHT",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "DK - Blood",
		},
		["IV"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["untrigger"] = {
				["spellName"] = 103840,
			},
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["use_inverse"] = true,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["custom_hide"] = "timed",
				["use_spellName"] = true,
				["spellName"] = 103840,
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_never"] = false,
				["talent"] = 6,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = " ",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["stacksPoint"] = "BOTTOM",
			["stacksContainment"] = "OUTSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["id"] = "IV",
			["additional_triggers"] = {
			},
			["yOffset"] = -65,
			["frameStrata"] = 1,
			["width"] = 40,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["numTriggers"] = 1,
			["inverse"] = true,
			["xOffset"] = -150,
			["stickyDuration"] = false,
			["selfPoint"] = "CENTER",
			["cooldown"] = false,
			["textColor"] = {
				1, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["HPe"] = {
			["xOffset"] = -2,
			["mirror"] = false,
			["yOffset"] = 34,
			["regionType"] = "texture",
			["blendMode"] = "ADD",
			["anchorPoint"] = "CENTER",
			["untrigger"] = {
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["texture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura75",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.75, -- [4]
			},
			["selfPoint"] = "CENTER",
			["trigger"] = {
				["type"] = "status",
				["power"] = "0",
				["power_operator"] = ">=",
				["use_power"] = true,
				["event"] = "Holy Power",
				["use_unit"] = true,
				["debuffType"] = "HELPFUL",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["unevent"] = "auto",
				["names"] = {
				},
				["subeventPrefix"] = "SPELL",
				["custom_hide"] = "timed",
			},
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["id"] = "HPe",
			["rotation"] = 0,
			["frameStrata"] = 1,
			["width"] = 75.0003356933594,
			["discrete_rotation"] = 0,
			["desaturate"] = false,
			["numTriggers"] = 1,
			["additional_triggers"] = {
			},
			["height"] = 120,
			["rotate"] = true,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = false,
				["use_combat"] = true,
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						[2] = true,
						[3] = true,
					},
				},
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "v0.91 Prot Pala Group",
		},
		["DK - Blood"] = {
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["controlledChildren"] = {
				"BoneShield", -- [1]
				"BloodCharges", -- [2]
				"DeathSiphonUseable", -- [3]
				"RuneShield", -- [4]
				"PlagueLeechUseable", -- [5]
				"BloodShield", -- [6]
				"Blood Shield Timer", -- [7]
				"Blood Shield Absorb Size", -- [8]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = 0,
			["border"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["borderSize"] = 16,
			["borderColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["borderOffset"] = 5,
			["selfPoint"] = "BOTTOMLEFT",
			["trigger"] = {
				["unit"] = "player",
				["type"] = "aura",
				["debuffType"] = "HELPFUL",
				["names"] = {
				},
			},
			["frameStrata"] = 1,
			["regionType"] = "group",
			["untrigger"] = {
			},
			["borderInset"] = 11,
			["numTriggers"] = 1,
			["id"] = "DK - Blood",
			["borderEdge"] = "None",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["load"] = {
				["class"] = {
					["multi"] = {
					},
				},
				["role"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["expanded"] = false,
		},
		["Bladestorm"] = {
			["disjunctive"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["custom_hide"] = "timed",
				["use_remaining"] = false,
				["custom_type"] = "status",
				["unevent"] = "auto",
				["use_matchedRune"] = true,
				["use_inverse"] = true,
				["event"] = "Cooldown Progress (Spell)",
				["subeventPrefix"] = "SPELL",
				["type"] = "status",
				["use_spellName"] = true,
				["spellName"] = 46924,
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["names"] = {
				},
				["use_unit"] = true,
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_never"] = false,
				["talent"] = 18,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						[3] = true,
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
						["WARRIOR"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%s",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["cooldown"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["additional_triggers"] = {
			},
			["untrigger"] = {
				["spellName"] = 46924,
			},
			["frameStrata"] = 1,
			["width"] = 40,
			["numTriggers"] = 1,
			["stickyDuration"] = false,
			["inverse"] = false,
			["xOffset"] = -45,
			["id"] = "Bladestorm",
			["selfPoint"] = "CENTER",
			["stacksPoint"] = "BOTTOMRIGHT",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Victory Rush"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = -65,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "aura",
				["unevent"] = "auto",
				["use_inverse"] = false,
				["event"] = "Action Usable",
				["use_unit"] = true,
				["spellName"] = 34428,
				["use_spellName"] = true,
				["custom_hide"] = "timed",
				["names"] = {
					"Victorious", -- [1]
				},
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = " %p",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["cooldown"] = false,
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["id"] = "Victory Rush",
			["additional_triggers"] = {
			},
			["untrigger"] = {
				["spellName"] = 34428,
			},
			["frameStrata"] = 1,
			["width"] = 40,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["inverse"] = true,
			["numTriggers"] = 1,
			["xOffset"] = -150,
			["stickyDuration"] = false,
			["selfPoint"] = "CENTER",
			["stacksPoint"] = "BOTTOM",
			["textColor"] = {
				0.196078431372549, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["Warrior Rage Bar"] = {
			["sparkWidth"] = 10,
			["stacksSize"] = 12,
			["xOffset"] = 0,
			["stacksFlags"] = "None",
			["yOffset"] = -32,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["rotateText"] = "NONE",
			["icon"] = false,
			["fontFlags"] = "OUTLINE",
			["selfPoint"] = "CENTER",
			["barColor"] = {
				1, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["sparkOffsetY"] = 0,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["timerColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "aurabar",
			["stacks"] = true,
			["texture"] = "Minimalist",
			["textFont"] = "ElvUI Alt-Font",
			["stacksFont"] = "ElvUI Alt-Font",
			["auto"] = false,
			["timerFont"] = "ElvUI Alt-Font",
			["alpha"] = 1,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["sparkOffsetX"] = 0,
			["parent"] = "Warrior - Arms",
			["barInFront"] = true,
			["sparkRotationMode"] = "AUTO",
			["textSize"] = 20,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["colorR"] = 0,
					["type"] = "custom",
					["use_color"] = true,
					["duration"] = "2",
					["x"] = 0,
					["scaley"] = 1,
					["alpha"] = 0,
					["colorA"] = 1,
					["y"] = 0,
					["colorB"] = 1,
					["colorG"] = 0.376470588235294,
					["colorType"] = "custom",
					["colorFunc"] = "return function(progress, r1, g1, b1, a1, r2, g2, b2, a2)\n    local colors_for_rage = {}\n    -- when you reach \"X\" rage set the red/green/blue colors for rage.\n    \n    colors_for_rage[0] = {red = 1, green = 0, blue = 0} -- red: need 15 rage for devestate\n    colors_for_rage[33] = {red = 1, green = 1, blue = 0} --  yellow: everythign is good\n    colors_for_rage[66] = {red = 0, green = 1, blue = 0} --  green: do anything you want. too much rage\n    \n    local red, green, blue = colors_for_rage[0].red, colors_for_rage[0].green, colors_for_rage[0].blue\n    \n    local player_rage = UnitPower(\"player\", 1)\n    for threshold, rage_colors in pairs(colors_for_rage) do\n        if player_rage > threshold then\n            --print(string.format(\"%i %i\", player_rage, threshold))\n            red, green, blue = rage_colors.red, rage_colors.green, rage_colors.blue\n            \n        end\n    end\n    \n    return red, green, blue, 1\nend\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
					["rotate"] = 0,
					["duration_type"] = "seconds",
					["scalex"] = 1,
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["event"] = "Power",
				["use_unit"] = true,
				["custom_hide"] = "timed",
				["powertype"] = 1,
				["names"] = {
				},
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["use_powertype"] = true,
				["debuffType"] = "HELPFUL",
			},
			["text"] = true,
			["stickyDuration"] = false,
			["timer"] = true,
			["timerFlags"] = "OUTLINE",
			["sparkBlendMode"] = "ADD",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["textFlags"] = "None",
			["borderBackdrop"] = "Blizzard Tooltip",
			["border"] = false,
			["borderEdge"] = "None",
			["height"] = 18,
			["borderSize"] = 16,
			["borderOffset"] = 5,
			["icon_side"] = "RIGHT",
			["numTriggers"] = 1,
			["sparkRotation"] = 0,
			["sparkHeight"] = 30,
			["displayTextLeft"] = " ",
			["displayTextRight"] = "%p",
			["stacksColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["timerSize"] = 20,
			["id"] = "Warrior Rage Bar",
			["additional_triggers"] = {
			},
			["customTextUpdate"] = "update",
			["frameStrata"] = 1,
			["width"] = 315,
			["untrigger"] = {
			},
			["borderInset"] = 11,
			["inverse"] = false,
			["sparkDesature"] = false,
			["orientation"] = "HORIZONTAL",
			["spark"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
		},
		["Self Heal Useable"] = {
			["fontSize"] = 12,
			["displayStacks"] = " ",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["parent"] = "Warrior - Prot",
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["untrigger"] = {
				["spellName"] = 103840,
			},
			["yOffset"] = -119.999938964844,
			["anchorPoint"] = "CENTER",
			["xOffset"] = 230,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "preset",
					["duration_type"] = "seconds",
					["preset"] = "pulse",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["inverse"] = false,
			["customTextUpdate"] = "update",
			["trigger"] = {
				["type"] = "status",
				["subeventSuffix"] = "_CAST_START",
				["event"] = "Action Usable",
				["unit"] = "player",
				["debuffType"] = "HELPFUL",
				["use_spellName"] = true,
				["names"] = {
				},
				["subeventPrefix"] = "SPELL",
				["unevent"] = "auto",
				["use_unit"] = true,
				["use_targetRequired"] = false,
				["spellName"] = 103840,
			},
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["selfPoint"] = "CENTER",
			["id"] = "Self Heal Useable",
			["width"] = 48,
			["frameStrata"] = 1,
			["stickyDuration"] = false,
			["desaturate"] = false,
			["font"] = "Friz Quadrata TT",
			["numTriggers"] = 1,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["height"] = 48,
			["regionType"] = "icon",
			["stacksPoint"] = "BOTTOMRIGHT",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Heroic Leap 2"] = {
			["parent"] = "Warrior - Arms",
			["fontSize"] = 16,
			["displayStacks"] = "%s",
			["stacksPoint"] = "BOTTOMRIGHT",
			["xOffset"] = 135,
			["yOffset"] = 0,
			["regionType"] = "icon",
			["untrigger"] = {
				["spellName"] = 6544,
			},
			["anchorPoint"] = "CENTER",
			["icon"] = true,
			["numTriggers"] = 1,
			["selfPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["stickyDuration"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["fontFlags"] = "OUTLINE",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["additional_triggers"] = {
			},
			["width"] = 40,
			["frameStrata"] = 1,
			["desaturate"] = false,
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["use_matchedRune"] = true,
				["use_inverse"] = true,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["spellName"] = 6544,
				["use_spellName"] = true,
				["custom_hide"] = "timed",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["debuffType"] = "HELPFUL",
			},
			["font"] = "ElvUI Alt-Font",
			["inverse"] = false,
			["id"] = "Heroic Leap 2",
			["height"] = 40,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["use_talent"] = false,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
						["WARRIOR"] = true,
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
						[3] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["HPb"] = {
			["xOffset"] = -164,
			["mirror"] = false,
			["yOffset"] = 34,
			["regionType"] = "texture",
			["blendMode"] = "ADD",
			["anchorPoint"] = "CENTER",
			["untrigger"] = {
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["texture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura75",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.75, -- [4]
			},
			["selfPoint"] = "CENTER",
			["id"] = "HPb",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "status",
				["power"] = "0",
				["power_operator"] = ">=",
				["use_power"] = true,
				["event"] = "Holy Power",
				["use_unit"] = true,
				["debuffType"] = "HELPFUL",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["unevent"] = "auto",
				["names"] = {
				},
				["subeventPrefix"] = "SPELL",
				["custom_hide"] = "timed",
			},
			["rotation"] = 0,
			["frameStrata"] = 1,
			["width"] = 75.0003356933594,
			["discrete_rotation"] = 0,
			["desaturate"] = false,
			["numTriggers"] = 1,
			["additional_triggers"] = {
			},
			["height"] = 120,
			["rotate"] = true,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = false,
				["use_combat"] = true,
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						[2] = true,
						[3] = true,
					},
				},
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "v0.91 Prot Pala Group",
		},
		["Execute"] = {
			["xOffset"] = 113.808959960938,
			["fontSize"] = 12,
			["displayStacks"] = "%s",
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "Warrior - Arms",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.75, -- [4]
			},
			["anchorPoint"] = "CENTER",
			["untrigger"] = {
				["spellName"] = 5308,
			},
			["regionType"] = "icon",
			["actions"] = {
				["start"] = {
					["do_glow"] = true,
					["glow_frame"] = "WeakAuras:Execute",
					["glow_action"] = "show",
					["do_sound"] = false,
				},
				["finish"] = {
				},
			},
			["numTriggers"] = 1,
			["selfPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["desaturate"] = false,
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0.33,
			["auto"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["preset"] = "fade",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "preset",
					["preset"] = "pulse",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["additional_triggers"] = {
			},
			["width"] = 75,
			["frameStrata"] = 1,
			["stickyDuration"] = false,
			["id"] = "Execute",
			["font"] = "Friz Quadrata TT",
			["inverse"] = false,
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["custom_hide"] = "timed",
				["event"] = "Action Usable",
				["subeventPrefix"] = "SPELL",
				["use_targetRequired"] = true,
				["use_spellName"] = true,
				["spellName"] = 5308,
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["use_unit"] = true,
				["names"] = {
				},
				["debuffType"] = "HELPFUL",
			},
			["height"] = 75,
			["yOffset"] = 75.191162109375,
			["stacksPoint"] = "BOTTOMRIGHT",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Warrior Rage Bar Prot"] = {
			["textFlags"] = "None",
			["stacksSize"] = 12,
			["xOffset"] = 0,
			["stacksFlags"] = "None",
			["yOffset"] = -120,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["rotateText"] = "NONE",
			["icon"] = false,
			["fontFlags"] = "OUTLINE",
			["selfPoint"] = "CENTER",
			["barColor"] = {
				1, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["sparkOffsetY"] = 0,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["spec"] = {
					["single"] = 3,
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["timerColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "aurabar",
			["stacks"] = true,
			["texture"] = "Minimalist",
			["textFont"] = "ElvUI Font",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["auto"] = false,
			["timerFont"] = "ElvUI Font",
			["alpha"] = 1,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["parent"] = "Warrior - Prot",
			["untrigger"] = {
			},
			["customTextUpdate"] = "update",
			["textSize"] = 20,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration"] = "2",
					["colorR"] = 0,
					["duration_type"] = "seconds",
					["scaley"] = 1,
					["colorA"] = 1,
					["use_color"] = true,
					["alpha"] = 0,
					["colorType"] = "custom",
					["y"] = 0,
					["x"] = 0,
					["colorG"] = 0.376470588235294,
					["colorB"] = 1,
					["colorFunc"] = "return function(progress, r1, g1, b1, a1, r2, g2, b2, a2)\n    local colors_for_rage = {}\n    -- when you reach \"X\" rage set the red/green/blue colors for rage.\n    \n    colors_for_rage[0] = {red = 1, green = 0, blue = 0} -- red: need 15 rage for devestate\n    colors_for_rage[33] = {red = 1, green = 1, blue = 0} --  yellow: everythign is good\n    colors_for_rage[66] = {red = 0, green = 1, blue = 0} --  green: do anything you want. too much rage\n    \n    local red, green, blue = colors_for_rage[0].red, colors_for_rage[0].green, colors_for_rage[0].blue\n    \n    local player_rage = UnitPower(\"player\", 1)\n    for threshold, rage_colors in pairs(colors_for_rage) do\n        if player_rage > threshold then\n            --print(string.format(\"%i %i\", player_rage, threshold))\n            red, green, blue = rage_colors.red, rage_colors.green, rage_colors.blue\n            \n        end\n    end\n    \n    return red, green, blue, 1\nend\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
					["rotate"] = 0,
					["scalex"] = 1,
					["type"] = "custom",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["event"] = "Power",
				["use_unit"] = true,
				["debuffType"] = "HELPFUL",
				["powertype"] = 1,
				["names"] = {
				},
				["subeventPrefix"] = "SPELL",
				["subeventSuffix"] = "_CAST_START",
				["unit"] = "player",
				["use_powertype"] = true,
				["custom_hide"] = "timed",
			},
			["text"] = true,
			["stickyDuration"] = false,
			["timer"] = true,
			["timerFlags"] = "OUTLINE",
			["sparkBlendMode"] = "ADD",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["stacksFont"] = "ElvUI Font",
			["borderInset"] = 11,
			["sparkWidth"] = 10,
			["border"] = false,
			["borderEdge"] = "None",
			["sparkOffsetX"] = 0,
			["borderSize"] = 16,
			["sparkRotationMode"] = "AUTO",
			["icon_side"] = "RIGHT",
			["inverse"] = false,
			["borderColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["sparkHeight"] = 30,
			["barInFront"] = true,
			["timerSize"] = 20,
			["stacksColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayTextRight"] = "%p",
			["additional_triggers"] = {
			},
			["id"] = "Warrior Rage Bar Prot",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["frameStrata"] = 1,
			["width"] = 315,
			["borderOffset"] = 5,
			["height"] = 18,
			["numTriggers"] = 1,
			["sparkDesature"] = false,
			["orientation"] = "HORIZONTAL",
			["displayTextLeft"] = " ",
			["spark"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
		},
		["B Rage"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 45,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["use_inverse"] = true,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["spellName"] = 18499,
				["use_spellName"] = true,
				["custom_hide"] = "timed",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%s",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["selfPoint"] = "CENTER",
			["additional_triggers"] = {
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["frameStrata"] = 1,
			["width"] = 40,
			["untrigger"] = {
				["spellName"] = 18499,
			},
			["numTriggers"] = 1,
			["inverse"] = false,
			["stickyDuration"] = false,
			["xOffset"] = -25,
			["id"] = "B Rage",
			["stacksPoint"] = "TOP",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["HP3"] = {
			["disjunctive"] = true,
			["mirror"] = false,
			["yOffset"] = 34,
			["regionType"] = "texture",
			["blendMode"] = "ADD",
			["untrigger"] = {
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.75, -- [4]
			},
			["xOffset"] = -110,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["texture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura74",
			["anchorPoint"] = "CENTER",
			["id"] = "HP3",
			["trigger"] = {
				["type"] = "status",
				["power"] = "3",
				["power_operator"] = ">=",
				["use_power"] = true,
				["event"] = "Holy Power",
				["use_unit"] = true,
				["debuffType"] = "HELPFUL",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["unevent"] = "auto",
				["names"] = {
				},
				["subeventPrefix"] = "SPELL",
				["custom_hide"] = "timed",
			},
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura",
						["subeventSuffix"] = "_CAST_START",
						["ownOnly"] = true,
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["unit"] = "player",
						["names"] = {
							"Divine Purpose", -- [1]
						},
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["desaturate"] = false,
			["frameStrata"] = 1,
			["width"] = 100,
			["rotation"] = 0,
			["discrete_rotation"] = 0,
			["numTriggers"] = 2,
			["selfPoint"] = "CENTER",
			["height"] = 40,
			["rotate"] = true,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = false,
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						[2] = true,
						[3] = true,
					},
				},
				["use_combat"] = true,
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "v0.91 Prot Pala Group",
		},
		["Runic Power Text"] = {
			["outline"] = false,
			["fontSize"] = 35,
			["xOffset"] = -250,
			["displayText"] = "%p",
			["yOffset"] = -36,
			["regionType"] = "text",
			["customTextUpdate"] = "update",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["untrigger"] = {
			},
			["trigger"] = {
				["custom_hide"] = "timed",
				["type"] = "status",
				["use_percentpower"] = false,
				["unevent"] = "auto",
				["power_operator"] = ">=",
				["use_power"] = true,
				["event"] = "Power",
				["subeventPrefix"] = "SPELL",
				["use_unit"] = true,
				["powertype"] = 6,
				["power"] = "1",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["names"] = {
				},
				["use_powertype"] = true,
				["debuffType"] = "HELPFUL",
			},
			["justify"] = "CENTER",
			["selfPoint"] = "CENTER",
			["additional_triggers"] = {
			},
			["color"] = {
				0, -- [1]
				0.749019607843137, -- [2]
				1, -- [3]
				0.910000003874302, -- [4]
			},
			["frameStrata"] = 1,
			["width"] = 7.82224893569946,
			["anchorPoint"] = "CENTER",
			["font"] = "DorisPP",
			["numTriggers"] = 1,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["height"] = 22.7555465698242,
			["id"] = "Runic Power Text",
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = true,
				["class"] = {
					["single"] = "DEATHKNIGHT",
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "Runic Power",
		},
		["S Reflect"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = -65,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["use_inverse"] = true,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["custom_hide"] = "timed",
				["use_spellName"] = true,
				["spellName"] = 23920,
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%s",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["cooldown"] = false,
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["additional_triggers"] = {
			},
			["untrigger"] = {
				["spellName"] = 23920,
			},
			["frameStrata"] = 1,
			["width"] = 40,
			["stickyDuration"] = false,
			["numTriggers"] = 1,
			["inverse"] = false,
			["xOffset"] = -50,
			["id"] = "S Reflect",
			["selfPoint"] = "CENTER",
			["stacksPoint"] = "BOTTOMRIGHT",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Irupt CD"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.350000023841858, -- [4]
			},
			["yOffset"] = -65,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["spellName"] = 6552,
				["use_spellName"] = true,
				["custom_hide"] = "timed",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["stacksPoint"] = "BOTTOM",
			["stacksContainment"] = "OUTSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["event"] = "Cooldown Progress (Spell)",
						["subeventPrefix"] = "SPELL",
						["use_spellName"] = true,
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["spellName"] = 102060,
					},
					["untrigger"] = {
						["spellName"] = 102060,
					},
				}, -- [1]
			},
			["untrigger"] = {
				["spellName"] = 6552,
			},
			["frameStrata"] = 1,
			["width"] = 40,
			["id"] = "Irupt CD",
			["inverse"] = true,
			["numTriggers"] = 2,
			["xOffset"] = 50,
			["stickyDuration"] = false,
			["selfPoint"] = "CENTER",
			["cooldown"] = true,
			["textColor"] = {
				1, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["HP2"] = {
			["disjunctive"] = true,
			["mirror"] = false,
			["yOffset"] = 34,
			["regionType"] = "texture",
			["blendMode"] = "ADD",
			["untrigger"] = {
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.75, -- [4]
			},
			["xOffset"] = -164,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["texture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura74",
			["anchorPoint"] = "CENTER",
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["power_operator"] = ">=",
				["use_power"] = true,
				["event"] = "Holy Power",
				["use_unit"] = true,
				["custom_hide"] = "timed",
				["power"] = "2",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["debuffType"] = "HELPFUL",
			},
			["additional_triggers"] = {
				{
					["trigger"] = {
						["subeventPrefix"] = "SPELL",
						["type"] = "aura",
						["debuffType"] = "HELPFUL",
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["ownOnly"] = true,
						["event"] = "Health",
						["names"] = {
							"Divine Purpose", -- [1]
						},
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["selfPoint"] = "CENTER",
			["id"] = "HP2",
			["desaturate"] = false,
			["frameStrata"] = 1,
			["width"] = 100,
			["rotation"] = 0,
			["discrete_rotation"] = 0,
			["numTriggers"] = 2,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["height"] = 40,
			["rotate"] = true,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = false,
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						[2] = true,
						[3] = true,
					},
				},
				["use_combat"] = true,
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "v0.91 Prot Pala Group",
		},
		["Resolve, Haste Text"] = {
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["controlledChildren"] = {
				"Resolve", -- [1]
				"Current Haste", -- [2]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = -140,
			["border"] = false,
			["yOffset"] = -100,
			["regionType"] = "group",
			["borderSize"] = 16,
			["borderColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["expanded"] = false,
			["borderOffset"] = 5,
			["selfPoint"] = "BOTTOMLEFT",
			["additional_triggers"] = {
			},
			["id"] = "Resolve, Haste Text",
			["frameStrata"] = 1,
			["anchorPoint"] = "CENTER",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["borderInset"] = 11,
			["numTriggers"] = 1,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "aura",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["debuffType"] = "HELPFUL",
				["names"] = {
				},
				["event"] = "Health",
				["subeventPrefix"] = "SPELL",
			},
			["borderEdge"] = "None",
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["untrigger"] = {
			},
		},
		["Warrior - Prot"] = {
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["controlledChildren"] = {
				"ShieldBarrier", -- [1]
				"ShieldBlock", -- [2]
				"ShieldBlockUseable", -- [3]
				"Warrior Rage Bar Prot", -- [4]
				"Self Heal Useable", -- [5]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = 0,
			["border"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["borderSize"] = 16,
			["borderColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["borderOffset"] = 5,
			["selfPoint"] = "BOTTOMLEFT",
			["trigger"] = {
				["unit"] = "player",
				["type"] = "aura",
				["debuffType"] = "HELPFUL",
				["names"] = {
				},
			},
			["frameStrata"] = 1,
			["regionType"] = "group",
			["untrigger"] = {
			},
			["borderInset"] = 11,
			["numTriggers"] = 1,
			["id"] = "Warrior - Prot",
			["borderEdge"] = "None",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["load"] = {
				["class"] = {
					["multi"] = {
					},
				},
				["role"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["expanded"] = false,
		},
		["Warrior - Arms"] = {
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["controlledChildren"] = {
				"MS", -- [1]
				"MS CD", -- [2]
				"CS", -- [3]
				"CS CD", -- [4]
				"Execute", -- [5]
				"Whirlwind", -- [6]
				"No Rage", -- [7]
				"SW", -- [8]
				"SW CD", -- [9]
				"Bladestorm", -- [10]
				"Bladestorm Aura", -- [11]
				"Bladestorm CD", -- [12]
				"Bloodbath", -- [13]
				"Bloodbath Aura", -- [14]
				"Bloodbath CD", -- [15]
				"Avatar", -- [16]
				"Avatar Aura", -- [17]
				"Avatar CD", -- [18]
				"Charge", -- [19]
				"Charge CD", -- [20]
				"Warrior Rage Bar", -- [21]
				"Heroic Leap 2", -- [22]
				"Heroic Leap CD 2", -- [23]
				"B Rage", -- [24]
				"B Rage CD", -- [25]
				"PvP Trinket", -- [26]
				"PvP Trinket CD", -- [27]
				"S Reflect", -- [28]
				"S Reflect CD", -- [29]
				"Rallying Cry", -- [30]
				"Rallying Cry Aura", -- [31]
				"Rallying Cry CD", -- [32]
				"Irupt", -- [33]
				"Irupt CD", -- [34]
				"I Shout", -- [35]
				"I Shout CD", -- [36]
				"Sweeping Strikes", -- [37]
				"Rend", -- [38]
				"Stance", -- [39]
				"Victory Rush", -- [40]
				"IV", -- [41]
				"IV CD", -- [42]
				"Storm Bolt", -- [43]
				"Storm Bolt CD", -- [44]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = 0,
			["border"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["borderSize"] = 16,
			["borderColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["expanded"] = false,
			["borderOffset"] = 5,
			["selfPoint"] = "BOTTOMLEFT",
			["additional_triggers"] = {
			},
			["regionType"] = "group",
			["frameStrata"] = 1,
			["untrigger"] = {
			},
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["borderInset"] = 11,
			["numTriggers"] = 1,
			["trigger"] = {
				["type"] = "aura",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["debuffType"] = "HELPFUL",
				["names"] = {
				},
				["event"] = "Health",
				["subeventPrefix"] = "SPELL",
			},
			["borderEdge"] = "None",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["id"] = "Warrior - Arms",
		},
		["Bastion of Glory"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["untrigger"] = {
			},
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["useTooltip"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["rem"] = "5",
				["subeventSuffix"] = "_CAST_START",
				["ownOnly"] = true,
				["event"] = "Health",
				["names"] = {
					"Bastion of Glory", -- [1]
				},
				["custom_hide"] = "timed",
				["unit"] = "player",
				["remOperator"] = "<",
				["type"] = "aura",
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["font"] = "Friz Quadrata TT",
			["height"] = 44,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["use_combat"] = true,
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						true, -- [1]
					},
				},
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 24,
			["displayStacks"] = "%s",
			["regionType"] = "icon",
			["parent"] = "v0.91 Prot Pala Group",
			["cooldown"] = false,
			["selfPoint"] = "CENTER",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["id"] = "Bastion of Glory",
			["yOffset"] = 0,
			["frameStrata"] = 1,
			["width"] = 44,
			["numTriggers"] = 2,
			["stickyDuration"] = false,
			["inverse"] = false,
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura",
						["unevent"] = "auto",
						["ownOnly"] = true,
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["inverse"] = true,
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["names"] = {
							"Shield of the Righteous", -- [1]
						},
						["unit"] = "player",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["xOffset"] = -0.000244140625,
			["displayIcon"] = "INTERFACE\\ICONS\\inv_helmet_96",
			["stacksPoint"] = "CENTER",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Rallying Cry CD"] = {
			["xOffset"] = 0,
			["yOffset"] = -65,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["spellName"] = 97462,
				["use_spellName"] = true,
				["custom_hide"] = "timed",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["stacksPoint"] = "BOTTOM",
			["stacksContainment"] = "OUTSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["additional_triggers"] = {
			},
			["id"] = "Rallying Cry CD",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["frameStrata"] = 1,
			["width"] = 40,
			["untrigger"] = {
				["spellName"] = 97462,
			},
			["inverse"] = true,
			["numTriggers"] = 1,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.350000023841858, -- [4]
			},
			["stickyDuration"] = false,
			["selfPoint"] = "CENTER",
			["cooldown"] = true,
			["textColor"] = {
				1, -- [1]
				0.0313725490196078, -- [2]
				0.0745098039215686, -- [3]
				1, -- [4]
			},
		},
		["Avenging Wrath"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["useTooltip"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["rem"] = "180",
				["spellId"] = "114163 ",
				["ownOnly"] = true,
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
				["type"] = "aura",
				["subeventSuffix"] = "_CAST_START",
				["custom_hide"] = "timed",
				["spellName"] = 0,
				["event"] = "Cooldown Progress (Spell)",
				["use_inverse"] = false,
				["names"] = {
					"Eternal Flame", -- [1]
				},
				["use_spellId"] = true,
				["unevent"] = "auto",
				["use_spellName"] = true,
				["remOperator"] = "<=",
				["use_unit"] = true,
				["unit"] = "player",
				["fullscan"] = true,
			},
			["desaturate"] = false,
			["font"] = "Friz Quadrata TT",
			["height"] = 44,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						true, -- [1]
					},
				},
				["use_combat"] = true,
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 20,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "v0.91 Prot Pala Group",
			["stacksPoint"] = "BOTTOM",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["id"] = "Avenging Wrath",
			["untrigger"] = {
				["use_spellName"] = true,
				["unit"] = "player",
				["use_unit"] = true,
			},
			["frameStrata"] = 1,
			["width"] = 44,
			["stickyDuration"] = false,
			["numTriggers"] = 1,
			["inverse"] = true,
			["additional_triggers"] = {
			},
			["xOffset"] = -220,
			["selfPoint"] = "CENTER",
			["cooldown"] = false,
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Rend"] = {
			["textFlags"] = "OUTLINE",
			["stacksSize"] = 12,
			["user_x"] = 0,
			["xOffset"] = 0.00042724609375,
			["stacksFlags"] = "None",
			["yOffset"] = -147.999755859375,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["sameTexture"] = true,
			["rotateText"] = "NONE",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["selfPoint"] = "CENTER",
			["barColor"] = {
				1, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["rotation"] = 0,
			["sparkOffsetY"] = 0,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["foregroundTexture"] = "Textures\\SpellActivationOverlays\\Art_of_War",
			["regionType"] = "aurabar",
			["stacks"] = true,
			["blendMode"] = "BLEND",
			["texture"] = "ElvUI Norm",
			["textFont"] = "ElvUI Font",
			["zoom"] = 0,
			["auto"] = true,
			["compress"] = false,
			["timerFont"] = "ElvUI Font",
			["alpha"] = 1,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["stacksPoint"] = "BOTTOMRIGHT",
			["textColor"] = {
				1, -- [1]
				0.0784313725490196, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["sparkOffsetX"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["barInFront"] = true,
			["desaturateBackground"] = false,
			["backgroundOffset"] = 2,
			["stacksFont"] = "Friz Quadrata TT",
			["customTextUpdate"] = "update",
			["crop_y"] = 0.41,
			["desaturateForeground"] = false,
			["borderInset"] = 11,
			["untrigger"] = {
			},
			["numTriggers"] = 1,
			["textSize"] = 15,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "aura",
				["spellId"] = "772",
				["subeventSuffix"] = "_CAST_START",
				["ownOnly"] = true,
				["event"] = "Health",
				["names"] = {
					"Rend", -- [1]
				},
				["use_spellId"] = true,
				["debuffType"] = "HARMFUL",
				["unit"] = "target",
				["subeventPrefix"] = "SPELL",
				["custom_hide"] = "timed",
			},
			["text"] = true,
			["borderOffset"] = 5,
			["stickyDuration"] = false,
			["borderBackdrop"] = "Blizzard Tooltip",
			["backgroundColor"] = {
				0.819607843137255, -- [1]
				0.172549019607843, -- [2]
				0.666666666666667, -- [3]
				0.5, -- [4]
			},
			["height"] = 25,
			["id"] = "Rend",
			["timer"] = true,
			["timerFlags"] = "None",
			["sparkRotationMode"] = "AUTO",
			["sparkBlendMode"] = "ADD",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["backgroundTexture"] = "Textures\\SpellActivationOverlays\\Eclipse_Sun",
			["displayStacks"] = "%p",
			["timerSize"] = 12,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["mirror"] = false,
			["border"] = false,
			["borderEdge"] = "None",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["borderSize"] = 16,
			["timerColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon_side"] = "LEFT",
			["user_y"] = 0,
			["displayTextLeft"] = "%n",
			["sparkHeight"] = 30,
			["foregroundColor"] = {
				1, -- [1]
				0.215686274509804, -- [2]
				0.109803921568628, -- [3]
				1, -- [4]
			},
			["stacksContainment"] = "INSIDE",
			["stacksColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayTextRight"] = "%p",
			["spark"] = false,
			["additional_triggers"] = {
			},
			["sparkWidth"] = 10,
			["frameStrata"] = 1,
			["width"] = 350,
			["borderColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["progressPrecision"] = 0,
			["inverse"] = false,
			["sparkDesature"] = false,
			["orientation"] = "HORIZONTAL",
			["crop_x"] = 0.41,
			["cooldown"] = false,
			["parent"] = "Warrior - Arms",
		},
		["Avatar CD"] = {
			["xOffset"] = -45,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["spellName"] = 107574,
				["use_spellName"] = true,
				["custom_hide"] = "timed",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_never"] = false,
				["talent"] = 16,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["stacksPoint"] = "BOTTOMRIGHT",
			["stacksContainment"] = "OUTSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["id"] = "Avatar CD",
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["custom_hide"] = "timed",
						["inverse"] = true,
						["unit"] = "player",
						["names"] = {
							"Avatar", -- [1]
						},
						["use_unit"] = true,
						["unevent"] = "auto",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["untrigger"] = {
				["spellName"] = 107574,
			},
			["frameStrata"] = 1,
			["width"] = 40,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["inverse"] = true,
			["numTriggers"] = 2,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["stickyDuration"] = false,
			["selfPoint"] = "CENTER",
			["cooldown"] = true,
			["textColor"] = {
				1, -- [1]
				0, -- [2]
				0.8, -- [3]
				1, -- [4]
			},
		},
		["I Shout CD"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.350000023841858, -- [4]
			},
			["untrigger"] = {
				["spellName"] = 5246,
			},
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["names"] = {
					"Charge", -- [1]
				},
				["custom_hide"] = "timed",
				["use_spellName"] = true,
				["use_unit"] = true,
				["spellName"] = 5246,
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_level"] = false,
				["use_spec"] = true,
				["use_never"] = false,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["stacksPoint"] = "BOTTOM",
			["stacksContainment"] = "OUTSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["additional_triggers"] = {
			},
			["id"] = "I Shout CD",
			["frameStrata"] = 1,
			["width"] = 40,
			["yOffset"] = -65,
			["inverse"] = true,
			["numTriggers"] = 1,
			["xOffset"] = 150,
			["stickyDuration"] = false,
			["selfPoint"] = "CENTER",
			["cooldown"] = true,
			["textColor"] = {
				1, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["Runic Power"] = {
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["controlledChildren"] = {
				"Runic Power Text", -- [1]
				"Runic Power Aura", -- [2]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = 0,
			["border"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["borderSize"] = 16,
			["borderColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["expanded"] = false,
			["borderOffset"] = 5,
			["selfPoint"] = "BOTTOMLEFT",
			["additional_triggers"] = {
			},
			["regionType"] = "group",
			["frameStrata"] = 1,
			["untrigger"] = {
			},
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["borderInset"] = 11,
			["numTriggers"] = 1,
			["trigger"] = {
				["type"] = "aura",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["debuffType"] = "HELPFUL",
				["names"] = {
				},
				["event"] = "Health",
				["subeventPrefix"] = "SPELL",
			},
			["borderEdge"] = "None",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["id"] = "Runic Power",
		},
		["Rallying Cry"] = {
			["xOffset"] = 0,
			["untrigger"] = {
				["spellName"] = 97462,
			},
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["use_inverse"] = true,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["custom_hide"] = "timed",
				["use_spellName"] = true,
				["spellName"] = 97462,
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%s",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["cooldown"] = false,
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["id"] = "Rallying Cry",
			["yOffset"] = -65,
			["frameStrata"] = 1,
			["width"] = 40,
			["stickyDuration"] = false,
			["numTriggers"] = 1,
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["additional_triggers"] = {
			},
			["selfPoint"] = "CENTER",
			["stacksPoint"] = "BOTTOMRIGHT",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["BoneShield"] = {
			["xOffset"] = -0.0003662109375,
			["yOffset"] = 160,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["unit"] = "player",
				["type"] = "aura",
				["inverse"] = true,
				["subeventSuffix"] = "_CAST_START",
				["debuffType"] = "HELPFUL",
				["names"] = {
					"Bone Shield", -- [1]
				},
				["event"] = "Health",
				["subeventPrefix"] = "SPELL",
			},
			["desaturate"] = false,
			["font"] = "Friz Quadrata TT",
			["height"] = 64,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
					},
				},
				["use_combat"] = true,
				["class"] = {
					["single"] = "DEATHKNIGHT",
					["multi"] = {
						["DEATHKNIGHT"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 12,
			["displayStacks"] = "%s",
			["regionType"] = "icon",
			["parent"] = "DK - Blood",
			["color"] = {
				1, -- [1]
				0, -- [2]
				0.0431372549019608, -- [3]
				1, -- [4]
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["additional_triggers"] = {
				{
					["trigger"] = {
						["charges_operator"] = "<=",
						["type"] = "status",
						["unevent"] = "auto",
						["use_charges"] = true,
						["event"] = "Action Usable",
						["subeventPrefix"] = "SPELL",
						["use_spellName"] = true,
						["charges"] = "1",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["spellName"] = 49222,
					},
					["untrigger"] = {
						["spellName"] = 49222,
						["use_spellName"] = true,
					},
				}, -- [1]
			},
			["id"] = "BoneShield",
			["stickyDuration"] = false,
			["frameStrata"] = 1,
			["width"] = 64,
			["selfPoint"] = "CENTER",
			["inverse"] = false,
			["numTriggers"] = 2,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["untrigger"] = {
			},
			["displayIcon"] = "INTERFACE\\ICONS\\ability_deathknight_boneshield",
			["stacksPoint"] = "CENTER",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Heroic Leap CD 2"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["use_matchedRune"] = true,
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["custom_hide"] = "timed",
				["use_spellName"] = true,
				["spellName"] = 6544,
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["use_talent"] = false,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
						[3] = true,
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
						["WARRIOR"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 14,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["stacksPoint"] = "BOTTOMRIGHT",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["id"] = "Heroic Leap CD 2",
			["selfPoint"] = "CENTER",
			["frameStrata"] = 1,
			["width"] = 40,
			["untrigger"] = {
				["spellName"] = 6544,
			},
			["numTriggers"] = 1,
			["inverse"] = true,
			["xOffset"] = 135,
			["additional_triggers"] = {
			},
			["stickyDuration"] = false,
			["cooldown"] = true,
			["textColor"] = {
				1, -- [1]
				0, -- [2]
				0.780392156862745, -- [3]
				1, -- [4]
			},
		},
		["Rallying Cry Aura"] = {
			["xOffset"] = 0,
			["yOffset"] = -65,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["actions"] = {
				["start"] = {
					["message_type"] = "YELL",
					["do_message"] = false,
					["do_sound"] = false,
				},
				["finish"] = {
					["sound"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Sounds\\chant2.ogg",
					["do_sound"] = false,
				},
			},
			["fontFlags"] = "OUTLINE",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["preset"] = "alphaPulse",
					["type"] = "preset",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["itemName"] = 0,
				["unevent"] = "auto",
				["spellName"] = 1719,
				["event"] = "Cooldown Progress (Spell)",
				["use_itemName"] = true,
				["subeventPrefix"] = "SPELL",
				["custom_hide"] = "timed",
				["use_spellName"] = true,
				["names"] = {
					"Rallying Cry", -- [1]
				},
				["type"] = "aura",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["use_unit"] = true,
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "ElvUI Alt-Font",
			["height"] = 40,
			["load"] = {
				["use_level"] = false,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["level_operator"] = ">=",
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
					},
				},
				["level"] = "85",
				["use_never"] = false,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 16,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "Warrior - Arms",
			["cooldown"] = true,
			["icon"] = true,
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["id"] = "Rallying Cry Aura",
			["additional_triggers"] = {
			},
			["selfPoint"] = "CENTER",
			["frameStrata"] = 1,
			["width"] = 40,
			["numTriggers"] = 1,
			["untrigger"] = {
				["spellName"] = 1719,
			},
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["stickyDuration"] = false,
			["displayIcon"] = "Interface\\Icons\\Spell_Nature_WispSplode",
			["stacksPoint"] = "CENTER",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["HPd"] = {
			["xOffset"] = -56,
			["mirror"] = false,
			["yOffset"] = 34,
			["regionType"] = "texture",
			["blendMode"] = "ADD",
			["untrigger"] = {
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.75, -- [4]
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["texture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura75",
			["anchorPoint"] = "CENTER",
			["selfPoint"] = "CENTER",
			["id"] = "HPd",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "status",
				["power"] = "0",
				["power_operator"] = ">=",
				["use_power"] = true,
				["event"] = "Holy Power",
				["use_unit"] = true,
				["debuffType"] = "HELPFUL",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["unevent"] = "auto",
				["names"] = {
				},
				["subeventPrefix"] = "SPELL",
				["custom_hide"] = "timed",
			},
			["rotation"] = 0,
			["frameStrata"] = 1,
			["width"] = 75.0003356933594,
			["discrete_rotation"] = 0,
			["desaturate"] = false,
			["numTriggers"] = 1,
			["additional_triggers"] = {
			},
			["height"] = 120,
			["rotate"] = true,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = false,
				["use_combat"] = true,
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						[2] = true,
						[3] = true,
					},
				},
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "v0.91 Prot Pala Group",
		},
		["Irupt"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["fontSize"] = 16,
			["displayStacks"] = "%s",
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "Warrior - Arms",
			["xOffset"] = 50,
			["anchorPoint"] = "CENTER",
			["yOffset"] = -65,
			["regionType"] = "icon",
			["icon"] = true,
			["numTriggers"] = 1,
			["selfPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["desaturate"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["fontFlags"] = "OUTLINE",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["additional_triggers"] = {
			},
			["width"] = 40,
			["frameStrata"] = 1,
			["stickyDuration"] = false,
			["id"] = "Irupt",
			["font"] = "ElvUI Alt-Font",
			["inverse"] = false,
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["use_inverse"] = true,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["spellName"] = 6552,
				["use_spellName"] = true,
				["custom_hide"] = "timed",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["debuffType"] = "HELPFUL",
			},
			["height"] = 40,
			["untrigger"] = {
				["spellName"] = 6552,
			},
			["stacksPoint"] = "BOTTOMRIGHT",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["ScentOfBlood-GT-Stacks"] = {
			["fontSize"] = 24,
			["displayStacks"] = "%s",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["parent"] = "GRP-ScentOfBlood",
			["stacksPoint"] = "CENTER",
			["regionType"] = "icon",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["xOffset"] = -130,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["preset"] = "spiralandpulse",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["numTriggers"] = 1,
			["customTextUpdate"] = "update",
			["id"] = "ScentOfBlood-GT-Stacks",
			["icon"] = true,
			["fontFlags"] = "None",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["selfPoint"] = "CENTER",
			["trigger"] = {
				["type"] = "aura",
				["subeventSuffix"] = "_CAST_START",
				["event"] = "Health",
				["unit"] = "player",
				["useCount"] = true,
				["count"] = "4",
				["custom_hide"] = "timed",
				["countOperator"] = ">=",
				["subeventPrefix"] = "SPELL",
				["names"] = {
					"Scent of Blood", -- [1]
				},
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["frameStrata"] = 5,
			["stickyDuration"] = false,
			["width"] = 48,
			["font"] = "Friz Quadrata TT",
			["inverse"] = false,
			["actions"] = {
				["start"] = {
					["do_glow"] = true,
					["glow_action"] = "show",
					["glow_frame"] = "WeakAuras:ScentOfBlood-GT-Stacks",
				},
				["finish"] = {
				},
			},
			["height"] = 48,
			["untrigger"] = {
			},
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DEATHKNIGHT",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["MS"] = {
			["parent"] = "Warrior - Arms",
			["fontSize"] = 16,
			["displayStacks"] = "%s",
			["stacksPoint"] = "BOTTOMRIGHT",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["untrigger"] = {
				["spellName"] = 12294,
			},
			["regionType"] = "icon",
			["trigger"] = {
				["type"] = "status",
				["unevent"] = "auto",
				["use_inverse"] = true,
				["event"] = "Cooldown Progress (Spell)",
				["names"] = {
					"Charge", -- [1]
				},
				["spellName"] = 12294,
				["use_spellName"] = true,
				["use_unit"] = true,
				["custom_hide"] = "timed",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["numTriggers"] = 1,
			["selfPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["additional_triggers"] = {
			},
			["icon"] = true,
			["fontFlags"] = "OUTLINE",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["id"] = "MS",
			["stickyDuration"] = false,
			["frameStrata"] = 1,
			["desaturate"] = false,
			["width"] = 40,
			["font"] = "ElvUI Alt-Font",
			["inverse"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["height"] = 40,
			["xOffset"] = -135,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_level"] = false,
				["use_spec"] = true,
				["use_never"] = false,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["textColor"] = {
				1, -- [1]
				0, -- [2]
				0.780392156862745, -- [3]
				1, -- [4]
			},
		},
		["Dancing Rune Weapon Aura"] = {
			["color"] = {
				1, -- [1]
				0.894117647058824, -- [2]
				0, -- [3]
				0.75, -- [4]
			},
			["mirror"] = false,
			["yOffset"] = -200,
			["regionType"] = "texture",
			["blendMode"] = "ADD",
			["parent"] = "Dancing Rune Weapon",
			["untrigger"] = {
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["texture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura19",
			["additional_triggers"] = {
			},
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["desaturate"] = false,
			["selfPoint"] = "CENTER",
			["trigger"] = {
				["name_operator"] = "==",
				["spellId"] = "31884",
				["subeventSuffix"] = "_CAST_START",
				["ownOnly"] = true,
				["event"] = "Health",
				["names"] = {
					"Dancing Rune Weapon", -- [1]
				},
				["use_name"] = true,
				["use_spellId"] = true,
				["name"] = "Avenging Wrath",
				["debuffType"] = "HELPFUL",
				["subeventPrefix"] = "SPELL",
				["unit"] = "player",
				["type"] = "aura",
				["custom_hide"] = "timed",
			},
			["discrete_rotation"] = 0,
			["frameStrata"] = 1,
			["width"] = 103,
			["rotation"] = 0,
			["anchorPoint"] = "CENTER",
			["numTriggers"] = 1,
			["id"] = "Dancing Rune Weapon Aura",
			["height"] = 103,
			["rotate"] = true,
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DEATHKNIGHT",
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["xOffset"] = -130,
		},
		["Resolve"] = {
			["outline"] = true,
			["fontSize"] = 14,
			["xOffset"] = -210,
			["displayText"] = "%c",
			["customText"] = "function () \n    \n    local name,_,icon,_,_,_,_,_,_,_,_,_,_,_,value=UnitBuff(\"player\", \"Resolve\")\n    \n    if not value then\n        value = 0\n    end\n    \n    if(value > 999999) then value = math.floor(value/1000000) .. \"M\" \n    elseif(value > 999) then value = math.floor(value/1000) .. \"k\" end\n    \n    \n    return( \"+\".. value..\"%%\" )\nend",
			["yOffset"] = -70,
			["regionType"] = "text",
			["customTextUpdate"] = "event",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["untrigger"] = {
			},
			["additional_triggers"] = {
			},
			["justify"] = "LEFT",
			["selfPoint"] = "CENTER",
			["id"] = "Resolve",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["frameStrata"] = 1,
			["width"] = 29.0000305175781,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["font"] = "Friz Quadrata TT",
			["numTriggers"] = 1,
			["anchorPoint"] = "CENTER",
			["height"] = 13.9999942779541,
			["trigger"] = {
				["custom_hide"] = "timed",
				["type"] = "aura",
				["names"] = {
					"Resolve", -- [1]
				},
				["subeventSuffix"] = "_CAST_START",
				["unit"] = "player",
				["debuffType"] = "HELPFUL",
				["event"] = "Health",
				["subeventPrefix"] = "SPELL",
			},
			["load"] = {
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_combat"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
						true, -- [2]
					},
				},
				["class"] = {
					["single"] = "DEATHKNIGHT",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "Resolve, Haste Text",
		},
		["Fortitude"] = {
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["controlledChildren"] = {
				"Fortitude Aura", -- [1]
				"Fortitude Timer", -- [2]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = -513.000366210938,
			["border"] = false,
			["yOffset"] = 86.9998779296875,
			["anchorPoint"] = "CENTER",
			["borderSize"] = 16,
			["borderColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["expanded"] = true,
			["borderOffset"] = 5,
			["selfPoint"] = "BOTTOMLEFT",
			["additional_triggers"] = {
			},
			["regionType"] = "group",
			["frameStrata"] = 1,
			["untrigger"] = {
			},
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["borderInset"] = 11,
			["numTriggers"] = 1,
			["trigger"] = {
				["type"] = "aura",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["debuffType"] = "HELPFUL",
				["names"] = {
				},
				["event"] = "Health",
				["subeventPrefix"] = "SPELL",
			},
			["borderEdge"] = "None",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["id"] = "Fortitude",
		},
		["v0.91 Prot Pala Group"] = {
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["controlledChildren"] = {
				"Shield of the Righteous", -- [1]
				"Bastion of Glory", -- [2]
				"Guardian of Ancient Kings", -- [3]
				"Divine Protection", -- [4]
				"Devotion Aura", -- [5]
				"Argent Defender", -- [6]
				"Avenging Wrath", -- [7]
				"HP1", -- [8]
				"HP2", -- [9]
				"HP3", -- [10]
				"HP4", -- [11]
				"HP5", -- [12]
				"HPa", -- [13]
				"HPb", -- [14]
				"HPc", -- [15]
				"HPd", -- [16]
				"HPe", -- [17]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = 110.023019008028,
			["border"] = false,
			["yOffset"] = -142.140555335843,
			["regionType"] = "group",
			["borderSize"] = 16,
			["borderColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["expanded"] = false,
			["borderOffset"] = 5,
			["selfPoint"] = "BOTTOMLEFT",
			["id"] = "v0.91 Prot Pala Group",
			["anchorPoint"] = "CENTER",
			["frameStrata"] = 1,
			["additional_triggers"] = {
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["borderInset"] = 11,
			["numTriggers"] = 1,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["type"] = "aura",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["debuffType"] = "HELPFUL",
				["names"] = {
				},
				["event"] = "Health",
				["subeventPrefix"] = "SPELL",
			},
			["borderEdge"] = "None",
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["untrigger"] = {
			},
		},
	},
	["talent_cache"] = {
		["HUNTER"] = {
			{
				["name"] = "Posthaste",
				["icon"] = "INTERFACE\\ICONS\\ability_hunter_posthaste",
			}, -- [1]
			{
				["name"] = "Narrow Escape",
				["icon"] = "Interface\\Icons\\INV_Misc_Web_01",
			}, -- [2]
			{
				["name"] = "Crouching Tiger, Hidden Chimaera",
				["icon"] = "INTERFACE\\ICONS\\ability_hunter_pet_chimera",
			}, -- [3]
			{
				["name"] = "Binding Shot",
				["icon"] = "INTERFACE\\ICONS\\spell_shaman_bindelemental",
			}, -- [4]
			{
				["name"] = "Wyvern Sting",
				["icon"] = "Interface\\Icons\\INV_Spear_02",
			}, -- [5]
			{
				["name"] = "Intimidation",
				["icon"] = "Interface\\Icons\\Ability_Devour",
			}, -- [6]
			{
				["name"] = "Exhilaration",
				["icon"] = "INTERFACE\\ICONS\\ability_hunter_onewithnature",
			}, -- [7]
			{
				["name"] = "Iron Hawk",
				["icon"] = "Interface\\Icons\\spell_hunter_aspectoftheironhawk",
			}, -- [8]
			{
				["name"] = "Spirit Bond",
				["icon"] = "Interface\\Icons\\Ability_Druid_DemoralizingRoar",
			}, -- [9]
			{
				["name"] = "Steady Focus",
				["icon"] = "Interface\\Icons\\Ability_Hunter_ImprovedSteadyShot",
			}, -- [10]
			{
				["name"] = "Dire Beast",
				["icon"] = "INTERFACE\\ICONS\\ability_hunter_sickem",
			}, -- [11]
			{
				["name"] = "Thrill of the Hunt",
				["icon"] = "Interface\\Icons\\Ability_Hunter_ThrilloftheHunt",
			}, -- [12]
			{
				["name"] = "A Murder of Crows",
				["icon"] = "Interface\\Icons\\ability_hunter_murderofcrows",
			}, -- [13]
			{
				["name"] = "Blink Strikes",
				["icon"] = "Interface\\Icons\\Spell_Arcane_Arcane04",
			}, -- [14]
			{
				["name"] = "Stampede",
				["icon"] = "INTERFACE\\ICONS\\ability_hunter_bestialdiscipline",
			}, -- [15]
			{
				["name"] = "Glaive Toss",
				["icon"] = "Interface\\Icons\\ability_glaivetoss",
			}, -- [16]
			{
				["name"] = "Powershot",
				["icon"] = "INTERFACE\\ICONS\\ability_hunter_resistanceisfutile",
			}, -- [17]
			{
				["name"] = "Barrage",
				["icon"] = "Interface\\Icons\\Ability_Hunter_RapidRegeneration",
			}, -- [18]
			{
				["name"] = "Exotic Munitions",
				["icon"] = "Interface\\Icons\\inv_ammo_bullet_07",
			}, -- [19]
			{
				["name"] = "Focusing Shot",
				["icon"] = "Interface\\Icons\\spell_hunter_focusingshot",
			}, -- [20]
			{
				["name"] = "Adaptation",
				["icon"] = "Interface\\Icons\\spell_hunter_adaptation",
			}, -- [21]
		},
		["WARRIOR"] = {
			{
				["name"] = "Juggernaut",
				["icon"] = "Interface\\Icons\\Ability_Warrior_BullRush",
			}, -- [1]
			{
				["name"] = "Double Time",
				["icon"] = "Interface\\Icons\\INV_Misc_Horn_04",
			}, -- [2]
			{
				["name"] = "Warbringer",
				["icon"] = "Interface\\Icons\\Ability_Warrior_Warbringer",
			}, -- [3]
			{
				["name"] = "Enraged Regeneration",
				["icon"] = "Interface\\Icons\\Ability_Warrior_FocusedRage",
			}, -- [4]
			{
				["name"] = "Second Wind",
				["icon"] = "Interface\\Icons\\Ability_Hunter_Harass",
			}, -- [5]
			{
				["name"] = "Impending Victory",
				["icon"] = "Interface\\Icons\\spell_impending_victory",
			}, -- [6]
			{
				["name"] = "Heavy Repercussions",
				["icon"] = "Interface\\Icons\\INV_Shield_32",
			}, -- [7]
			{
				["name"] = "Sudden Death",
				["icon"] = "Interface\\Icons\\Ability_Warrior_ImprovedDisciplines",
			}, -- [8]
			{
				["name"] = "Unyielding Strikes",
				["icon"] = "Interface\\Icons\\Ability_Warrior_BloodBath",
			}, -- [9]
			{
				["name"] = "Storm Bolt",
				["icon"] = "Interface\\Icons\\warrior_talent_icon_stormbolt",
			}, -- [10]
			{
				["name"] = "Shockwave",
				["icon"] = "Interface\\Icons\\Ability_Warrior_Shockwave",
			}, -- [11]
			{
				["name"] = "Dragon Roar",
				["icon"] = "Interface\\Icons\\ability_warrior_dragonroar",
			}, -- [12]
			{
				["name"] = "Mass Spell Reflection",
				["icon"] = "Interface\\Icons\\Ability_Warrior_ShieldBreak",
			}, -- [13]
			{
				["name"] = "Safeguard",
				["icon"] = "Interface\\Icons\\Ability_Warrior_Safeguard",
			}, -- [14]
			{
				["name"] = "Vigilance",
				["icon"] = "Interface\\Icons\\Ability_Warrior_Vigilance",
			}, -- [15]
			{
				["name"] = "Avatar",
				["icon"] = "Interface\\Icons\\warrior_talent_icon_avatar",
			}, -- [16]
			{
				["name"] = "Bloodbath",
				["icon"] = "Interface\\Icons\\Ability_Warrior_BloodBath",
			}, -- [17]
			{
				["name"] = "Bladestorm",
				["icon"] = "Interface\\Icons\\Ability_Warrior_Bladestorm",
			}, -- [18]
			{
				["name"] = "Anger Management",
				["icon"] = "Interface\\Icons\\warrior_talent_icon_angermanagement",
			}, -- [19]
			{
				["name"] = "Ravager",
				["icon"] = "Interface\\Icons\\warrior_talent_icon_ravager",
			}, -- [20]
			{
				["name"] = "Gladiator's Resolve",
				["icon"] = "Interface\\Icons\\spell_warrior_gladiatorstance",
			}, -- [21]
		},
		["ROGUE"] = {
			{
				["name"] = "Nightstalker",
				["icon"] = "Interface\\Icons\\Ability_Stealth",
			}, -- [1]
			{
				["name"] = "Subterfuge",
				["icon"] = "Interface\\Icons\\rogue_subterfuge",
			}, -- [2]
			{
				["name"] = "Shadow Focus",
				["icon"] = "Interface\\Icons\\rogue_shadowfocus",
			}, -- [3]
			{
				["name"] = "Deadly Throw",
				["icon"] = "Interface\\Icons\\INV_ThrowingKnife_06",
			}, -- [4]
			{
				["name"] = "Nerve Strike",
				["icon"] = "Interface\\Icons\\rogue_nerve _strike",
			}, -- [5]
			{
				["name"] = "Combat Readiness",
				["icon"] = "INTERFACE\\ICONS\\ability_rogue_combatreadiness",
			}, -- [6]
			{
				["name"] = "Cheat Death",
				["icon"] = "Interface\\Icons\\Ability_Rogue_CheatDeath",
			}, -- [7]
			{
				["name"] = "Leeching Poison",
				["icon"] = "Interface\\Icons\\rogue_leeching_poison",
			}, -- [8]
			{
				["name"] = "Elusiveness",
				["icon"] = "Interface\\Icons\\Ability_Rogue_TurntheTables",
			}, -- [9]
			{
				["name"] = "Cloak and Dagger",
				["icon"] = "Interface\\Icons\\Ability_Rogue_UnfairAdvantage",
			}, -- [10]
			{
				["name"] = "Shadowstep",
				["icon"] = "Interface\\Icons\\Ability_Rogue_Shadowstep",
			}, -- [11]
			{
				["name"] = "Burst of Speed",
				["icon"] = "Interface\\Icons\\rogue_burstofspeed",
			}, -- [12]
			{
				["name"] = "Prey on the Weak",
				["icon"] = "Interface\\Icons\\Ability_Rogue_PreyontheWeak",
			}, -- [13]
			{
				["name"] = "Paralytic Poison",
				["icon"] = "Interface\\Icons\\rogue_paralytic_poison",
			}, -- [14]
			{
				["name"] = "Dirty Tricks",
				["icon"] = "Interface\\Icons\\ability_rogue_dirtydeeds",
			}, -- [15]
			{
				["name"] = "Shuriken Toss",
				["icon"] = "INTERFACE\\ICONS\\inv_throwingknife_07",
			}, -- [16]
			{
				["name"] = "Marked for Death",
				["icon"] = "Interface\\Icons\\Achievement_BG_killingblow_berserker",
			}, -- [17]
			{
				["name"] = "Anticipation",
				["icon"] = "Interface\\Icons\\Ability_Rogue_SlaughterfromtheShadows",
			}, -- [18]
		},
		["MAGE"] = {
			{
				["name"] = "Evanesce",
				["icon"] = "Interface\\Icons\\Ability_Mage_NetherWindPresence",
			}, -- [1]
			{
				["name"] = "Blazing Speed",
				["icon"] = "Interface\\Icons\\Spell_Fire_BurningSpeed",
			}, -- [2]
			{
				["name"] = "Ice Floes",
				["icon"] = "Interface\\Icons\\spell_mage_iceflows",
			}, -- [3]
			{
				["name"] = "Alter Time",
				["icon"] = "Interface\\Icons\\spell_mage_altertime",
			}, -- [4]
			{
				["name"] = "Flameglow",
				["icon"] = "Interface\\Icons\\INV_Elemental_Primal_Fire",
			}, -- [5]
			{
				["name"] = "Ice Barrier",
				["icon"] = "Interface\\Icons\\Spell_Ice_Lament",
			}, -- [6]
			{
				["name"] = "Ring of Frost",
				["icon"] = "INTERFACE\\ICONS\\spell_frost_ring of frost",
			}, -- [7]
			{
				["name"] = "Ice Ward",
				["icon"] = "Interface\\Icons\\Spell_Frost_FrostWard",
			}, -- [8]
			{
				["name"] = "Frostjaw",
				["icon"] = "Interface\\Icons\\ability_mage_frostjaw",
			}, -- [9]
			{
				["name"] = "Greater Invisibility",
				["icon"] = "Interface\\Icons\\ability_mage_greaterinvisibility",
			}, -- [10]
			{
				["name"] = "Cauterize",
				["icon"] = "Interface\\Icons\\spell_fire_rune",
			}, -- [11]
			{
				["name"] = "Cold Snap",
				["icon"] = "Interface\\Icons\\Spell_Frost_WizardMark",
			}, -- [12]
			{
				["name"] = "Frost Bomb",
				["icon"] = "Interface\\Icons\\spell_mage_frostbomb",
			}, -- [13]
			{
				["name"] = "Unstable Magic",
				["icon"] = "Interface\\Icons\\spell_mage_unstablemagic",
			}, -- [14]
			{
				["name"] = "Ice Nova",
				["icon"] = "Interface\\Icons\\spell_mage_icenova",
			}, -- [15]
			{
				["name"] = "Mirror Image",
				["icon"] = "Interface\\Icons\\Spell_Magic_LesserInvisibilty",
			}, -- [16]
			{
				["name"] = "Rune of Power",
				["icon"] = "Interface\\Icons\\spell_mage_runeofpower",
			}, -- [17]
			{
				["name"] = "Incanter's Flow",
				["icon"] = "Interface\\Icons\\Ability_Mage_IncantersAbsorbtion",
			}, -- [18]
			{
				["name"] = "Thermal Void",
				["icon"] = "Interface\\Icons\\spell_mage_thermalvoid",
			}, -- [19]
			{
				["name"] = "Prismatic Crystal",
				["icon"] = "Interface\\Icons\\spell_mage_focusingcrystal",
			}, -- [20]
			{
				["name"] = "Comet Storm",
				["icon"] = "Interface\\Icons\\spell_mage_cometstorm",
			}, -- [21]
		},
		["PRIEST"] = {
			{
				["name"] = "Desperate Prayer",
				["icon"] = "Interface\\Icons\\Spell_Holy_TestOfFaith",
			}, -- [1]
			{
				["name"] = "Spectral Guise",
				["icon"] = "Interface\\Icons\\spell_priest_spectralguise",
			}, -- [2]
			{
				["name"] = "Angelic Bulwark",
				["icon"] = "Interface\\Icons\\ability_priest_angelicbulwark",
			}, -- [3]
			{
				["name"] = "Body and Soul",
				["icon"] = "Interface\\Icons\\Spell_Holy_SymbolOfHope",
			}, -- [4]
			{
				["name"] = "Angelic Feather",
				["icon"] = "Interface\\Icons\\ability_priest_angelicfeather",
			}, -- [5]
			{
				["name"] = "Phantasm",
				["icon"] = "Interface\\Icons\\ability_priest_phantasm",
			}, -- [6]
			{
				["name"] = "Surge of Light",
				["icon"] = "Interface\\Icons\\Spell_Holy_SurgeOfLight",
			}, -- [7]
			{
				["name"] = "Mindbender",
				["icon"] = "Interface\\Icons\\Spell_Shadow_SoulLeech_3",
			}, -- [8]
			{
				["name"] = "Power Word: Solace",
				["icon"] = "Interface\\Icons\\ability_priest_flashoflight",
			}, -- [9]
			{
				["name"] = "Void Tendrils",
				["icon"] = "Interface\\Icons\\spell_priest_voidtendrils",
			}, -- [10]
			{
				["name"] = "Psychic Scream",
				["icon"] = "Interface\\Icons\\Spell_Shadow_PsychicScream",
			}, -- [11]
			{
				["name"] = "Dominate Mind",
				["icon"] = "Interface\\Icons\\Spell_Shadow_ShadowWordDominate",
			}, -- [12]
			{
				["name"] = "Twist of Fate",
				["icon"] = "Interface\\Icons\\Spell_Shadow_MindTwisting",
			}, -- [13]
			{
				["name"] = "Power Infusion",
				["icon"] = "Interface\\Icons\\Spell_Holy_PowerInfusion",
			}, -- [14]
			{
				["name"] = "Divine Insight",
				["icon"] = "Interface\\Icons\\spell_priest_burningwill",
			}, -- [15]
			{
				["name"] = "Cascade",
				["icon"] = "Interface\\Icons\\ability_priest_cascade",
			}, -- [16]
			{
				["name"] = "Divine Star",
				["icon"] = "Interface\\Icons\\spell_priest_divinestar",
			}, -- [17]
			{
				["name"] = "Halo",
				["icon"] = "Interface\\Icons\\ability_priest_halo",
			}, -- [18]
			{
				["name"] = "Clarity of Purpose",
				["icon"] = "Interface\\Icons\\ability_priest_clarityofpurpose",
			}, -- [19]
			{
				["name"] = "Words of Mending",
				["icon"] = "Interface\\Icons\\ability_priest_wordsofmeaning",
			}, -- [20]
			{
				["name"] = "Saving Grace",
				["icon"] = "Interface\\Icons\\ability_priest_savinggrace",
			}, -- [21]
		},
		["WARLOCK"] = {
			{
				["name"] = "Dark Regeneration",
				["icon"] = "Interface\\Icons\\spell_warlock_darkregeneration",
			}, -- [1]
			{
				["name"] = "Soul Leech",
				["icon"] = "Interface\\Icons\\warlock_siphonlife",
			}, -- [2]
			{
				["name"] = "Harvest Life",
				["icon"] = "Interface\\Icons\\spell_warlock_harvestoflife",
			}, -- [3]
			{
				["name"] = "Demonic Breath",
				["icon"] = "Interface\\Icons\\Ability_Warlock_ShadowFlame",
			}, -- [4]
			{
				["name"] = "Mortal Coil",
				["icon"] = "Interface\\Icons\\ability_warlock_mortalcoil",
			}, -- [5]
			{
				["name"] = "Shadowfury",
				["icon"] = "Interface\\Icons\\ability_warlock_shadowfurytga",
			}, -- [6]
			{
				["name"] = "Soul Link",
				["icon"] = "Interface\\Icons\\ability_warlock_soullink",
			}, -- [7]
			{
				["name"] = "Sacrificial Pact",
				["icon"] = "Interface\\Icons\\warlock_sacrificial_pact",
			}, -- [8]
			{
				["name"] = "Dark Bargain",
				["icon"] = "Interface\\Icons\\ability_deathwing_bloodcorruption_death",
			}, -- [9]
			{
				["name"] = "Blood Horror",
				["icon"] = "Interface\\Icons\\ability_deathwing_bloodcorruption_earth",
			}, -- [10]
			{
				["name"] = "Burning Rush",
				["icon"] = "Interface\\Icons\\ability_deathwing_sealarmorbreachtga",
			}, -- [11]
			{
				["name"] = "Unbound Will",
				["icon"] = "Interface\\Icons\\warlock_spelldrain",
			}, -- [12]
			{
				["name"] = "Grimoire of Supremacy",
				["icon"] = "Interface\\Icons\\warlock_grimoireofcommand",
			}, -- [13]
			{
				["name"] = "Grimoire of Service",
				["icon"] = "Interface\\Icons\\warlock_grimoireofservice",
			}, -- [14]
			{
				["name"] = "Grimoire of Sacrifice",
				["icon"] = "Interface\\Icons\\warlock_grimoireofsacrifice",
			}, -- [15]
			{
				["name"] = "Archimonde's Darkness",
				["icon"] = "Interface\\Icons\\Achievement_Boss_Archimonde ",
			}, -- [16]
			{
				["name"] = "Kil'jaeden's Cunning",
				["icon"] = "Interface\\Icons\\Achievement_Boss_Kiljaedan",
			}, -- [17]
			{
				["name"] = "Mannoroth's Fury",
				["icon"] = "Interface\\Icons\\Achievement_Boss_Magtheridon",
			}, -- [18]
		},
		["SHAMAN"] = {
			{
				["name"] = "Nature's Guardian",
				["icon"] = "Interface\\Icons\\Spell_Nature_NatureGuardian",
			}, -- [1]
			{
				["name"] = "Stone Bulwark Totem",
				["icon"] = "Interface\\Icons\\ability_shaman_stonebulwark",
			}, -- [2]
			{
				["name"] = "Astral Shift",
				["icon"] = "Interface\\Icons\\ability_shaman_astralshift",
			}, -- [3]
			{
				["name"] = "Frozen Power",
				["icon"] = "Interface\\Icons\\Spell_Fire_BlueCano",
			}, -- [4]
			{
				["name"] = "Earthgrab Totem",
				["icon"] = "Interface\\Icons\\Spell_Nature_StrangleVines",
			}, -- [5]
			{
				["name"] = "Windwalk Totem",
				["icon"] = "Interface\\Icons\\ability_shaman_windwalktotem",
			}, -- [6]
			{
				["name"] = "Call of the Elements",
				["icon"] = "Interface\\Icons\\ability_shaman_multitotemactivation",
			}, -- [7]
			{
				["name"] = "Totemic Persistence",
				["icon"] = "Interface\\Icons\\ability_shaman_totemcooldownrefund",
			}, -- [8]
			{
				["name"] = "Totemic Projection",
				["icon"] = "Interface\\Icons\\ability_shaman_totemrelocation",
			}, -- [9]
			{
				["name"] = "Elemental Mastery",
				["icon"] = "Interface\\Icons\\Spell_Nature_WispHeal",
			}, -- [10]
			{
				["name"] = "Ancestral Swiftness",
				["icon"] = "Interface\\Icons\\Spell_Shaman_ElementalOath",
			}, -- [11]
			{
				["name"] = "Echo of the Elements",
				["icon"] = "Interface\\Icons\\ability_shaman_echooftheelements",
			}, -- [12]
			{
				["name"] = "Rushing Streams",
				["icon"] = "Interface\\Icons\\INV_Spear_04",
			}, -- [13]
			{
				["name"] = "Ancestral Guidance",
				["icon"] = "Interface\\Icons\\ability_shaman_ancestralguidance",
			}, -- [14]
			{
				["name"] = "Conductivity",
				["icon"] = "Interface\\Icons\\ability_shaman_fortifyingwaters",
			}, -- [15]
			{
				["name"] = "Unleashed Fury",
				["icon"] = "Interface\\Icons\\shaman_talent_unleashedfury",
			}, -- [16]
			{
				["name"] = "Primal Elementalist",
				["icon"] = "Interface\\Icons\\shaman_talent_primalelementalist",
			}, -- [17]
			{
				["name"] = "Elemental Blast",
				["icon"] = "Interface\\Icons\\shaman_talent_elementalblast",
			}, -- [18]
			{
				["name"] = "Elemental Fusion",
				["icon"] = "Interface\\Icons\\spell_shaman_shockinglava",
			}, -- [19]
			{
				["name"] = "Storm Elemental Totem",
				["icon"] = "Interface\\Icons\\spell_shaman_stormtotem",
			}, -- [20]
			{
				["name"] = "Liquid Magma",
				["icon"] = "Interface\\Icons\\spell_shaman_spewlava",
			}, -- [21]
		},
		["DEATHKNIGHT"] = {
			{
				["name"] = "Plaguebearer",
				["icon"] = "Interface\\Icons\\Achievement_Zone_WesternPlaguelands_01",
			}, -- [1]
			{
				["name"] = "Plague Leech",
				["icon"] = "Interface\\Icons\\Ability_Creature_Disease_02",
			}, -- [2]
			{
				["name"] = "Unholy Blight",
				["icon"] = "Interface\\Icons\\Spell_Shadow_Contagion",
			}, -- [3]
			{
				["name"] = "Lichborne",
				["icon"] = "Interface\\Icons\\Spell_Shadow_RaiseDead",
			}, -- [4]
			{
				["name"] = "Anti-Magic Zone",
				["icon"] = "Interface\\Icons\\Spell_DeathKnight_AntiMagicZone",
			}, -- [5]
			{
				["name"] = "Purgatory",
				["icon"] = "Interface\\Icons\\INV_Misc_ShadowEgg",
			}, -- [6]
			{
				["name"] = "Death's Advance",
				["icon"] = "Interface\\Icons\\Spell_Shadow_DemonicEmpathy",
			}, -- [7]
			{
				["name"] = "Chilblains",
				["icon"] = "Interface\\Icons\\Spell_Frost_Wisp",
			}, -- [8]
			{
				["name"] = "Asphyxiate",
				["icon"] = "Interface\\Icons\\ability_deathknight_asphixiate",
			}, -- [9]
			{
				["name"] = "Blood Tap",
				["icon"] = "Interface\\Icons\\Spell_DeathKnight_BloodTap",
			}, -- [10]
			{
				["name"] = "Runic Empowerment",
				["icon"] = "Interface\\Icons\\INV_Misc_Rune_10",
			}, -- [11]
			{
				["name"] = "Runic Corruption",
				["icon"] = "INTERFACE\\ICONS\\spell_shadow_rune",
			}, -- [12]
			{
				["name"] = "Death Pact",
				["icon"] = "Interface\\Icons\\Spell_Shadow_DeathPact",
			}, -- [13]
			{
				["name"] = "Death Siphon",
				["icon"] = "Interface\\Icons\\ability_deathknight_deathsiphon",
			}, -- [14]
			{
				["name"] = "Conversion",
				["icon"] = "Interface\\Icons\\ability_deathknight_deathsiphon2",
			}, -- [15]
			{
				["name"] = "Gorefiend's Grasp",
				["icon"] = "Interface\\Icons\\ability_deathknight_aoedeathgrip",
			}, -- [16]
			{
				["name"] = "Remorseless Winter",
				["icon"] = "Interface\\Icons\\ability_deathknight_remorselesswinters2",
			}, -- [17]
			{
				["name"] = "Desecrated Ground",
				["icon"] = "Interface\\Icons\\ability_deathknight_desecratedground",
			}, -- [18]
			{
				["name"] = "Necrotic Plague",
				["icon"] = "Interface\\Icons\\spell_deathknight_necroticplague",
			}, -- [19]
			{
				["name"] = "Defile",
				["icon"] = "Interface\\Icons\\spell_deathknight_defile",
			}, -- [20]
			{
				["name"] = "Breath of Sindragosa",
				["icon"] = "Interface\\Icons\\spell_deathknight_breathofsindragosa",
			}, -- [21]
		},
		["DRUID"] = {
			{
				["name"] = "Feline Swiftness",
				["icon"] = "Interface\\Icons\\spell_druid_tirelesspursuit",
			}, -- [1]
			{
				["name"] = "Displacer Beast",
				["icon"] = "Interface\\Icons\\spell_druid_displacement",
			}, -- [2]
			{
				["name"] = "Wild Charge",
				["icon"] = "Interface\\Icons\\spell_druid_wildcharge",
			}, -- [3]
			{
				["name"] = "Ysera's Gift",
				["icon"] = "Interface\\Icons\\INV_Misc_Head_Dragon_Green",
			}, -- [4]
			{
				["name"] = "Renewal",
				["icon"] = "Interface\\Icons\\Spell_Nature_NatureBlessing",
			}, -- [5]
			{
				["name"] = "Cenarion Ward",
				["icon"] = "Interface\\Icons\\Ability_Druid_NaturalPerfection",
			}, -- [6]
			{
				["name"] = "Faerie Swarm",
				["icon"] = "Interface\\Icons\\spell_druid_swarm",
			}, -- [7]
			{
				["name"] = "Mass Entanglement",
				["icon"] = "Interface\\Icons\\spell_druid_massentanglement",
			}, -- [8]
			{
				["name"] = "Typhoon",
				["icon"] = "Interface\\Icons\\Ability_Druid_Typhoon",
			}, -- [9]
			{
				["name"] = "Soul of the Forest",
				["icon"] = "Interface\\Icons\\Ability_Druid_ManaTree",
			}, -- [10]
			{
				["name"] = "Incarnation: Son of Ursoc",
				["icon"] = "Interface\\Icons\\spell_druid_incarnation",
			}, -- [11]
			{
				["name"] = "Force of Nature",
				["icon"] = "Interface\\Icons\\Ability_Druid_ForceofNature",
			}, -- [12]
			{
				["name"] = "Incapacitating Roar",
				["icon"] = "Interface\\Icons\\Ability_Druid_DemoralizingRoar",
			}, -- [13]
			{
				["name"] = "Ursol's Vortex",
				["icon"] = "Interface\\Icons\\spell_druid_ursolsvortex",
			}, -- [14]
			{
				["name"] = "Mighty Bash",
				["icon"] = "Interface\\Icons\\Ability_Druid_Bash",
			}, -- [15]
			{
				["name"] = "Heart of the Wild",
				["icon"] = "Interface\\Icons\\Spell_Holy_BlessingOfAgility",
			}, -- [16]
			{
				["name"] = "Dream of Cenarius",
				["icon"] = "Interface\\Icons\\Ability_Druid_Dreamstate",
			}, -- [17]
			{
				["name"] = "Nature's Vigil",
				["icon"] = "Interface\\Icons\\Achievement_Zone_Feralas",
			}, -- [18]
			{
				["name"] = "Guardian of Elune",
				["icon"] = "Interface\\Icons\\spell_druid_guardianofelune",
			}, -- [19]
			{
				["name"] = "Pulverize",
				["icon"] = "Interface\\Icons\\spell_druid_malfurionstenacity",
			}, -- [20]
			{
				["name"] = "Bristling Fur",
				["icon"] = "Interface\\Icons\\spell_druid_bristlingfur",
			}, -- [21]
		},
		["MONK"] = {
			{
				["name"] = "Celerity",
				["icon"] = "Interface\\Icons\\ability_monk_quipunch",
			}, -- [1]
			{
				["name"] = "Tiger's Lust",
				["icon"] = "Interface\\Icons\\ability_monk_tigerslust",
			}, -- [2]
			{
				["name"] = "Momentum",
				["icon"] = "Interface\\Icons\\ability_monk_standingkick",
			}, -- [3]
			{
				["name"] = "Chi Wave",
				["icon"] = "Interface\\Icons\\ability_monk_chiwave",
			}, -- [4]
			{
				["name"] = "Zen Sphere",
				["icon"] = "Interface\\Icons\\ability_monk_forcesphere",
			}, -- [5]
			{
				["name"] = "Chi Burst",
				["icon"] = "Interface\\Icons\\Spell_Arcane_ArcaneTorrent",
			}, -- [6]
			{
				["name"] = "Power Strikes",
				["icon"] = "Interface\\Icons\\ability_monk_powerstrikes",
			}, -- [7]
			{
				["name"] = "Ascension",
				["icon"] = "Interface\\Icons\\ability_monk_ascension",
			}, -- [8]
			{
				["name"] = "Chi Brew",
				["icon"] = "Interface\\Icons\\ability_monk_chibrew",
			}, -- [9]
			{
				["name"] = "Ring of Peace",
				["icon"] = "Interface\\Icons\\spell_monk_ringofpeace",
			}, -- [10]
			{
				["name"] = "Charging Ox Wave",
				["icon"] = "Interface\\Icons\\ability_monk_chargingoxwave",
			}, -- [11]
			{
				["name"] = "Leg Sweep",
				["icon"] = "Interface\\Icons\\ability_monk_legsweep",
			}, -- [12]
			{
				["name"] = "Healing Elixirs",
				["icon"] = "Interface\\Icons\\ability_monk_jasmineforcetea",
			}, -- [13]
			{
				["name"] = "Dampen Harm",
				["icon"] = "Interface\\Icons\\ability_monk_dampenharm",
			}, -- [14]
			{
				["name"] = "Diffuse Magic",
				["icon"] = "Interface\\Icons\\spell_monk_diffusemagic",
			}, -- [15]
			{
				["name"] = "Rushing Jade Wind",
				["icon"] = "Interface\\Icons\\ability_monk_rushingjadewind",
			}, -- [16]
			{
				["name"] = "Invoke Xuen, the White Tiger",
				["icon"] = "Interface\\Icons\\ability_monk_summontigerstatue",
			}, -- [17]
			{
				["name"] = "Chi Torpedo",
				["icon"] = "Interface\\Icons\\ability_monk_quitornado",
			}, -- [18]
		},
		["PALADIN"] = {
			{
				["name"] = "Speed of Light",
				["icon"] = "Interface\\Icons\\ability_paladin_speedoflight",
			}, -- [1]
			{
				["name"] = "Long Arm of the Law",
				["icon"] = "Interface\\Icons\\ability_paladin_longarmofthelaw",
			}, -- [2]
			{
				["name"] = "Pursuit of Justice",
				["icon"] = "Interface\\Icons\\ability_paladin_veneration",
			}, -- [3]
			{
				["name"] = "Fist of Justice",
				["icon"] = "Interface\\Icons\\Spell_Holy_FistOfJustice",
			}, -- [4]
			{
				["name"] = "Repentance",
				["icon"] = "Interface\\Icons\\Spell_Holy_PrayerOfHealing",
			}, -- [5]
			{
				["name"] = "Blinding Light",
				["icon"] = "Interface\\Icons\\ability_paladin_blindinglight",
			}, -- [6]
			{
				["name"] = "Selfless Healer",
				["icon"] = "Interface\\Icons\\Ability_Paladin_GaurdedbytheLight",
			}, -- [7]
			{
				["name"] = "Eternal Flame",
				["icon"] = "Interface\\Icons\\INV_Torch_Thrown",
			}, -- [8]
			{
				["name"] = "Sacred Shield",
				["icon"] = "Interface\\Icons\\Ability_Paladin_BlessedMending",
			}, -- [9]
			{
				["name"] = "Hand of Purity",
				["icon"] = "Interface\\Icons\\Spell_Holy_SealOfWisdom",
			}, -- [10]
			{
				["name"] = "Unbreakable Spirit",
				["icon"] = "Interface\\Icons\\spell_holy_unyieldingfaith",
			}, -- [11]
			{
				["name"] = "Clemency",
				["icon"] = "Interface\\Icons\\ability_paladin_clemency",
			}, -- [12]
			{
				["name"] = "Holy Avenger",
				["icon"] = "Interface\\Icons\\ability_paladin_holyavenger",
			}, -- [13]
			{
				["name"] = "Sanctified Wrath",
				["icon"] = "Interface\\Icons\\Ability_Paladin_SanctifiedWrath",
			}, -- [14]
			{
				["name"] = "Divine Purpose",
				["icon"] = "Interface\\Icons\\Spell_Holy_DivinePurpose",
			}, -- [15]
			{
				["name"] = "Holy Prism",
				["icon"] = "Interface\\Icons\\spell_paladin_holyprism",
			}, -- [16]
			{
				["name"] = "Light's Hammer",
				["icon"] = "Interface\\Icons\\spell_paladin_lightshammer",
			}, -- [17]
			{
				["name"] = "Execution Sentence",
				["icon"] = "Interface\\Icons\\spell_paladin_executionsentence",
			}, -- [18]
			{
				["name"] = "Empowered Seals",
				["icon"] = "Interface\\Icons\\ability_paladin_empoweredseals",
			}, -- [19]
			{
				["name"] = "Seraphim",
				["icon"] = "Interface\\Icons\\ability_paladin_seraphim",
			}, -- [20]
			{
				["name"] = "Holy Shield",
				["icon"] = "Interface\\Icons\\Spell_Holy_BlessingOfProtection",
			}, -- [21]
		},
	},
	["login_squelch_time"] = 5,
	["frame"] = {
		["xOffset"] = -363.212646484375,
		["yOffset"] = -125.31298828125,
		["height"] = 492,
		["width"] = 630.000183105469,
	},
	["tempIconCache"] = {
		["Avenging Wrath"] = "Interface\\Icons\\Spell_Holy_AvengineWrath",
		["Rune Tap"] = "Interface\\Icons\\Spell_DeathKnight_RuneTap",
		["Deadly Poison"] = "Interface\\Icons\\Ability_Rogue_DualWeild",
		["Divine Purpose"] = "Interface\\Icons\\Spell_Holy_MindVision",
		["Immolate"] = "Interface\\Icons\\Spell_Fire_Immolation",
		["Backdraft"] = "Interface\\Icons\\Ability_Warlock_Backdraft",
		["Bastion of Glory"] = "Interface\\Icons\\achievement_dungeon_ulduarraid_misc_03",
		["Slice and Dice"] = "Interface\\Icons\\Ability_Rogue_SliceDice",
		["Shadow Blades"] = "Interface\\Icons\\inv_knife_1h_grimbatolraid_d_03",
		["Divine Protection"] = "Interface\\Icons\\spell_holy_divineprotection",
		["Anticipation"] = "Interface\\Icons\\Ability_Rogue_SlaughterfromtheShadows",
		["Eternal Flame"] = "Interface\\Icons\\INV_Torch_Thrown",
		["Bone Shield"] = "INTERFACE\\ICONS\\ability_deathknight_boneshield",
		["Sacred Shield"] = "Interface\\Icons\\Ability_Paladin_BlessedMending",
		["Recuperate"] = "INTERFACE\\ICONS\\ability_rogue_recuperate",
		["Heavy Stagger"] = "INTERFACE\\ICONS\\priest_icon_chakra_red",
		["Ardent Defender"] = "Interface\\Icons\\Spell_Holy_ArdentDefender",
		["Shadow Focus"] = "Interface\\Icons\\rogue_shadowfocus",
		["Guardian of Ancient Kings"] = "Interface\\Icons\\Spell_Holy_Heroism",
		["Shuffle"] = "Interface\\Icons\\ability_monk_shuffle",
		["Dancing Rune Weapon"] = "Interface\\Icons\\INV_Sword_07",
		["Deep Insight"] = "Interface\\Icons\\INV_Bijou_Red",
		["Shield Barrier"] = "Interface\\Icons\\inv_shield_07",
		["Revealing Strike"] = "INTERFACE\\ICONS\\inv_sword_97",
		["Killing Spree"] = "Interface\\Icons\\Ability_Rogue_MurderSpree",
		["Shield Block"] = "Interface\\Icons\\Ability_Defend",
		["Shallow Insight"] = "Interface\\Icons\\INV_Bijou_Green",
		["Power Guard"] = "Interface\\Icons\\Ability_Warrior_ShieldBash",
		["Resolve"] = "Interface\\Icons\\Spell_Shadow_Charm",
		["Grand Crusader"] = "Interface\\Icons\\INV_Helmet_74",
		["Elusive Brew"] = "Interface\\Icons\\spell_brew_wheat",
		["Guard"] = "Interface\\Icons\\ability_monk_guard",
		["Curse of the Elements"] = "Interface\\Icons\\warlock_curse_shadow",
		["Blood Charge"] = "Interface\\Icons\\Spell_DeathKnight_BloodTap",
		["Devotion Aura"] = "Interface\\Icons\\Spell_Holy_AuraMastery",
		["Moderate Stagger"] = "INTERFACE\\ICONS\\priest_icon_chakra",
		["Light Stagger"] = "INTERFACE\\ICONS\\priest_icon_chakra_green",
		["Rupture"] = "Interface\\Icons\\Ability_Rogue_Rupture",
		["Moderate Insight"] = "Interface\\Icons\\INV_Bijou_Yellow",
		["Moonfire"] = "Interface\\Icons\\Spell_Nature_StarFall",
		["Tiger Power"] = "Interface\\Icons\\ability_monk_tigerpalm",
		["Adrenaline Rush"] = "Interface\\Icons\\Spell_Shadow_ShadowWordDominate",
		["Shield of the Righteous"] = "Interface\\Icons\\Ability_Paladin_ShieldofVengeance",
		["Fortitude"] = "Interface\\Icons\\INV_Stone_08",
		["Sprint"] = "Interface\\Icons\\Ability_Rogue_Sprint",
		["Evasion"] = "Interface\\Icons\\Spell_Shadow_ShadowWard",
		["Sunfire"] = "Interface\\Icons\\Ability_Mage_FireStarter",
		["Blood Shield"] = "Interface\\Icons\\Spell_DeathKnight_Butcher2",
		["Scent of Blood"] = "Interface\\Icons\\Ability_Rogue_BloodyEye",
	},
	["registered"] = {
	},
}
