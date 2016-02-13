
TellMeWhenDB = {
	["profileKeys"] = {
		["Zapunzel - Aggramar"] = "Zapunzel - Aggramar",
		["Greenthorn - Aggramar"] = "Greenthorn - Aggramar",
		["Ryjax - Aggramar"] = "Ryjax - Aggramar",
		["Kylosandrax - Aggramar"] = "Kylosandrax - Aggramar",
		["Feldspar - Aggramar"] = "Feldspar - Aggramar",
		["Stormslinger - Aggramar"] = "Stormslinger - Aggramar",
		["Ryvok - Terokkar"] = "Ryvok - Terokkar",
		["Kyloc - Aggramar"] = "Kyloc - Aggramar",
		["Banjax - Aggramar"] = "Banjax - Aggramar",
		["Kylosandrix - Aggramar"] = "Kylosandrix - Aggramar",
		["Ryvok - Aggramar"] = "Ryvok - Aggramar",
		["Bronin - Aggramar"] = "Bronin - Aggramar",
	},
	["global"] = {
		["TextLayouts"] = {
			["icon1"] = {
				{
				}, -- [1]
				{
				}, -- [2]
			},
			["bar2"] = {
				{
				}, -- [1]
				{
				}, -- [2]
			},
		},
		["HelpSettings"] = {
			["SCROLLBAR_DROPDOWN"] = false,
		},
		["AuraCache"] = {
			[164812] = 2,
			[127769] = 1,
			[166592] = 2,
			[109128] = 2,
			[81500] = 1,
			[105771] = 2,
			[128182] = 1,
			[81653] = 1,
			[20549] = 2,
			[186406] = 2,
			[11977] = 1,
		},
	},
	["Version"] = 74003,
	["profiles"] = {
		["Zapunzel - Aggramar"] = {
			["Locked"] = true,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1KhSW7m7Ksnh",
				}, -- [1]
			},
			["Version"] = 73501,
		},
		["Greenthorn - Aggramar"] = {
			["Locked"] = true,
			["Version"] = 72218,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1KlgigJpdlC2",
				}, -- [1]
			},
		},
		["Ryjax - Aggramar"] = {
			["Locked"] = true,
			["NumGroups"] = 74,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1IdaHFPrZJRS",
					["Point"] = {
						["y"] = -93.7962264677415,
						["x"] = 1.21874555744085,
					},
					["Scale"] = 1.641,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1KG1723GjGrt", -- [1]
								"TMW:icon:1KV5woo7JSQA", -- [2]
								"TMW:icon:1KSqNW046p1f", -- [3]
								"TMW:icon:1KUkPzxVFlgR", -- [4]
							},
						}, -- [1]
					},
					["Name"] = "Moonkin Starsurge",
					["Columns"] = 1,
					["Tree3"] = false,
					["Conditions"] = {
						{
							["Name"] = "Moonkin form",
							["Type"] = "STANCE",
						}, -- [1]
						["n"] = 1,
					},
					["Tree2"] = false,
					["OnlyInCombat"] = true,
				}, -- [1]
				{
					["GUID"] = "TMW:group:1IdaHFPrizI0",
					["Point"] = {
						["y"] = -92.5610054317078,
						["x"] = 30.1706184535278,
					},
					["Scale"] = 1.64,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Name"] = "Starfall",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"", -- [2]
									},
								},
							},
							["Conditions"] = {
								{
									["Type"] = "VEHICLE",
									["Level"] = 1,
								}, -- [1]
								["n"] = 1,
							},
							["Alpha"] = 0.75,
							["Icons"] = {
								"TMW:icon:1KUkO92UH0oE", -- [1]
								"TMW:icon:1KUkO92XFgKg", -- [2]
							},
						}, -- [1]
					},
					["Columns"] = 1,
					["Name"] = "Moonkin Starfall",
					["Tree2"] = false,
					["Tree3"] = false,
					["Conditions"] = {
						{
							["Name"] = "Moonkin form",
							["Type"] = "STANCE",
						}, -- [1]
						["n"] = 1,
					},
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [2]
				{
					["GUID"] = "TMW:group:1IdaHFProZlq",
					["Point"] = {
						["y"] = -92.6828621211609,
						["x"] = -81.8292594761598,
					},
					["Scale"] = 1.64,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1Kd_ogXVGzHD", -- [1]
								"TMW:icon:1IdaHFQ4CGna", -- [2]
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1Kd_ogXhQE9m", -- [1]
								"TMW:icon:1Kd_ogXbUFvG", -- [2]
							},
						}, -- [2]
					},
					["Name"] = "Moonkin Dot Meta GRP",
					["Columns"] = 2,
					["Tree3"] = false,
					["Tree2"] = false,
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [3]
				{
					["GUID"] = "TMW:group:1IdaHFPru5U0",
					["Point"] = {
						["y"] = -92.6829078975281,
						["x"] = 88.536890426184,
					},
					["Scale"] = 1.64,
					["Icons"] = {
						{
							["Enabled"] = true,
							["OnlyMine"] = true,
							["Name"] = "Barkskin; Rejuvenation; Prowl; Nature's Vigil",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1KYGy=JWopOQ", -- [1]
								"TMW:icon:1KYGy=JZc_IQ", -- [2]
								"TMW:icon:1KUxWPdZ5wIz", -- [3]
							},
							["Alpha"] = 0.75,
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Name"] = "Celestial Alignment; Incarnation: Chosen of Elune; Heart of the Wild; Mastermind; Toxic Power; Ultimate Power",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Alpha"] = 0.75,
							["Icons"] = {
								"TMW:icon:1KW3Dce9jf4R", -- [1]
								"TMW:icon:1KW3DceFXylD", -- [2]
							},
						}, -- [2]
					},
					["Name"] = "Moonkin BuffsDPS",
					["Tree3"] = false,
					["Tree2"] = false,
					["Tree4"] = false,
					["Columns"] = 2,
				}, -- [4]
				{
					["GUID"] = "TMW:group:1IdaHFPrzKLn",
					["Point"] = {
						["y"] = 84.8843528446594,
						["x"] = -79.6517871634584,
						["point"] = "RIGHT",
						["relativePoint"] = "RIGHT",
					},
					["Scale"] = 1.64,
					["Icons"] = {
						{
							["FakeHidden"] = true,
							["Type"] = "cooldown",
							["Name"] = "Nature's Vigil",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Enabled"] = true,
							["Alpha"] = 0.75,
							["GUID"] = "TMW:icon:1IdaHFPz7P_5",
						}, -- [1]
						{
							["FakeHidden"] = true,
							["Type"] = "cooldown",
							["Name"] = "Celestial Alignment",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "LEVEL",
									["Level"] = -1,
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["Alpha"] = 0.7,
							["GUID"] = "TMW:icon:1IdaHFPzFNN9",
						}, -- [2]
						{
							["FakeHidden"] = true,
							["Type"] = "cooldown",
							["Name"] = "Incarnation: Chosen of Elune",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Name"] = "Eclipse (Lunar)",
									["Level"] = 1,
									["Checked"] = true,
									["Type"] = "BUFFSTACKS",
								}, -- [1]
								{
									["Type"] = "BUFFSTACKS",
									["Checked"] = true,
									["AndOr"] = "OR",
									["Name"] = "Eclipse (Solar)",
									["Level"] = 1,
								}, -- [2]
								["n"] = 2,
							},
							["Alpha"] = 0.7,
							["GUID"] = "TMW:icon:1IdaHFPzBcrh",
						}, -- [3]
						{
							["Enabled"] = true,
							["Type"] = "item",
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["Name"] = "Force of Nature",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Stacks:Hide(0)]", -- [2]
									},
								},
							},
							["GUID"] = "TMW:icon:1IdaHFPzJ3CZ",
							["OnlyEquipped"] = true,
							["CustomTex"] = "Force of Nature",
							["OnlyInBags"] = true,
						}, -- [4]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["Alpha"] = 0.75,
							["Unit"] = "target",
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["Name"] = "Stellar Flare",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["GUID"] = "TMW:icon:1KUxWPdZ5wIz",
						}, -- [5]
						{
							["FakeHidden"] = true,
							["Type"] = "buff",
							["Name"] = "Barkskin; Rejuvenation; Prowl; Nature's Vigil; Dash; Stampeding Roar",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Enabled"] = true,
							["GUID"] = "TMW:icon:1KW3DceFXylD",
							["Alpha"] = 0.75,
							["OnlyMine"] = true,
						}, -- [6]
						{
							["FakeHidden"] = true,
							["Type"] = "buff",
							["Name"] = "Celestial Alignment; Incarnation: Chosen of Elune; Heart of the Wild; Mark of Bleeding Hollow; Mastermind; Toxic Power; Ultimate Power; Mastery; Exquisite Proficiency",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Enabled"] = true,
							["Alpha"] = 0.75,
							["GUID"] = "TMW:icon:1KW3Dce9jf4R",
						}, -- [7]
					},
					["Name"] = "Moonkin Cds",
					["Columns"] = 8,
					["Tree3"] = false,
					["Tree2"] = false,
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [5]
				{
					["GUID"] = "TMW:group:1IdaHFPs3IOS",
					["Point"] = {
						["y"] = 332.268310546875,
						["x"] = 464.365844726563,
						["point"] = "TOPLEFT",
						["relativePoint"] = "BOTTOMLEFT",
					},
					["Scale"] = 1.64,
					["Tree1"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1KRDwOcn0opH", -- [1]
								"TMW:icon:1KTxR45MVEdZ", -- [2]
								"TMW:icon:1KTxbNLN_C5N", -- [3]
								"TMW:icon:1KTxR45Rz3zZ", -- [4]
							},
						}, -- [1]
					},
					["Name"] = "Bear Left",
					["Columns"] = 1,
					["Tree2"] = false,
					["Conditions"] = {
						{
							["Name"] = "Bear Form",
							["Type"] = "STANCE",
						}, -- [1]
						["n"] = 1,
					},
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [6]
				{
					["GUID"] = "TMW:group:1IdaHFPs8lP9",
					["Point"] = {
						["y"] = 332.268310546875,
						["x"] = 676.365905761719,
						["point"] = "TOPLEFT",
						["relativePoint"] = "BOTTOMLEFT",
					},
					["Scale"] = 1.64,
					["Tree1"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["BuffOrDebuff"] = "HARMFUL",
							["StackMax"] = 2,
							["Alpha"] = 0.75,
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Name"] = "Lacerate",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Icons"] = {
								"TMW:icon:1KUx9IDMNx=1", -- [1]
								"TMW:icon:1KUx4wivcCp5", -- [2]
								"TMW:icon:1KRDpTRri_5C", -- [3]
								"TMW:icon:1KRE3y0g4sHS", -- [4]
							},
							["Events"] = {
								{
									["Type"] = "Animations",
									["Event"] = "OnShow",
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["StackMaxEnabled"] = true,
						}, -- [1]
					},
					["Name"] = "Bear Thrash",
					["Columns"] = 1,
					["Tree2"] = false,
					["Conditions"] = {
						{
							["Name"] = "Bear Form",
							["Type"] = "STANCE",
						}, -- [1]
						["n"] = 1,
					},
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [7]
				{
					["GUID"] = "TMW:group:1IdaHFPsDOY9",
					["Point"] = {
						["y"] = -119.86,
						["x"] = -15,
					},
					["Scale"] = 1.64,
					["Tree1"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1KRDmTQRg_xc", -- [1]
								"TMW:icon:1KRDmTP3eWO_", -- [2]
								"TMW:icon:1KRDmTOuXxY=", -- [3]
								"TMW:icon:1KRDmTO=9HNA", -- [4]
								"TMW:icon:1KUnrwYeMQ8T", -- [5]
								"TMW:icon:1KUnNlKA5iEi", -- [6]
							},
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [1]
						{
							["ClockGCD"] = true,
							["ShowTimer"] = true,
							["Name"] = "Mangle",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Type"] = "cooldown",
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Alpha"] = 0.75,
							["Enabled"] = true,
						}, -- [2]
					},
					["Name"] = "Bear RageMangle",
					["Columns"] = 2,
					["Tree2"] = false,
					["Conditions"] = {
						{
							["Name"] = "Bear Form",
							["Type"] = "STANCE",
						}, -- [1]
						["n"] = 1,
					},
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [8]
				{
					["GUID"] = "TMW:group:1IdaHFPsImrG",
					["Point"] = {
						["y"] = -175,
						["x"] = -75,
					},
					["Scale"] = 1.64,
					["Tree1"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["Name"] = "Savage Defense",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Alpha"] = 0.75,
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["Name"] = "Survival Instincts; Pulverize; Barkskin; Dancing Steal; Mastery; Superluminal",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Alpha"] = 0.75,
						}, -- [2]
					},
					["Name"] = "Bear Buffs",
					["Columns"] = 2,
					["Tree2"] = false,
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [9]
				{
					["GUID"] = "TMW:group:1IdaHFPsNw_b",
					["Point"] = {
						["y"] = -175,
						["x"] = 75,
					},
					["Scale"] = 1.64,
					["Tree1"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["OnlyMine"] = true,
							["Name"] = "Lacerate",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["BuffOrDebuff"] = "HARMFUL",
							["Type"] = "buff",
							["Alpha"] = 0.75,
							["Unit"] = "target",
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["Name"] = "Thrash; Weakened Blows",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["BuffOrDebuff"] = "HARMFUL",
							["Alpha"] = 0.75,
							["Unit"] = "target",
						}, -- [2]
					},
					["Name"] = "Bear Debuffs",
					["Columns"] = 2,
					["Tree2"] = false,
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [10]
				{
					["GUID"] = "TMW:group:1IdaHFPsTqJB",
					["Point"] = {
						["y"] = 0.999980085035496,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Columns"] = 1,
					["Name"] = "Heroism",
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["Name"] = "Heroism; Time Warp; Ancient Hysteria; Bloodlust",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Events"] = {
								{
									["Type"] = "Animations",
									["Animation"] = "ICONFLASH",
									["Duration"] = 0.1,
									["Event"] = "OnShow",
									["a_anim"] = 0.829999998211861,
									["b_anim"] = 0.988235294117647,
									["Period"] = 1,
									["g_anim"] = 1,
									["Infinite"] = true,
									["r_anim"] = 0.976470588235294,
								}, -- [1]
								["n"] = 1,
							},
						}, -- [1]
					},
					["OnlyInCombat"] = true,
				}, -- [11]
				{
					["GUID"] = "TMW:group:1IdaHFPsYcu_",
					["Point"] = {
						["y"] = -12,
						["x"] = 200,
					},
					["Scale"] = 1.64,
					["Columns"] = 3,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["Name"] = "ImmuneToStun; ImmuneToMagicCC; Spell Reflection",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Alpha"] = 0.65,
							["Unit"] = "target",
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["Alpha"] = 0.65,
							["Unit"] = "target",
							["Name"] = "Stunned; Incapacitated; Feared; CrowdControl; Disarmed",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Conditions"] = {
								{
									["Type"] = "MOUSEOVER",
									["Level"] = 1,
								}, -- [1]
								["n"] = 1,
							},
							["ConditionDurEnabled"] = true,
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["Alpha"] = 0.65,
							["Unit"] = "target",
							["Name"] = "Rooted; Slowed",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Conditions"] = {
								{
									["Type"] = "INSTANCE2",
									["Level"] = 1,
									["BitFlags"] = {
										[2] = true,
									},
								}, -- [1]
								["n"] = 1,
							},
							["ConditionDurEnabled"] = true,
						}, -- [3]
					},
					["Name"] = "PVPenemy",
				}, -- [12]
				{
					["GUID"] = "TMW:group:1IdaHFPseawM",
					["Point"] = {
						["y"] = -91.3414467158875,
						["x"] = -29.5609489292848,
					},
					["Scale"] = 1.64,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Events"] = {
								{
									["Type"] = "Animations",
									["Duration"] = 0.4,
									["Event"] = "OnShow",
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["Type"] = "VEHICLE",
									["Level"] = 1,
								}, -- [1]
								{
									["PrtsBefore"] = 2,
									["Type"] = "INSTANCE2",
									["Level"] = 4,
									["BitFlags"] = 24,
								}, -- [2]
								{
									["Type"] = "LEVEL",
									["Operator"] = ">=",
									["Level"] = 102,
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [3]
								{
									["Type"] = "LEVEL",
									["AndOr"] = "OR",
									["Level"] = -1,
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "PVPFLAG",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [5]
								["n"] = 5,
							},
							["Icons"] = {
								"TMW:icon:1IdaHFPzBcrh", -- [1]
								"TMW:icon:1IdaHFPzFNN9", -- [2]
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Shield Slam; Dragon Roar",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Alpha"] = 0.7,
						}, -- [2]
					},
					["Columns"] = 1,
					["Name"] = "RaidBossCDsBalance",
					["Tree2"] = false,
					["Tree3"] = false,
					["Conditions"] = {
						{
							["Name"] = "Moonkin form",
							["Type"] = "STANCE",
						}, -- [1]
						["n"] = 1,
					},
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [13]
				{
					["GUID"] = "TMW:group:1IdaHFPsjgMB",
					["Point"] = {
						["y"] = 45,
						["point"] = "BOTTOM",
						["relativePoint"] = "BOTTOM",
					},
					["Columns"] = 1,
					["Scale"] = 1,
					["Name"] = "ALL Form",
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Icons"] = {
								"TMW:icon:1IdaHFPzkAtR", -- [1]
								"TMW:icon:1IdaHFPznshL", -- [2]
								"TMW:icon:1IdaHFPzrYWp", -- [3]
								"TMW:icon:1IdaHFPzvXCl", -- [4]
								"TMW:icon:1IdaHFPz_7fi", -- [5]
								"TMW:icon:1IdaHFP=4tYv", -- [6]
							},
							["Alpha"] = 0.7,
							["ConditionDurEnabled"] = true,
							["GUID"] = "TMW:icon:1IdaHFQ2YWdn",
						}, -- [1]
					},
					["OnlyInCombat"] = true,
				}, -- [14]
				{
					["GUID"] = "TMW:group:1IdaHFPsoSxW",
					["Point"] = {
						["y"] = -166.833880094944,
						["x"] = 104.560667959129,
						["point"] = "LEFT",
						["relativePoint"] = "LEFT",
					},
					["Enabled"] = false,
					["Scale"] = 1,
					["Name"] = "ALL Forms",
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["UnAlpha"] = 0.5,
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["Name"] = "Sacred Shield",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "bar1",
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["GUID"] = "TMW:icon:1IdaHFPzkAtR",
							["Conditions"] = {
								{
									["Name"] = "Bear Form",
									["Type"] = "STANCE",
								}, -- [1]
								["n"] = 1,
							},
							["ConditionDurEnabled"] = true,
							["CustomTex"] = "5487",
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["UnAlpha"] = 0.5,
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["Name"] = "Divine Protection; Divine Shield; Devotion Aura",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "bar1",
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["GUID"] = "TMW:icon:1IdaHFPznshL",
							["Conditions"] = {
								{
									["Name"] = "Cat Form",
									["Type"] = "STANCE",
								}, -- [1]
								["n"] = 1,
							},
							["ConditionDurEnabled"] = true,
							["CustomTex"] = "768",
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["UnAlpha"] = 0.5,
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["GUID"] = "TMW:icon:1IdaHFPzrYWp",
							["Conditions"] = {
								{
									["Name"] = "Travel Form",
									["Type"] = "STANCE",
								}, -- [1]
								["n"] = 1,
							},
							["ConditionDurEnabled"] = true,
							["CustomTex"] = "783",
						}, -- [3]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["GUID"] = "TMW:icon:1IdaHFPzvXCl",
							["Conditions"] = {
								{
									["Name"] = "Moonkin Form",
									["Type"] = "STANCE",
								}, -- [1]
								["n"] = 1,
							},
							["ConditionDurEnabled"] = true,
							["CustomTex"] = "24858",
						}, -- [4]
						{
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1IdaHFPz_7fi",
							["CustomTex"] = "1066",
							["Conditions"] = {
								{
									["Name"] = "Aquatic Form",
									["Type"] = "STANCE",
								}, -- [1]
								["n"] = 1,
							},
							["Alpha"] = 0.75,
							["Enabled"] = true,
						}, -- [5]
						{
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1IdaHFP=4tYv",
							["CustomTex"] = "40120",
							["Conditions"] = {
								{
									["Name"] = "Swift Flight Form",
									["Type"] = "STANCE",
								}, -- [1]
								["n"] = 1,
							},
							["Alpha"] = 0.75,
							["Enabled"] = true,
						}, -- [6]
					},
					["Columns"] = 6,
				}, -- [15]
				{
					["GUID"] = "TMW:group:1IdaHFPsv0ik",
					["Point"] = {
						["y"] = 96.1601104736328,
						["x"] = 188.725570678711,
						["point"] = "BOTTOMLEFT",
						["relativePoint"] = "BOTTOMLEFT",
					},
					["Columns"] = 1,
					["Tree2"] = false,
					["Tree1"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["UnAlpha"] = 0.7,
							["OnlyMine"] = true,
							["Name"] = "Blood Presence",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["ShowWhen"] = 1,
							["CustomTex"] = "5487",
							["Conditions"] = {
								{
									["Name"] = "Bear Form",
									["Type"] = "STANCE",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [1]
					},
					["Name"] = "Bear Tankbuff Missing",
				}, -- [16]
				{
					["GUID"] = "TMW:group:1IdaHFPszkZ4",
					["Point"] = {
						["y"] = -12,
						["x"] = -106,
					},
					["Scale"] = 1.64,
					["Tree1"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Alpha"] = 0.7,
							["CooldownCheck"] = true,
							["Name"] = "Rake",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Conditions"] = {
								{
									["Name"] = "Cat form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "STANCE",
									["Name"] = "Claws of Shirvallah",
									["AndOr"] = "OR",
								}, -- [2]
								["n"] = 2,
							},
							["Icons"] = {
								"TMW:icon:1KUyMWvNoQE0", -- [1]
								"TMW:icon:1KHeBJWt4s5l", -- [2]
								"TMW:icon:1KdrNkf1nBZc", -- [3]
								"TMW:icon:1KHeTpX=Y7Vq", -- [4]
							},
							["GUID"] = "TMW:icon:1IdaHFQ7Dszo",
						}, -- [1]
					},
					["Name"] = "Feral Rake",
					["Tree3"] = false,
					["Tree4"] = false,
					["Columns"] = 1,
				}, -- [17]
				{
					["GUID"] = "TMW:group:1IdaHFPt2brg",
					["Point"] = {
						["y"] = -130,
						["x"] = -15,
					},
					["Scale"] = 1.64,
					["Tree1"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["OnlyMine"] = true,
							["Name"] = "Killing Spree; Adrenaline Rush; Combat Readiness",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "bar1",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"", -- [2]
									},
								},
							},
							["Type"] = "meta",
							["Conditions"] = {
								{
									["Type"] = "COMBAT",
								}, -- [1]
								["n"] = 1,
							},
							["Icons"] = {
								"TMW:icon:1IdaHFP_dUCP", -- [1]
								"TMW:icon:1IdaHFP_hA0g", -- [2]
								"TMW:icon:1KG2SpAbSAZc", -- [3]
							},
							["Alpha"] = 0.7,
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Alpha"] = 0.7,
							["CooldownCheck"] = true,
							["Icons"] = {
								"TMW:icon:1IdaHFP_z8rc", -- [1]
								"TMW:icon:1IdaHFQ01QOd", -- [2]
								"TMW:icon:1KHg9aTBoszV", -- [3]
								"TMW:icon:1IdaHFQ05KNv", -- [4]
								"TMW:icon:1IdaHFQ08xUv", -- [5]
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["SourceUnit"] = "player",
							["Conditions"] = {
								{
									["Type"] = "COMBAT",
								}, -- [1]
								["n"] = 1,
							},
							["ConditionDurEnabled"] = true,
							["GUID"] = "TMW:icon:1IdaHFQ4YX9n",
						}, -- [2]
					},
					["Name"] = "Feral 5 Combo",
					["Tree3"] = false,
					["Tree4"] = false,
					["Columns"] = 2,
				}, -- [18]
				{
					["GUID"] = "TMW:group:1IdaHFPt7qjF",
					["Point"] = {
						["y"] = 122.488895123656,
						["x"] = -0.0716965114834782,
					},
					["Scale"] = 1.64,
					["Tree1"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["UnAlpha"] = 0.7,
							["Alpha"] = 0.75,
							["Unit"] = "target",
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["Name"] = "Savage Roar",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Level"] = 1,
									["Name"] = "Savage Roar",
									["Operator"] = "<=",
								}, -- [1]
								{
									["Type"] = "COMBO",
									["Level"] = 5,
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "ENERGY_ABS",
									["Level"] = 25,
									["Operator"] = ">=",
								}, -- [3]
								["n"] = 3,
							},
							["ConditionDurEnabled"] = true,
							["GUID"] = "TMW:icon:1IdaHFP_z8rc",
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["Name"] = "Rip",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "<",
									["Level"] = 7,
									["Name"] = "Rip",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "COMBO",
									["Level"] = 5,
									["Unit"] = "target",
								}, -- [2]
								{
									["PrtsBefore"] = 1,
									["Type"] = "ENERGY_ABS",
									["Level"] = 30,
									["Operator"] = ">=",
								}, -- [3]
								{
									["Type"] = "BUFFSTACKS",
									["Checked"] = true,
									["Name"] = "Omen of Clarity",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Level"] = 1,
								}, -- [4]
								["n"] = 4,
							},
							["ConditionDurEnabled"] = true,
							["GUID"] = "TMW:icon:1IdaHFQ01QOd",
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["Name"] = "Ferocious Bite",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Conditions"] = {
								{
									["Type"] = "COMBO",
									["Level"] = 5,
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "DEBUFFSTACKS",
									["Checked"] = true,
									["Level"] = 1,
									["Name"] = "Rip",
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "ENERGY_ABS",
									["Level"] = 25,
									["Operator"] = ">=",
								}, -- [3]
								["n"] = 3,
							},
							["ConditionDurEnabled"] = true,
							["GUID"] = "TMW:icon:1IdaHFQ05KNv",
						}, -- [3]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["Name"] = "Ferocious Bite",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Events"] = {
								{
									["Type"] = "Animations",
									["Event"] = "OnShow",
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "COMBO",
									["Level"] = 5,
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "DEBUFFSTACKS",
									["Checked"] = true,
									["Level"] = 1,
									["Name"] = "Rip",
									["Unit"] = "target",
								}, -- [2]
								{
									["PrtsBefore"] = 1,
									["Type"] = "ENERGY_ABS",
									["Level"] = 50,
									["Operator"] = ">=",
								}, -- [3]
								{
									["Type"] = "BUFFSTACKS",
									["Checked"] = true,
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Name"] = "Omen of Clarity",
									["Level"] = 1,
								}, -- [4]
								{
									["Type"] = "ENERGY_ABS",
									["Level"] = 25,
									["PrtsAfter"] = 3,
									["Operator"] = ">=",
								}, -- [5]
								["n"] = 5,
							},
							["ConditionDurEnabled"] = true,
							["GUID"] = "TMW:icon:1KHg9aTBoszV",
						}, -- [4]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["GUID"] = "TMW:icon:1IdaHFQ08xUv",
							["Conditions"] = {
								{
									["Type"] = "COMBO",
									["Level"] = 5,
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["ConditionDurEnabled"] = true,
							["CustomTex"] = "34071",
						}, -- [5]
						{
							["FakeHidden"] = true,
							["Type"] = "cooldown",
							["Name"] = "Lava Lash",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Alpha"] = 0.7,
							["Enabled"] = true,
						}, -- [6]
						{
							["FakeHidden"] = true,
							["Type"] = "totem",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["TotemSlots"] = 1,
							["UnAlpha"] = 0.7,
							["Enabled"] = true,
							["ShowWhen"] = 1,
						}, -- [7]
					},
					["Name"] = "Feral SetFinisher",
					["Tree3"] = false,
					["Columns"] = 5,
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [19]
				{
					["GUID"] = "TMW:group:1IdaHFPtEqnF",
					["Point"] = {
						["y"] = 103.231120598648,
						["x"] = 185.807487917566,
						["point"] = "LEFT",
						["relativePoint"] = "LEFT",
					},
					["Scale"] = 1.64,
					["Tree1"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["UnAlpha"] = 0.7,
							["Alpha"] = 0.75,
							["Unit"] = "target",
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["Name"] = "Tiger's Fury",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Conditions"] = {
								{
									["Type"] = "ENERGY",
									["Level"] = 41,
									["Operator"] = "<",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1IdaHFP_dUCP",
						}, -- [1]
						{
							["FakeHidden"] = true,
							["Type"] = "cooldown",
							["Name"] = "Berserk",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "COMBAT",
								}, -- [1]
								{
									["Type"] = "VEHICLE",
									["PrtsAfter"] = 1,
									["Level"] = 1,
								}, -- [2]
								{
									["PrtsBefore"] = 2,
									["Type"] = "INSTANCE2",
									["Level"] = 4,
									["BitFlags"] = {
										[5] = true,
									},
								}, -- [3]
								{
									["Type"] = "LEVEL",
									["Level"] = 92,
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "LEVEL",
									["AndOr"] = "OR",
									["Level"] = -1,
									["Unit"] = "target",
								}, -- [5]
								{
									["Type"] = "PVPFLAG",
									["PrtsAfter"] = 1,
									["AndOr"] = "OR",
								}, -- [6]
								["n"] = 6,
							},
							["Alpha"] = 0.75,
							["GUID"] = "TMW:icon:1IdaHFP_hA0g",
						}, -- [2]
						nil, -- [3]
						{
							["FakeHidden"] = true,
							["Type"] = "cooldown",
							["Name"] = "Nature's Vigil",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "COMBAT",
								}, -- [1]
								{
									["Type"] = "VEHICLE",
									["PrtsAfter"] = 1,
									["Level"] = 1,
								}, -- [2]
								["n"] = 2,
							},
							["Alpha"] = 0.75,
							["GUID"] = "TMW:icon:1KG2SpAYRqV9",
						}, -- [4]
						{
							["FakeHidden"] = true,
							["Type"] = "cooldown",
							["Name"] = "Incarnation: King of the Jungle",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "COMBAT",
								}, -- [1]
								{
									["Type"] = "VEHICLE",
									["PrtsAfter"] = 1,
									["Level"] = 1,
								}, -- [2]
								{
									["PrtsBefore"] = 2,
									["Type"] = "INSTANCE2",
									["Level"] = 4,
									["BitFlags"] = {
										[5] = true,
									},
								}, -- [3]
								{
									["Type"] = "LEVEL",
									["Level"] = 92,
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [4]
								{
									["Type"] = "LEVEL",
									["AndOr"] = "OR",
									["Level"] = -1,
									["Unit"] = "target",
								}, -- [5]
								{
									["Type"] = "PVPFLAG",
									["PrtsAfter"] = 1,
									["AndOr"] = "OR",
								}, -- [6]
								["n"] = 6,
							},
							["Alpha"] = 0.75,
							["GUID"] = "TMW:icon:1KG2SpAbSAZc",
						}, -- [5]
						[7] = {
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Force of Nature",
							["FakeHidden"] = true,
							["Alpha"] = 0.75,
							["GUID"] = "TMW:icon:1IdaHFP_oOEB",
						},
					},
					["Name"] = "Feral SetBossPVPcds",
					["Tree3"] = false,
					["Columns"] = 7,
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [20]
				{
					["GUID"] = "TMW:group:1IdaHFPtLhPG",
					["Point"] = {
						["y"] = -175,
						["x"] = -75,
					},
					["Scale"] = 1.64,
					["Tree1"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["Alpha"] = 0.75,
							["Unit"] = "target",
							["Name"] = "155722",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Events"] = {
								{
									["Type"] = "Animations",
									["Magnitude"] = 5,
									["Animation"] = "ICONSHAKE",
									["OnlyShown"] = true,
									["Event"] = "OnFinish",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "rake",
							["GUID"] = "TMW:icon:1IdaHFQ3dxYl",
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["Name"] = "Savage Roar",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["GUID"] = "TMW:icon:1IdaHFQ6kKJF",
							["Alpha"] = 0.75,
							["OnlyMine"] = true,
						}, -- [2]
					},
					["Name"] = "Feral BuffsCombat",
					["Tree3"] = false,
					["Tree4"] = false,
					["Columns"] = 2,
				}, -- [21]
				{
					["GUID"] = "TMW:group:1IdaHFPtQmrF",
					["Point"] = {
						["y"] = -175,
						["x"] = 75,
					},
					["Scale"] = 1.64,
					["Tree1"] = false,
					["Icons"] = {
						{
							["GUID"] = "TMW:icon:1IdaHFQ6HtmD",
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["Alpha"] = 0.75,
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Name"] = "Rip",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Enabled"] = true,
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["Name"] = "Incarnation: King of the Jungle; Tiger's Fury; Berserk; Survival Instincts; Barkskin; Agile; Mastery; Agility",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Alpha"] = 0.75,
							["GUID"] = "TMW:icon:1IdaHFQ3HEt_",
						}, -- [2]
					},
					["Name"] = "Feral BuffsCombat2",
					["Tree3"] = false,
					["Tree4"] = false,
					["Columns"] = 2,
				}, -- [22]
				{
					["GUID"] = "TMW:group:1IdaHFPtVsHs",
					["Point"] = {
						["relativeTo"] = "TMW:icon:1IdaHFQ2YWdn",
						["x"] = -31,
						["point"] = "BOTTOM",
						["relativePoint"] = "BOTTOM",
					},
					["Scale"] = 1,
					["Columns"] = 1,
					["Icons"] = {
						{
							["Enabled"] = true,
							["OnlyMine"] = true,
							["Name"] = "Prowl",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Type"] = "buff",
							["Alpha"] = 0.75,
							["ConditionDurEnabled"] = true,
							["Icons"] = {
								"TMW:icon:1IdaHFPzkAtR", -- [1]
							},
						}, -- [1]
					},
					["Name"] = "ALL Prowl",
				}, -- [23]
				{
					["GUID"] = "TMW:group:1IdaHFPtaesV",
					["Point"] = {
						["y"] = 63.1793052372376,
						["x"] = 146.131992160458,
					},
					["Scale"] = 1.64,
					["Tree1"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Alpha"] = 0.75,
							["ClockGCD"] = true,
							["Type"] = "cooldown",
							["Name"] = "Shred",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "COMBO",
									["Level"] = 5,
									["Operator"] = "<",
								}, -- [1]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1IdaHFQ7Dszo",
									["Level"] = 1,
								}, -- [2]
								{
									["Name"] = "Berserk",
									["Level"] = 1,
									["Checked"] = true,
									["Type"] = "BUFFSTACKS",
								}, -- [3]
								{
									["PrtsBefore"] = 1,
									["Type"] = "ENERGY_ABS",
									["Level"] = 20,
									["Operator"] = ">=",
								}, -- [4]
								{
									["Type"] = "BUFFSTACKS",
									["Checked"] = true,
									["Name"] = "Omen of Clarity",
									["AndOr"] = "OR",
									["PrtsAfter"] = 2,
									["Level"] = 1,
								}, -- [5]
								["n"] = 5,
							},
							["GUID"] = "TMW:icon:1KZnV3bA2mHu",
							["FakeHidden"] = true,
						}, -- [1]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Alpha"] = 0.75,
							["ClockGCD"] = true,
							["Type"] = "cooldown",
							["Name"] = "Shred",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "COMBO",
									["Level"] = 5,
									["Operator"] = "<",
								}, -- [1]
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1IdaHFQ7Dszo",
									["Level"] = 1,
								}, -- [2]
								{
									["Name"] = "Berserk",
									["Type"] = "BUFFSTACKS",
								}, -- [3]
								{
									["PrtsBefore"] = 1,
									["Type"] = "ENERGY_ABS",
									["Level"] = 40,
									["Operator"] = ">=",
								}, -- [4]
								{
									["Type"] = "BUFFSTACKS",
									["Checked"] = true,
									["Name"] = "Omen of Clarity",
									["AndOr"] = "OR",
									["PrtsAfter"] = 2,
									["Level"] = 1,
								}, -- [5]
								["n"] = 5,
							},
							["GUID"] = "TMW:icon:1IdaHFQ3uuLe",
							["FakeHidden"] = true,
						}, -- [2]
					},
					["Name"] = "Feral Shred",
					["Tree3"] = false,
					["Columns"] = 3,
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [24]
				{
					["GUID"] = "TMW:group:1IdaHFPtkgIc",
					["Point"] = {
						["y"] = 51,
						["relativeTo"] = "TMW:icon:1IdaHFQ3dxYl",
						["point"] = "TOP",
					},
					["Scale"] = 1.16682393318194,
					["Tree1"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Name"] = "Predatory Swiftness",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Icons"] = {
								"TMW:icon:1KUyRkBKki46", -- [1]
								"TMW:icon:1KUyRk9Zh5nL", -- [2]
							},
							["Alpha"] = 0.7,
							["OnlyMine"] = true,
						}, -- [1]
					},
					["Name"] = "Feral Predatory Swiftness",
					["Tree3"] = false,
					["Columns"] = 1,
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [25]
				{
					["GUID"] = "TMW:group:1IdaHFPtpO9j",
					["Point"] = {
						["y"] = -12,
						["x"] = 106,
					},
					["Scale"] = 1.64,
					["Tree1"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["Name"] = "Cat Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "STANCE",
									["Name"] = "Claws of Shirvallah",
									["AndOr"] = "OR",
								}, -- [2]
								["n"] = 2,
							},
							["Icons"] = {
								"TMW:icon:1KZnV3bA2mHu", -- [1]
								"TMW:icon:1IdaHFQ3uuLe", -- [2]
							},
						}, -- [1]
					},
					["Name"] = "Feral Shred",
					["Tree3"] = false,
					["Columns"] = 1,
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [26]
				{
					["GUID"] = "TMW:group:1IdaHFPttyaY",
					["Point"] = {
						["y"] = 34.7498766846349,
						["relativeTo"] = "TellMeWhen_Group3_Icon1",
					},
					["Scale"] = 1.3,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Alpha"] = 0.75,
							["Icons"] = {
								"TMW:icon:1KdrFg10Huye", -- [1]
								"TMW:icon:1KdrFg19MK3t", -- [2]
								"TMW:icon:1KG1a0E31jO0", -- [3]
								"TMW:icon:1KG1YCkiFCC1", -- [4]
								"TMW:icon:1Kd_sFlf0Xz5", -- [5]
								"TMW:icon:1Kd_sHkKu3xR", -- [6]
								"TMW:icon:1KGlorNKxtvK", -- [7]
								"TMW:icon:1KGlorNQXIvW", -- [8]
							},
						}, -- [1]
					},
					["Columns"] = 1,
					["Name"] = "Moonkin Dot Icon",
					["Tree2"] = false,
					["Tree3"] = false,
					["Conditions"] = {
						{
							["Name"] = "Moonkin Form",
							["Type"] = "STANCE",
						}, -- [1]
						["n"] = 1,
					},
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [27]
				{
					["GUID"] = "TMW:group:1IdaHFPu1=0T",
					["Point"] = {
						["y"] = 99.6601342864675,
						["x"] = 188.725564678326,
						["point"] = "BOTTOMLEFT",
						["relativePoint"] = "BOTTOMLEFT",
					},
					["Columns"] = 1,
					["Name"] = "Catform missing",
					["Tree3"] = false,
					["Tree1"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["OnlyMine"] = true,
							["Name"] = "Blood Presence",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Type"] = "meta",
							["UnAlpha"] = 0.4,
							["Icons"] = {
								"TMW:icon:1KXvTDJvKiGe", -- [1]
								"TMW:icon:1KXvTDJ_Z5Za", -- [2]
							},
							["Alpha"] = 0.4,
						}, -- [1]
					},
					["OnlyInCombat"] = true,
				}, -- [28]
				{
					["GUID"] = "TMW:group:1IdaHFPu6htY",
					["Point"] = {
						["y"] = 100.160237509603,
						["x"] = 189.72555654788,
						["point"] = "BOTTOMLEFT",
						["relativePoint"] = "BOTTOMLEFT",
					},
					["Columns"] = 1,
					["Tree3"] = false,
					["Tree2"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["UnAlpha"] = 0.7,
							["OnlyMine"] = true,
							["Name"] = "Blood Presence",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["ShowWhen"] = 1,
							["Conditions"] = {
								{
									["Name"] = "Moonkin Form",
									["Type"] = "STANCE",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "24858",
							["GUID"] = "TMW:icon:1IdaHFQAJ8_g",
						}, -- [1]
					},
					["Name"] = "Moonkin form missing",
				}, -- [29]
				{
					["GUID"] = "TMW:group:1IdaHFPuBGI4",
					["Point"] = {
						["y"] = 21,
						["x"] = 170,
					},
					["Scale"] = 1.64,
					["Columns"] = 1,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["Name"] = "Enraged",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Duration:TMWFormatDuration]",
									},
								},
							},
							["Events"] = {
								{
									["Type"] = "Animations",
									["Event"] = "OnShow",
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Alpha"] = 0.75,
							["Unit"] = "target",
						}, -- [1]
					},
					["Name"] = "EnrageDispell",
				}, -- [30]
				{
					["GUID"] = "TMW:group:1IdaHFPuFqjb",
					["Point"] = {
						["y"] = -36.6406602007078,
						["x"] = -1.67327004348264,
					},
					["Scale"] = 1,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["UnAlpha"] = 0.65,
							["Alpha"] = 0.7,
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Name"] = "Moonfire",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["ShowWhen"] = 1,
							["Conditions"] = {
								{
									["Type"] = "BUFFSTACKS",
									["Checked"] = true,
									["Name"] = "Eclipse (Solar)",
								}, -- [1]
								{
									["Checked"] = true,
									["Type"] = "DEBUFFSTACKS",
									["Name"] = "Sunfire",
									["Unit"] = "target",
								}, -- [2]
								["n"] = 2,
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["UnAlpha"] = 0.65,
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Name"] = "Sunfire",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["ShowWhen"] = 1,
						}, -- [2]
					},
					["Enabled"] = false,
					["Name"] = "MoonkinDots Missing",
					["SettingsPerView"] = {
						["icon"] = {
							["SpacingX"] = 50,
						},
					},
					["Tree3"] = false,
					["Conditions"] = {
						{
							["Type"] = "COMBAT",
						}, -- [1]
						{
							["Type"] = "VEHICLE",
							["Level"] = 1,
						}, -- [2]
						["n"] = 2,
					},
					["Tree2"] = false,
					["Columns"] = 2,
				}, -- [31]
				{
					["GUID"] = "TMW:group:1IdaHFPuPe0a",
					["Point"] = {
						["y"] = 51,
						["relativeTo"] = "TMW:icon:1IdaHFQ6HtmD",
						["point"] = "TOP",
					},
					["Scale"] = 1.16682393318194,
					["Tree1"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["OnlyMine"] = true,
							["Name"] = "Thrash; Lacerate",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["BuffOrDebuff"] = "HARMFUL",
							["Type"] = "buff",
							["Alpha"] = 0.7,
							["Unit"] = "target",
						}, -- [1]
					},
					["Name"] = "Tank Thrash Small",
					["Tree3"] = false,
					["Columns"] = 1,
					["Tree2"] = false,
					["OnlyInCombat"] = true,
				}, -- [32]
				{
					["GUID"] = "TMW:group:1IdaHFPuU2_c",
					["Point"] = {
						["y"] = -117.307463905778,
					},
					["Scale"] = 1.3,
					["Tree1"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["Name"] = "Clearcasting",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Alpha"] = 0.75,
							["Conditions"] = {
								{
									["Name"] = "Cat Form",
									["Type"] = "STANCE",
								}, -- [1]
								["n"] = 1,
							},
							["Icons"] = {
								"TMW:icon:1IdaHFQ62U0A", -- [1]
							},
							["CustomTex"] = "16864",
						}, -- [1]
					},
					["Name"] = "Thrash Clearcast",
					["Tree3"] = false,
					["Columns"] = 1,
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [33]
				{
					["GUID"] = "TMW:group:1IdaHFPuYdQP",
					["Point"] = {
						["y"] = 51,
						["relativeTo"] = "TMW:icon:1IdaHFQ6kKJF",
						["point"] = "TOP",
					},
					["Scale"] = 1.16682393318194,
					["Tree1"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["Alpha"] = 0.7,
							["Unit"] = "target",
							["OnlyMine"] = true,
							["Name"] = "Moonfire",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["CustomTex"] = "Moonfire",
						}, -- [1]
					},
					["Role"] = 3,
					["Name"] = "Feral Moonfire",
					["Tree3"] = false,
					["Tree4"] = false,
					["Columns"] = 1,
				}, -- [34]
				{
					["GUID"] = "TMW:group:1IdaHFPuhJzO",
					["Point"] = {
						["y"] = 133.238783997003,
						["x"] = -251.935512722354,
					},
					["Scale"] = 1.64,
					["Tree1"] = false,
					["Icons"] = {
						{
							["GUID"] = "TMW:icon:1KRDTWkOWTjs",
							["Type"] = "cooldown",
							["Alpha"] = 0.7,
							["Name"] = "Savage Defense",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "RAGE",
									["Level"] = 60,
									["Operator"] = ">=",
								}, -- [1]
								{
									["Type"] = "BUFFSTACKS",
									["Checked"] = true,
									["Name"] = "Savage Defense",
								}, -- [2]
								{
									["Type"] = "COMBAT",
								}, -- [3]
								["n"] = 3,
							},
							["ConditionDurEnabled"] = true,
							["ManaCheck"] = true,
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["Name"] = "Dream of Cenarius",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["ManaCheck"] = true,
							["ConditionDurEnabled"] = true,
							["CustomTex"] = "Healing Touch",
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["Alpha"] = 0.7,
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["Name"] = "Predatory Swiftness",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["CustomTex"] = "healing touch",
							["GUID"] = "TMW:icon:1IdaHFQ6yB05",
						}, -- [3]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["Alpha"] = 0.7,
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["Name"] = "Predatory Swiftness",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Events"] = {
								{
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
									["Duration"] = 0.4,
									["Event"] = "OnShow",
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Level"] = 2.1,
									["Name"] = "Predatory Swiftness",
									["Operator"] = "<",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "healing touch",
							["GUID"] = "TMW:icon:1IdaHFQ6uZvo",
						}, -- [4]
					},
					["Name"] = "Guardian Pred Swiftness Grp",
					["Tree3"] = false,
					["Tree2"] = false,
					["Columns"] = 5,
				}, -- [35]
				{
					["GUID"] = "TMW:group:1IdaHFPumri9",
					["Point"] = {
						["y"] = -245.600769042969,
						["x"] = -147.967590332031,
					},
					["Scale"] = 1,
					["Tree1"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Alpha"] = 0.75,
							["Name"] = "Survival Instincts",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Stacks:Hide(0)]", -- [2]
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["Type"] = "BUFFSTACKS",
									["Checked"] = true,
									["Name"] = "Survival Instincts",
								}, -- [1]
								["n"] = 1,
							},
							["ConditionDurEnabled"] = true,
							["GUID"] = "TMW:icon:1KRDmd5Agkuj",
						}, -- [1]
					},
					["Name"] = "Guardian Above Buffs Left",
					["Columns"] = 1,
					["Conditions"] = {
						{
							["Type"] = "VEHICLE",
							["Level"] = 1,
						}, -- [1]
						["n"] = 1,
					},
					["Tree2"] = false,
					["OnlyInCombat"] = true,
				}, -- [36]
				{
					["GUID"] = "TMW:group:1IdaHFPurniR",
					["Name"] = "Rake Grp",
					["Point"] = {
						["y"] = -110.73343054115,
						["x"] = -185.35583132587,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Tree4"] = false,
					["Tree3"] = false,
					["Tree1"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["CooldownCheck"] = true,
							["Name"] = "Rake",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Icons"] = {
								"TMW:icon:1IdaHFP_IFrK", -- [1]
							},
							["Conditions"] = {
								{
									["Type"] = "COMBAT",
								}, -- [1]
								{
									["Type"] = "VEHICLE",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "<",
									["Level"] = 5,
									["Name"] = "155722",
									["Unit"] = "target",
								}, -- [3]
								{
									["Operator"] = "<",
									["Level"] = 5,
									["Type"] = "COMBO",
									["Unit"] = "target",
								}, -- [4]
								["n"] = 4,
							},
							["CustomTex"] = "rake",
							["GUID"] = "TMW:icon:1KHeTpX=Y7Vq",
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Alpha"] = 0.75,
							["Icons"] = {
								"TMW:icon:1IdaHFP_IFrK", -- [1]
							},
							["FakeHidden"] = true,
							["CooldownCheck"] = true,
							["Name"] = "Rake",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["Type"] = "COMBAT",
								}, -- [1]
								{
									["Type"] = "VEHICLE",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "<",
									["Level"] = 5,
									["Name"] = "155722",
									["Unit"] = "target",
								}, -- [3]
								{
									["Operator"] = "<",
									["Level"] = 5,
									["Type"] = "COMBO",
									["Unit"] = "target",
								}, -- [4]
								{
									["PrtsBefore"] = 1,
									["Type"] = "ENERGY_ABS",
									["Level"] = 35,
									["Operator"] = ">=",
								}, -- [5]
								{
									["Name"] = "Berserk",
									["Type"] = "BUFFSTACKS",
								}, -- [6]
								{
									["Type"] = "BUFFSTACKS",
									["Checked"] = true,
									["Name"] = "Omen of Clarity",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Level"] = 1,
								}, -- [7]
								["n"] = 7,
							},
							["CustomTex"] = "rake",
							["GUID"] = "TMW:icon:1KHeBJWt4s5l",
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Alpha"] = 0.75,
							["Icons"] = {
								"TMW:icon:1IdaHFP_IFrK", -- [1]
							},
							["FakeHidden"] = true,
							["CooldownCheck"] = true,
							["Name"] = "Rake",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["Type"] = "COMBAT",
								}, -- [1]
								{
									["Type"] = "VEHICLE",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "<",
									["Level"] = 5,
									["Name"] = "155722",
									["Unit"] = "target",
								}, -- [3]
								{
									["Operator"] = "<",
									["Level"] = 5,
									["Type"] = "COMBO",
									["Unit"] = "target",
								}, -- [4]
								{
									["PrtsBefore"] = 1,
									["Type"] = "ENERGY_ABS",
									["Level"] = 18,
									["Operator"] = ">=",
								}, -- [5]
								{
									["Type"] = "BUFFSTACKS",
									["Name"] = "Berserk",
									["Level"] = 1,
								}, -- [6]
								{
									["Type"] = "BUFFSTACKS",
									["Checked"] = true,
									["Name"] = "Omen of Clarity",
									["AndOr"] = "OR",
									["PrtsAfter"] = 1,
									["Level"] = 1,
								}, -- [7]
								["n"] = 7,
							},
							["CustomTex"] = "rake",
							["GUID"] = "TMW:icon:1KdrNkf1nBZc",
						}, -- [3]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["CooldownCheck"] = true,
							["Name"] = "Rake",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Icons"] = {
								"TMW:icon:1IdaHFP_IFrK", -- [1]
							},
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "VEHICLE",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "<",
									["Level"] = 5,
									["Name"] = "Moonfire",
									["Unit"] = "target",
								}, -- [2]
								{
									["Operator"] = "<",
									["Level"] = 5,
									["Type"] = "COMBO",
									["Unit"] = "target",
								}, -- [3]
								{
									["Name"] = "Lunar Inspiration",
									["Type"] = "TALENTLEARNED",
								}, -- [4]
								{
									["Type"] = "REACT",
									["Level"] = 1,
									["Unit"] = "target",
								}, -- [5]
								{
									["PrtsBefore"] = 1,
									["Type"] = "ENERGY_ABS",
									["Level"] = 30,
									["Operator"] = ">=",
								}, -- [6]
								{
									["Type"] = "BUFFSTACKS",
									["Checked"] = true,
									["Name"] = "Omen of Clarity",
									["AndOr"] = "OR",
									["PrtsAfter"] = 2,
									["Level"] = 1,
								}, -- [7]
								["n"] = 7,
							},
							["CustomTex"] = "Moonfire",
							["GUID"] = "TMW:icon:1KUyMWvNoQE0",
						}, -- [4]
					},
					["Scale"] = 1.64,
				}, -- [37]
				{
					["GUID"] = "TMW:group:1IdaHFPuwjip",
					["Point"] = {
						["y"] = 21,
						["x"] = -170,
					},
					["Scale"] = 1.64,
					["Columns"] = 1,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["Name"] = "Curse; Poison",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["BuffOrDebuff"] = "HARMFUL",
							["Conditions"] = {
								{
									["Name"] = "Remove Corruption",
									["Type"] = "SPELLCD",
								}, -- [1]
								["n"] = 1,
							},
							["Alpha"] = 0.65,
							["Events"] = {
								{
									["Type"] = "Animations",
									["Event"] = "OnShow",
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [1]
					},
					["Name"] = "RemoveCorruption",
				}, -- [38]
				{
					["GUID"] = "TMW:group:1IdaHFPu_I7g",
					["Point"] = {
						["y"] = -165.163401652648,
						["x"] = 316.294317650556,
						["point"] = "LEFT",
						["relativePoint"] = "LEFT",
					},
					["Enabled"] = false,
					["Scale"] = 1,
					["Name"] = "FormMOVED",
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Alpha"] = 0.7,
							["Icons"] = {
								"TMW:icon:1IdaHFPzkAtR", -- [1]
								"TMW:icon:1IdaHFPznshL", -- [2]
								"TMW:icon:1IdaHFPzrYWp", -- [3]
								"TMW:icon:1IdaHFPzvXCl", -- [4]
								"TMW:icon:1IdaHFPz_7fi", -- [5]
								"TMW:icon:1IdaHFP=4tYv", -- [6]
							},
							["ConditionDurEnabled"] = true,
						}, -- [1]
					},
					["Columns"] = 1,
				}, -- [39]
				{
					["GUID"] = "TMW:group:1IdaHFPv3_=s",
					["Point"] = {
						["y"] = -220.137009489782,
						["x"] = 2.004967635169480e-005,
					},
					["Columns"] = 5,
					["Scale"] = 0.861745022652819,
					["Conditions"] = {
						{
							["Name"] = "Cat form; Claws of Shirvallah",
							["Type"] = "STANCE",
						}, -- [1]
						["n"] = 1,
					},
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"", -- [1]
									},
								},
							},
							["Conditions"] = {
								{
									["Operator"] = ">=",
									["Level"] = 1,
									["Type"] = "COMBO",
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["ShowWhen"] = 3,
							["CustomTex"] = "34071",
							["UnAlpha"] = 0,
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon2",
								},
							},
							["Conditions"] = {
								{
									["Operator"] = ">=",
									["Level"] = 2,
									["Type"] = "COMBO",
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["ShowWhen"] = 3,
							["CustomTex"] = "34071",
							["UnAlpha"] = 0,
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon2",
								},
							},
							["Conditions"] = {
								{
									["Operator"] = ">=",
									["Level"] = 3,
									["Type"] = "COMBO",
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["ShowWhen"] = 3,
							["CustomTex"] = "34071",
							["UnAlpha"] = 0,
						}, -- [3]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon2",
								},
							},
							["Conditions"] = {
								{
									["Operator"] = ">=",
									["Level"] = 4,
									["Type"] = "COMBO",
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["ShowWhen"] = 3,
							["CustomTex"] = "34071",
							["UnAlpha"] = 0,
						}, -- [4]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon2",
								},
							},
							["Conditions"] = {
								{
									["Type"] = "COMBO",
									["Level"] = 5,
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["ShowWhen"] = 3,
							["CustomTex"] = "34071",
							["UnAlpha"] = 0,
						}, -- [5]
					},
					["Name"] = "Combo Point Tracking",
				}, -- [40]
				{
					["GUID"] = "TMW:group:1IdaHFPvGlxq",
					["Columns"] = 1,
					["Tree2"] = false,
					["Tree4"] = false,
					["Tree3"] = false,
					["Name"] = "Raidflask",
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["UnAlpha"] = 0.7,
							["Alpha"] = 0.5,
							["OnlyMine"] = true,
							["Name"] = "Flask of Spring Blossoms",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Conditions"] = {
								{
									["Type"] = "INSTANCE2",
									["BitFlags"] = 258072,
								}, -- [1]
								{
									["Type"] = "GLYPH",
									["Name"] = "Glyph of Guided Stars",
									["Level"] = 1,
								}, -- [2]
								{
									["Type"] = "COMBAT",
									["Level"] = 1,
								}, -- [3]
								["n"] = 3,
							},
							["CustomTex"] = "146655",
						}, -- [1]
					},
					["Point"] = {
						["y"] = 100.578437805176,
						["x"] = 160.362854003906,
						["point"] = "BOTTOMLEFT",
						["relativePoint"] = "BOTTOMLEFT",
					},
				}, -- [41]
				{
					["GUID"] = "TMW:group:1IdaHFPvLToi",
					["Point"] = {
						["y"] = 88.8767844852844,
						["x"] = 20.2398719787598,
						["point"] = "LEFT",
						["relativePoint"] = "LEFT",
					},
					["Scale"] = 1.64,
					["Icons"] = {
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["Alpha"] = 0.65,
							["FakeHidden"] = true,
							["Name"] = "Rooted; Slowed; Dazed",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Type"] = "buff",
							["Conditions"] = {
								{
									["Type"] = "ICON",
									["Icon"] = "TMW:icon:1IdaHFQAJ8_g",
									["Level"] = 1,
								}, -- [1]
								["n"] = 1,
							},
							["ConditionDurEnabled"] = true,
							["GUID"] = "TMW:icon:1IdaHFQBXLBu",
						}, -- [1]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["Alpha"] = 0.65,
							["FakeHidden"] = true,
							["Name"] = "Disarmed; Silenced",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Type"] = "buff",
							["GUID"] = "TMW:icon:1IdaHFQBmuMM",
						}, -- [2]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["LoseControlTypes"] = {
								["SNARE"] = true,
								["DAZE"] = true,
								["ROOT"] = true,
							},
							["UnAlpha"] = 0.7,
							["Alpha"] = 0.7,
							["FakeHidden"] = true,
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Type"] = "losecontrol",
							["GUID"] = "TMW:icon:1IdaHFQBb0_k",
						}, -- [3]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["LoseControlTypes"] = {
								["DISARM"] = true,
								["INTERRUPT"] = true,
								["SILENCE"] = true,
							},
							["UnAlpha"] = 0.7,
							["Alpha"] = 0.7,
							["FakeHidden"] = true,
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Type"] = "losecontrol",
							["GUID"] = "TMW:icon:1IdaHFQBqoKG",
						}, -- [4]
					},
					["Name"] = "PVPownDebuffs",
				}, -- [42]
				{
					["View"] = "bar",
					["Point"] = {
						["y"] = 76.6953627991197,
						["x"] = 11.8321913219246,
					},
					["Scale"] = 1.25392300773555,
					["Rows"] = 4,
					["Icons"] = {
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["LoseControlTypes"] = {
								["CYCLONE"] = true,
								["POSSESS"] = true,
								["POLYMORPH"] = true,
								["FREEZE"] = true,
								["PACIFY"] = true,
								["CONFUSE"] = true,
								["INCAPACITATE"] = true,
								["SHACKLE_UNDEAD"] = true,
								["SAP"] = true,
								["SLEEP"] = true,
								["DISTRACT"] = true,
								["FEAR"] = true,
								["INVULNERABILITY"] = true,
								["STUN"] = true,
								["CHARM"] = true,
								["PACIFYSILENCE"] = true,
								["DISORIENT"] = true,
								["HORROR"] = true,
							},
							["UnAlpha"] = 0.7,
							["Alpha"] = 0.7,
							["FakeHidden"] = true,
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
								["bar"] = {
									["Texts"] = {
										"[Duration:TMWFormatDuration]", -- [1]
									},
								},
							},
							["Type"] = "losecontrol",
							["GUID"] = "TMW:icon:1IdaHFQBC27l",
						}, -- [1]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["Alpha"] = 0.65,
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["Name"] = "Stunned; Incapacitated; Feared; CrowdControl; Disarmed; Silenced",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
								["bar"] = {
									["Texts"] = {
										"[Duration:TMWFormatDuration]", -- [1]
									},
								},
							},
							["Type"] = "buff",
							["ConditionDurEnabled"] = true,
							["GUID"] = "TMW:icon:1IdaHFQBFy5M",
						}, -- [2]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["LoseControlTypes"] = {
								["DISARM"] = true,
								["INTERRUPT"] = true,
								["SILENCE"] = true,
							},
							["UnAlpha"] = 0.7,
							["Alpha"] = 0.7,
							["FakeHidden"] = true,
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
								["bar"] = {
									["Texts"] = {
										"[Duration:TMWFormatDuration]", -- [1]
									},
								},
							},
							["Type"] = "losecontrol",
							["GUID"] = "TMW:icon:1IdaHFQBJUUy",
						}, -- [3]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1IdaHFQBC27l", -- [1]
								"TMW:icon:1IdaHFQBFy5M", -- [2]
								"TMW:icon:1IdaHFQBJUUy", -- [3]
							},
						}, -- [4]
					},
					["Name"] = "LossOfControlBar",
					["SettingsPerView"] = {
						["bar"] = {
							["SizeX"] = 171.154316662745,
						},
					},
					["Columns"] = 1,
					["GUID"] = "TMW:group:1IdaHFPvRIOO",
				}, -- [43]
				{
					["GUID"] = "TMW:group:1IdaHFPvWzZ8",
					["Point"] = {
						["y"] = -12,
						["x"] = -185,
					},
					["Scale"] = 1.64,
					["Columns"] = 2,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1IdaHFQBXLBu", -- [1]
								"TMW:icon:1IdaHFQBb0_k", -- [2]
							},
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Icons"] = {
								"TMW:icon:1IdaHFQBmuMM", -- [1]
								"TMW:icon:1IdaHFQBqoKG", -- [2]
							},
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [2]
					},
					["Name"] = "LossOfControlOWN",
				}, -- [44]
				{
					["GUID"] = "TMW:group:1KG1Nn9YMOfU",
					["Point"] = {
						["y"] = -12,
						["x"] = 106,
					},
					["Scale"] = 1.64,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Alpha"] = 0.75,
							["Icons"] = {
								"TMW:icon:1KUquaY=gFzd", -- [1]
								"TMW:icon:1KG1z_pkdDAx", -- [2]
								"TMW:icon:1KYHZTlGWlYD", -- [3]
								"TMW:icon:1KG1YCkWdvdQ", -- [4]
								"TMW:icon:1KYHN8YLFCby", -- [5]
							},
						}, -- [1]
					},
					["Columns"] = 1,
					["Role"] = 1,
					["Name"] = "MoonkinWrath Euphoria",
					["Tree2"] = false,
					["Tree3"] = false,
					["Conditions"] = {
						{
							["Name"] = "Moonkin Form",
							["Type"] = "STANCE",
						}, -- [1]
						{
							["Name"] = "Euphoria",
							["Type"] = "TALENTLEARNED",
						}, -- [2]
						{
							["Name"] = "Celestial Alignment",
							["Type"] = "BUFFSTACKS",
						}, -- [3]
						["n"] = 3,
					},
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [45]
				{
					["GUID"] = "TMW:group:1KG1SmZd1GXj",
					["Point"] = {
						["y"] = 332.268310546875,
						["x"] = 464.365844726563,
						["point"] = "TOPLEFT",
						["relativePoint"] = "BOTTOMLEFT",
					},
					["Scale"] = 1.64,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Alpha"] = 0.75,
							["Icons"] = {
								"TMW:icon:1KUquaYgq7Q0", -- [1]
								"TMW:icon:1KG1=0UokAiz", -- [2]
								"TMW:icon:1KYHSxb5m537", -- [3]
								"TMW:icon:1KG1YCkcVqTA", -- [4]
								"TMW:icon:1KYHN8YQnOCG", -- [5]
							},
						}, -- [1]
					},
					["Role"] = 1,
					["Name"] = "MoonkinStarfire Euphoria",
					["Columns"] = 1,
					["Tree3"] = false,
					["Conditions"] = {
						{
							["Name"] = "Moonkin form",
							["Type"] = "STANCE",
						}, -- [1]
						{
							["Name"] = "Euphoria",
							["Type"] = "TALENTLEARNED",
						}, -- [2]
						{
							["Name"] = "Celestial Alignment",
							["Type"] = "BUFFSTACKS",
						}, -- [3]
						["n"] = 3,
					},
					["Tree2"] = false,
					["OnlyInCombat"] = true,
				}, -- [46]
				{
					["GUID"] = "TMW:group:1KG1YCkTBZIh",
					["Point"] = {
						["y"] = -42.6825272208374,
						["x"] = 20.1215801239014,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["Scale"] = 1.64,
					["Icons"] = {
						{
							["FakeHidden"] = true,
							["Type"] = "buff",
							["Name"] = "Empowered Moonkin",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Duration:TMWFormatDuration]",
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Operator"] = ">",
								}, -- [1]
								["n"] = 1,
							},
							["Alpha"] = 0.75,
							["GUID"] = "TMW:icon:1KUquaY=gFzd",
						}, -- [1]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["Type"] = "buff",
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["GUID"] = "TMW:icon:1KG1z_pkdDAx",
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Level"] = 52,
									["Operator"] = ">",
								}, -- [1]
								{
									["Type"] = "ECLIPSE_DIRECTION",
								}, -- [2]
								["n"] = 2,
							},
							["CustomTex"] = "Wrath",
							["Name"] = "Solar Empowerment",
						}, -- [2]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["Type"] = "buff",
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["GUID"] = "TMW:icon:1KYHZTlGWlYD",
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Level"] = -74,
									["Operator"] = ">",
								}, -- [1]
								{
									["Type"] = "ECLIPSE_DIRECTION",
									["Level"] = 1,
								}, -- [2]
								["n"] = 2,
							},
							["CustomTex"] = "Wrath",
							["Name"] = "Solar Empowerment",
						}, -- [3]
						{
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1KYHN8YLFCby",
							["SettingsPerView"] = {
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["CustomTex"] = "Wrath",
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Level"] = 52,
									["Operator"] = ">",
								}, -- [1]
								{
									["Type"] = "ECLIPSE_DIRECTION",
								}, -- [2]
								["n"] = 2,
							},
							["Alpha"] = 0.75,
							["Enabled"] = true,
						}, -- [4]
						{
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1KG1YCkWdvdQ",
							["SettingsPerView"] = {
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["CustomTex"] = "Wrath",
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Level"] = -74,
									["Operator"] = ">",
								}, -- [1]
								{
									["Type"] = "ECLIPSE_DIRECTION",
									["Level"] = 1,
								}, -- [2]
								["n"] = 2,
							},
							["Alpha"] = 0.75,
							["Enabled"] = true,
						}, -- [5]
						nil, -- [6]
						{
							["FakeHidden"] = true,
							["Type"] = "buff",
							["Name"] = "Empowered Moonkin",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Duration:TMWFormatDuration]",
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Operator"] = "<",
								}, -- [1]
								["n"] = 1,
							},
							["Alpha"] = 0.75,
							["GUID"] = "TMW:icon:1KUquaYgq7Q0",
						}, -- [7]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["Type"] = "buff",
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["GUID"] = "TMW:icon:1KG1=0UokAiz",
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Level"] = -74,
									["Operator"] = "<",
								}, -- [1]
								{
									["Type"] = "ECLIPSE_DIRECTION",
									["Level"] = 1,
								}, -- [2]
								["n"] = 2,
							},
							["CustomTex"] = "Starfire",
							["Name"] = "Lunar Empowerment",
						}, -- [8]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["Type"] = "buff",
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["GUID"] = "TMW:icon:1KYHSxb5m537",
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Level"] = 52,
									["Operator"] = "<",
								}, -- [1]
								{
									["Type"] = "ECLIPSE_DIRECTION",
								}, -- [2]
								["n"] = 2,
							},
							["CustomTex"] = "Starfire",
							["Name"] = "Lunar Empowerment",
						}, -- [9]
						{
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1KG1YCkcVqTA",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["CustomTex"] = "Starfire",
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Level"] = -74,
									["Operator"] = "<",
								}, -- [1]
								{
									["Type"] = "ECLIPSE_DIRECTION",
									["Level"] = 1,
								}, -- [2]
								["n"] = 2,
							},
							["Alpha"] = 0.75,
							["Enabled"] = true,
						}, -- [10]
						{
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1KYHN8YQnOCG",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["CustomTex"] = "Starfire",
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Level"] = 52,
									["Operator"] = "<",
								}, -- [1]
								{
									["Type"] = "ECLIPSE_DIRECTION",
								}, -- [2]
								["n"] = 2,
							},
							["Alpha"] = 0.75,
							["Enabled"] = true,
						}, -- [11]
					},
					["Columns"] = 12,
					["Role"] = 1,
					["Name"] = "Moonkin Eclipse Euphoria GRP",
					["Tree2"] = false,
					["Tree3"] = false,
					["Conditions"] = {
						{
							["Type"] = "VEHICLE",
							["Level"] = 1,
						}, -- [1]
						{
							["Name"] = "Euphoria",
							["Type"] = "TALENTLEARNED",
						}, -- [2]
						["n"] = 2,
					},
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [47]
				{
					["GUID"] = "TMW:group:1KGldvmI9E3o",
					["Point"] = {
						["y"] = 37.0000021338587,
						["x"] = -0.000658287962897951,
						["relativeTo"] = "TellMeWhen_Group4_Icon2",
					},
					["Scale"] = 1.12,
					["Icons"] = {
						{
							["GUID"] = "TMW:icon:1KSqNW081bHL",
							["OnlyMine"] = true,
							["Name"] = "Force of Nature",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"", -- [2]
									},
								},
							},
							["Type"] = "cooldown",
							["Enabled"] = true,
							["Alpha"] = 0.75,
							["DurationMax"] = 15,
						}, -- [1]
					},
					["SecondarySpec"] = false,
					["Columns"] = 1,
					["Role"] = 1,
					["Name"] = "MoonkinDot Empowerment",
					["Tree2"] = false,
					["Tree3"] = false,
					["Conditions"] = {
						{
							["Name"] = "Moonkin",
							["Type"] = "STANCE",
						}, -- [1]
						["n"] = 1,
					},
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [48]
				{
					["GUID"] = "TMW:group:1KRDmTQSCTFH",
					["Point"] = {
						["y"] = 133.238783997003,
						["x"] = -251.935512722354,
					},
					["Scale"] = 1.64,
					["Tree1"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["Name"] = "Savage Defense",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["Conditions"] = {
								{
									["Type"] = "RAGE",
									["Level"] = 60,
									["Operator"] = ">=",
								}, -- [1]
								{
									["Type"] = "BUFFSTACKS",
									["Checked"] = true,
									["Name"] = "Savage Defense",
								}, -- [2]
								["n"] = 2,
							},
							["ConditionDurEnabled"] = true,
							["GUID"] = "TMW:icon:1KRDmTQRg_xc",
						}, -- [1]
						{
							["GUID"] = "TMW:icon:1KRDmTOuXxY=",
							["Type"] = "buff",
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["ManaCheck"] = true,
							["Name"] = "Dream of Cenarius",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["CustomTex"] = "Healing Touch",
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 85,
									["Operator"] = "<=",
								}, -- [1]
								["n"] = 1,
							},
							["ConditionDurEnabled"] = true,
							["Enabled"] = true,
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["Name"] = "Frenzied Regeneration",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 70,
									["Operator"] = "<=",
								}, -- [1]
								{
									["Name"] = "Savage Defense",
									["Level"] = 1,
									["Checked"] = true,
									["Type"] = "BUFFSTACKS",
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 60,
									["Operator"] = ">=",
								}, -- [3]
								["n"] = 3,
							},
							["ConditionDurEnabled"] = true,
							["GUID"] = "TMW:icon:1KRDmTO=9HNA",
						}, -- [3]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["Name"] = "Frenzied Regeneration",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["Conditions"] = {
								{
									["Type"] = "HEALTH",
									["Level"] = 70,
									["Operator"] = "<=",
								}, -- [1]
								{
									["Type"] = "SPELLCD",
									["Name"] = "Savage Defense",
									["Operator"] = "~=",
								}, -- [2]
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 60,
									["Operator"] = ">=",
								}, -- [3]
								["n"] = 3,
							},
							["ConditionDurEnabled"] = true,
							["GUID"] = "TMW:icon:1KUnrwYeMQ8T",
						}, -- [4]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["Name"] = "Barkskin",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["Conditions"] = {
								{
									["Type"] = "COMBAT",
								}, -- [1]
								{
									["Type"] = "HEALTH",
									["Level"] = 95,
									["Operator"] = "<=",
								}, -- [2]
								["n"] = 2,
							},
							["ConditionDurEnabled"] = true,
							["GUID"] = "TMW:icon:1KRDmTP3eWO_",
						}, -- [5]
					},
					["Name"] = "Guardian Swiftness Grp",
					["Columns"] = 5,
					["Tree2"] = false,
					["OnlyInCombat"] = true,
				}, -- [49]
				{
					["GUID"] = "TMW:group:1KRDpTRoJIR5",
					["Point"] = {
						["y"] = 111.219618957941,
						["x"] = 194.75632077374,
					},
					["Scale"] = 1.64,
					["Tree1"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["UnAlpha"] = 0.75,
							["Alpha"] = 0.75,
							["Unit"] = "target",
							["ClockGCD"] = true,
							["OnlyMine"] = true,
							["Name"] = "Lacerate",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Stacks:Hide(0)]", -- [2]
									},
								},
							},
							["Type"] = "cooldown",
							["Conditions"] = {
								{
									["Type"] = "DEBUFFSTACKS",
									["Checked"] = true,
									["Operator"] = "<",
									["Level"] = 3,
									["Name"] = "Lacerate",
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1KRDpTRri_5C",
						}, -- [1]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Type"] = "cooldown",
							["BuffOrDebuff"] = "HARMFUL",
							["UnAlpha"] = 0.75,
							["Alpha"] = 0.75,
							["Unit"] = "target",
							["ClockGCD"] = true,
							["OnlyMine"] = true,
							["Name"] = "Lacerate",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Stacks:Hide(0)]", -- [2]
									},
								},
							},
							["Events"] = {
								{
									["Type"] = "Animations",
									["Event"] = "OnHide",
									["Animation"] = "ICONSHAKE",
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "<",
									["Level"] = 5,
									["Name"] = "Lacerate",
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1KRE3y0g4sHS",
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["UnAlpha"] = 0.75,
							["Alpha"] = 0.8,
							["Unit"] = "target",
							["FakeHidden"] = true,
							["Name"] = "Thrash",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Conditions"] = {
								{
									["Type"] = "COMBAT",
								}, -- [1]
								["n"] = 1,
							},
							["ShowWhen"] = 1,
							["GUID"] = "TMW:icon:1KRDtTVK7MBO",
						}, -- [3]
						{
							["FakeHidden"] = true,
							["Type"] = "cooldown",
							["Name"] = "Berserk",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "INSTANCE2",
									["BitFlags"] = 24,
								}, -- [1]
								{
									["Type"] = "LEVEL",
									["Operator"] = ">=",
									["Level"] = 102,
									["PrtsAfter"] = 1,
									["Unit"] = "target",
								}, -- [2]
								{
									["Type"] = "LEVEL",
									["AndOr"] = "OR",
									["Level"] = -1,
									["Unit"] = "target",
								}, -- [3]
								["n"] = 3,
							},
							["Alpha"] = 0.75,
							["GUID"] = "TMW:icon:1KUnNlKA5iEi",
						}, -- [4]
						{
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Type"] = "Animations",
									["Event"] = "OnShow",
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								{
									["Type"] = "Animations",
									["Event"] = "OnShow",
									["Animation"] = "ICONSHAKE",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1KUx4wivcCp5",
							["CustomTex"] = "Pulverize",
							["Conditions"] = {
								{
									["Type"] = "DEBUFFSTACKS",
									["Level"] = 3,
									["Name"] = "Lacerate",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Level"] = 4,
									["Name"] = "Pulverize",
									["Operator"] = "<",
								}, -- [2]
								["n"] = 2,
							},
							["Alpha"] = 0.76,
							["Enabled"] = true,
						}, -- [5]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["UnAlpha"] = 0.75,
							["Alpha"] = 0.75,
							["Unit"] = "target",
							["ClockGCD"] = true,
							["OnlyMine"] = true,
							["Name"] = "Lacerate",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Stacks:Hide(0)]", -- [2]
									},
								},
							},
							["Events"] = {
								{
									["Type"] = "Animations",
									["Event"] = "OnStack",
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["Type"] = "DEBUFFSTACKS",
									["Checked"] = true,
									["Operator"] = "<",
									["Level"] = 3,
									["Name"] = "Lacerate",
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["FakeHidden"] = true,
							["GUID"] = "TMW:icon:1KUx9IDMNx=1",
						}, -- [6]
					},
					["Name"] = "Guardian Group Right",
					["Columns"] = 6,
					["Tree2"] = false,
					["OnlyInCombat"] = true,
				}, -- [50]
				{
					["GUID"] = "TMW:group:1KRDzMig7OmG",
					["Point"] = {
						["y"] = -245.600769042969,
						["x"] = 147.97,
					},
					["Scale"] = 1,
					["Tree1"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Mighty Bash",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Alpha"] = 0.75,
						}, -- [1]
					},
					["Name"] = "Guardian Above Buffs Right",
					["Columns"] = 1,
					["Tree2"] = false,
					["OnlyInCombat"] = true,
				}, -- [51]
				{
					["GUID"] = "TMW:group:1KSoko2GvE5G",
					["Point"] = {
						["x"] = 30,
						["relativeTo"] = "TellMeWhen_Group8_Icon2",
					},
					["Scale"] = 1.64,
					["Tree1"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["UnAlpha"] = 0.75,
							["Alpha"] = 0.8,
							["Unit"] = "target",
							["Name"] = "Thrash",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["ShowWhen"] = 1,
							["Conditions"] = {
								{
									["Type"] = "COMBAT",
								}, -- [1]
								["n"] = 1,
							},
						}, -- [1]
					},
					["Name"] = "Guardian Trash dot",
					["Columns"] = 1,
					["Conditions"] = {
						{
							["Name"] = "Bear Form",
							["Type"] = "STANCE",
						}, -- [1]
						["n"] = 1,
					},
					["Tree2"] = false,
					["OnlyInCombat"] = true,
				}, -- [52]
				{
					["GUID"] = "TMW:group:1KTvp4EVZZUR",
					["Point"] = {
						["y"] = -148.170625365369,
						["x"] = 20.1217555999756,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["Scale"] = 1.64,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["UnAlpha"] = 0.75,
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["Name"] = "Celestial Alignment",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Duration:TMWFormatDuration]",
									},
								},
							},
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Level"] = 3.5,
									["Name"] = "Celestial Alignment",
									["Operator"] = "<",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "Celestial Alignment",
							["GUID"] = "TMW:icon:1KdrFg10Huye",
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["UnAlpha"] = 0.75,
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["Name"] = "Celestial Alignment",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Duration:TMWFormatDuration]",
									},
								},
							},
							["Events"] = {
								{
									["Type"] = "Animations",
									["Event"] = "OnShow",
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "Celestial Alignment",
							["GUID"] = "TMW:icon:1KdrFg19MK3t",
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["Name"] = "Lunar Peak",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "<",
									["Level"] = 20,
									["Name"] = "Moonfire",
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "15798",
							["GUID"] = "TMW:icon:1KG1a0E31jO0",
						}, -- [3]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["UnAlpha"] = 0.75,
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["Name"] = "Solar Peak",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "93402",
							["GUID"] = "TMW:icon:1KG1YCkiFCC1",
						}, -- [4]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["UnAlpha"] = 0.75,
							["Alpha"] = 0.75,
							["Unit"] = "target",
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["Name"] = "Moonfire",
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Operator"] = "<",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "<",
									["Level"] = 12,
									["Name"] = "Moonfire",
									["Unit"] = "target",
								}, -- [2]
								["n"] = 2,
							},
							["CustomTex"] = "155625",
							["GUID"] = "TMW:icon:1Kd_sFlf0Xz5",
						}, -- [5]
						{
							["GUID"] = "TMW:icon:1Kd_sHkKu3xR",
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["UnAlpha"] = 0.75,
							["Alpha"] = 0.83,
							["Unit"] = "target",
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["Name"] = "Sunfire",
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Operator"] = ">",
								}, -- [1]
								["n"] = 1,
							},
							["ShowWhen"] = 1,
							["CustomTex"] = "164815",
							["Enabled"] = true,
						}, -- [6]
						{
							["GUID"] = "TMW:icon:1KGlorNKxtvK",
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["UnAlpha"] = 0.75,
							["Alpha"] = 0.83,
							["Unit"] = "target",
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["Name"] = "Moonfire",
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Operator"] = "<",
								}, -- [1]
								["n"] = 1,
							},
							["ShowWhen"] = 1,
							["CustomTex"] = "155625",
							["Enabled"] = true,
						}, -- [7]
						{
							["GUID"] = "TMW:icon:1KGlorNQXIvW",
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["UnAlpha"] = 0.75,
							["Alpha"] = 0.83,
							["Unit"] = "target",
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["Name"] = "Sunfire",
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Operator"] = ">",
								}, -- [1]
								["n"] = 1,
							},
							["ShowWhen"] = 1,
							["CustomTex"] = "164815",
							["Enabled"] = true,
						}, -- [8]
					},
					["Name"] = "Moonkin Dots",
					["Tree3"] = false,
					["Tree2"] = false,
					["Tree4"] = false,
					["Columns"] = 10,
				}, -- [53]
				{
					["GUID"] = "TMW:group:1KTxR45DJyfH",
					["Point"] = {
						["y"] = -28.9999389648438,
						["x"] = -189.000244140625,
						["point"] = "TOP",
						["relativePoint"] = "TOP",
					},
					["Tree2"] = false,
					["Tree4"] = false,
					["Tree1"] = false,
					["Icons"] = {
						{
							["StackMin"] = 2,
							["Type"] = "buff",
							["Alpha"] = 0.8,
							["Enabled"] = true,
							["FakeHidden"] = true,
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Name"] = "Tooth and Claw",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["StackMinEnabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 80,
									["Operator"] = ">=",
								}, -- [1]
								{
									["Name"] = "Maul",
									["Type"] = "SPELLCD",
								}, -- [2]
								{
									["Type"] = "HEALTH",
									["Level"] = 90,
									["Operator"] = ">=",
								}, -- [3]
								{
									["Name"] = "Savage Defense",
									["Level"] = 1,
									["Checked"] = true,
									["Type"] = "BUFFSTACKS",
								}, -- [4]
								["n"] = 4,
							},
							["CustomTex"] = "Maul",
							["GUID"] = "TMW:icon:1KRDwOcn0opH",
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["Alpha"] = 0.8,
							["FakeHidden"] = true,
							["Name"] = "Tooth and Claw",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 45,
									["Operator"] = ">=",
								}, -- [1]
								{
									["Name"] = "Maul",
									["Type"] = "SPELLCD",
								}, -- [2]
								{
									["Type"] = "HEALTH",
									["Level"] = 90,
									["Operator"] = ">=",
								}, -- [3]
								{
									["Name"] = "Savage Defense",
									["Level"] = 1,
									["Checked"] = true,
									["Type"] = "BUFFSTACKS",
								}, -- [4]
								["n"] = 4,
							},
							["CustomTex"] = "Maul",
							["GUID"] = "TMW:icon:1KTxR45MVEdZ",
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["Alpha"] = 0.8,
							["FakeHidden"] = true,
							["Name"] = "Tooth and Claw",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 45,
									["Operator"] = ">=",
								}, -- [1]
								{
									["Name"] = "Maul",
									["Type"] = "SPELLCD",
								}, -- [2]
								{
									["Type"] = "BUFFSTACKS",
									["Checked"] = true,
									["Name"] = "Savage Defense",
								}, -- [3]
								{
									["Type"] = "SPELLCD",
									["Name"] = "Savage Defense",
									["Operator"] = "~=",
								}, -- [4]
								["n"] = 4,
							},
							["CustomTex"] = "Maul",
							["GUID"] = "TMW:icon:1KTxbNLN_C5N",
						}, -- [3]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Alpha"] = 0.8,
							["FakeHidden"] = true,
							["Name"] = "Tooth and Claw",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 80,
									["Operator"] = ">=",
								}, -- [1]
								{
									["Name"] = "Maul",
									["Type"] = "SPELLCD",
								}, -- [2]
								["n"] = 2,
							},
							["CustomTex"] = "Maul",
							["GUID"] = "TMW:icon:1KTxR45Rz3zZ",
						}, -- [4]
					},
					["Name"] = "Bear Tooth & Claw Grp",
				}, -- [54]
				{
					["GUID"] = "TMW:group:1KUkPzxGHxZD",
					["Point"] = {
						["y"] = -125.609590209119,
						["x"] = -137.683037163458,
						["point"] = "TOPRIGHT",
						["relativePoint"] = "TOPRIGHT",
					},
					["Scale"] = 1.64,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Alpha"] = 0.7,
							["FakeHidden"] = true,
							["Name"] = "Starsurge",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"", -- [2]
									},
								},
							},
							["Conditions"] = {
								{
									["PrtsBefore"] = 1,
									["Type"] = "BUFFSTACKS",
									["Name"] = "Solar Empowerment",
									["Icon"] = "TMW:icon:1KG1z_pkdDAx",
								}, -- [1]
								{
									["Type"] = "ECLIPSE",
									["Level"] = 75,
									["Operator"] = ">=",
								}, -- [2]
								{
									["Type"] = "ECLIPSE_DIRECTION",
									["PrtsAfter"] = 1,
									["Level"] = 1,
								}, -- [3]
								{
									["Type"] = "BUFFSTACKS",
									["Name"] = "Lunar Empowerment",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Icon"] = "TMW:icon:1KG1=0UokAiz",
								}, -- [4]
								{
									["Type"] = "ECLIPSE",
									["Level"] = -75,
									["Operator"] = "<=",
								}, -- [5]
								{
									["PrtsAfter"] = 1,
									["Type"] = "ECLIPSE_DIRECTION",
								}, -- [6]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "Euphoria",
									["Level"] = 1,
								}, -- [7]
								["n"] = 7,
							},
							["Events"] = {
								{
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
									["Duration"] = 0.4,
									["Event"] = "OnShow",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1KG1723GjGrt",
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Alpha"] = 0.7,
							["FakeHidden"] = true,
							["Name"] = "Starsurge",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"", -- [2]
									},
								},
							},
							["Conditions"] = {
								{
									["PrtsBefore"] = 2,
									["Type"] = "BUFFSTACKS",
									["Name"] = "Solar Empowerment",
									["Icon"] = "TMW:icon:1KG1z_pkdDAx",
								}, -- [1]
								{
									["Type"] = "ECLIPSE",
									["PrtsAfter"] = 1,
									["Operator"] = ">",
								}, -- [2]
								{
									["Type"] = "BUFFSTACKS",
									["Name"] = "Lunar Empowerment",
									["PrtsBefore"] = 1,
									["AndOr"] = "OR",
									["Icon"] = "TMW:icon:1KG1=0UokAiz",
								}, -- [3]
								{
									["Type"] = "ECLIPSE",
									["PrtsAfter"] = 1,
									["Operator"] = "<",
								}, -- [4]
								{
									["Type"] = "TALENTLEARNED",
									["PrtsAfter"] = 1,
									["Name"] = "Euphoria",
								}, -- [5]
								["n"] = 5,
							},
							["Events"] = {
								{
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
									["Duration"] = 0.4,
									["Event"] = "OnShow",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1KV5woo7JSQA",
						}, -- [2]
						{
							["FakeHidden"] = true,
							["Type"] = "cooldown",
							["Name"] = "Starsurge",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"", -- [2]
									},
								},
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "VEHICLE",
									["Level"] = 1,
								}, -- [1]
								["n"] = 1,
							},
							["Alpha"] = 0.6,
							["GUID"] = "TMW:icon:1KSqNW046p1f",
						}, -- [3]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["UnAlpha"] = 0.6,
							["Alpha"] = 0.7,
							["FakeHidden"] = true,
							["Name"] = "Starsurge",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["ShowWhen"] = 1,
							["GUID"] = "TMW:icon:1KUkPzxVFlgR",
							["Conditions"] = {
								{
									["Type"] = "VEHICLE",
									["Level"] = 1,
								}, -- [1]
								["n"] = 1,
							},
						}, -- [4]
						{
							["FakeHidden"] = true,
							["Type"] = "cooldown",
							["Name"] = "Starfall",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"", -- [2]
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Operator"] = "<",
								}, -- [1]
								{
									["Type"] = "BUFFSTACKS",
									["Checked"] = true,
									["Name"] = "Starfall",
								}, -- [2]
								["n"] = 2,
							},
							["Alpha"] = 0.7,
							["GUID"] = "TMW:icon:1KUkO92UH0oE",
						}, -- [5]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Alpha"] = 0.7,
							["FakeHidden"] = true,
							["Name"] = "Starfall",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"", -- [2]
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Operator"] = ">",
								}, -- [1]
								{
									["Type"] = "BUFFSTACKS",
									["Checked"] = true,
									["Name"] = "Starfall",
								}, -- [2]
								["n"] = 2,
							},
							["CustomTex"] = "155592",
							["GUID"] = "TMW:icon:1KUkO92XFgKg",
						}, -- [6]
					},
					["Name"] = "Moonkin Starsurge",
					["Tree3"] = false,
					["Tree2"] = false,
					["Tree4"] = false,
					["Columns"] = 6,
				}, -- [55]
				{
					["GUID"] = "TMW:group:1KUyJIVxvKu9",
					["Point"] = {
						["y"] = 51,
						["relativeTo"] = "TellMeWhen_Group22_Icon2",
						["point"] = "TOP",
					},
					["Scale"] = 1.16682393318194,
					["Tree1"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["OnlyMine"] = true,
							["Name"] = "Thrash; Lacerate",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["BuffOrDebuff"] = "HARMFUL",
							["Type"] = "buff",
							["Alpha"] = 0.7,
							["Unit"] = "target",
						}, -- [1]
					},
					["Role"] = 3,
					["Name"] = "Feral Thrash Small",
					["Tree3"] = false,
					["Columns"] = 1,
					["OnlyInCombat"] = true,
				}, -- [56]
				{
					["GUID"] = "TMW:group:1KUyRkBLGWxP",
					["Point"] = {
						["y"] = -104.200105345837,
						["x"] = 107.210838317871,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["Scale"] = 1.64,
					["Tree1"] = false,
					["Icons"] = {
						{
							["GUID"] = "TMW:icon:1KUyRkBKki46",
							["Type"] = "buff",
							["Alpha"] = 0.7,
							["FakeHidden"] = true,
							["Name"] = "Bloodtalons",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"", -- [2]
									},
								},
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "COMBAT",
								}, -- [1]
								["n"] = 1,
							},
							["ConditionDurEnabled"] = true,
							["ManaCheck"] = true,
						}, -- [1]
						{
							["GUID"] = "TMW:icon:1KUyRk9Zh5nL",
							["Type"] = "buff",
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["Name"] = "Predatory Swiftness",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Enabled"] = true,
							["CustomTex"] = "Healing Touch",
							["ConditionDurEnabled"] = true,
							["ManaCheck"] = true,
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["Alpha"] = 0.7,
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["Name"] = "Predatory Swiftness",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["CustomTex"] = "healing touch",
							["GUID"] = "TMW:icon:1KUyRkBKrdQc",
						}, -- [3]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["Alpha"] = 0.7,
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["Name"] = "Predatory Swiftness",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Events"] = {
								{
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
									["Duration"] = 0.4,
									["Event"] = "OnShow",
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["Type"] = "BUFFDUR",
									["Checked"] = true,
									["Level"] = 2.1,
									["Name"] = "Predatory Swiftness",
									["Operator"] = "<",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "healing touch",
							["GUID"] = "TMW:icon:1KUyRkBKww_S",
						}, -- [4]
					},
					["Name"] = "Feral Pred Swiftness Bloodtalons",
					["Tree3"] = false,
					["Tree4"] = false,
					["Columns"] = 5,
				}, -- [57]
				{
					["GUID"] = "TMW:group:1KW38o5YUVne",
					["Point"] = {
						["y"] = -61.1707924190125,
						["x"] = -9.687850350338320e-005,
					},
					["Scale"] = 1.64,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["BuffOrDebuff"] = "HARMFUL",
							["UnAlpha"] = 0.75,
							["Alpha"] = 0.75,
							["Unit"] = "target",
							["Name"] = "Stellar Flare",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Duration:TMWFormatDuration]",
									},
								},
							},
							["ShowWhen"] = 3,
							["Icons"] = {
								"TMW:icon:1KW1yhbKhhTH", -- [1]
								"TMW:icon:1KW1yhbNFDLp", -- [2]
							},
						}, -- [1]
					},
					["Columns"] = 1,
					["Name"] = "Moonkin Stellar Flare",
					["Tree2"] = false,
					["Tree3"] = false,
					["Conditions"] = {
						{
							["Name"] = "Stellar Flare",
							["Type"] = "TALENTLEARNED",
						}, -- [1]
						{
							["Name"] = "Moonkin",
							["Type"] = "STANCE",
						}, -- [2]
						["n"] = 2,
					},
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [58]
				{
					["GUID"] = "TMW:group:1KXvTDJrcpTw",
					["Point"] = {
						["y"] = 154.512374084894,
						["x"] = -258.293022515021,
						["point"] = "RIGHT",
						["relativePoint"] = "RIGHT",
					},
					["Scale"] = 1.64,
					["Columns"] = 2,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["UnAlpha"] = 0.4,
							["Alpha"] = 0.5,
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["Name"] = "Blood Presence",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Cat Form",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "ALIVE",
								}, -- [2]
								{
									["Type"] = "TALENTLEARNED",
									["Name"] = "Claws of Shirvallah",
									["Level"] = 1,
								}, -- [3]
								["n"] = 3,
							},
							["CustomTex"] = "768",
							["GUID"] = "TMW:icon:1KXvTDJvKiGe",
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["UnAlpha"] = 0.4,
							["Alpha"] = 0.5,
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["Name"] = "Blood Presence",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Conditions"] = {
								{
									["Type"] = "STANCE",
									["Name"] = "Claws of Shirvallah",
									["Level"] = 1,
								}, -- [1]
								{
									["Type"] = "ALIVE",
								}, -- [2]
								{
									["Name"] = "Claws of Shirvallah",
									["Type"] = "TALENTLEARNED",
								}, -- [3]
								["n"] = 3,
							},
							["CustomTex"] = "768",
							["GUID"] = "TMW:icon:1KXvTDJ_Z5Za",
						}, -- [2]
					},
					["Name"] = "Feral Catforms",
				}, -- [59]
				{
					["GUID"] = "TMW:group:1KYH7vVsnaKO",
					["Point"] = {
						["y"] = -74.9996048575562,
						["x"] = 17.6827125549316,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["Scale"] = 1.64,
					["Icons"] = {
						{
							["FakeHidden"] = true,
							["Type"] = "buff",
							["Name"] = "Empowered Moonkin",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Duration:TMWFormatDuration]",
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Operator"] = ">",
								}, -- [1]
								["n"] = 1,
							},
							["Alpha"] = 0.75,
							["GUID"] = "TMW:icon:1KZBDSRNxuJl",
						}, -- [1]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["Type"] = "buff",
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["GUID"] = "TMW:icon:1KZBDUCcKjxC",
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Level"] = 30,
									["Operator"] = ">",
								}, -- [1]
								{
									["Type"] = "ECLIPSE_DIRECTION",
								}, -- [2]
								["n"] = 2,
							},
							["CustomTex"] = "Wrath",
							["Name"] = "Solar Empowerment",
						}, -- [2]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["Type"] = "buff",
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["GUID"] = "TMW:icon:1KZBDWuH4p6O",
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Level"] = -50,
									["Operator"] = ">",
								}, -- [1]
								{
									["Type"] = "ECLIPSE_DIRECTION",
									["Level"] = 1,
								}, -- [2]
								["n"] = 2,
							},
							["CustomTex"] = "Wrath",
							["Name"] = "Solar Empowerment",
						}, -- [3]
						{
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1KZBDYfog8UN",
							["SettingsPerView"] = {
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["CustomTex"] = "Wrath",
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Level"] = 30,
									["Operator"] = ">",
								}, -- [1]
								{
									["Type"] = "ECLIPSE_DIRECTION",
								}, -- [2]
								["n"] = 2,
							},
							["Alpha"] = 0.75,
							["Enabled"] = true,
						}, -- [4]
						{
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1KZBDZRGXpB1",
							["SettingsPerView"] = {
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["CustomTex"] = "Wrath",
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Level"] = -50,
									["Operator"] = ">",
								}, -- [1]
								{
									["Type"] = "ECLIPSE_DIRECTION",
									["Level"] = 1,
								}, -- [2]
								["n"] = 2,
							},
							["Alpha"] = 0.75,
							["Enabled"] = true,
						}, -- [5]
						nil, -- [6]
						{
							["FakeHidden"] = true,
							["Type"] = "buff",
							["Name"] = "Empowered Moonkin",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Duration:TMWFormatDuration]",
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Operator"] = "<",
								}, -- [1]
								["n"] = 1,
							},
							["Alpha"] = 0.75,
							["Enabled"] = true,
						}, -- [7]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["Type"] = "buff",
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["GUID"] = "TMW:icon:1KZBDivsV2vu",
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Level"] = -50,
									["Operator"] = "<",
								}, -- [1]
								{
									["Type"] = "ECLIPSE_DIRECTION",
									["Level"] = 1,
								}, -- [2]
								["n"] = 2,
							},
							["CustomTex"] = "Starfire",
							["Name"] = "Lunar Empowerment",
						}, -- [8]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["Type"] = "buff",
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["GUID"] = "TMW:icon:1KZBDlcHfc_t",
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Level"] = 30,
									["Operator"] = "<",
								}, -- [1]
								{
									["Type"] = "ECLIPSE_DIRECTION",
								}, -- [2]
								["n"] = 2,
							},
							["CustomTex"] = "Starfire",
							["Name"] = "Lunar Empowerment",
						}, -- [9]
						{
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1KZBDrdlUkCC",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["CustomTex"] = "Starfire",
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Level"] = -50,
									["Operator"] = "<",
								}, -- [1]
								{
									["Type"] = "ECLIPSE_DIRECTION",
									["Level"] = 1,
								}, -- [2]
								["n"] = 2,
							},
							["Alpha"] = 0.75,
							["Enabled"] = true,
						}, -- [10]
						{
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1KZBDxw9v_4K",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["CustomTex"] = "Starfire",
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Level"] = 30,
									["Operator"] = "<",
								}, -- [1]
								{
									["Type"] = "ECLIPSE_DIRECTION",
								}, -- [2]
								["n"] = 2,
							},
							["Alpha"] = 0.75,
							["Enabled"] = true,
						}, -- [11]
					},
					["Columns"] = 12,
					["Role"] = 1,
					["Name"] = "Eclipse Non-Euphoria Grp",
					["Tree2"] = false,
					["Tree3"] = false,
					["Conditions"] = {
						{
							["Type"] = "VEHICLE",
							["Level"] = 1,
						}, -- [1]
						{
							["Type"] = "TALENTLEARNED",
							["Name"] = "Euphoria",
							["Level"] = 1,
						}, -- [2]
						["n"] = 2,
					},
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [60]
				{
					["GUID"] = "TMW:group:1KXslPLOAfze",
					["Point"] = {
						["y"] = 130.731764954034,
						["x"] = -203.902584255557,
					},
					["Scale"] = 1.64,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Solar Beam",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Conditions"] = {
								{
									["Type"] = "CASTING",
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["Alpha"] = 0.75,
						}, -- [1]
					},
					["Name"] = "Druid Balance Interrupt",
					["Columns"] = 1,
					["Tree3"] = false,
					["Tree2"] = false,
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [61]
				{
					["GUID"] = "TMW:group:1KYOjOdVf400",
					["Point"] = {
						["y"] = 130.731764954034,
						["x"] = -203.902584255557,
					},
					["Scale"] = 1.64,
					["Tree1"] = false,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Name"] = "Skull Bash",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Conditions"] = {
								{
									["Type"] = "CASTING",
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["Alpha"] = 0.75,
						}, -- [1]
					},
					["Name"] = "Druid Feral/Guardian Interrupt",
					["Columns"] = 1,
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [62]
				{
					["GUID"] = "TMW:group:1KYPLbvbyt2S",
					["Point"] = {
						["y"] = -91.2012794795593,
						["x"] = -15.6098991245973,
					},
					["Scale"] = 1.64,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "conditionicon",
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Alpha"] = 0.75,
							["Conditions"] = {
								{
									["Type"] = "RAGE_ABS",
									["Level"] = 60,
									["Operator"] = ">=",
								}, -- [1]
								{
									["Name"] = "Bear Form",
									["Type"] = "STANCE",
								}, -- [2]
								["n"] = 2,
							},
							["Icons"] = {
								"TMW:icon:1KUnNlKA5iEi", -- [1]
							},
							["CustomTex"] = "Frenzied Regeneration",
						}, -- [1]
						{
							["ClockGCD"] = true,
							["ShowTimer"] = true,
							["Name"] = "Mangle",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["Type"] = "meta",
							["Alpha"] = 0.75,
							["Icons"] = {
								"TMW:icon:1KYPUwXwm38R", -- [1]
								"TMW:icon:1KYPUwXqlpBm", -- [2]
								"TMW:icon:1KYPUwY0gGKD", -- [3]
							},
							["Enabled"] = true,
						}, -- [2]
					},
					["Name"] = "NonBearFeral Center",
					["Tree3"] = false,
					["Columns"] = 2,
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [63]
				{
					["GUID"] = "TMW:group:1KYPN0goxBut",
					["Point"] = {
						["y"] = 332.268310546875,
						["x"] = 676.365905761719,
						["point"] = "TOPLEFT",
						["relativePoint"] = "BOTTOMLEFT",
					},
					["Scale"] = 1.64,
					["Icons"] = {
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["BuffOrDebuff"] = "HARMFUL",
							["StackMax"] = 2,
							["Alpha"] = 0.75,
							["Unit"] = "target",
							["ClockGCD"] = true,
							["OnlyMine"] = true,
							["Name"] = "Thrash",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"", -- [2]
									},
								},
							},
							["Type"] = "cooldown",
							["Icons"] = {
								"TMW:icon:1KRE3y0g4sHS", -- [1]
							},
							["Events"] = {
								{
									["Type"] = "Animations",
									["Event"] = "OnShow",
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["StackMaxEnabled"] = true,
						}, -- [1]
					},
					["Name"] = "Nontank Thrash",
					["Tree3"] = false,
					["Conditions"] = {
						{
							["Name"] = "Bear Form",
							["Type"] = "STANCE",
						}, -- [1]
						["n"] = 1,
					},
					["Columns"] = 1,
					["OnlyInCombat"] = true,
				}, -- [64]
				{
					["GUID"] = "TMW:group:1KYPP=ueEija",
					["Point"] = {
						["y"] = -12,
						["x"] = 106,
					},
					["Columns"] = 1,
					["Tree2"] = false,
					["Scale"] = 1.64,
					["Name"] = "NonFeral Shred",
					["Icons"] = {
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Alpha"] = 0.75,
							["ClockGCD"] = true,
							["Name"] = "Shred",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Type"] = "cooldown",
							["Conditions"] = {
								{
									["Type"] = "COMBO",
									["Level"] = 5,
									["Operator"] = "<",
								}, -- [1]
								{
									["Type"] = "ENERGY_ABS",
									["Level"] = 40,
									["Operator"] = ">=",
								}, -- [2]
								{
									["Name"] = "Cat Form",
									["Type"] = "STANCE",
								}, -- [3]
								["n"] = 3,
							},
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["GUID"] = "TMW:icon:1KYPP=udtC9g",
						}, -- [1]
					},
					["OnlyInCombat"] = true,
				}, -- [65]
				{
					["GUID"] = "TMW:group:1KYPTRSnv9_Z",
					["Point"] = {
						["y"] = -12,
						["x"] = -106,
					},
					["Columns"] = 1,
					["Tree2"] = false,
					["Scale"] = 1.64,
					["Name"] = "NonFeral Thrash",
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Alpha"] = 0.75,
							["CooldownCheck"] = true,
							["Name"] = "Thrash",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
							},
							["Conditions"] = {
								{
									["Type"] = "ENERGY_ABS",
									["Level"] = 50,
									["Operator"] = ">=",
								}, -- [1]
								{
									["Name"] = "Cat form",
									["Type"] = "STANCE",
								}, -- [2]
								["n"] = 2,
							},
							["Icons"] = {
								"TMW:icon:1KHeTpX=Y7Vq", -- [1]
							},
							["GUID"] = "TMW:icon:1KYPTRSnXk8W",
						}, -- [1]
					},
					["OnlyInCombat"] = true,
				}, -- [66]
				{
					["GUID"] = "TMW:group:1KYPUwXnEkwz",
					["Point"] = {
						["y"] = 120.366164368097,
						["x"] = -198.902458550177,
						["point"] = "RIGHT",
						["relativePoint"] = "RIGHT",
					},
					["Scale"] = 1.64,
					["Name"] = "NonFeral/Bear Center",
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["Name"] = "Ferocious Bite",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["Conditions"] = {
								{
									["Type"] = "COMBO",
									["Level"] = 5,
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "ENERGY_ABS",
									["Level"] = 25,
									["Operator"] = ">=",
								}, -- [2]
								{
									["Name"] = "Cat form",
									["Type"] = "STANCE",
								}, -- [3]
								{
									["Type"] = "TREE",
									["Level"] = 2,
									["Operator"] = "~=",
								}, -- [4]
								["n"] = 4,
							},
							["ConditionDurEnabled"] = true,
							["GUID"] = "TMW:icon:1KYPUwXqlpBm",
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "cooldown",
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["Name"] = "Ferocious Bite",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["Type"] = "COMBO",
									["Level"] = 5,
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "ENERGY_ABS",
									["Level"] = 50,
									["Operator"] = ">=",
								}, -- [2]
								{
									["Name"] = "Cat form",
									["Type"] = "STANCE",
								}, -- [3]
								{
									["Type"] = "TREE",
									["Level"] = 2,
									["Operator"] = "~=",
								}, -- [4]
								["n"] = 4,
							},
							["ConditionDurEnabled"] = true,
							["GUID"] = "TMW:icon:1KYPUwXwm38R",
						}, -- [2]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Alpha"] = 0.75,
							["ClockGCD"] = true,
							["Type"] = "cooldown",
							["Name"] = "Mangle",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "",
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["Name"] = "Bear Form",
									["Type"] = "STANCE",
								}, -- [1]
								{
									["Type"] = "TREE",
									["Level"] = 3,
									["Operator"] = "~=",
								}, -- [2]
								["n"] = 2,
							},
							["GUID"] = "TMW:icon:1KYPUwY0gGKD",
							["FakeHidden"] = true,
						}, -- [3]
					},
					["Tree4"] = false,
				}, -- [67]
				{
					["GUID"] = "TMW:group:1KZBG7F1jHNg",
					["Point"] = {
						["y"] = -12,
						["x"] = -106,
					},
					["Scale"] = 1.64,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Alpha"] = 0.75,
							["Icons"] = {
								"TMW:icon:1KZBDSRNxuJl", -- [1]
								"TMW:icon:1KZBDivsV2vu", -- [2]
								"TMW:icon:1KZBDlcHfc_t", -- [3]
								"TMW:icon:1KZBDrdlUkCC", -- [4]
								"TMW:icon:1KZBDxw9v_4K", -- [5]
							},
						}, -- [1]
					},
					["Columns"] = 1,
					["Role"] = 1,
					["Name"] = "MoonkinStarfire Non-Euphoria",
					["Tree2"] = false,
					["Tree3"] = false,
					["Conditions"] = {
						{
							["Name"] = "Moonkin form",
							["Type"] = "STANCE",
						}, -- [1]
						{
							["Type"] = "TALENTLEARNED",
							["Name"] = "Euphoria",
							["Level"] = 1,
						}, -- [2]
						{
							["Name"] = "Celestial Alignment",
							["Type"] = "BUFFSTACKS",
						}, -- [3]
						["n"] = 3,
					},
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [68]
				{
					["GUID"] = "TMW:group:1KZBJOh0OUFf",
					["Point"] = {
						["y"] = -12,
						["x"] = 106,
					},
					["Scale"] = 1.64,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Alpha"] = 0.75,
							["Icons"] = {
								"TMW:icon:1KZBDSRNxuJl", -- [1]
								"TMW:icon:1KZBDUCcKjxC", -- [2]
								"TMW:icon:1KZBDWuH4p6O", -- [3]
								"TMW:icon:1KZBDYfog8UN", -- [4]
								"TMW:icon:1KZBDZRGXpB1", -- [5]
							},
						}, -- [1]
					},
					["Columns"] = 1,
					["Role"] = 1,
					["Name"] = "MoonkinWrath Non-Euphoria",
					["Tree2"] = false,
					["Tree3"] = false,
					["Conditions"] = {
						{
							["Name"] = "Moonkin Form",
							["Type"] = "STANCE",
						}, -- [1]
						{
							["Type"] = "TALENTLEARNED",
							["Name"] = "Euphoria",
							["Level"] = 1,
						}, -- [2]
						{
							["Name"] = "Celestial Alignment",
							["Type"] = "BUFFSTACKS",
						}, -- [3]
						["n"] = 3,
					},
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [69]
				{
					["GUID"] = "TMW:group:1KZF8hG6EoSk",
					["Point"] = {
						["y"] = -109.755647338025,
						["x"] = 20.7313404083252,
						["point"] = "TOPLEFT",
						["relativePoint"] = "TOPLEFT",
					},
					["Scale"] = 1.64,
					["Icons"] = {
						{
							["FakeHidden"] = true,
							["Type"] = "buff",
							["Name"] = "Empowered Moonkin",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Duration:TMWFormatDuration]",
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Operator"] = ">",
								}, -- [1]
								["n"] = 1,
							},
							["Alpha"] = 0.75,
							["GUID"] = "TMW:icon:1KZF8hG4xIhW",
						}, -- [1]
						{
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["Type"] = "buff",
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["GUID"] = "TMW:icon:1KZF8hG555=E",
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Operator"] = ">",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "Wrath",
							["Name"] = "Solar Empowerment",
						}, -- [2]
						{
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1KZF8hG5GEAI",
							["SettingsPerView"] = {
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["CustomTex"] = "Wrath",
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Operator"] = ">",
								}, -- [1]
								["n"] = 1,
							},
							["Alpha"] = 0.75,
							["Enabled"] = true,
						}, -- [3]
						[5] = {
							["FakeHidden"] = true,
							["Type"] = "buff",
							["Name"] = "Empowered Moonkin",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										[2] = "[Duration:TMWFormatDuration]",
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Operator"] = "<",
								}, -- [1]
								["n"] = 1,
							},
							["Alpha"] = 0.75,
							["GUID"] = "TMW:icon:1KZF8hG5TZry",
						},
						[6] = {
							["Enabled"] = true,
							["ShowTimer"] = true,
							["Alpha"] = 0.75,
							["FakeHidden"] = true,
							["Type"] = "buff",
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon2",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["GUID"] = "TMW:icon:1KZF8hG5ZXu3",
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Operator"] = "<",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "Starfire",
							["Name"] = "Lunar Empowerment",
						},
						[7] = {
							["FakeHidden"] = true,
							["Type"] = "conditionicon",
							["GUID"] = "TMW:icon:1KZF8hG5jwvt",
							["SettingsPerView"] = {
								["icon"] = {
									["Texts"] = {
										"", -- [1]
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["CustomTex"] = "Starfire",
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Operator"] = "<",
								}, -- [1]
								["n"] = 1,
							},
							["Alpha"] = 0.75,
							["Enabled"] = true,
						},
					},
					["Columns"] = 8,
					["Role"] = 1,
					["Name"] = "Moonkin Eclipse Celestial Alignment GRP",
					["Tree2"] = false,
					["Tree3"] = false,
					["Conditions"] = {
						{
							["Type"] = "VEHICLE",
							["Level"] = 1,
						}, -- [1]
						{
							["Type"] = "BUFFSTACKS",
							["Name"] = "Celestial Alignment",
							["Level"] = 1,
						}, -- [2]
						["n"] = 2,
					},
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [70]
				{
					["GUID"] = "TMW:group:1KZFAL94azCq",
					["Point"] = {
						["y"] = -12,
						["x"] = -106,
					},
					["Scale"] = 1.64,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Alpha"] = 0.75,
							["Icons"] = {
								"TMW:icon:1KZF8hG5TZry", -- [1]
								"TMW:icon:1KZF8hG5ZXu3", -- [2]
								"TMW:icon:1KZF8hG5dbI4", -- [3]
								"TMW:icon:1KZF8hG5jwvt", -- [4]
								"TMW:icon:1KZF8hG5qBpq", -- [5]
							},
						}, -- [1]
					},
					["Columns"] = 1,
					["Role"] = 1,
					["Name"] = "MoonkinStarfire Celestial Alignment",
					["Tree2"] = false,
					["Tree3"] = false,
					["Conditions"] = {
						{
							["Name"] = "Moonkin form",
							["Type"] = "STANCE",
						}, -- [1]
						{
							["Type"] = "BUFFSTACKS",
							["Name"] = "Celestial Alignment",
							["Level"] = 1,
						}, -- [2]
						["n"] = 2,
					},
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [71]
				{
					["GUID"] = "TMW:group:1KZFBUT65wVZ",
					["Point"] = {
						["y"] = -12,
						["x"] = 106,
					},
					["Scale"] = 1.64,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "meta",
							["Alpha"] = 0.75,
							["Icons"] = {
								"TMW:icon:1KZF8hG4xIhW", -- [1]
								"TMW:icon:1KZF8hG555=E", -- [2]
								"TMW:icon:1KZF8hG5A1=Q", -- [3]
								"TMW:icon:1KZF8hG5GEAI", -- [4]
								"TMW:icon:1KZF8hG5MeVX", -- [5]
							},
						}, -- [1]
					},
					["Columns"] = 1,
					["Role"] = 1,
					["Name"] = "MoonkinWrath Celestial Alignment",
					["Tree2"] = false,
					["Tree3"] = false,
					["Conditions"] = {
						{
							["Name"] = "Moonkin Form",
							["Type"] = "STANCE",
						}, -- [1]
						{
							["Type"] = "BUFFSTACKS",
							["Name"] = "Celestial Alignment",
							["Level"] = 1,
						}, -- [2]
						["n"] = 2,
					},
					["Tree4"] = false,
					["OnlyInCombat"] = true,
				}, -- [72]
				{
					["GUID"] = "TMW:group:1Kd_ogXQ4btD",
					["Point"] = {
						["y"] = 127.682967346613,
						["x"] = 21.3411350250244,
						["point"] = "LEFT",
						["relativePoint"] = "LEFT",
					},
					["Scale"] = 1.64,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["Alpha"] = 0.75,
							["Unit"] = "target",
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["Name"] = "Moonfire",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["CustomTex"] = "Moonfire",
							["GUID"] = "TMW:icon:1IdaHFQ4CGna",
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["Alpha"] = 0.75,
							["Unit"] = "target",
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["Name"] = "Moonfire",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "<",
									["Level"] = 12,
									["Name"] = "Moonfire",
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "Moonfire",
							["GUID"] = "TMW:icon:1Kd_ogXVGzHD",
						}, -- [2]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["Alpha"] = 0.75,
							["Unit"] = "target",
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["Name"] = "Sunfire",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["CustomTex"] = "93402",
							["GUID"] = "TMW:icon:1Kd_ogXbUFvG",
						}, -- [3]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["Alpha"] = 0.75,
							["Unit"] = "target",
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["Name"] = "Sunfire",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "<",
									["Level"] = 7,
									["Name"] = "Sunfire",
									["Unit"] = "target",
								}, -- [1]
								["n"] = 1,
							},
							["CustomTex"] = "93402",
							["GUID"] = "TMW:icon:1Kd_ogXhQE9m",
						}, -- [4]
					},
					["Name"] = "Moonkin Dot Grp",
				}, -- [73]
				{
					["GUID"] = "TMW:group:1Kd_rxfbIquL",
					["Point"] = {
						["y"] = 47.8048850712219,
						["x"] = -201.341423393927,
						["point"] = "RIGHT",
						["relativePoint"] = "RIGHT",
					},
					["Scale"] = 1.64,
					["Icons"] = {
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["Alpha"] = 0.75,
							["Unit"] = "target",
							["FakeHidden"] = true,
							["Name"] = "Stellar Flare",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
							},
							["Conditions"] = {
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "<",
									["Level"] = 5,
									["Name"] = "Stellar Flare",
									["Unit"] = "target",
								}, -- [1]
								{
									["Type"] = "ECLIPSE",
									["Level"] = -40,
									["Operator"] = ">",
								}, -- [2]
								{
									["Type"] = "ECLIPSE",
									["Level"] = 40,
									["Operator"] = "<",
								}, -- [3]
								{
									["Name"] = "Stellar Flare",
									["Type"] = "TALENTLEARNED",
								}, -- [4]
								["n"] = 4,
							},
							["GUID"] = "TMW:icon:1KW1yhbKhhTH",
						}, -- [1]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["BuffOrDebuff"] = "HARMFUL",
							["UnAlpha"] = 0.75,
							["Alpha"] = 0.83,
							["Unit"] = "target",
							["FakeHidden"] = true,
							["OnlyMine"] = true,
							["Name"] = "Stellar Flare",
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Level"] = -40,
									["Operator"] = ">",
								}, -- [1]
								{
									["Type"] = "ECLIPSE",
									["Level"] = 40,
									["Operator"] = "<",
								}, -- [2]
								{
									["Name"] = "Stellar Flare",
									["Type"] = "TALENTLEARNED",
								}, -- [3]
								["n"] = 3,
							},
							["ShowWhen"] = 1,
							["GUID"] = "TMW:icon:1KW1yhbNFDLp",
						}, -- [2]
						{
							["FakeHidden"] = true,
							["Type"] = "buff",
							["Name"] = "Starfall",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["Enabled"] = true,
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Operator"] = "<",
								}, -- [1]
								["n"] = 1,
							},
							["Alpha"] = 0.7,
							["GUID"] = "TMW:icon:1KYGy=JWopOQ",
						}, -- [3]
						{
							["Enabled"] = true,
							["Type"] = "buff",
							["Alpha"] = 0.7,
							["FakeHidden"] = true,
							["Name"] = "Starfall",
							["SettingsPerView"] = {
								["icon"] = {
									["TextLayout"] = "icon1",
									["Texts"] = {
										"[Stacks:Hide(0)]", -- [1]
										"[Duration:TMWFormatDuration]", -- [2]
									},
								},
								["Type"] = {
									["TextLayout"] = "",
								},
							},
							["Events"] = {
								{
									["Event"] = "OnShow",
									["Type"] = "Animations",
									["Infinite"] = true,
									["Animation"] = "ACTVTNGLOW",
								}, -- [1]
								["n"] = 1,
							},
							["Conditions"] = {
								{
									["Type"] = "ECLIPSE",
									["Operator"] = ">",
								}, -- [1]
								{
									["Type"] = "DEBUFFDUR",
									["Checked"] = true,
									["Operator"] = "<",
									["Level"] = 7,
									["Name"] = "Sunfire",
									["Unit"] = "target",
								}, -- [2]
								["n"] = 2,
							},
							["CustomTex"] = "155592",
							["GUID"] = "TMW:icon:1KYGy=JZc_IQ",
						}, -- [4]
					},
					["Name"] = "Moonkin Starfire & Stellar Flare",
				}, -- [74]
			},
			["Version"] = 73501,
		},
		["Kylosandrax - Aggramar"] = {
			["Locked"] = true,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1KgTxdI1GrFD",
				}, -- [1]
			},
			["Version"] = 73501,
		},
		["Feldspar - Aggramar"] = {
			["Locked"] = true,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1KhSi2CcNGtD",
				}, -- [1]
			},
			["Version"] = 72332,
		},
		["Stormslinger - Aggramar"] = {
			["Locked"] = true,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1KgTymns3g=9",
				}, -- [1]
			},
			["Version"] = 73501,
		},
		["Ryvok - Terokkar"] = {
			["Locked"] = true,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1LpqEKbNzKmr",
				}, -- [1]
			},
			["Version"] = 73501,
		},
		["Kyloc - Aggramar"] = {
			["Locked"] = true,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1KxZsMqwNB5g",
				}, -- [1]
			},
			["Version"] = 73501,
		},
		["Banjax - Aggramar"] = {
			["Locked"] = true,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1KlgkDvoGVFc",
				}, -- [1]
			},
			["Version"] = 73501,
		},
		["Kylosandrix - Aggramar"] = {
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1MHykHnCN7VN",
				}, -- [1]
			},
			["Locked"] = true,
			["Version"] = 74003,
		},
		["Ryvok - Aggramar"] = {
			["Locked"] = true,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1KgT=SCvGJdp",
				}, -- [1]
			},
			["Version"] = 73501,
		},
		["Bronin - Aggramar"] = {
			["Locked"] = true,
			["Groups"] = {
				{
					["GUID"] = "TMW:group:1KgTuqLn8Zdq",
				}, -- [1]
			},
			["Version"] = 73501,
		},
	},
}
