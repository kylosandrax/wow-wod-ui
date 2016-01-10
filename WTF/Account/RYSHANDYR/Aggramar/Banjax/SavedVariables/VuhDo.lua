
VUHDO_CONFIG = {
	["SMARTCAST_CLEANSE"] = true,
	["RANGE_SPELL"] = "Holy Light",
	["BLIZZ_UI_HIDE_PARTY"] = 1,
	["BLIZZ_UI_HIDE_PLAYER"] = 1,
	["DIRECTION"] = {
		["isDistanceText"] = false,
		["scale"] = 76,
		["isDeadOnly"] = false,
		["enable"] = true,
	},
	["STANDARD_TOOLTIP"] = 1,
	["AOE_ADVISOR"] = {
		["isCooldown"] = true,
		["config"] = {
			["tq"] = {
				["enable"] = true,
				["thresh"] = 15000,
			},
			["hr"] = {
				["enable"] = false,
				["thresh"] = 10000,
			},
			["wg"] = {
				["enable"] = true,
				["thresh"] = 15000,
			},
			["ch"] = {
				["enable"] = true,
				["thresh"] = 15000,
			},
			["poh"] = {
				["enable"] = true,
				["thresh"] = 20000,
			},
			["ef"] = {
				["enable"] = true,
				["thresh"] = 8000,
			},
			["cb"] = {
				["enable"] = false,
				["thresh"] = 10000,
			},
			["lod"] = {
				["enable"] = true,
				["thresh"] = 8000,
			},
			["coh"] = {
				["enable"] = true,
				["thresh"] = 15000,
			},
		},
		["animate"] = true,
		["subIncOnlyCastTime"] = true,
		["refresh"] = 800,
		["knownOnly"] = true,
		["subInc"] = true,
	},
	["LOCK_PANELS"] = true,
	["SHOW_OVERHEAL_EXTRA"] = true,
	["RANGE_PESSIMISTIC"] = false,
	["SMARTCAST_RESURRECT"] = true,
	["BLIZZ_UI_HIDE_PET"] = 1,
	["INC_HOTS_SECS"] = 3,
	["SMARTCAST_BUFF"] = false,
	["SHOW_PANELS"] = true,
	["PANEL_FRAME_STRATA"] = "",
	["CURRENT_ARRANGEMENT"] = "current",
	["RANGE_CHECK_DELAY"] = 1000,
	["SHOW_MINIMAP"] = true,
	["DETECT_DEBUFFS_IGNORE_MOVEMENT"] = true,
	["OMIT_OWN_GROUP"] = false,
	["RES_IS_SHOW_TEXT"] = false,
	["INC_CASTED_SECS"] = 3,
	["DETECT_DEBUFFS_REMOVABLE_ONLY"] = true,
	["CLUSTER"] = {
		["REFRESH"] = 180,
		["CHAIN_MAX_JUMP"] = 3,
		["RANGE_JUMP"] = 11,
		["BELOW_HEALTH_PERC"] = 85,
		["DISPLAY_DESTINATION"] = 2,
		["IS_NUMBER"] = false,
		["ENABLE"] = true,
		["RANGE"] = 15,
		["MODE"] = 1,
		["DISPLAY_SOURCE"] = 2,
		["TEXT"] = {
			["X_ADJUST"] = 40,
			["Y_ADJUST"] = 22,
			["ANCHOR"] = "BOTTOMRIGHT",
			["USE_OUTLINE"] = true,
			["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
			["USE_SHADOW"] = false,
			["COLOR"] = {
				["TG"] = 1,
				["R"] = 0,
				["TB"] = 1,
				["G"] = 0,
				["TR"] = 1,
				["TO"] = 1,
				["useOpacity"] = true,
				["useBackground"] = true,
				["useText"] = true,
				["O"] = 1,
				["B"] = 0,
			},
			["SCALE"] = 85,
		},
		["THRESH_GOOD"] = 5,
		["COOLDOWN_SPELL"] = "",
		["CONE_DEGREES"] = 360,
		["THRESH_FAIR"] = 3,
	},
	["LOCK_CLICKS_THROUGH"] = false,
	["SHOW_INC_BOMBED"] = true,
	["VERSION"] = 4,
	["SHOW_INC_HOTS"] = true,
	["SHOW_INC_CHANNELLED"] = true,
	["DETECT_DEBUFFS_IGNORE_DURATION"] = false,
	["CUSTOM_DEBUFF"] = {
		["animate"] = true,
		["scale"] = 0.8,
		["STORED"] = {
			"Acid-Drenched Mandibles", -- [1]
			"Boiling Blood", -- [2]
			"Burning Bile", -- [3]
			"Chilled to the Bone", -- [4]
			"Consuming Darkness", -- [5]
			"Corrosion", -- [6]
			"Defile", -- [7]
			"Delirious Slash", -- [8]
			"Essence of the Blood Queen", -- [9]
			"Expose Weakness", -- [10]
			"Feral Pounce", -- [11]
			"Fiery Combustion", -- [12]
			"Fire Bomb", -- [13]
			"Frost Beacon", -- [14]
			"Frost Blast", -- [15]
			"Frost Breath", -- [16]
			"Gas Spore", -- [17]
			"Gaseous Bloat", -- [18]
			"Gastric Bloat", -- [19]
			"Glittering Sparks", -- [20]
			"Gravity Bomb", -- [21]
			"Grievous Bite", -- [22]
			"Gut Spray", -- [23]
			"Harvest Soul", -- [24]
			"Ice Tomb", -- [25]
			"Impale", -- [26]
			"Impaled", -- [27]
			"Incinerate Flesh", -- [28]
			"Infest", -- [29]
			"Inoculated", -- [30]
			"Instability", -- [31]
			"Instant Heal", -- [32]
			"Iron Roots", -- [33]
			"Jagged Knife", -- [34]
			"Legion Flame", -- [35]
			"Low Health", -- [36]
			"Mark of the Fallen Champion", -- [37]
			"Mistress' Kiss", -- [38]
			"Mutated Infection", -- [39]
			"Mutated Plague", -- [40]
			"Mystic Buffet", -- [41]
			"Napalm Shell", -- [42]
			"Necrotic Plague", -- [43]
			"Necrotic Strike", -- [44]
			"Pact of the Darkfallen", -- [45]
			"Paralytic Toxin", -- [46]
			"Penetrating Cold", -- [47]
			"Rune of Blood", -- [48]
			"Sara's Blessing", -- [49]
			"Searing Light", -- [50]
			"Shadow Prison", -- [51]
			"Shroud of Sorrow", -- [52]
			"Slag Pot", -- [53]
			"Snobolled!", -- [54]
			"Soul Consumption", -- [55]
			"Spinning Pain Spike", -- [56]
			"Stone Grip", -- [57]
			"Swarming Shadows", -- [58]
			"Touch of Darkness", -- [59]
			"Touch of Light", -- [60]
			"Unbound Plague", -- [61]
			"Vile Gas", -- [62]
			"Volatile Ooze Adhesive", -- [63]
			"Waterlogged", -- [64]
			"Weakened Soul", -- [65]
			"Web Wrap", -- [66]
			"unbound plague", -- [67]
			"Constricting Chains", -- [68]
			"Parasitic Infection", -- [69]
			"Mangle", -- [70]
			"Poison Soaked Shell", -- [71]
			"Lightning Conductor", -- [72]
			"Incineration Security Measure", -- [73]
			"Flash Freeze", -- [74]
			"Biting Chill", -- [75]
			"Searing Flame", -- [76]
			"Roaring Flame", -- [77]
			"Sonic Breath", -- [78]
			"Break", -- [79]
			"Blackout", -- [80]
			"Devouring Flames", -- [81]
			"Engulfing Magic", -- [82]
			"Malevolent Strikes", -- [83]
			"Hydro Lance", -- [84]
			"Frozen", -- [85]
			"Flame Torrent", -- [86]
			"Lightning Rod", -- [87]
			"Gravity Core", -- [88]
			"Gravity Crush", -- [89]
			"Cho's Blast", -- [90]
			"Gall's Blast", -- [91]
			"Ice Patch", -- [92]
			"Soothing Breeze", -- [93]
			"Toxic Spores", -- [94]
			"Slicing Gale", -- [95]
			"Ice Storm", -- [96]
			"Corruption: Accelerated", -- [97]
			"Electrical Storm", -- [98]
			"Plucked", -- [99]
			"Grievous Throw", -- [100]
			"Flame Shock", -- [101]
			"Flame Breath", -- [102]
			"Siphon Soul", -- [103]
			"Body Slam", -- [104]
			"Lash of Anguish", -- [105]
			"Ravage", -- [106]
			"Decapitate", -- [107]
			"Bloodletting", -- [108]
			"Whispers of Hethiss", -- [109]
			"Toxic Link", -- [110]
			"Pursuit", -- [111]
			"Toxic Torment", -- [112]
			"Burning Blood", -- [113]
			"Frostburn Formula", -- [114]
			"Wrack", -- [115]
			"The Widow's Kiss", -- [116]
			"Fieroblast", -- [117]
			"Gushing Wound", -- [118]
			"Crystal Prison Trap Effect", -- [119]
			"Jagged Tear", -- [120]
			"Tormented", -- [121]
			"Searing Seeds", -- [122]
			"Burning Wound", -- [123]
			"Melt Armor", -- [124]
			"Crush Armor", -- [125]
			"Watery Entrenchment", -- [126]
			"Shattered Ice", -- [127]
			"Twilight Barrage", -- [128]
			"Shockwave", -- [129]
			"Sunder Armor", -- [130]
			"Brutal Strike", -- [131]
			"Degeneration", -- [132]
			"Heroic Will", -- [133]
			"Twilight Shift", -- [134]
			"Twilight Burst", -- [135]
			"Faded Into Twilight", -- [136]
			"Fading Light", -- [137]
			"Deep Corruption", -- [138]
			"Disrupting Shadows", -- [139]
			"Black Blood of Go'rath", -- [140]
			"Grasping Tendrils", -- [141]
			"Fiery Grip", -- [142]
			"Searing Plasma", -- [143]
			"Blood Corruption: Death", -- [144]
			"Blood Corruption: Earth", -- [145]
			"Degradation", -- [146]
			"Degenerative Bite", -- [147]
			"Blistering Heat", -- [148]
			"Tetanus", -- [149]
			"Exhale", -- [150]
			"Pheromones of Zeal", -- [151]
			"Convert", -- [152]
			"Noise Cancelling", -- [153]
			"Unseen Strike", -- [154]
			"Overwhelming Assault", -- [155]
			"Storm Unleashed", -- [156]
			"Wind Step", -- [157]
			"Pheromones", -- [158]
			"Pungency", -- [159]
			"Crush", -- [160]
			"Weak Points", -- [161]
			"Amber Prison", -- [162]
			"Residue", -- [163]
			"Corrosive Resin", -- [164]
			"Parasitic Growth", -- [165]
			"Reshape Life", -- [166]
			"Fixate", -- [167]
			"Eyes of the Empress", -- [168]
			"Cry of Terror", -- [169]
			"Sticky Resin", -- [170]
			"Trapped!", -- [171]
			"Poison Bomb", -- [172]
			"Poison-Drenched Armor", -- [173]
			"Poison Fumes", -- [174]
			"Consuming Terror", -- [175]
			"Visions of Demise", -- [176]
			"Heart of Fear", -- [177]
			"Dissonance Field", -- [178]
			"Sha Corruption", -- [179]
			"Dismantled Armor", -- [180]
			"Arterial Bleeding", -- [181]
			"Gouge Throat", -- [182]
			"Riposte", -- [183]
			"Gale Force Winds", -- [184]
			"Stunning Strike", -- [185]
			"Slam", -- [186]
			"Burning Sting", -- [187]
			"Mortal Rend", -- [188]
			"Grievous Whirl", -- [189]
			"Petrified", -- [190]
			"Smoke Bomb", -- [191]
			"Sundering Bite", -- [192]
			"Ground Slam", -- [193]
			"Pyroblast", -- [194]
			"Troll Rush", -- [195]
			"Jasper Chains", -- [196]
			"Amethyst Pool", -- [197]
			"Jasper Petrification", -- [198]
			"Cobalt Petrification", -- [199]
			"Amethyst Petrification", -- [200]
			"Cobalt Mine Blast", -- [201]
			"Rend Flesh", -- [202]
			"Jade Petrification", -- [203]
			"Lightning Lash", -- [204]
			"Epicenter", -- [205]
			"Flaming Spear", -- [206]
			"Wildfire Spark", -- [207]
			"Arcane Shock", -- [208]
			"Arcane Resonance", -- [209]
			"Arcane Velocity", -- [210]
			"Lightning Charge", -- [211]
			"Shadowburn", -- [212]
			"Voodoo Doll", -- [213]
			"Frail Soul", -- [214]
			"Crossed Over", -- [215]
			"Soul Sever", -- [216]
			"Maddening Shout", -- [217]
			"Pillaged", -- [218]
			"Pinned Down", -- [219]
			"Pillage", -- [220]
			"Robbed Blind", -- [221]
			"Overcharged", -- [222]
			"Closed Circuit", -- [223]
			"Arcing Energy", -- [224]
			"Destabilizing Energies", -- [225]
			"Devastating Arc", -- [226]
			"Stomp", -- [227]
			"Focused Assault", -- [228]
			"Focused Defense", -- [229]
			"Impeding Thrust", -- [230]
			"Energizing Smash", -- [231]
			"Focused Energy", -- [232]
			"Aggressive Behavior", -- [233]
			"Unleashed Wrath", -- [234]
			"Bitter Thoughts", -- [235]
			"Touch of Sha", -- [236]
			"Lightning Prison", -- [237]
			"Corrupted Essence", -- [238]
			"Defiled Ground", -- [239]
			"Purified", -- [240]
			"Cleansing Waters", -- [241]
			"Overwhelming Corruption", -- [242]
			"Dread Shadows", -- [243]
			"Nightmares", -- [244]
			"Shadow Breath", -- [245]
			"Sunbeam", -- [246]
			"Terrorize", -- [247]
			"Fright", -- [248]
			"Bathed in Light", -- [249]
			"Spray", -- [250]
			"Scary Fog", -- [251]
			"Breath of Fear", -- [252]
			"Ominous Cackle", -- [253]
			"Dread Spray", -- [254]
			"Naked and Afraid", -- [255]
			"Waterspout", -- [256]
			"Huddle in Terror", -- [257]
			"Eternal Darkness", -- [258]
			"Sha Globe", -- [259]
			"Penetrating Bolt", -- [260]
			"Reaching Attack", -- [261]
			"Electrified Waters", -- [262]
			"Focused Lightning", -- [263]
			"Ionization", -- [264]
			"Static Wound", -- [265]
			"Thundering Throw", -- [266]
			"Charge", -- [267]
			"Triple Puncture", -- [268]
			"Stone Gaze", -- [269]
			"Sand Trap", -- [270]
			"Venom Bolt Volley", -- [271]
			"Deadly Plague", -- [272]
			"Mortal Strike", -- [273]
			"Frozen Bolt", -- [274]
			"Hex of Confusion", -- [275]
			"Blazing Sunlight", -- [276]
			"Rending Charge", -- [277]
			"Dire Fixation", -- [278]
			"Frostbite", -- [279]
			"Body Heat", -- [280]
			"Soul Fragment", -- [281]
			"Ensnared", -- [282]
			"Entrapped", -- [283]
			"Shadowed Soul", -- [284]
			"Marked Soul", -- [285]
			"Twisted Fate", -- [286]
			"Quicksand", -- [287]
			"Kick Shell", -- [288]
			"Quake Stomp", -- [289]
			"Sonic Screech", -- [290]
			"Slashing Talons", -- [291]
			"Crystal Shell", -- [292]
			"Cinders", -- [293]
			"Consuming Flames", -- [294]
			"Ignite Flesh", -- [295]
			"Frozen Solid", -- [296]
			"Icy Ground", -- [297]
			"Consuming Magic", -- [298]
			"Arctic Freeze", -- [299]
			"Rot Armor", -- [300]
			"Suppression", -- [301]
			"Slimed", -- [302]
			"Feed Pool", -- [303]
			"Lesson of Icarus", -- [304]
			"Screech", -- [305]
			"Arterial Cut", -- [306]
			"Serious Wound", -- [307]
			"Force of Will", -- [308]
			"Blue Rays", -- [309]
			"Infrared Light", -- [310]
			"Bright Light", -- [311]
			"Life Drain", -- [312]
			"Dark Parasite", -- [313]
			"Lingering Gaze", -- [314]
			"Fully Mutated", -- [315]
			"Keen Eyesight", -- [316]
			"Impaired Eyesight", -- [317]
			"Improved Synapses", -- [318]
			"Dulled Synapses", -- [319]
			"Thick Bones", -- [320]
			"Fragile Bones", -- [321]
			"Clear Mind", -- [322]
			"Clouded Mind", -- [323]
			"Malformed Blood", -- [324]
			"Explosive Slam", -- [325]
			"Touch of the Animus", -- [326]
			"Matter Swap", -- [327]
			"Anima Font", -- [328]
			"Anima Ring", -- [329]
			"Crimson Wake", -- [330]
			"Scorched", -- [331]
			"Arcing Lightning", -- [332]
			"Dead Zone", -- [333]
			"Freeze", -- [334]
			"Frozen Blood", -- [335]
			"Storm Cloud", -- [336]
			"Burning Cinders", -- [337]
			"Rushing Winds", -- [338]
			"Wind Storm", -- [339]
			"Lightning Storm", -- [340]
			"Icy Shadows", -- [341]
			"Flames of Passion", -- [342]
			"Serpent's Vitality", -- [343]
			"Fan of Flames", -- [344]
			"Corrupted Healing", -- [345]
			"Beast of Nightmares", -- [346]
			"Slumber Spores", -- [347]
			"Static Shock", -- [348]
			"Summon Ball Lightning", -- [349]
			"Discharged Energy", -- [350]
			"Overcharge", -- [351]
			"Overloaded Circuits", -- [352]
			"Lightning Bolt", -- [353]
			"Crashing Thunder", -- [354]
			"Electrical Shock", -- [355]
			"Maim", -- [356]
			"Locked On", -- [357]
			"Resonating Amber", -- [358]
			"Corrosive Blast", -- [359]
			"Sha Splash", -- [360]
			"Inferno Strike", -- [361]
			"Vengeful Strikes", -- [362]
			"Corruption Kick", -- [363]
			"Garrote", -- [364]
			"Gouge", -- [365]
			"Mark of Anguish", -- [366]
			"Shadow Weakness", -- [367]
			"Debilitation", -- [368]
			"Sha Sear", -- [369]
			"Wounded Pride", -- [370]
			"Corrupted Prison", -- [371]
			"Fracture", -- [372]
			"Flame Arrows", -- [373]
			"Poison Cloud", -- [374]
			"Flames of Galakrond", -- [375]
			"Laser Burn", -- [376]
			"Ignite Armor", -- [377]
			"Explosive Tar", -- [378]
			"Cutter Laser Target", -- [379]
			"Rend", -- [380]
			"Froststorm Strike", -- [381]
			"Toxic Mist", -- [382]
			"Foul Geyser", -- [383]
			"Iron Prison", -- [384]
			"Iron Tomb", -- [385]
			"Sundering Blow", -- [386]
			"Bonecracker", -- [387]
			"Assassin's Mark", -- [388]
			"Hunter's Mark", -- [389]
			"Fatal Strike", -- [390]
			"Ancient Barrier", -- [391]
			"Ancient Miasma", -- [392]
			"Languish", -- [393]
			"Set to Blow", -- [394]
			"Carnivorous Bite", -- [395]
			"Encapsulated Pheromones", -- [396]
			"Keg Toss", -- [397]
			"Gusting Bomb", -- [398]
			"Panic", -- [399]
			"Tail Lash", -- [400]
			"Acid Breath", -- [401]
			"Freezing Breath", -- [402]
			"Icy Blood", -- [403]
			"Scorching Breath", -- [404]
			"Electrostatic Charge", -- [405]
			"Overload", -- [406]
			"Superheated", -- [407]
			"Magnetic Crush", -- [408]
			"Exposed Veins", -- [409]
			"Caustic Blood", -- [410]
			"Tenderizing Strikes", -- [411]
			"Mesmerize", -- [412]
			"Shield Bash", -- [413]
			"Caustic Amber", -- [414]
			"Hewn", -- [415]
			"Genetic Alteration", -- [416]
			"Injection", -- [417]
			"Aim", -- [418]
			"Whirling", -- [419]
			"Hunger", -- [420]
			"Fiery Edge", -- [421]
			"Pierced Armor", -- [422]
			"Loose Quills", -- [423]
			"Savage Vines", -- [424]
			"Rot", -- [425]
			"Blade Dance", -- [426]
			"Chain Hurl", -- [427]
			"On the Hunt", -- [428]
			"Expel Magic: Arcane", -- [429]
			"Expel Magic: Fire", -- [430]
			"Branded", -- [431]
			"Mark of Chaos", -- [432]
			"Slow", -- [433]
			"Crystalline Barrage", -- [434]
			"Petrification", -- [435]
			"The Tenderizer", -- [436]
			"Arcane Wound", -- [437]
			"Blaze", -- [438]
			"Arcane Volatility", -- [439]
			"Marked for Death", -- [440]
			"Attach Slag Bombs", -- [441]
			"Rend and Tear", -- [442]
			"Conflagration", -- [443]
			"Seared Flesh", -- [444]
			"Overwhelming Blows", -- [445]
			"Petrifying Slam", -- [446]
			"Shattered Vertebrae", -- [447]
			"Molten Torrent", -- [448]
			"Rising Flames", -- [449]
			"Charring Breath", -- [450]
			"Warped Armor", -- [451]
			"Acid Torrent", -- [452]
			"Shields Down", -- [453]
			"Bomb", -- [454]
			"Volatile Fire", -- [455]
			"Rapid Fire", -- [456]
			"Penetrating Shot", -- [457]
			"Convulsive Shadows", -- [458]
			"Dark Hunt", -- [459]
			"Bloodsoaked Heartseeker", -- [460]
			"Enkindle", -- [461]
			"Prototype Pulse Grenade", -- [462]
			"Delayed Siege Bomb", -- [463]
		},
		["isIcon"] = true,
		["selected"] = "",
		["SELECTED"] = "Waterlogged",
		["STORED_SETTINGS"] = {
			["Dismantled Armor"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Blackout"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Crush Armor"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Feral Pounce"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Ensnared"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Crush"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Gravity Core"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Frostbite"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Inoculated"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["timer"] = true,
				["isColor"] = false,
				["SOUND"] = "Interface\\Quiet.mp3",
			},
			["Paralytic Toxin"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Twilight Shift"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Melt Armor"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Touch of the Animus"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Infrared Light"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Sticky Resin"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Amethyst Pool"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Poison Fumes"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Gaseous Bloat"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Focused Assault"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Instant Heal"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Fire Bomb"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Languish"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Poison-Drenched Armor"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Bomb"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Vile Gas"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Lightning Prison"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Jagged Tear"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Burning Blood"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Jade Petrification"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Crystal Shell"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Consuming Flames"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Impeding Thrust"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Epicenter"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Napalm Shell"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Stunning Strike"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Degenerative Bite"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Expose Weakness"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Nightmares"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Glittering Sparks"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Ground Slam"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Destabilizing Energies"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Burning Wound"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Whispers of Hethiss"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Devouring Flames"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Mark of Chaos"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Corrupted Essence"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Entrapped"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Body Heat"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Pillaged"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Deadly Plague"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Hewn"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Pheromones"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Searing Plasma"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Degeneration"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Scary Fog"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Stone Grip"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Encapsulated Pheromones"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Web Wrap"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Convert"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Legion Flame"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Summon Ball Lightning"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Fully Mutated"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Petrified"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Prototype Pulse Grenade"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Enkindle"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Bloodsoaked Heartseeker"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Dark Hunt"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Convulsive Shadows"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Penetrating Shot"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Ionization"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Rapid Fire"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Searing Flame"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Maddening Shout"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Triple Puncture"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Bloodletting"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Rising Flames"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Smoke Bomb"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Shields Down"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Poison Soaked Shell"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Acid Torrent"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Charge"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Noise Cancelling"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Amber Prison"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Jasper Chains"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Reaching Attack"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Assassin's Mark"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Overwhelming Corruption"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Robbed Blind"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Warped Armor"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Charring Breath"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Set to Blow"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Engulfing Magic"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Molten Torrent"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Quake Stomp"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Freeze"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Clouded Mind"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Scorched"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Incinerate Flesh"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Petrifying Slam"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Ancient Miasma"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Expel Magic: Arcane"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Seared Flesh"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Magnetic Crush"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Conflagration"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Shadow Prison"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Heart of Fear"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Consuming Terror"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Pierced Armor"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Overloaded Circuits"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Ominous Cackle"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Frozen Bolt"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Marked for Death"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Touch of Darkness"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Penetrating Cold"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Arcane Volatility"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Blaze"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Slashing Talons"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Whirling"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Hunger"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Sha Globe"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Flames of Passion"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Burning Sting"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Lingering Gaze"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Impale"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Bright Light"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Arcing Energy"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Arcane Resonance"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Rushing Winds"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Branded"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Explosive Slam"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Pillage"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Gall's Blast"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Expel Magic: Fire"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Reshape Life"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Overwhelming Blows"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Toxic Torment"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Overwhelming Assault"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["On the Hunt"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Visions of Demise"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Chain Hurl"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Brutal Strike"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Resonating Amber"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Sha Splash"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Poison Bomb"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Flaming Spear"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Savage Vines"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Frost Beacon"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Tenderizing Strikes"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Wind Step"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Slag Pot"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Icy Ground"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Mortal Strike"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Focused Energy"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Rend Flesh"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Attach Slag Bombs"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Plucked"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Ignite Armor"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Fright"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Parasitic Infection"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Sunder Armor"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Fixate"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Storm Unleashed"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Pact of the Darkfallen"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Impaired Eyesight"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Rot"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Scorching Breath"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Dead Zone"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Breath of Fear"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Carnivorous Bite"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Searing Seeds"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Flame Breath"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Freezing Breath"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Pungency"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Corrupted Prison"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Disrupting Shadows"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Rend and Tear"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Bonecracker"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Frostburn Formula"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Wrack"] = {
				["isStacks"] = 1,
				["isAliveTime"] = true,
				["isIcon"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isFullDuration"] = true,
				["animate"] = true,
			},
			["Fiery Combustion"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["timer"] = true,
			},
			["Heroic Will"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Laser Burn"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Defile"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Body Slam"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Storm Cloud"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Hex of Confusion"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Suppression"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Dread Spray"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Troll Rush"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Discharged Energy"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Static Wound"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Infest"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Fracture"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Kick Shell"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Incineration Security Measure"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Garrote"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Inferno Strike"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["unbound plague"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isIcon"] = true,
				["timer"] = true,
			},
			["Gravity Bomb"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Volatile Ooze Adhesive"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["timer"] = true,
				["isColor"] = false,
				["SOUND"] = "Interface\\Quiet.mp3",
			},
			["Lightning Charge"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Flame Torrent"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Corrupted Healing"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Siphon Soul"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Gas Spore"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["timer"] = true,
				["isColor"] = false,
				["SOUND"] = "Interface\\Quiet.mp3",
			},
			["Mark of the Fallen Champion"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Degradation"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Burning Bile"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Blood Corruption: Earth"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Shattered Vertebrae"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Dark Parasite"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Electrical Shock"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Overcharged"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Sonic Breath"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Energizing Smash"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Stone Gaze"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Unleashed Wrath"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Searing Light"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Mutated Plague"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["timer"] = true,
				["isColor"] = false,
				["SOUND"] = "Interface\\Quiet.mp3",
			},
			["Frozen"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Dulled Synapses"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Loose Quills"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Crimson Wake"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Ravage"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Anima Font"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Toxic Link"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Crossed Over"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Naked and Afraid"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Pursuit"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Fading Light"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Fatal Strike"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Crystalline Barrage"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Gut Spray"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Ice Tomb"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Amethyst Petrification"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Thundering Throw"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Mangle"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Ice Storm"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Aggressive Behavior"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Corrosive Resin"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Sara's Blessing"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Gouge Throat"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Keen Eyesight"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Harvest Soul"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Wounded Pride"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Grasping Tendrils"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Flash Freeze"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Arcing Lightning"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Arcane Shock"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Roaring Flame"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Penetrating Bolt"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Frost Blast"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Slow"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Lightning Lash"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Jagged Knife"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Boiling Blood"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Slumber Spores"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Volatile Fire"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Quicksand"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Sha Corruption"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Maim"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Wildfire Spark"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Bitter Thoughts"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Serpent's Vitality"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Fieroblast"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Soul Consumption"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["timer"] = true,
			},
			["Dissonance Field"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Lash of Anguish"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Weak Points"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Delirious Slash"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Focused Lightning"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Shockwave"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Sha Sear"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Shattered Ice"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Panic"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Slam"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Residue"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Blazing Sunlight"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Rot Armor"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Acid-Drenched Mandibles"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Pyroblast"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Keg Toss"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Dread Shadows"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Shroud of Sorrow"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Mesmerize"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Devastating Arc"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Grievous Bite"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Consuming Darkness"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["timer"] = true,
			},
			["Stomp"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Rune of Blood"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Corrosive Blast"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Mistress' Kiss"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Soul Sever"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Grievous Throw"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Break"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Bathed in Light"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Necrotic Plague"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Slimed"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Sunbeam"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Weakened Soul"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Faded Into Twilight"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Ignite Flesh"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Thick Bones"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Caustic Amber"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Cry of Terror"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Closed Circuit"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Corruption Kick"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Rending Charge"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Fan of Flames"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Soothing Breeze"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Cutter Laser Target"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Delayed Siege Bomb"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Trapped!"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Iron Tomb"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Low Health"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Gusting Bomb"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Deep Corruption"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Dire Fixation"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Sonic Screech"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Anima Ring"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Gouge"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Improved Synapses"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Focused Defense"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Toxic Spores"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Foul Geyser"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Lightning Storm"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Ancient Barrier"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Twilight Burst"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Fiery Grip"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Force of Will"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Hydro Lance"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Unbound Plague"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isIcon"] = true,
				["timer"] = true,
			},
			["Twisted Fate"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Gastric Bloat"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["timer"] = true,
				["isColor"] = false,
				["SOUND"] = "Interface\\Quiet.mp3",
			},
			["Frost Breath"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Terrorize"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Chilled to the Bone"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Marked Soul"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Watery Entrenchment"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Riposte"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Cho's Blast"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Jasper Petrification"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Impaled"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Fragile Bones"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Exhale"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Soul Fragment"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Swarming Shadows"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Parasitic Growth"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Mutated Infection"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Locked On"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Mark of Anguish"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Constricting Chains"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Flame Shock"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Arcane Velocity"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Tetanus"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Shadowburn"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Icy Shadows"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Blue Rays"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Lightning Conductor"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Injection"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Spinning Pain Spike"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Serious Wound"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Instability"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Corrosion"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["The Widow's Kiss"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Flame Arrows"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Pheromones of Zeal"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Waterspout"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Spray"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Huddle in Terror"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Snobolled!"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Decapitate"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Mystic Buffet"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isIcon"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
			},
			["Essence of the Blood Queen"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isIcon"] = true,
			},
			["Cinders"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Blood Corruption: Death"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Overload"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Shadowed Soul"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Exposed Veins"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Frail Soul"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Arterial Bleeding"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Icy Blood"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Explosive Tar"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Lightning Rod"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Grievous Whirl"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Beast of Nightmares"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Sand Trap"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Touch of Sha"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Lightning Bolt"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Blistering Heat"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Aim"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Arcane Wound"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Frozen Blood"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Pinned Down"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Electrical Storm"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Arctic Freeze"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Eternal Darkness"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Acid Breath"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Feed Pool"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Eyes of the Empress"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Screech"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Sundering Bite"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Biting Chill"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Tormented"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Sundering Blow"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Touch of Light"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Malevolent Strikes"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Debilitation"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Cleansing Waters"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Voodoo Doll"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Iron Prison"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Genetic Alteration"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Electrified Waters"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Unseen Strike"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Black Blood of Go'rath"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Iron Roots"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Waterlogged"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["timer"] = true,
			},
			["Clear Mind"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Purified"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Wind Storm"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Life Drain"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Lesson of Icarus"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["The Tenderizer"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Frozen Solid"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Blade Dance"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Toxic Mist"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Shadow Weakness"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Static Shock"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Matter Swap"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Overcharge"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Malformed Blood"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Crashing Thunder"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Defiled Ground"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Twilight Barrage"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Poison Cloud"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Crystal Prison Trap Effect"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Rend"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Corruption: Accelerated"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Cobalt Mine Blast"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Mortal Rend"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Cobalt Petrification"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Vengeful Strikes"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Flames of Galakrond"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Hunter's Mark"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Shadow Breath"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Froststorm Strike"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Tail Lash"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Gale Force Winds"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Necrotic Strike"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Arterial Cut"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Slicing Gale"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Gushing Wound"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Gravity Crush"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Electrostatic Charge"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Caustic Blood"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Ice Patch"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Burning Cinders"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Shield Bash"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Venom Bolt Volley"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Superheated"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Consuming Magic"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Petrification"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Fiery Edge"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
		},
		["isStacks"] = 1,
		["TIMER_TEXT"] = {
			["X_ADJUST"] = 20,
			["Y_ADJUST"] = 26,
			["ANCHOR"] = "BOTTOMRIGHT",
			["USE_OUTLINE"] = false,
			["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
			["USE_SHADOW"] = true,
			["COLOR"] = {
				["TG"] = 1,
				["R"] = 0,
				["TB"] = 1,
				["G"] = 0,
				["TR"] = 1,
				["TO"] = 1,
				["useOpacity"] = true,
				["useBackground"] = true,
				["useText"] = true,
				["O"] = 1,
				["B"] = 0,
			},
			["SCALE"] = 85,
		},
		["SOUND"] = "Interface\\Quiet.mp3",
		["point"] = "TOPRIGHT",
		["isColor"] = false,
		["max_num"] = 3,
		["yAdjust"] = -2,
		["version"] = 23,
		["COUNTER_TEXT"] = {
			["X_ADJUST"] = -10,
			["Y_ADJUST"] = -15,
			["ANCHOR"] = "TOPLEFT",
			["USE_OUTLINE"] = false,
			["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
			["USE_SHADOW"] = true,
			["COLOR"] = {
				["TG"] = 1,
				["R"] = 0,
				["TB"] = 0,
				["G"] = 0,
				["TR"] = 0,
				["TO"] = 1,
				["useOpacity"] = true,
				["useBackground"] = true,
				["useText"] = true,
				["O"] = 1,
				["B"] = 0,
			},
			["SCALE"] = 70,
		},
		["timer"] = true,
		["xAdjust"] = -2,
		["BUTTON_FACADE"] = "Blizzard",
	},
	["BLIZZ_UI_HIDE_RAID_MGR"] = 2,
	["PARSE_COMBAT_LOG"] = true,
	["SHOW_OVERHEAL"] = 1,
	["ON_MOUSE_UP"] = false,
	["BLIZZ_UI_HIDE_FOCUS"] = 1,
	["DETECT_DEBUFFS_IGNORE_NO_HARM"] = true,
	["DETECT_DEBUFFS_IGNORE_BY_CLASS"] = true,
	["BLIZZ_UI_HIDE_RAID"] = 2,
	["MAX_EMERGENCIES"] = 6,
	["INC_BOMBED_SECS"] = 3,
	["PLAYER_TARGET_FRAME_THICKNESS"] = 1,
	["INC_CHANNELLED_SECS"] = 3,
	["SHOW_PLAYER_TAGS"] = true,
	["DETECT_DEBUFFS"] = true,
	["UPDATE_HOTS_MS"] = 250,
	["SHOW_INC_CASTED"] = true,
	["AUTO_ARRANGEMENTS"] = {
		["25"] = "current",
		["15"] = "current",
		["lastAutoSaveSlot"] = 0,
		["5"] = "current",
		["dirty"] = false,
		["40"] = "current",
		["10"] = "current",
	},
	["HIDE_PANELS_SOLO"] = false,
	["CURRENT_PROFILE"] = "Banjax: LUI-Towelliee",
	["EMERGENCY_TRIGGER"] = 100,
	["SHOW_INCOMING"] = true,
	["AUTO_PROFILES"] = {
	},
	["OMIT_FOCUS"] = false,
	["IS_SHARE"] = true,
	["MODE"] = 1,
	["OVERHEAL_EXTRA_SCALE"] = 1.9,
	["BLIZZ_UI_HIDE_TARGET"] = 1,
	["doCompress"] = true,
	["THREAT"] = {
		["AGGRO_TEXT_RIGHT"] = "<<",
		["AGGRO_TEXT_LEFT"] = ">>",
		["AGGRO_USE_TEXT"] = true,
		["IS_TANK_MODE"] = false,
		["AGGRO_REFRESH_MS"] = 300,
	},
	["SHOW_TEXT_OVERHEAL"] = true,
	["SHOW_OWN_INCOMING"] = true,
	["RES_ANNOUNCE_TEXT"] = "Come to life, vuhdo, you b00n!",
	["SCAN_RANGE"] = "2",
}
VUHDO_PANEL_SETUP = {
	{
		["OVERHEAL_TEXT"] = {
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 24,
		},
		["POSITION"] = {
			["y"] = 843.262634277344,
			["x"] = 2342.642578125,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 51.9999885559082,
			["growth"] = "TOPLEFT",
			["width"] = 124.000076293945,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["ordering"] = 0,
			["groups"] = {
				1, -- [1]
				2, -- [2]
				3, -- [3]
				4, -- [4]
				5, -- [5]
			},
			["sort"] = 0,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["y"] = -100,
			["point"] = "TOPLEFT",
			["relativePoint"] = "TOPLEFT",
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["classColorsBackHeader"] = false,
			["BARS"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["BORDER"] = {
				["edgeSize"] = 9,
				["R"] = 0,
				["G"] = 0,
				["useBackground"] = true,
				["B"] = 0,
				["useOpacity"] = true,
				["file"] = "Interface\\CHARACTERFRAME\\UI-Party-Border",
				["O"] = 1,
				["insets"] = 0,
			},
			["barTexture"] = "VuhDo - Convex",
			["HEADER"] = {
				["TG"] = 0.254,
				["R"] = 0,
				["TB"] = 1,
				["barTexture"] = "Flat",
				["G"] = 0,
				["TR"] = 0.0429,
				["font"] = "Interface\\Addons\\MikScrollingBattleText\\Fonts\\transformers.ttf",
				["TO"] = 0.89,
				["B"] = 0,
				["O"] = 0.95,
				["useText"] = true,
				["textSize"] = 15,
				["useBackground"] = true,
			},
			["isBrightnessToHealth"] = false,
			["TEXT"] = {
				["outline"] = 1,
				["B"] = 0,
				["G"] = 0,
				["TR"] = 0.737,
				["USE_SHADOW"] = false,
				["textSize"] = 20,
				["TG"] = 0.705,
				["R"] = 0,
				["TB"] = 0.8189,
				["useText"] = true,
				["maxChars"] = 7,
				["font"] = "Interface\\AddOns\\ArkInventory\\Fonts\\DESIB___.ttf",
				["TO"] = 1,
				["useOpacity"] = true,
				["useBackground"] = true,
				["textSizeLife"] = 2,
				["O"] = 1,
			},
			["classColorsBar"] = false,
			["classColorsName"] = 1,
			["classColorsHeader"] = 1,
			["TARGET"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["barBackBrightness"] = 57,
			["TOT"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
		},
		["LIFE_TEXT"] = {
			["show"] = false,
			["hideIrrelevant"] = false,
			["position"] = 1,
			["showTotalHp"] = false,
			["mode"] = 1,
			["verbose"] = false,
		},
		["SCALING"] = {
			["targetWidth"] = 30,
			["barHeight"] = 44,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["maxRowsWhenLoose"] = 6,
			["totSpacing"] = 3,
			["showHeaders"] = false,
			["isDamFlash"] = false,
			["damFlashFactor"] = 0.75,
			["alignBottom"] = false,
			["headerHeight"] = 14,
			["arrangeHorizontal"] = false,
			["scale"] = 0.8,
			["swapDirection"] = false,
			["targetSpacing"] = 3,
			["targetOrientation"] = 1,
			["raidIconScale"] = 1,
			["sideLeftWidth"] = 6,
			["headerSpacing"] = 7,
			["borderGapX"] = 2,
			["sideRightWidth"] = 6,
			["rowSpacing"] = 2,
			["totWidth"] = 30,
			["maxColumnsWhenStructured"] = 8,
			["headerWidth"] = 100,
			["invertGrowth"] = false,
			["vertical"] = false,
			["borderGapY"] = 4,
			["columnSpacing"] = 2,
			["manaBarHeight"] = 3,
			["showTot"] = false,
			["barWidth"] = 120,
		},
		["IS_RAID_ICON"] = true,
		["ID_TEXT"] = {
			["_spacing"] = 19.9999923706055,
			["showName"] = true,
			["version"] = 2,
			["position"] = "TOPLEFT+TOPLEFT",
			["yAdjust"] = 0,
			["showTags"] = 1,
			["xAdjust"] = 0,
		},
		["HOTS"] = {
			["SLOTS"] = {
				"Beacon of Light", -- [1]
				"Sacred Shield", -- [2]
				"Flash of Light", -- [3]
				"Power Word: Shield", -- [4]
				"Guardian Spirit", -- [5]
				"Abolish Disease", -- [6]
			},
			["BARS"] = {
				["show"] = false,
				["radioValue"] = 1,
				["invertOrientation"] = false,
				["invertDirection"] = false,
				["width"] = 25,
			},
			["SLOTCFG"] = {
				{
					true, -- [1]
					false, -- [2]
				}, -- [1]
				{
					true, -- [1]
					true, -- [2]
				}, -- [2]
				{
					true, -- [1]
					false, -- [2]
				}, -- [3]
				{
					true, -- [1]
					false, -- [2]
				}, -- [4]
				{
					true, -- [1]
					false, -- [2]
				}, -- [5]
				{
					true, -- [1]
					true, -- [2]
				}, -- [6]
				{
					true, -- [1]
					false, -- [2]
				}, -- [7]
				{
					true, -- [1]
					false, -- [2]
				}, -- [8]
				["1"] = {
					["mine"] = true,
					["others"] = false,
				},
				["3"] = {
					["mine"] = true,
					["others"] = false,
				},
				["2"] = {
					["mine"] = true,
					["others"] = false,
				},
				["5"] = {
					["mine"] = true,
					["others"] = false,
				},
				["4"] = {
					["mine"] = true,
					["others"] = false,
				},
				["7"] = {
					["mine"] = true,
					["others"] = false,
				},
				["6"] = {
					["mine"] = true,
					["others"] = false,
				},
				["9"] = {
					["mine"] = true,
					["others"] = false,
				},
				["8"] = {
					["mine"] = true,
					["others"] = false,
				},
			},
			["isFlatTexture"] = false,
			["show"] = true,
			["iconRadioValue"] = 2,
			["radioValue"] = 20,
			["stacksRadioValue"] = 3,
			["textSize"] = 100,
			["size"] = 76,
		},
	}, -- [1]
	{
		["OVERHEAL_TEXT"] = {
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 24,
		},
		["POSITION"] = {
			["y"] = 724,
			["x"] = 369.3,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 35,
			["growth"] = "TOPLEFT",
			["width"] = 143,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["sort"] = 0,
			["ordering"] = 0,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["y"] = -100,
			["point"] = "TOPLEFT",
			["relativePoint"] = "TOPLEFT",
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["classColorsBackHeader"] = false,
			["BARS"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["mode"] = 2,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["BORDER"] = {
				["edgeSize"] = 9,
				["R"] = 0,
				["G"] = 0,
				["useBackground"] = true,
				["B"] = 0,
				["useOpacity"] = true,
				["file"] = "Interface\\CHARACTERFRAME\\UI-Party-Border",
				["O"] = 1,
				["insets"] = 0,
			},
			["barTexture"] = "Minimalist",
			["HEADER"] = {
				["TG"] = 0.254,
				["R"] = 0,
				["TB"] = 1,
				["barTexture"] = "Flat",
				["G"] = 0,
				["TR"] = 0.0429,
				["font"] = "Interface\\Addons\\MikScrollingBattleText\\Fonts\\transformers.ttf",
				["TO"] = 0.89,
				["B"] = 0,
				["O"] = 0.95,
				["useText"] = true,
				["textSize"] = 15,
				["useBackground"] = true,
			},
			["isBrightnessToHealth"] = false,
			["TEXT"] = {
				["outline"] = 1,
				["B"] = 0.901,
				["G"] = 0.901,
				["useOpacity"] = true,
				["USE_SHADOW"] = false,
				["O"] = 0,
				["TG"] = 0.8189,
				["R"] = 0.901,
				["TB"] = 0,
				["useText"] = true,
				["useBackground"] = true,
				["font"] = "Interface\\AddOns\\ArkInventory\\Fonts\\Emblem.ttf",
				["TO"] = 1,
				["TR"] = 1,
				["maxChars"] = 5,
				["textSizeLife"] = 1,
				["textSize"] = 19,
			},
			["classColorsBar"] = false,
			["classColorsName"] = 1,
			["classColorsHeader"] = 1,
			["TARGET"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["barBackBrightness"] = 85,
			["TOT"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
		},
		["LIFE_TEXT"] = {
			["hideIrrelevant"] = false,
			["position"] = 3,
			["mode"] = 1,
			["verbose"] = false,
		},
		["SCALING"] = {
			["targetWidth"] = 30,
			["barHeight"] = 38,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = true,
			["maxRowsWhenLoose"] = 6,
			["headerWidth"] = 100,
			["showHeaders"] = 1,
			["isDamFlash"] = true,
			["damFlashFactor"] = 0.75,
			["alignBottom"] = false,
			["headerHeight"] = 14,
			["arrangeHorizontal"] = false,
			["scale"] = 0.75,
			["swapDirection"] = false,
			["vertical"] = false,
			["targetOrientation"] = 1,
			["raidIconScale"] = 1,
			["sideLeftWidth"] = 6,
			["headerSpacing"] = 7,
			["borderGapX"] = 2,
			["invertGrowth"] = false,
			["rowSpacing"] = 2,
			["totWidth"] = 30,
			["maxColumnsWhenStructured"] = 8,
			["totSpacing"] = 3,
			["manaBarHeight"] = 3,
			["targetSpacing"] = 3,
			["borderGapY"] = 4,
			["columnSpacing"] = 2,
			["sideRightWidth"] = 6,
			["showTot"] = false,
			["barWidth"] = 119,
		},
		["IS_RAID_ICON"] = true,
		["ID_TEXT"] = {
			["showClass"] = false,
			["yAdjust"] = 0,
			["version"] = 2,
			["position"] = "BOTTOMRIGHT+BOTTOMRIGHT",
			["_spacing"] = 19,
			["showName"] = true,
			["xAdjust"] = 0,
		},
		["HOTS"] = {
			["SLOTS"] = {
				"Beacon of Light", -- [1]
				"Sacred Shield", -- [2]
				"Flash of Light", -- [3]
				"Power Word: Shield", -- [4]
				"Guardian Spirit", -- [5]
				"Abolish Disease", -- [6]
			},
			["BARS"] = {
				["show"] = false,
				["radioValue"] = 1,
				["invertOrientation"] = false,
				["invertDirection"] = false,
				["width"] = 25,
			},
			["SLOTCFG"] = {
				{
					true, -- [1]
					false, -- [2]
				}, -- [1]
				{
					true, -- [1]
					true, -- [2]
				}, -- [2]
				{
					true, -- [1]
					false, -- [2]
				}, -- [3]
				{
					true, -- [1]
					false, -- [2]
				}, -- [4]
				{
					true, -- [1]
					false, -- [2]
				}, -- [5]
				{
					true, -- [1]
					true, -- [2]
				}, -- [6]
				{
					true, -- [1]
					false, -- [2]
				}, -- [7]
				{
					true, -- [1]
					false, -- [2]
				}, -- [8]
				["1"] = {
					["mine"] = true,
					["others"] = false,
				},
				["3"] = {
					["mine"] = true,
					["others"] = false,
				},
				["2"] = {
					["mine"] = true,
					["others"] = false,
				},
				["5"] = {
					["mine"] = true,
					["others"] = false,
				},
				["4"] = {
					["mine"] = true,
					["others"] = false,
				},
				["7"] = {
					["mine"] = true,
					["others"] = false,
				},
				["6"] = {
					["mine"] = true,
					["others"] = false,
				},
				["9"] = {
					["mine"] = true,
					["others"] = false,
				},
				["8"] = {
					["mine"] = true,
					["others"] = false,
				},
			},
			["isFlatTexture"] = false,
			["show"] = true,
			["iconRadioValue"] = 2,
			["radioValue"] = 20,
			["stacksRadioValue"] = 3,
			["textSize"] = 100,
			["size"] = 75,
		},
	}, -- [2]
	{
		["OVERHEAL_TEXT"] = {
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 24,
		},
		["POSITION"] = {
			["y"] = 746,
			["x"] = 567.3,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 30,
			["growth"] = "TOPLEFT",
			["width"] = 85,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["ordering"] = 0,
			["sort"] = 0,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["y"] = -100,
			["point"] = "TOPLEFT",
			["relativePoint"] = "TOPLEFT",
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["classColorsBackHeader"] = false,
			["BARS"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["mode"] = 2,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["BORDER"] = {
				["edgeSize"] = 9,
				["R"] = 0,
				["G"] = 0,
				["useBackground"] = true,
				["B"] = 0,
				["useOpacity"] = true,
				["file"] = "Interface\\CHARACTERFRAME\\UI-Party-Border",
				["O"] = 1,
				["insets"] = 0,
			},
			["barTexture"] = "Minimalist",
			["HEADER"] = {
				["TG"] = 0.254,
				["R"] = 0,
				["TB"] = 1,
				["barTexture"] = "Flat",
				["G"] = 0,
				["TR"] = 0.0429,
				["font"] = "Interface\\Addons\\MikScrollingBattleText\\Fonts\\transformers.ttf",
				["TO"] = 0.89,
				["B"] = 0,
				["O"] = 0.95,
				["useText"] = true,
				["textSize"] = 15,
				["useBackground"] = true,
			},
			["isBrightnessToHealth"] = false,
			["TEXT"] = {
				["outline"] = 1,
				["B"] = 0.901,
				["G"] = 0.901,
				["useOpacity"] = true,
				["USE_SHADOW"] = false,
				["O"] = 0,
				["TG"] = 0.8189,
				["R"] = 0.901,
				["TB"] = 0,
				["useText"] = true,
				["useBackground"] = true,
				["font"] = "Interface\\AddOns\\ArkInventory\\Fonts\\Emblem.ttf",
				["TO"] = 1,
				["TR"] = 1,
				["maxChars"] = 5,
				["textSizeLife"] = 1,
				["textSize"] = 19,
			},
			["classColorsBar"] = false,
			["classColorsName"] = 1,
			["classColorsHeader"] = 1,
			["TARGET"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["barBackBrightness"] = 85,
			["TOT"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
		},
		["LIFE_TEXT"] = {
			["hideIrrelevant"] = false,
			["position"] = 3,
			["mode"] = 1,
			["verbose"] = false,
		},
		["SCALING"] = {
			["targetWidth"] = 30,
			["barHeight"] = 38,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["maxRowsWhenLoose"] = 6,
			["headerWidth"] = 100,
			["showHeaders"] = 1,
			["isDamFlash"] = true,
			["damFlashFactor"] = 0.75,
			["alignBottom"] = false,
			["headerHeight"] = 14,
			["arrangeHorizontal"] = false,
			["scale"] = 0.75,
			["swapDirection"] = false,
			["vertical"] = false,
			["targetOrientation"] = 1,
			["raidIconScale"] = 1,
			["sideLeftWidth"] = 6,
			["headerSpacing"] = 7,
			["borderGapX"] = 2,
			["invertGrowth"] = false,
			["rowSpacing"] = 2,
			["totWidth"] = 30,
			["maxColumnsWhenStructured"] = 8,
			["totSpacing"] = 3,
			["manaBarHeight"] = 3,
			["targetSpacing"] = 3,
			["borderGapY"] = 4,
			["columnSpacing"] = 2,
			["sideRightWidth"] = 6,
			["showTot"] = false,
			["barWidth"] = 119,
		},
		["IS_RAID_ICON"] = true,
		["ID_TEXT"] = {
			["showClass"] = false,
			["yAdjust"] = 0,
			["version"] = 2,
			["position"] = "BOTTOMRIGHT+BOTTOMRIGHT",
			["_spacing"] = 17.999,
			["showName"] = true,
			["xAdjust"] = 0,
		},
		["HOTS"] = {
			["SLOTS"] = {
				"Beacon of Light", -- [1]
				"Sacred Shield", -- [2]
				"Flash of Light", -- [3]
				"Power Word: Shield", -- [4]
				"Guardian Spirit", -- [5]
				"Abolish Disease", -- [6]
			},
			["BARS"] = {
				["show"] = false,
				["radioValue"] = 1,
				["invertOrientation"] = false,
				["invertDirection"] = false,
				["width"] = 25,
			},
			["SLOTCFG"] = {
				{
					true, -- [1]
					false, -- [2]
				}, -- [1]
				{
					true, -- [1]
					true, -- [2]
				}, -- [2]
				{
					true, -- [1]
					false, -- [2]
				}, -- [3]
				{
					true, -- [1]
					false, -- [2]
				}, -- [4]
				{
					true, -- [1]
					false, -- [2]
				}, -- [5]
				{
					true, -- [1]
					true, -- [2]
				}, -- [6]
				{
					true, -- [1]
					false, -- [2]
				}, -- [7]
				{
					true, -- [1]
					false, -- [2]
				}, -- [8]
				["1"] = {
					["mine"] = true,
					["others"] = false,
				},
				["3"] = {
					["mine"] = true,
					["others"] = false,
				},
				["2"] = {
					["mine"] = true,
					["others"] = false,
				},
				["5"] = {
					["mine"] = true,
					["others"] = false,
				},
				["4"] = {
					["mine"] = true,
					["others"] = false,
				},
				["7"] = {
					["mine"] = true,
					["others"] = false,
				},
				["6"] = {
					["mine"] = true,
					["others"] = false,
				},
				["9"] = {
					["mine"] = true,
					["others"] = false,
				},
				["8"] = {
					["mine"] = true,
					["others"] = false,
				},
			},
			["isFlatTexture"] = false,
			["show"] = true,
			["iconRadioValue"] = 2,
			["radioValue"] = 20,
			["stacksRadioValue"] = 3,
			["textSize"] = 100,
			["size"] = 75,
		},
	}, -- [3]
	{
		["OVERHEAL_TEXT"] = {
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 24,
		},
		["POSITION"] = {
			["y"] = 621.3,
			["x"] = 372,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 35,
			["growth"] = "TOPLEFT",
			["width"] = 231,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["ordering"] = 0,
			["sort"] = 0,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["y"] = -100,
			["point"] = "TOPLEFT",
			["relativePoint"] = "TOPLEFT",
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["classColorsBackHeader"] = false,
			["BARS"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["mode"] = 2,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["BORDER"] = {
				["edgeSize"] = 9,
				["R"] = 0,
				["G"] = 0,
				["useBackground"] = true,
				["B"] = 0,
				["useOpacity"] = true,
				["file"] = "Interface\\CHARACTERFRAME\\UI-Party-Border",
				["O"] = 1,
				["insets"] = 0,
			},
			["barTexture"] = "Minimalist",
			["HEADER"] = {
				["TG"] = 0.254,
				["R"] = 0,
				["TB"] = 1,
				["barTexture"] = "Flat",
				["G"] = 0,
				["TR"] = 0.0429,
				["font"] = "Interface\\Addons\\MikScrollingBattleText\\Fonts\\transformers.ttf",
				["TO"] = 0.89,
				["B"] = 0,
				["O"] = 0.95,
				["useText"] = true,
				["textSize"] = 15,
				["useBackground"] = true,
			},
			["isBrightnessToHealth"] = false,
			["TEXT"] = {
				["outline"] = 1,
				["B"] = 0.901,
				["G"] = 0.901,
				["useOpacity"] = true,
				["USE_SHADOW"] = false,
				["O"] = 0,
				["TG"] = 0.8189,
				["R"] = 0.901,
				["TB"] = 0,
				["useText"] = true,
				["useBackground"] = true,
				["font"] = "Interface\\AddOns\\ArkInventory\\Fonts\\Emblem.ttf",
				["TO"] = 1,
				["TR"] = 1,
				["maxChars"] = 5,
				["textSizeLife"] = 1,
				["textSize"] = 19,
			},
			["classColorsBar"] = false,
			["classColorsName"] = 1,
			["classColorsHeader"] = 1,
			["TARGET"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["barBackBrightness"] = 85,
			["TOT"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
		},
		["LIFE_TEXT"] = {
			["hideIrrelevant"] = false,
			["position"] = 3,
			["mode"] = 1,
			["verbose"] = false,
		},
		["SCALING"] = {
			["targetWidth"] = 30,
			["barHeight"] = 38,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = true,
			["maxRowsWhenLoose"] = 6,
			["headerWidth"] = 100,
			["showHeaders"] = 1,
			["isDamFlash"] = true,
			["damFlashFactor"] = 0.75,
			["alignBottom"] = false,
			["headerHeight"] = 14,
			["arrangeHorizontal"] = false,
			["scale"] = 0.75,
			["swapDirection"] = false,
			["vertical"] = false,
			["targetOrientation"] = 1,
			["raidIconScale"] = 1,
			["sideLeftWidth"] = 6,
			["headerSpacing"] = 7,
			["borderGapX"] = 2,
			["invertGrowth"] = false,
			["rowSpacing"] = 2,
			["totWidth"] = 30,
			["maxColumnsWhenStructured"] = 8,
			["totSpacing"] = 3,
			["manaBarHeight"] = 3,
			["targetSpacing"] = 3,
			["borderGapY"] = 4,
			["columnSpacing"] = 2,
			["sideRightWidth"] = 6,
			["showTot"] = false,
			["barWidth"] = 119,
		},
		["IS_RAID_ICON"] = true,
		["ID_TEXT"] = {
			["showClass"] = false,
			["yAdjust"] = 0,
			["version"] = 2,
			["position"] = "BOTTOMRIGHT+BOTTOMRIGHT",
			["_spacing"] = 17.999,
			["showName"] = true,
			["xAdjust"] = 0,
		},
		["HOTS"] = {
			["SLOTS"] = {
				"Beacon of Light", -- [1]
				"Sacred Shield", -- [2]
				"Flash of Light", -- [3]
				"Power Word: Shield", -- [4]
				"Guardian Spirit", -- [5]
				"Abolish Disease", -- [6]
			},
			["BARS"] = {
				["show"] = false,
				["radioValue"] = 1,
				["invertOrientation"] = false,
				["invertDirection"] = false,
				["width"] = 25,
			},
			["SLOTCFG"] = {
				{
					true, -- [1]
					false, -- [2]
				}, -- [1]
				{
					true, -- [1]
					true, -- [2]
				}, -- [2]
				{
					true, -- [1]
					false, -- [2]
				}, -- [3]
				{
					true, -- [1]
					false, -- [2]
				}, -- [4]
				{
					true, -- [1]
					false, -- [2]
				}, -- [5]
				{
					true, -- [1]
					true, -- [2]
				}, -- [6]
				{
					true, -- [1]
					false, -- [2]
				}, -- [7]
				{
					true, -- [1]
					false, -- [2]
				}, -- [8]
				["1"] = {
					["mine"] = true,
					["others"] = false,
				},
				["3"] = {
					["mine"] = true,
					["others"] = false,
				},
				["2"] = {
					["mine"] = true,
					["others"] = false,
				},
				["5"] = {
					["mine"] = true,
					["others"] = false,
				},
				["4"] = {
					["mine"] = true,
					["others"] = false,
				},
				["7"] = {
					["mine"] = true,
					["others"] = false,
				},
				["6"] = {
					["mine"] = true,
					["others"] = false,
				},
				["9"] = {
					["mine"] = true,
					["others"] = false,
				},
				["8"] = {
					["mine"] = true,
					["others"] = false,
				},
			},
			["isFlatTexture"] = false,
			["show"] = true,
			["iconRadioValue"] = 2,
			["radioValue"] = 20,
			["stacksRadioValue"] = 3,
			["textSize"] = 100,
			["size"] = 75,
		},
	}, -- [4]
	{
		["OVERHEAL_TEXT"] = {
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 24,
		},
		["POSITION"] = {
			["y"] = 518,
			["x"] = 250,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 200,
			["growth"] = "TOPLEFT",
			["width"] = 200,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["sort"] = 0,
			["ordering"] = 0,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["y"] = -100,
			["point"] = "TOPLEFT",
			["relativePoint"] = "TOPLEFT",
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["classColorsBackHeader"] = false,
			["BARS"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["mode"] = 2,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["BORDER"] = {
				["edgeSize"] = 9,
				["R"] = 0,
				["G"] = 0,
				["useBackground"] = true,
				["B"] = 0,
				["useOpacity"] = true,
				["file"] = "Interface\\CHARACTERFRAME\\UI-Party-Border",
				["O"] = 1,
				["insets"] = 0,
			},
			["barTexture"] = "Minimalist",
			["HEADER"] = {
				["TG"] = 0.254,
				["R"] = 0,
				["TB"] = 1,
				["barTexture"] = "Flat",
				["G"] = 0,
				["TR"] = 0.0429,
				["font"] = "Interface\\Addons\\MikScrollingBattleText\\Fonts\\transformers.ttf",
				["TO"] = 0.89,
				["B"] = 0,
				["O"] = 0.95,
				["useText"] = true,
				["textSize"] = 15,
				["useBackground"] = true,
			},
			["isBrightnessToHealth"] = false,
			["TEXT"] = {
				["outline"] = 1,
				["B"] = 0.901,
				["G"] = 0.901,
				["useOpacity"] = true,
				["USE_SHADOW"] = false,
				["O"] = 0,
				["TG"] = 0.8189,
				["R"] = 0.901,
				["TB"] = 0,
				["useText"] = true,
				["useBackground"] = true,
				["font"] = "Interface\\AddOns\\ArkInventory\\Fonts\\Emblem.ttf",
				["TO"] = 1,
				["TR"] = 1,
				["maxChars"] = 5,
				["textSizeLife"] = 1,
				["textSize"] = 19,
			},
			["classColorsBar"] = false,
			["classColorsName"] = 1,
			["classColorsHeader"] = 1,
			["TARGET"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["barBackBrightness"] = 85,
			["TOT"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
		},
		["LIFE_TEXT"] = {
			["hideIrrelevant"] = false,
			["position"] = 3,
			["mode"] = 1,
			["verbose"] = false,
		},
		["SCALING"] = {
			["targetWidth"] = 30,
			["barHeight"] = 38,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["maxRowsWhenLoose"] = 6,
			["headerWidth"] = 100,
			["showHeaders"] = 1,
			["isDamFlash"] = true,
			["damFlashFactor"] = 0.75,
			["alignBottom"] = false,
			["headerHeight"] = 14,
			["arrangeHorizontal"] = false,
			["scale"] = 0.75,
			["swapDirection"] = false,
			["vertical"] = false,
			["targetOrientation"] = 1,
			["raidIconScale"] = 1,
			["sideLeftWidth"] = 6,
			["headerSpacing"] = 7,
			["borderGapX"] = 2,
			["invertGrowth"] = false,
			["rowSpacing"] = 2,
			["totWidth"] = 30,
			["maxColumnsWhenStructured"] = 8,
			["totSpacing"] = 3,
			["manaBarHeight"] = 3,
			["targetSpacing"] = 3,
			["borderGapY"] = 4,
			["columnSpacing"] = 2,
			["sideRightWidth"] = 6,
			["showTot"] = false,
			["barWidth"] = 119,
		},
		["IS_RAID_ICON"] = true,
		["ID_TEXT"] = {
			["showClass"] = false,
			["yAdjust"] = 0,
			["version"] = 2,
			["position"] = "BOTTOMRIGHT+BOTTOMRIGHT",
			["showName"] = true,
			["xAdjust"] = 0,
		},
		["HOTS"] = {
			["SLOTS"] = {
				"Beacon of Light", -- [1]
				"Sacred Shield", -- [2]
				"Flash of Light", -- [3]
				"Power Word: Shield", -- [4]
				"Guardian Spirit", -- [5]
				"Abolish Disease", -- [6]
			},
			["BARS"] = {
				["show"] = false,
				["radioValue"] = 1,
				["invertOrientation"] = false,
				["invertDirection"] = false,
				["width"] = 25,
			},
			["SLOTCFG"] = {
				{
					true, -- [1]
					false, -- [2]
				}, -- [1]
				{
					true, -- [1]
					true, -- [2]
				}, -- [2]
				{
					true, -- [1]
					false, -- [2]
				}, -- [3]
				{
					true, -- [1]
					false, -- [2]
				}, -- [4]
				{
					true, -- [1]
					false, -- [2]
				}, -- [5]
				{
					true, -- [1]
					true, -- [2]
				}, -- [6]
				{
					true, -- [1]
					false, -- [2]
				}, -- [7]
				{
					true, -- [1]
					false, -- [2]
				}, -- [8]
				["1"] = {
					["mine"] = true,
					["others"] = false,
				},
				["3"] = {
					["mine"] = true,
					["others"] = false,
				},
				["2"] = {
					["mine"] = true,
					["others"] = false,
				},
				["5"] = {
					["mine"] = true,
					["others"] = false,
				},
				["4"] = {
					["mine"] = true,
					["others"] = false,
				},
				["7"] = {
					["mine"] = true,
					["others"] = false,
				},
				["6"] = {
					["mine"] = true,
					["others"] = false,
				},
				["9"] = {
					["mine"] = true,
					["others"] = false,
				},
				["8"] = {
					["mine"] = true,
					["others"] = false,
				},
			},
			["isFlatTexture"] = false,
			["show"] = true,
			["iconRadioValue"] = 2,
			["radioValue"] = 20,
			["stacksRadioValue"] = 3,
			["textSize"] = 100,
			["size"] = 75,
		},
	}, -- [5]
	{
		["OVERHEAL_TEXT"] = {
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 24,
		},
		["POSITION"] = {
			["y"] = 488,
			["x"] = 280,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 200,
			["growth"] = "TOPLEFT",
			["width"] = 200,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["sort"] = 0,
			["ordering"] = 0,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["y"] = -100,
			["point"] = "TOPLEFT",
			["relativePoint"] = "TOPLEFT",
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["classColorsBackHeader"] = false,
			["BARS"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["mode"] = 2,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["BORDER"] = {
				["edgeSize"] = 9,
				["R"] = 0,
				["G"] = 0,
				["useBackground"] = true,
				["B"] = 0,
				["useOpacity"] = true,
				["file"] = "Interface\\CHARACTERFRAME\\UI-Party-Border",
				["O"] = 1,
				["insets"] = 0,
			},
			["barTexture"] = "Minimalist",
			["HEADER"] = {
				["TG"] = 0.254,
				["R"] = 0,
				["TB"] = 1,
				["barTexture"] = "Flat",
				["G"] = 0,
				["TR"] = 0.0429,
				["font"] = "Interface\\Addons\\MikScrollingBattleText\\Fonts\\transformers.ttf",
				["TO"] = 0.89,
				["B"] = 0,
				["O"] = 0.95,
				["useText"] = true,
				["textSize"] = 15,
				["useBackground"] = true,
			},
			["isBrightnessToHealth"] = false,
			["TEXT"] = {
				["outline"] = 1,
				["B"] = 0.901,
				["G"] = 0.901,
				["useOpacity"] = true,
				["USE_SHADOW"] = false,
				["O"] = 0,
				["TG"] = 0.8189,
				["R"] = 0.901,
				["TB"] = 0,
				["useText"] = true,
				["useBackground"] = true,
				["font"] = "Interface\\AddOns\\ArkInventory\\Fonts\\Emblem.ttf",
				["TO"] = 1,
				["TR"] = 1,
				["maxChars"] = 5,
				["textSizeLife"] = 1,
				["textSize"] = 19,
			},
			["classColorsBar"] = false,
			["classColorsName"] = 1,
			["classColorsHeader"] = 1,
			["TARGET"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["barBackBrightness"] = 85,
			["TOT"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
		},
		["LIFE_TEXT"] = {
			["hideIrrelevant"] = false,
			["position"] = 3,
			["mode"] = 1,
			["verbose"] = false,
		},
		["SCALING"] = {
			["targetWidth"] = 30,
			["barHeight"] = 38,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["maxRowsWhenLoose"] = 6,
			["headerWidth"] = 100,
			["showHeaders"] = 1,
			["isDamFlash"] = true,
			["damFlashFactor"] = 0.75,
			["alignBottom"] = false,
			["headerHeight"] = 14,
			["arrangeHorizontal"] = false,
			["scale"] = 0.75,
			["swapDirection"] = false,
			["vertical"] = false,
			["targetOrientation"] = 1,
			["raidIconScale"] = 1,
			["sideLeftWidth"] = 6,
			["headerSpacing"] = 7,
			["borderGapX"] = 2,
			["invertGrowth"] = false,
			["rowSpacing"] = 2,
			["totWidth"] = 30,
			["maxColumnsWhenStructured"] = 8,
			["totSpacing"] = 3,
			["manaBarHeight"] = 3,
			["targetSpacing"] = 3,
			["borderGapY"] = 4,
			["columnSpacing"] = 2,
			["sideRightWidth"] = 6,
			["showTot"] = false,
			["barWidth"] = 119,
		},
		["IS_RAID_ICON"] = true,
		["ID_TEXT"] = {
			["showClass"] = false,
			["yAdjust"] = 0,
			["version"] = 2,
			["position"] = "BOTTOMRIGHT+BOTTOMRIGHT",
			["showName"] = true,
			["xAdjust"] = 0,
		},
		["HOTS"] = {
			["SLOTS"] = {
				"Beacon of Light", -- [1]
				"Sacred Shield", -- [2]
				"Flash of Light", -- [3]
				"Power Word: Shield", -- [4]
				"Guardian Spirit", -- [5]
				"Abolish Disease", -- [6]
			},
			["BARS"] = {
				["show"] = false,
				["radioValue"] = 1,
				["invertOrientation"] = false,
				["invertDirection"] = false,
				["width"] = 25,
			},
			["SLOTCFG"] = {
				{
					true, -- [1]
					false, -- [2]
				}, -- [1]
				{
					true, -- [1]
					true, -- [2]
				}, -- [2]
				{
					true, -- [1]
					false, -- [2]
				}, -- [3]
				{
					true, -- [1]
					false, -- [2]
				}, -- [4]
				{
					true, -- [1]
					false, -- [2]
				}, -- [5]
				{
					true, -- [1]
					true, -- [2]
				}, -- [6]
				{
					true, -- [1]
					false, -- [2]
				}, -- [7]
				{
					true, -- [1]
					false, -- [2]
				}, -- [8]
				["1"] = {
					["mine"] = true,
					["others"] = false,
				},
				["3"] = {
					["mine"] = true,
					["others"] = false,
				},
				["2"] = {
					["mine"] = true,
					["others"] = false,
				},
				["5"] = {
					["mine"] = true,
					["others"] = false,
				},
				["4"] = {
					["mine"] = true,
					["others"] = false,
				},
				["7"] = {
					["mine"] = true,
					["others"] = false,
				},
				["6"] = {
					["mine"] = true,
					["others"] = false,
				},
				["9"] = {
					["mine"] = true,
					["others"] = false,
				},
				["8"] = {
					["mine"] = true,
					["others"] = false,
				},
			},
			["isFlatTexture"] = false,
			["show"] = true,
			["iconRadioValue"] = 2,
			["radioValue"] = 20,
			["stacksRadioValue"] = 3,
			["textSize"] = 100,
			["size"] = 75,
		},
	}, -- [6]
	{
		["OVERHEAL_TEXT"] = {
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 24,
		},
		["POSITION"] = {
			["y"] = 458,
			["x"] = 310,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 200,
			["growth"] = "TOPLEFT",
			["width"] = 200,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["sort"] = 0,
			["ordering"] = 0,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["y"] = -100,
			["point"] = "TOPLEFT",
			["relativePoint"] = "TOPLEFT",
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["classColorsBackHeader"] = false,
			["BARS"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["mode"] = 2,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["BORDER"] = {
				["edgeSize"] = 9,
				["R"] = 0,
				["G"] = 0,
				["useBackground"] = true,
				["B"] = 0,
				["useOpacity"] = true,
				["file"] = "Interface\\CHARACTERFRAME\\UI-Party-Border",
				["O"] = 1,
				["insets"] = 0,
			},
			["barTexture"] = "Minimalist",
			["HEADER"] = {
				["TG"] = 0.254,
				["R"] = 0,
				["TB"] = 1,
				["barTexture"] = "Flat",
				["G"] = 0,
				["TR"] = 0.0429,
				["font"] = "Interface\\Addons\\MikScrollingBattleText\\Fonts\\transformers.ttf",
				["TO"] = 0.89,
				["B"] = 0,
				["O"] = 0.95,
				["useText"] = true,
				["textSize"] = 15,
				["useBackground"] = true,
			},
			["isBrightnessToHealth"] = false,
			["TEXT"] = {
				["outline"] = 1,
				["B"] = 0.901,
				["G"] = 0.901,
				["useOpacity"] = true,
				["USE_SHADOW"] = false,
				["O"] = 0,
				["TG"] = 0.8189,
				["R"] = 0.901,
				["TB"] = 0,
				["useText"] = true,
				["useBackground"] = true,
				["font"] = "Interface\\AddOns\\ArkInventory\\Fonts\\Emblem.ttf",
				["TO"] = 1,
				["TR"] = 1,
				["maxChars"] = 5,
				["textSizeLife"] = 1,
				["textSize"] = 19,
			},
			["classColorsBar"] = false,
			["classColorsName"] = 1,
			["classColorsHeader"] = 1,
			["TARGET"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["barBackBrightness"] = 85,
			["TOT"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
		},
		["LIFE_TEXT"] = {
			["hideIrrelevant"] = false,
			["position"] = 3,
			["mode"] = 1,
			["verbose"] = false,
		},
		["SCALING"] = {
			["targetWidth"] = 30,
			["barHeight"] = 38,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["maxRowsWhenLoose"] = 6,
			["headerWidth"] = 100,
			["showHeaders"] = 1,
			["isDamFlash"] = true,
			["damFlashFactor"] = 0.75,
			["alignBottom"] = false,
			["headerHeight"] = 14,
			["arrangeHorizontal"] = false,
			["scale"] = 0.75,
			["swapDirection"] = false,
			["vertical"] = false,
			["targetOrientation"] = 1,
			["raidIconScale"] = 1,
			["sideLeftWidth"] = 6,
			["headerSpacing"] = 7,
			["borderGapX"] = 2,
			["invertGrowth"] = false,
			["rowSpacing"] = 2,
			["totWidth"] = 30,
			["maxColumnsWhenStructured"] = 8,
			["totSpacing"] = 3,
			["manaBarHeight"] = 3,
			["targetSpacing"] = 3,
			["borderGapY"] = 4,
			["columnSpacing"] = 2,
			["sideRightWidth"] = 6,
			["showTot"] = false,
			["barWidth"] = 119,
		},
		["IS_RAID_ICON"] = true,
		["ID_TEXT"] = {
			["showClass"] = false,
			["yAdjust"] = 0,
			["version"] = 2,
			["position"] = "BOTTOMRIGHT+BOTTOMRIGHT",
			["showName"] = true,
			["xAdjust"] = 0,
		},
		["HOTS"] = {
			["SLOTS"] = {
				"Beacon of Light", -- [1]
				"Sacred Shield", -- [2]
				"Flash of Light", -- [3]
				"Power Word: Shield", -- [4]
				"Guardian Spirit", -- [5]
				"Abolish Disease", -- [6]
			},
			["BARS"] = {
				["show"] = false,
				["radioValue"] = 1,
				["invertOrientation"] = false,
				["invertDirection"] = false,
				["width"] = 25,
			},
			["SLOTCFG"] = {
				{
					true, -- [1]
					false, -- [2]
				}, -- [1]
				{
					true, -- [1]
					true, -- [2]
				}, -- [2]
				{
					true, -- [1]
					false, -- [2]
				}, -- [3]
				{
					true, -- [1]
					false, -- [2]
				}, -- [4]
				{
					true, -- [1]
					false, -- [2]
				}, -- [5]
				{
					true, -- [1]
					true, -- [2]
				}, -- [6]
				{
					true, -- [1]
					false, -- [2]
				}, -- [7]
				{
					true, -- [1]
					false, -- [2]
				}, -- [8]
				["1"] = {
					["mine"] = true,
					["others"] = false,
				},
				["3"] = {
					["mine"] = true,
					["others"] = false,
				},
				["2"] = {
					["mine"] = true,
					["others"] = false,
				},
				["5"] = {
					["mine"] = true,
					["others"] = false,
				},
				["4"] = {
					["mine"] = true,
					["others"] = false,
				},
				["7"] = {
					["mine"] = true,
					["others"] = false,
				},
				["6"] = {
					["mine"] = true,
					["others"] = false,
				},
				["9"] = {
					["mine"] = true,
					["others"] = false,
				},
				["8"] = {
					["mine"] = true,
					["others"] = false,
				},
			},
			["isFlatTexture"] = false,
			["show"] = true,
			["iconRadioValue"] = 2,
			["radioValue"] = 20,
			["stacksRadioValue"] = 3,
			["textSize"] = 100,
			["size"] = 75,
		},
	}, -- [7]
	{
		["OVERHEAL_TEXT"] = {
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 24,
		},
		["POSITION"] = {
			["y"] = 428,
			["x"] = 340,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 200,
			["growth"] = "TOPLEFT",
			["width"] = 200,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["sort"] = 0,
			["ordering"] = 0,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["y"] = -100,
			["point"] = "TOPLEFT",
			["relativePoint"] = "TOPLEFT",
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["classColorsBackHeader"] = false,
			["BARS"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["mode"] = 2,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["BORDER"] = {
				["edgeSize"] = 9,
				["R"] = 0,
				["G"] = 0,
				["useBackground"] = true,
				["B"] = 0,
				["useOpacity"] = true,
				["file"] = "Interface\\CHARACTERFRAME\\UI-Party-Border",
				["O"] = 1,
				["insets"] = 0,
			},
			["barTexture"] = "Minimalist",
			["HEADER"] = {
				["TG"] = 0.254,
				["R"] = 0,
				["TB"] = 1,
				["barTexture"] = "Flat",
				["G"] = 0,
				["TR"] = 0.0429,
				["font"] = "Interface\\Addons\\MikScrollingBattleText\\Fonts\\transformers.ttf",
				["TO"] = 0.89,
				["B"] = 0,
				["O"] = 0.95,
				["useText"] = true,
				["textSize"] = 15,
				["useBackground"] = true,
			},
			["isBrightnessToHealth"] = false,
			["TEXT"] = {
				["outline"] = 1,
				["B"] = 0.901,
				["G"] = 0.901,
				["useOpacity"] = true,
				["USE_SHADOW"] = false,
				["O"] = 0,
				["TG"] = 0.8189,
				["R"] = 0.901,
				["TB"] = 0,
				["useText"] = true,
				["useBackground"] = true,
				["font"] = "Interface\\AddOns\\ArkInventory\\Fonts\\Emblem.ttf",
				["TO"] = 1,
				["TR"] = 1,
				["maxChars"] = 5,
				["textSizeLife"] = 1,
				["textSize"] = 19,
			},
			["classColorsBar"] = false,
			["classColorsName"] = 1,
			["classColorsHeader"] = 1,
			["TARGET"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["barBackBrightness"] = 85,
			["TOT"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
		},
		["LIFE_TEXT"] = {
			["hideIrrelevant"] = false,
			["position"] = 3,
			["mode"] = 1,
			["verbose"] = false,
		},
		["SCALING"] = {
			["targetWidth"] = 30,
			["barHeight"] = 38,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["maxRowsWhenLoose"] = 6,
			["headerWidth"] = 100,
			["showHeaders"] = 1,
			["isDamFlash"] = true,
			["damFlashFactor"] = 0.75,
			["alignBottom"] = false,
			["headerHeight"] = 14,
			["arrangeHorizontal"] = false,
			["scale"] = 0.75,
			["swapDirection"] = false,
			["vertical"] = false,
			["targetOrientation"] = 1,
			["raidIconScale"] = 1,
			["sideLeftWidth"] = 6,
			["headerSpacing"] = 7,
			["borderGapX"] = 2,
			["invertGrowth"] = false,
			["rowSpacing"] = 2,
			["totWidth"] = 30,
			["maxColumnsWhenStructured"] = 8,
			["totSpacing"] = 3,
			["manaBarHeight"] = 3,
			["targetSpacing"] = 3,
			["borderGapY"] = 4,
			["columnSpacing"] = 2,
			["sideRightWidth"] = 6,
			["showTot"] = false,
			["barWidth"] = 119,
		},
		["IS_RAID_ICON"] = true,
		["ID_TEXT"] = {
			["showClass"] = false,
			["yAdjust"] = 0,
			["version"] = 2,
			["position"] = "BOTTOMRIGHT+BOTTOMRIGHT",
			["showName"] = true,
			["xAdjust"] = 0,
		},
		["HOTS"] = {
			["SLOTS"] = {
				"Beacon of Light", -- [1]
				"Sacred Shield", -- [2]
				"Flash of Light", -- [3]
				"Power Word: Shield", -- [4]
				"Guardian Spirit", -- [5]
				"Abolish Disease", -- [6]
			},
			["BARS"] = {
				["show"] = false,
				["radioValue"] = 1,
				["invertOrientation"] = false,
				["invertDirection"] = false,
				["width"] = 25,
			},
			["SLOTCFG"] = {
				{
					true, -- [1]
					false, -- [2]
				}, -- [1]
				{
					true, -- [1]
					true, -- [2]
				}, -- [2]
				{
					true, -- [1]
					false, -- [2]
				}, -- [3]
				{
					true, -- [1]
					false, -- [2]
				}, -- [4]
				{
					true, -- [1]
					false, -- [2]
				}, -- [5]
				{
					true, -- [1]
					true, -- [2]
				}, -- [6]
				{
					true, -- [1]
					false, -- [2]
				}, -- [7]
				{
					true, -- [1]
					false, -- [2]
				}, -- [8]
				["1"] = {
					["mine"] = true,
					["others"] = false,
				},
				["3"] = {
					["mine"] = true,
					["others"] = false,
				},
				["2"] = {
					["mine"] = true,
					["others"] = false,
				},
				["5"] = {
					["mine"] = true,
					["others"] = false,
				},
				["4"] = {
					["mine"] = true,
					["others"] = false,
				},
				["7"] = {
					["mine"] = true,
					["others"] = false,
				},
				["6"] = {
					["mine"] = true,
					["others"] = false,
				},
				["9"] = {
					["mine"] = true,
					["others"] = false,
				},
				["8"] = {
					["mine"] = true,
					["others"] = false,
				},
			},
			["isFlatTexture"] = false,
			["show"] = true,
			["iconRadioValue"] = 2,
			["radioValue"] = 20,
			["stacksRadioValue"] = 3,
			["textSize"] = 100,
			["size"] = 75,
		},
	}, -- [8]
	{
		["OVERHEAL_TEXT"] = {
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 24,
		},
		["POSITION"] = {
			["y"] = 398,
			["x"] = 370,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 200,
			["growth"] = "TOPLEFT",
			["width"] = 200,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["sort"] = 0,
			["ordering"] = 0,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["y"] = -100,
			["point"] = "TOPLEFT",
			["relativePoint"] = "TOPLEFT",
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["classColorsBackHeader"] = false,
			["BARS"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["mode"] = 2,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["BORDER"] = {
				["edgeSize"] = 9,
				["R"] = 0,
				["G"] = 0,
				["useBackground"] = true,
				["B"] = 0,
				["useOpacity"] = true,
				["file"] = "Interface\\CHARACTERFRAME\\UI-Party-Border",
				["O"] = 1,
				["insets"] = 0,
			},
			["barTexture"] = "Minimalist",
			["HEADER"] = {
				["TG"] = 0.254,
				["R"] = 0,
				["TB"] = 1,
				["barTexture"] = "Flat",
				["G"] = 0,
				["TR"] = 0.0429,
				["font"] = "Interface\\Addons\\MikScrollingBattleText\\Fonts\\transformers.ttf",
				["TO"] = 0.89,
				["B"] = 0,
				["O"] = 0.95,
				["useText"] = true,
				["textSize"] = 15,
				["useBackground"] = true,
			},
			["isBrightnessToHealth"] = false,
			["TEXT"] = {
				["outline"] = 1,
				["B"] = 0.901,
				["G"] = 0.901,
				["useOpacity"] = true,
				["USE_SHADOW"] = false,
				["O"] = 0,
				["TG"] = 0.8189,
				["R"] = 0.901,
				["TB"] = 0,
				["useText"] = true,
				["useBackground"] = true,
				["font"] = "Interface\\AddOns\\ArkInventory\\Fonts\\Emblem.ttf",
				["TO"] = 1,
				["TR"] = 1,
				["maxChars"] = 5,
				["textSizeLife"] = 1,
				["textSize"] = 19,
			},
			["classColorsBar"] = false,
			["classColorsName"] = 1,
			["classColorsHeader"] = 1,
			["TARGET"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["barBackBrightness"] = 85,
			["TOT"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
		},
		["LIFE_TEXT"] = {
			["hideIrrelevant"] = false,
			["position"] = 3,
			["mode"] = 1,
			["verbose"] = false,
		},
		["SCALING"] = {
			["targetWidth"] = 30,
			["barHeight"] = 38,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["maxRowsWhenLoose"] = 6,
			["headerWidth"] = 100,
			["showHeaders"] = 1,
			["isDamFlash"] = true,
			["damFlashFactor"] = 0.75,
			["alignBottom"] = false,
			["headerHeight"] = 14,
			["arrangeHorizontal"] = false,
			["scale"] = 0.75,
			["swapDirection"] = false,
			["vertical"] = false,
			["targetOrientation"] = 1,
			["raidIconScale"] = 1,
			["sideLeftWidth"] = 6,
			["headerSpacing"] = 7,
			["borderGapX"] = 2,
			["invertGrowth"] = false,
			["rowSpacing"] = 2,
			["totWidth"] = 30,
			["maxColumnsWhenStructured"] = 8,
			["totSpacing"] = 3,
			["manaBarHeight"] = 3,
			["targetSpacing"] = 3,
			["borderGapY"] = 4,
			["columnSpacing"] = 2,
			["sideRightWidth"] = 6,
			["showTot"] = false,
			["barWidth"] = 119,
		},
		["IS_RAID_ICON"] = true,
		["ID_TEXT"] = {
			["showClass"] = false,
			["yAdjust"] = 0,
			["version"] = 2,
			["position"] = "BOTTOMRIGHT+BOTTOMRIGHT",
			["showName"] = true,
			["xAdjust"] = 0,
		},
		["HOTS"] = {
			["SLOTS"] = {
				"Beacon of Light", -- [1]
				"Sacred Shield", -- [2]
				"Flash of Light", -- [3]
				"Power Word: Shield", -- [4]
				"Guardian Spirit", -- [5]
				"Abolish Disease", -- [6]
			},
			["BARS"] = {
				["show"] = false,
				["radioValue"] = 1,
				["invertOrientation"] = false,
				["invertDirection"] = false,
				["width"] = 25,
			},
			["SLOTCFG"] = {
				{
					true, -- [1]
					false, -- [2]
				}, -- [1]
				{
					true, -- [1]
					true, -- [2]
				}, -- [2]
				{
					true, -- [1]
					false, -- [2]
				}, -- [3]
				{
					true, -- [1]
					false, -- [2]
				}, -- [4]
				{
					true, -- [1]
					false, -- [2]
				}, -- [5]
				{
					true, -- [1]
					true, -- [2]
				}, -- [6]
				{
					true, -- [1]
					false, -- [2]
				}, -- [7]
				{
					true, -- [1]
					false, -- [2]
				}, -- [8]
				["1"] = {
					["mine"] = true,
					["others"] = false,
				},
				["3"] = {
					["mine"] = true,
					["others"] = false,
				},
				["2"] = {
					["mine"] = true,
					["others"] = false,
				},
				["5"] = {
					["mine"] = true,
					["others"] = false,
				},
				["4"] = {
					["mine"] = true,
					["others"] = false,
				},
				["7"] = {
					["mine"] = true,
					["others"] = false,
				},
				["6"] = {
					["mine"] = true,
					["others"] = false,
				},
				["9"] = {
					["mine"] = true,
					["others"] = false,
				},
				["8"] = {
					["mine"] = true,
					["others"] = false,
				},
			},
			["isFlatTexture"] = false,
			["show"] = true,
			["iconRadioValue"] = 2,
			["radioValue"] = 20,
			["stacksRadioValue"] = 3,
			["textSize"] = 100,
			["size"] = 75,
		},
	}, -- [9]
	{
		["OVERHEAL_TEXT"] = {
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 24,
		},
		["POSITION"] = {
			["y"] = 368,
			["x"] = 400,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 200,
			["growth"] = "TOPLEFT",
			["width"] = 200,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["sort"] = 0,
			["ordering"] = 0,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["inFight"] = false,
			["BORDER"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["showBuffs"] = false,
			["show"] = true,
			["x"] = 100,
			["position"] = 2,
			["SCALE"] = 1,
			["y"] = -100,
			["point"] = "TOPLEFT",
			["relativePoint"] = "TOPLEFT",
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["classColorsBackHeader"] = false,
			["BARS"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 0,
				["G"] = 0,
				["mode"] = 2,
				["O"] = 1,
				["useOpacity"] = true,
			},
			["BORDER"] = {
				["edgeSize"] = 9,
				["R"] = 0,
				["G"] = 0,
				["useBackground"] = true,
				["B"] = 0,
				["useOpacity"] = true,
				["file"] = "Interface\\CHARACTERFRAME\\UI-Party-Border",
				["O"] = 1,
				["insets"] = 0,
			},
			["barTexture"] = "Minimalist",
			["HEADER"] = {
				["TG"] = 0.254,
				["R"] = 0,
				["TB"] = 1,
				["barTexture"] = "Flat",
				["G"] = 0,
				["TR"] = 0.0429,
				["font"] = "Interface\\Addons\\MikScrollingBattleText\\Fonts\\transformers.ttf",
				["TO"] = 0.89,
				["B"] = 0,
				["O"] = 0.95,
				["useText"] = true,
				["textSize"] = 15,
				["useBackground"] = true,
			},
			["isBrightnessToHealth"] = false,
			["TEXT"] = {
				["outline"] = 1,
				["B"] = 0.901,
				["G"] = 0.901,
				["useOpacity"] = true,
				["USE_SHADOW"] = false,
				["O"] = 0,
				["TG"] = 0.8189,
				["R"] = 0.901,
				["TB"] = 0,
				["useText"] = true,
				["useBackground"] = true,
				["font"] = "Interface\\AddOns\\ArkInventory\\Fonts\\Emblem.ttf",
				["TO"] = 1,
				["TR"] = 1,
				["maxChars"] = 5,
				["textSizeLife"] = 1,
				["textSize"] = 19,
			},
			["classColorsBar"] = false,
			["classColorsName"] = 1,
			["classColorsHeader"] = 1,
			["TARGET"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["barBackBrightness"] = 85,
			["TOT"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
		},
		["LIFE_TEXT"] = {
			["hideIrrelevant"] = false,
			["position"] = 3,
			["mode"] = 1,
			["verbose"] = false,
		},
		["SCALING"] = {
			["targetWidth"] = 30,
			["barHeight"] = 38,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["maxRowsWhenLoose"] = 6,
			["headerWidth"] = 100,
			["showHeaders"] = 1,
			["isDamFlash"] = true,
			["damFlashFactor"] = 0.75,
			["alignBottom"] = false,
			["headerHeight"] = 14,
			["arrangeHorizontal"] = false,
			["scale"] = 0.75,
			["swapDirection"] = false,
			["vertical"] = false,
			["targetOrientation"] = 1,
			["raidIconScale"] = 1,
			["sideLeftWidth"] = 6,
			["headerSpacing"] = 7,
			["borderGapX"] = 2,
			["invertGrowth"] = false,
			["rowSpacing"] = 2,
			["totWidth"] = 30,
			["maxColumnsWhenStructured"] = 8,
			["totSpacing"] = 3,
			["manaBarHeight"] = 3,
			["targetSpacing"] = 3,
			["borderGapY"] = 4,
			["columnSpacing"] = 2,
			["sideRightWidth"] = 6,
			["showTot"] = false,
			["barWidth"] = 119,
		},
		["IS_RAID_ICON"] = true,
		["ID_TEXT"] = {
			["showClass"] = false,
			["yAdjust"] = 0,
			["version"] = 2,
			["position"] = "BOTTOMRIGHT+BOTTOMRIGHT",
			["showName"] = true,
			["xAdjust"] = 0,
		},
		["HOTS"] = {
			["SLOTS"] = {
				"Beacon of Light", -- [1]
				"Sacred Shield", -- [2]
				"Flash of Light", -- [3]
				"Power Word: Shield", -- [4]
				"Guardian Spirit", -- [5]
				"Abolish Disease", -- [6]
			},
			["BARS"] = {
				["show"] = false,
				["radioValue"] = 1,
				["invertOrientation"] = false,
				["invertDirection"] = false,
				["width"] = 25,
			},
			["SLOTCFG"] = {
				{
					true, -- [1]
					false, -- [2]
				}, -- [1]
				{
					true, -- [1]
					true, -- [2]
				}, -- [2]
				{
					true, -- [1]
					false, -- [2]
				}, -- [3]
				{
					true, -- [1]
					false, -- [2]
				}, -- [4]
				{
					true, -- [1]
					false, -- [2]
				}, -- [5]
				{
					true, -- [1]
					true, -- [2]
				}, -- [6]
				{
					true, -- [1]
					false, -- [2]
				}, -- [7]
				{
					true, -- [1]
					false, -- [2]
				}, -- [8]
				["1"] = {
					["mine"] = true,
					["others"] = false,
				},
				["3"] = {
					["mine"] = true,
					["others"] = false,
				},
				["2"] = {
					["mine"] = true,
					["others"] = false,
				},
				["5"] = {
					["mine"] = true,
					["others"] = false,
				},
				["4"] = {
					["mine"] = true,
					["others"] = false,
				},
				["7"] = {
					["mine"] = true,
					["others"] = false,
				},
				["6"] = {
					["mine"] = true,
					["others"] = false,
				},
				["9"] = {
					["mine"] = true,
					["others"] = false,
				},
				["8"] = {
					["mine"] = true,
					["others"] = false,
				},
			},
			["isFlatTexture"] = false,
			["show"] = true,
			["iconRadioValue"] = 2,
			["radioValue"] = 20,
			["stacksRadioValue"] = 3,
			["textSize"] = 100,
			["size"] = 75,
		},
	}, -- [10]
	["RAID_ICON_FILTER"] = {
		true, -- [1]
		true, -- [2]
		true, -- [3]
		true, -- [4]
		true, -- [5]
		true, -- [6]
		true, -- [7]
		true, -- [8]
	},
	["PANEL_COLOR"] = {
		["TEXT"] = {
			["TR"] = 0.737,
			["TO"] = 1,
			["TB"] = 0.8189,
			["useText"] = true,
			["TG"] = 0.705,
		},
		["HEALTH_TEXT"] = {
			["TR"] = 1,
			["TO"] = 1,
			["TB"] = 0,
			["useText"] = false,
			["TG"] = 0,
		},
		["BARS"] = {
			["useBackground"] = true,
			["B"] = 0,
			["R"] = 0,
			["G"] = 0,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["classColorsName"] = 1,
	},
	["HOTS"] = {
		["SLOTS"] = {
			"Sacred Shield", -- [1]
			"Flash of Light", -- [2]
		},
		["BARS"] = {
			["radioValue"] = 1,
			["width"] = 25,
		},
		["TIMER_TEXT"] = {
			["X_ADJUST"] = 10,
			["SCALE"] = 84,
			["Y_ADJUST"] = 0,
			["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
			["ANCHOR"] = "CENTER",
			["USE_OUTLINE"] = true,
		},
		["SLOTCFG"] = {
			["1"] = {
				["scale"] = 1,
				["others"] = true,
				["mine"] = true,
			},
			["3"] = {
				["scale"] = 1,
				["others"] = false,
				["mine"] = true,
			},
			["2"] = {
				["scale"] = 1,
				["others"] = false,
				["mine"] = true,
			},
			["5"] = {
				["scale"] = 1,
				["others"] = false,
				["mine"] = true,
			},
			["4"] = {
				["scale"] = 1,
				["others"] = false,
				["mine"] = true,
			},
			["7"] = {
				["scale"] = 1,
				["others"] = false,
				["mine"] = true,
			},
			["6"] = {
				["scale"] = 1,
				["others"] = false,
				["mine"] = true,
			},
			["9"] = {
				["scale"] = 1,
				["others"] = false,
				["mine"] = true,
			},
			["8"] = {
				["scale"] = 1,
				["others"] = false,
				["mine"] = true,
			},
			["10"] = {
				["scale"] = 1.5,
				["others"] = false,
				["mine"] = true,
			},
		},
		["show"] = true,
		["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
		["COUNTER_TEXT"] = {
			["X_ADJUST"] = -25,
			["SCALE"] = 66,
			["Y_ADJUST"] = 0,
			["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
			["ANCHOR"] = "TOPLEFT",
			["USE_OUTLINE"] = true,
		},
		["version"] = 2,
		["radioValue"] = 20,
		["iconRadioValue"] = 2,
		["stacksRadioValue"] = 3,
		["BUTTON_FACADE"] = "Blizzard",
	},
	["VERSION"] = 4,
	["SCALING"] = {
		["turnAxis"] = false,
		["vertical"] = false,
		["invertGrowth"] = false,
	},
	["BAR_COLORS"] = {
		["OVERHEAL_TEXT"] = {
			["TR"] = 0.8,
			["TO"] = 1,
			["TB"] = 0.8,
			["useOpacity"] = true,
			["useText"] = true,
			["TG"] = 1,
		},
		["HOT7"] = {
			["useBackground"] = true,
			["R"] = 1,
			["B"] = 1,
			["G"] = 1,
			["O"] = 0.75,
		},
		["PLAYER_TARGET"] = {
			["useBackground"] = true,
			["R"] = 0.7,
			["B"] = 0.7,
			["G"] = 0.7,
			["O"] = 1,
		},
		["HOT1"] = {
			["TG"] = 0.6,
			["countdownMode"] = 1,
			["R"] = 1,
			["TB"] = 0.6,
			["G"] = 0.3,
			["B"] = 0.3,
			["TR"] = 1,
			["TO"] = 1,
			["O"] = 1,
			["useBackground"] = true,
			["isFullDuration"] = false,
			["useText"] = true,
		},
		["DIRECTION"] = {
			["useBackground"] = true,
			["R"] = 1,
			["O"] = 1,
			["G"] = 0.4,
			["B"] = 0.4,
		},
		["DEBUFF0"] = {
			["useBackground"] = false,
			["useText"] = false,
			["useOpacity"] = false,
		},
		["HOT3"] = {
			["TG"] = 1,
			["countdownMode"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["B"] = 1,
			["TR"] = 1,
			["TO"] = 1,
			["O"] = 1,
			["useBackground"] = true,
			["isFullDuration"] = false,
			["useText"] = true,
		},
		["RAID_ICONS"] = {
			["1"] = {
				["TG"] = 1,
				["R"] = 1,
				["TB"] = 0.607,
				["G"] = 0.976,
				["TR"] = 0.98,
				["TO"] = 1,
				["B"] = 0.305,
				["useText"] = true,
				["O"] = 1,
				["useBackground"] = true,
			},
			["3"] = {
				["TG"] = 0.674,
				["B"] = 0.8,
				["TB"] = 0.921,
				["G"] = 0.29,
				["TR"] = 1,
				["TO"] = 1,
				["useText"] = true,
				["useBackground"] = true,
				["O"] = 1,
				["R"] = 0.788,
			},
			["2"] = {
				["TG"] = 0.827,
				["B"] = 0.039,
				["TB"] = 0.419,
				["G"] = 0.513,
				["TR"] = 1,
				["TO"] = 1,
				["useText"] = true,
				["useBackground"] = true,
				["O"] = 1,
				["R"] = 1,
			},
			["enable"] = false,
			["4"] = {
				["TG"] = 1,
				["B"] = 0.015,
				["TB"] = 0.6979,
				["G"] = 0.8,
				["TR"] = 0.6979,
				["TO"] = 1,
				["useText"] = true,
				["useBackground"] = true,
				["O"] = 1,
				["R"] = 0,
			},
			["7"] = {
				["TG"] = 0.627,
				["B"] = 0.129,
				["TB"] = 0.619,
				["G"] = 0.184,
				["TR"] = 1,
				["TO"] = 1,
				["useText"] = true,
				["useBackground"] = true,
				["O"] = 1,
				["R"] = 0.8,
			},
			["6"] = {
				["TG"] = 0.831,
				["B"] = 0.972,
				["TB"] = 1,
				["G"] = 0.6899,
				["TR"] = 0.662,
				["TO"] = 1,
				["useText"] = true,
				["useBackground"] = true,
				["O"] = 1,
				["R"] = 0.121,
			},
			["8"] = {
				["TG"] = 0.231,
				["B"] = 0.89,
				["TB"] = 0.231,
				["G"] = 0.866,
				["TR"] = 0.231,
				["TO"] = 1,
				["useText"] = true,
				["useBackground"] = true,
				["O"] = 1,
				["R"] = 0.847,
			},
			["5"] = {
				["TG"] = 0.87,
				["B"] = 0.8,
				["TB"] = 1,
				["G"] = 0.717,
				["TR"] = 0.725,
				["TO"] = 1,
				["useText"] = true,
				["useBackground"] = true,
				["O"] = 1,
				["R"] = 0.466,
			},
		},
		["useDebuffIcon"] = 1,
		["HOT9"] = {
			["TG"] = 1,
			["countdownMode"] = 1,
			["R"] = 0.3,
			["TB"] = 1,
			["G"] = 1,
			["B"] = 1,
			["TR"] = 0.6,
			["TO"] = 1,
			["O"] = 1,
			["useBackground"] = true,
			["isFullDuration"] = false,
			["useText"] = true,
		},
		["HOT_CHARGE_4"] = {
			["TG"] = 1,
			["R"] = 0.8,
			["TB"] = 1,
			["G"] = 0.8,
			["TR"] = 1,
			["TO"] = 1,
			["B"] = 0.8,
			["useBackground"] = true,
			["O"] = 1,
			["useText"] = true,
		},
		["HOT_CHARGE_3"] = {
			["TG"] = 1,
			["R"] = 0.3,
			["TB"] = 0.6,
			["G"] = 1,
			["TR"] = 0.6,
			["TO"] = 1,
			["B"] = 0.3,
			["useBackground"] = true,
			["O"] = 1,
			["useText"] = true,
		},
		["CLUSTER_GOOD"] = {
			["TG"] = 1,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 0.8,
			["TR"] = 0,
			["TO"] = 1,
			["useText"] = true,
			["useBackground"] = true,
			["O"] = 1,
			["B"] = 0,
		},
		["DEBUFF3"] = {
			["TG"] = 0.957,
			["R"] = 0.4,
			["TB"] = 1,
			["G"] = 0.4,
			["TR"] = 0.329,
			["TO"] = 1,
			["B"] = 0.8,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["INCOMING"] = {
			["TG"] = 0.82,
			["B"] = 0.058,
			["TB"] = 0,
			["G"] = 0.933,
			["TR"] = 1,
			["TO"] = 1,
			["useBackground"] = 1,
			["O"] = 0,
			["R"] = 0.019,
		},
		["HOT6"] = {
			["useBackground"] = true,
			["R"] = 1,
			["B"] = 1,
			["G"] = 1,
			["O"] = 0.75,
		},
		["TARGET_ENEMY"] = {
			["TG"] = 0,
			["R"] = 1,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 1,
			["TO"] = 1,
			["B"] = 0,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["HOT4"] = {
			["TG"] = 0.6,
			["countdownMode"] = 1,
			["R"] = 0.3,
			["TB"] = 1,
			["G"] = 0.3,
			["B"] = 1,
			["TR"] = 0.6,
			["TO"] = 1,
			["O"] = 1,
			["useBackground"] = true,
			["isFullDuration"] = false,
			["useText"] = true,
		},
		["DEBUFF1"] = {
			["TG"] = 1,
			["B"] = 0.8,
			["TB"] = 0.686,
			["G"] = 0.592,
			["TR"] = 0,
			["TO"] = 1,
			["useText"] = 1,
			["R"] = 0,
			["useBackground"] = 1,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["TARGET_NEUTRAL"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 0,
			["G"] = 1,
			["TR"] = 1,
			["TO"] = 1,
			["B"] = 0,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["GCD_BAR"] = {
			["useBackground"] = true,
			["R"] = 0.4,
			["G"] = 0.4,
			["O"] = 0.5,
			["B"] = 0.4,
		},
		["HOT5"] = {
			["TG"] = 0.6,
			["countdownMode"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 0.3,
			["B"] = 1,
			["TR"] = 1,
			["TO"] = 1,
			["O"] = 1,
			["useBackground"] = true,
			["isFullDuration"] = false,
			["useText"] = true,
		},
		["TARGET_FRIEND"] = {
			["TG"] = 1,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 1,
			["TR"] = 0,
			["TO"] = 1,
			["B"] = 0,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["NO_EMERGENCY"] = {
			["TG"] = 0.82,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 1,
			["TO"] = 1,
			["B"] = 0.4,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["HOTS"] = {
			["isFadeOut"] = true,
			["factorDivineAegis"] = 1.2,
			["WARNING"] = {
				["TG"] = 0.6,
				["lowSecs"] = 3,
				["R"] = 0.5,
				["TB"] = 0.6,
				["G"] = 0.2,
				["TR"] = 1,
				["TO"] = 1,
				["B"] = 0.2,
				["useBackground"] = true,
				["useText"] = true,
				["O"] = 1,
				["enabled"] = false,
			},
			["useColorText"] = true,
			["useAmount"] = true,
			["TEXT"] = {
				["outline"] = true,
			},
			["useSquare"] = true,
			["useColorBack"] = true,
		},
		["SHIELD"] = {
			["TG"] = 0.52,
			["R"] = 0.35,
			["TB"] = 1,
			["G"] = 0.52,
			["TR"] = 0.35,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = false,
			["O"] = 1,
			["B"] = 1,
		},
		["TARGET"] = {
			["TG"] = 1,
			["R"] = 0,
			["TB"] = 1,
			["G"] = 1,
			["modeText"] = 2,
			["TR"] = 1,
			["B"] = 0,
			["TO"] = 1,
			["useOpacity"] = true,
			["useText"] = true,
			["useBackground"] = true,
			["O"] = 1,
			["modeBack"] = 1,
		},
		["DEBUFF4"] = {
			["TG"] = 0,
			["R"] = 0.7,
			["TB"] = 1,
			["G"] = 0,
			["TR"] = 1,
			["TO"] = 1,
			["B"] = 0.7,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["HOT2"] = {
			["TG"] = 1,
			["countdownMode"] = 1,
			["R"] = 1,
			["TB"] = 0.6,
			["G"] = 1,
			["B"] = 0.3,
			["TR"] = 1,
			["TO"] = 1,
			["O"] = 1,
			["useBackground"] = true,
			["isFullDuration"] = false,
			["useText"] = true,
		},
		["DEAD"] = {
			["TG"] = 0.5,
			["R"] = 0.3,
			["TB"] = 0.5,
			["G"] = 0.3,
			["TR"] = 0.5,
			["TO"] = 1,
			["B"] = 0.3,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 0.5,
			["useOpacity"] = true,
		},
		["AGGRO"] = {
			["useBackground"] = true,
			["R"] = 1,
			["B"] = 0,
			["G"] = 0,
			["O"] = 1,
			["useText"] = false,
			["useOpacity"] = true,
		},
		["OFFLINE"] = {
			["TG"] = 0.576,
			["R"] = 0.298,
			["TB"] = 0.576,
			["G"] = 0.298,
			["TR"] = 0.576,
			["TO"] = 0.58,
			["B"] = 0.298,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 0.21,
			["useOpacity"] = true,
		},
		["OUTRANGED"] = {
			["TG"] = 0,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["useOpacity"] = 1,
			["TO"] = 0.5,
			["TR"] = 0,
			["O"] = 0.51,
			["B"] = 0,
		},
		["DEBUFF6"] = {
			["TG"] = 0.5,
			["R"] = 0.6,
			["TB"] = 0,
			["G"] = 0.3,
			["TR"] = 0.8,
			["TO"] = 1,
			["B"] = 0,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["IRRELEVANT"] = {
			["TG"] = 0.82,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 1,
			["TO"] = 1,
			["B"] = 0.4,
			["useText"] = false,
			["O"] = 0.5,
			["useBackground"] = false,
		},
		["CHARMED"] = {
			["TG"] = 0.31,
			["R"] = 0.51,
			["TB"] = 0.31,
			["G"] = 0.082,
			["TR"] = 1,
			["TO"] = 1,
			["B"] = 0.263,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["DEBUFF2"] = {
			["TG"] = 0,
			["R"] = 0.8,
			["TB"] = 0,
			["G"] = 0.4,
			["TR"] = 1,
			["TO"] = 1,
			["B"] = 0.4,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["CLUSTER_FAIR"] = {
			["TG"] = 1,
			["R"] = 0.8,
			["TB"] = 0,
			["G"] = 0.8,
			["TR"] = 1,
			["TO"] = 1,
			["useText"] = true,
			["useBackground"] = true,
			["O"] = 1,
			["B"] = 0,
		},
		["EMERGENCY"] = {
			["TG"] = 0.82,
			["R"] = 1,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 1,
			["TO"] = 1,
			["B"] = 0,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["HOT10"] = {
			["TG"] = 1,
			["countdownMode"] = 1,
			["R"] = 0.3,
			["TB"] = 1,
			["G"] = 1,
			["B"] = 1,
			["TR"] = 0.6,
			["TO"] = 1,
			["O"] = 1,
			["useBackground"] = true,
			["isFullDuration"] = false,
			["useText"] = true,
		},
		["THREAT"] = {
			["LOW"] = {
				["useBackground"] = true,
				["R"] = 0,
				["B"] = 1,
				["G"] = 1,
				["O"] = 1,
			},
			["HIGH"] = {
				["useBackground"] = true,
				["R"] = 1,
				["B"] = 1,
				["G"] = 0,
				["O"] = 1,
			},
		},
		["BAR_FRAMES"] = {
			["useBackground"] = true,
			["R"] = 0,
			["B"] = 0,
			["G"] = 0,
			["O"] = 0.7,
			["useOpacity"] = true,
		},
		["HOT8"] = {
			["useBackground"] = true,
			["R"] = 1,
			["B"] = 1,
			["G"] = 1,
			["O"] = 0.75,
		},
		["TAPPED"] = {
			["TG"] = 0.4,
			["R"] = 0.4,
			["TB"] = 0.4,
			["G"] = 0.4,
			["TR"] = 0.4,
			["TO"] = 1,
			["B"] = 0.4,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["LIFE_LEFT"] = {
			["GOOD"] = {
				["useBackground"] = true,
				["R"] = 0,
				["G"] = 1,
				["O"] = 1,
				["B"] = 0,
			},
			["LOW"] = {
				["useBackground"] = true,
				["R"] = 1,
				["G"] = 0,
				["O"] = 1,
				["B"] = 0,
			},
			["FAIR"] = {
				["useBackground"] = true,
				["R"] = 1,
				["G"] = 1,
				["O"] = 1,
				["B"] = 0,
			},
		},
		["HOT_CHARGE_2"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 0.6,
			["G"] = 1,
			["TR"] = 1,
			["TO"] = 1,
			["B"] = 0.3,
			["useBackground"] = true,
			["O"] = 1,
			["useText"] = true,
		},
	},
}
VUHDO_SPELL_ASSIGNMENTS = {
	["shift3"] = {
		nil, -- [1]
		"3", -- [2]
		"Detox", -- [3]
	},
	["13"] = {
		"", -- [1]
		"13", -- [2]
		"hand of freedom", -- [3]
	},
	["shift2"] = {
		"shift-", -- [1]
		"2", -- [2]
		"Renewing Mist", -- [3]
	},
	["shift4"] = {
		nil, -- [1]
		"4", -- [2]
		"Life Cocoon", -- [3]
	},
	["shift1"] = {
		"shift-", -- [1]
		"1", -- [2]
		"Surging Mist", -- [3]
	},
	["ctrl3"] = {
		"ctrl-", -- [1]
		"3", -- [2]
		"Resuscitate", -- [3]
	},
	["12"] = {
		"", -- [1]
		"12", -- [2]
		"cleanse", -- [3]
	},
}
VUHDO_HOSTILE_SPELL_ASSIGNMENTS = {
	["1"] = {
		"", -- [1]
		"1", -- [2]
		"target", -- [3]
	},
	["3"] = {
		"", -- [1]
		"3", -- [2]
		"focus", -- [3]
	},
	["2"] = {
		"", -- [1]
		"2", -- [2]
		"assist", -- [3]
	},
	["4"] = {
		"", -- [1]
		"4", -- [2]
		"menu", -- [3]
	},
	["5"] = {
		"", -- [1]
		"5", -- [2]
		"menu", -- [3]
	},
}
VUHDO_MM_SETTINGS = {
	["enabled"] = 1,
	["drag"] = "CIRCLE",
	["position"] = 8.31231591318806,
}
VUHDO_PLAYER_TARGETS = {
}
VUHDO_MAINTANK_NAMES = {
}
VUHDO_BUFF_SETTINGS = {
	["CONFIG"] = {
		["SWATCH_EMPTY_GROUP"] = {
			["TG"] = 0.8,
			["R"] = 0,
			["TB"] = 0.8,
			["G"] = 0,
			["TR"] = 0.8,
			["TO"] = 0.6,
			["B"] = 0,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 0.5,
			["useOpacity"] = true,
		},
		["SWATCH_COLOR_BUFF_OUT"] = {
			["TG"] = 0,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 0.8,
			["TO"] = 1,
			["B"] = 0,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["SHOW_LABEL"] = false,
		["REFRESH_SECS"] = 1,
		["SWATCH_COLOR_BUFF_COOLDOWN"] = {
			["TG"] = 0.6,
			["R"] = 0.3,
			["TB"] = 0.6,
			["G"] = 0.3,
			["TR"] = 0.6,
			["TO"] = 1,
			["B"] = 0.3,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["SWATCH_COLOR_BUFF_OKAY"] = {
			["TG"] = 0.8,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 0,
			["TO"] = 1,
			["B"] = 0,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["SHOW"] = false,
		["PANEL_BG_COLOR"] = {
			["useBackground"] = true,
			["R"] = 0,
			["B"] = 0,
			["G"] = 0,
			["O"] = 0.5,
			["useText"] = false,
			["useOpacity"] = false,
		},
		["SWATCH_COLOR_BUFF_LOW"] = {
			["TG"] = 0.7,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 1,
			["TO"] = 1,
			["B"] = 0,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["VERSION"] = 2,
		["SCALE"] = 1,
		["BAR_COLORS_TEXT"] = true,
		["BAR_COLORS_IN_FIGHT"] = false,
		["HIGHLIGHT_COOLDOWN"] = true,
		["HIDE_CHARGES"] = false,
		["POSITION"] = {
			["y"] = -230.396,
			["x"] = -127.945,
			["point"] = "RIGHT",
			["relativePoint"] = "RIGHT",
		},
		["COMPACT"] = true,
		["PANEL_BORDER_COLOR"] = {
			["useBackground"] = true,
			["R"] = 0,
			["B"] = 0,
			["G"] = 0,
			["O"] = 0.5,
			["useText"] = false,
			["useOpacity"] = false,
		},
		["BAR_COLORS_BACKGROUND"] = true,
		["PANEL_MAX_BUFFS"] = 5,
		["SWATCH_BG_COLOR"] = {
			["useBackground"] = true,
			["R"] = 0,
			["B"] = 0,
			["G"] = 0,
			["O"] = 1,
			["useText"] = false,
			["useOpacity"] = false,
		},
		["WHEEL_SMART_BUFF"] = false,
		["SWATCH_BORDER_COLOR"] = {
			["useBackground"] = true,
			["R"] = 0.8,
			["B"] = 0.8,
			["G"] = 0.8,
			["O"] = 0,
			["useText"] = false,
			["useOpacity"] = false,
		},
		["REBUFF_MIN_MINUTES"] = 3,
		["REBUFF_AT_PERCENT"] = 25,
		["SWATCH_COLOR_OUT_RANGE"] = {
			["TG"] = 0,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 0,
			["TO"] = 0.5,
			["B"] = 0,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 0.5,
			["useOpacity"] = true,
		},
		["BUTTON_FACADE"] = "Blizzard",
	},
	["Stance"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["useOpacity"] = true,
			["TO"] = 1,
			["useBackground"] = true,
			["useText"] = true,
			["TR"] = 1,
			["O"] = 1,
			["B"] = 1,
		},
		["buff"] = "Stance of the Fierce Tiger",
		["enabled"] = false,
		["filter"] = {
			[999] = true,
		},
	},
	["Legacy of the Emperor"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["useOpacity"] = true,
			["TO"] = 1,
			["useBackground"] = true,
			["useText"] = true,
			["TR"] = 1,
			["O"] = 1,
			["B"] = 1,
		},
		["enabled"] = false,
		["filter"] = {
			[999] = true,
		},
	},
	["Seal"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["useOpacity"] = true,
			["TO"] = 1,
			["useBackground"] = true,
			["useText"] = true,
			["TR"] = 1,
			["O"] = 1,
			["B"] = 1,
		},
		["filter"] = {
			[999] = true,
		},
		["enabled"] = false,
		["buff"] = "Seal of Truth",
	},
	["Legacy of the White Tiger"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["useOpacity"] = true,
			["TO"] = 1,
			["useBackground"] = true,
			["useText"] = true,
			["TR"] = 1,
			["O"] = 1,
			["B"] = 1,
		},
		["enabled"] = false,
		["filter"] = {
			[999] = true,
		},
	},
	["Inquisition"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["B"] = 1,
			["TO"] = 1,
			["useBackground"] = true,
			["TR"] = 1,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["enabled"] = false,
		["filter"] = {
			[999] = true,
		},
	},
	["Sacred Shield"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["B"] = 1,
			["TO"] = 1,
			["useBackground"] = true,
			["TR"] = 1,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["enabled"] = false,
		["name"] = "Towelliee",
		["filter"] = {
			[999] = true,
		},
	},
	["Shout"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["B"] = 1,
			["TO"] = 1,
			["useBackground"] = true,
			["TR"] = 1,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["enabled"] = false,
		["filter"] = {
			[999] = true,
		},
	},
	["Aura"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["useOpacity"] = true,
			["TO"] = 1,
			["useBackground"] = true,
			["useText"] = true,
			["TR"] = 1,
			["O"] = 1,
			["B"] = 1,
		},
		["filter"] = {
			[999] = true,
		},
		["enabled"] = true,
		["buff"] = "Devotion Aura",
	},
	["Vigilance"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["B"] = 1,
			["TO"] = 1,
			["useBackground"] = true,
			["TR"] = 1,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["enabled"] = false,
		["filter"] = {
			[999] = true,
		},
	},
	["Blessing"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["useOpacity"] = true,
			["TO"] = 1,
			["useBackground"] = true,
			["useText"] = true,
			["TR"] = 1,
			["O"] = 1,
			["B"] = 1,
		},
		["enabled"] = false,
		["filter"] = {
			[999] = true,
		},
	},
	["Beacon of Light"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["useOpacity"] = true,
			["TO"] = 1,
			["useBackground"] = true,
			["useText"] = true,
			["TR"] = 1,
			["O"] = 1,
			["B"] = 1,
		},
		["enabled"] = false,
		["name"] = "Towelliee",
		["filter"] = {
			[999] = true,
		},
	},
	["Righteous Fury"] = {
		["missingColor"] = {
			["TG"] = 1,
			["B"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["R"] = 1,
			["TO"] = 1,
			["useBackground"] = true,
			["TR"] = 1,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["filter"] = {
			[999] = true,
		},
		["enabled"] = false,
		["buff"] = "Righteous Fury",
	},
}
VUHDO_POWER_TYPE_COLORS = {
	{
		["useBackground"] = true,
		["R"] = 1,
		["useOpacity"] = true,
		["O"] = 1,
		["G"] = 0,
		["B"] = 0,
	}, -- [1]
	{
		["TG"] = 0.5,
		["B"] = 0.25,
		["TB"] = 0.25,
		["G"] = 0.5,
		["useBackground"] = true,
		["R"] = 1,
		["O"] = 1,
		["useOpacity"] = true,
	}, -- [2]
	{
		["useBackground"] = true,
		["R"] = 1,
		["useOpacity"] = true,
		["O"] = 1,
		["G"] = 1,
		["B"] = 0,
	}, -- [3]
	{
		["useBackground"] = true,
		["R"] = 0,
		["useOpacity"] = true,
		["O"] = 1,
		["G"] = 1,
		["B"] = 1,
	}, -- [4]
	nil, -- [5]
	{
		["TG"] = 0.5,
		["B"] = 0.5,
		["TB"] = 0.5,
		["G"] = 0.5,
		["useOpacity"] = true,
		["R"] = 0.5,
		["useBackground"] = true,
		["O"] = 1,
		["TR"] = 0.5,
	}, -- [6]
	[0] = {
		["useBackground"] = true,
		["R"] = 0,
		["useOpacity"] = true,
		["O"] = 1,
		["G"] = 0,
		["B"] = 1,
	},
}
VUHDO_SPELLS_KEYBOARD = {
	["SPELL15"] = "",
	["SPELL6"] = "",
	["SPELL13"] = "",
	["HOSTILE_WHEEL"] = {
		["1"] = {
			"", -- [1]
			"-w1", -- [2]
			"", -- [3]
		},
		["altctrl2"] = {
			"ALT-CTRL-", -- [1]
			"-w10", -- [2]
			"", -- [3]
		},
		["alt1"] = {
			"ALT-", -- [1]
			"-w3", -- [2]
			"", -- [3]
		},
		["2"] = {
			"", -- [1]
			"-w2", -- [2]
			"", -- [3]
		},
		["ctrlshift2"] = {
			"CTRL-SHIFT-", -- [1]
			"-w14", -- [2]
			"", -- [3]
		},
		["shift2"] = {
			"SHIFT-", -- [1]
			"-w8", -- [2]
			"", -- [3]
		},
		["altshift1"] = {
			"ALT-SHIFT-", -- [1]
			"-w11", -- [2]
			"", -- [3]
		},
		["shift1"] = {
			"SHIFT-", -- [1]
			"-w7", -- [2]
			"", -- [3]
		},
		["altctrl1"] = {
			"ALT-CTRL-", -- [1]
			"-w9", -- [2]
			"", -- [3]
		},
		["alt2"] = {
			"ALT-", -- [1]
			"-w4", -- [2]
			"", -- [3]
		},
		["altshift2"] = {
			"ALT-SHIFT-", -- [1]
			"-w12", -- [2]
			"", -- [3]
		},
		["altctrlshift2"] = {
			"ALT-CTRL-SHIFT-", -- [1]
			"-w16", -- [2]
			"", -- [3]
		},
		["altctrlshift1"] = {
			"ALT-CTRL-SHIFT-", -- [1]
			"-w15", -- [2]
			"", -- [3]
		},
		["ctrlshift1"] = {
			"CTRL-SHIFT-", -- [1]
			"-w13", -- [2]
			"", -- [3]
		},
		["ctrl1"] = {
			"CTRL-", -- [1]
			"-w5", -- [2]
			"", -- [3]
		},
		["ctrl2"] = {
			"CTRL-", -- [1]
			"-w6", -- [2]
			"", -- [3]
		},
	},
	["SPELL3"] = "",
	["SPELL4"] = "",
	["SPELL2"] = "",
	["SPELL16"] = "",
	["INTERNAL"] = {
	},
	["SPELL7"] = "",
	["SPELL12"] = "",
	["SPELL5"] = "",
	["SPELL9"] = "",
	["SPELL10"] = "",
	["version"] = 2,
	["SPELL14"] = "",
	["SPELL11"] = "",
	["SPELL8"] = "",
	["SPELL1"] = "",
	["WHEEL"] = {
		["1"] = {
			"", -- [1]
			"-w1", -- [2]
			"", -- [3]
		},
		["altctrl2"] = {
			"ALT-CTRL-", -- [1]
			"-w10", -- [2]
			"", -- [3]
		},
		["alt1"] = {
			"ALT-", -- [1]
			"-w3", -- [2]
			"", -- [3]
		},
		["2"] = {
			"", -- [1]
			"-w2", -- [2]
			"", -- [3]
		},
		["ctrlshift2"] = {
			"CTRL-SHIFT-", -- [1]
			"-w14", -- [2]
			"", -- [3]
		},
		["shift2"] = {
			"SHIFT-", -- [1]
			"-w8", -- [2]
			"", -- [3]
		},
		["altshift1"] = {
			"ALT-SHIFT-", -- [1]
			"-w11", -- [2]
			"", -- [3]
		},
		["shift1"] = {
			"SHIFT-", -- [1]
			"-w7", -- [2]
			"", -- [3]
		},
		["altctrl1"] = {
			"ALT-CTRL-", -- [1]
			"-w9", -- [2]
			"", -- [3]
		},
		["alt2"] = {
			"ALT-", -- [1]
			"-w4", -- [2]
			"", -- [3]
		},
		["altshift2"] = {
			"ALT-SHIFT-", -- [1]
			"-w12", -- [2]
			"", -- [3]
		},
		["altctrlshift2"] = {
			"ALT-CTRL-SHIFT-", -- [1]
			"-w16", -- [2]
			"", -- [3]
		},
		["altctrlshift1"] = {
			"ALT-CTRL-SHIFT-", -- [1]
			"-w15", -- [2]
			"", -- [3]
		},
		["ctrlshift1"] = {
			"CTRL-SHIFT-", -- [1]
			"-w13", -- [2]
			"", -- [3]
		},
		["ctrl1"] = {
			"CTRL-", -- [1]
			"-w5", -- [2]
			"", -- [3]
		},
		["ctrl2"] = {
			"CTRL-", -- [1]
			"-w6", -- [2]
			"", -- [3]
		},
	},
}
VUHDO_SPELL_CONFIG = {
	["IS_LOAD_HOTS"] = false,
	["IS_FIRE_OUT_FIGHT"] = false,
	["IS_AUTO_FIRE"] = false,
	["IS_FIRE_CUSTOM_2"] = false,
	["IS_FIRE_TRINKET_2"] = false,
	["IS_KEEP_STANCE"] = false,
	["IS_AUTO_TARGET"] = false,
	["IS_TOOLTIP_INFO"] = false,
	["FIRE_CUSTOM_1_SPELL"] = "Divine Illumination",
	["FIRE_CUSTOM_2_SPELL"] = "Divine Favor",
	["IS_FIRE_HOT"] = false,
	["IS_FIRE_CUSTOM_1"] = false,
	["smartCastModi"] = "all",
}
VUHDO_BUFF_ORDER = {
	["Legacy of the White Tiger"] = 2,
	["Legacy of the Emperor"] = 1,
	["Stance"] = 3,
}
VUHDO_SPEC_LAYOUTS = {
	["1"] = "",
	["selected"] = "Banjax: ",
	["2"] = "",
}
VUHDO_GROUP_SIZE = 1
VUHDO_RAID = {
	["player"] = {
		["number"] = 1,
		["class"] = "MONK",
		["visible"] = true,
		["targetUnit"] = "target",
		["group"] = 1,
		["afk"] = false,
		["range"] = true,
		["unit"] = "player",
		["zone"] = "Orgrimmar",
		["powertype"] = 0,
		["healthmax"] = 46795,
		["baseRange"] = true,
		["classId"] = 30,
		["sortMaxHp"] = 46795,
		["isVehicle"] = false,
		["dead"] = false,
		["map"] = "Orgrimmar",
		["charmed"] = false,
		["fullName"] = "Banjax",
		["power"] = 44400,
		["aggro"] = false,
		["debuff"] = 0,
		["threatPerc"] = 0,
		["isPet"] = false,
		["threat"] = 0,
		["name"] = "Banjax",
		["className"] = "Monk",
		["powermax"] = 44400,
		["petUnit"] = "pet",
		["connected"] = true,
		["health"] = 46795,
	},
}
VUHDO_INDICATOR_CONFIG = {
	["BOUQUETS"] = {
		["THREAT_BAR"] = "",
		["MOUSEOVER_HIGHLIGHT"] = "Mouseover: Single",
		["AGGRO_BAR"] = "Aggro Indicator",
		["BACKGROUND_BAR"] = "Background: Solid",
		["HEALTH_BAR_PANEL"] = {
			"", -- [1]
			"", -- [2]
			"", -- [3]
			"", -- [4]
			"", -- [5]
			"", -- [6]
			"", -- [7]
			"", -- [8]
			"", -- [9]
			"", -- [10]
		},
		["CLUSTER_BORDER"] = "",
		["INCOMING_BAR"] = "",
		["DAMAGE_FLASH_BAR"] = "",
		["THREAT_MARK"] = "Threat: Marks",
		["SIDE_RIGHT"] = "",
		["MANA_BAR"] = "Manabars: Mana only",
		["BAR_BORDER"] = "",
		["HEALTH_BAR"] = "Health (generic, class col)",
		["SIDE_LEFT"] = "",
		["SWIFTMEND_INDICATOR"] = "",
	},
	["CUSTOM"] = {
		["THREAT_BAR"] = {
			["HEIGHT"] = 4,
			["WARN_AT"] = 85,
			["TEXTURE"] = "VuhDo - Polished Wood",
		},
		["MOUSEOVER_HIGHLIGHT"] = {
			["TEXTURE"] = "LiteStepLite",
		},
		["AGGRO_BAR"] = {
			["TEXTURE"] = "VuhDo - Polished Wood",
		},
		["BACKGROUND_BAR"] = {
			["TEXTURE"] = "VuhDo - Minimalist",
		},
		["SWIFTMEND_INDICATOR"] = {
			["SCALE"] = 1,
		},
		["CLUSTER_BORDER"] = {
			["FILE"] = "Interface\\AddOns\\VuhDo\\Images\\white_square_16_16",
			["WIDTH"] = 2,
		},
		["SIDE_RIGHT"] = {
			["turnAxis"] = false,
			["vertical"] = true,
			["invertGrowth"] = false,
			["TEXTURE"] = "VuhDo - Polished Wood",
		},
		["MANA_BAR"] = {
			["HEIGHT"] = 3,
			["TEXTURE"] = "VuhDo - Pipe, light",
		},
		["BAR_BORDER"] = {
			["FILE"] = "Interface\\AddOns\\VuhDo\\Images\\white_square_16_16",
			["ADJUST"] = 0,
			["WIDTH"] = 1,
		},
		["HEALTH_BAR"] = {
			["turnAxis"] = false,
			["vertical"] = false,
			["invertGrowth"] = false,
		},
		["HOT_BARS"] = {
			["turnAxis"] = false,
			["vertical"] = false,
			["invertGrowth"] = false,
		},
		["SIDE_LEFT"] = {
			["turnAxis"] = false,
			["vertical"] = true,
			["invertGrowth"] = false,
			["TEXTURE"] = "VuhDo - Polished Wood",
		},
	},
	["TEXT_INDICATORS"] = {
		["OVERHEAL_TEXT"] = {
			["TEXT_PROVIDER"] = {
				"OVERHEAL_KILO_PLUS_N_K", -- [1]
				"OVERHEAL_KILO_PLUS_N_K", -- [2]
				"OVERHEAL_KILO_PLUS_N_K", -- [3]
				"OVERHEAL_KILO_PLUS_N_K", -- [4]
				"OVERHEAL_KILO_PLUS_N_K", -- [5]
				"OVERHEAL_KILO_PLUS_N_K", -- [6]
				"OVERHEAL_KILO_PLUS_N_K", -- [7]
				"OVERHEAL_KILO_PLUS_N_K", -- [8]
				"OVERHEAL_KILO_PLUS_N_K", -- [9]
				"OVERHEAL_KILO_PLUS_N_K", -- [10]
			},
		},
		["SIDE_RIGHT"] = {
			["TEXT_PROVIDER"] = {
				[0] = "",
			},
			["TEXT"] = {
				["X_ADJUST"] = 4,
				["USE_MONO"] = false,
				["Y_ADJUST"] = 0,
				["ANCHOR"] = "BOTTOM",
				["USE_OUTLINE"] = true,
				["SCALE"] = 18,
				["COLOR"] = {
					["TG"] = 1,
					["R"] = 0,
					["TB"] = 1,
					["G"] = 0,
					["TR"] = 1,
					["TO"] = 1,
					["useOpacity"] = true,
					["useText"] = true,
					["useBackground"] = true,
					["O"] = 1,
					["B"] = 0,
				},
				["USE_SHADOW"] = false,
				["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
			},
		},
		["THREAT_BAR"] = {
			["TEXT_PROVIDER"] = {
				[0] = "",
			},
			["TEXT"] = {
				["X_ADJUST"] = 7,
				["USE_MONO"] = false,
				["Y_ADJUST"] = 2,
				["ANCHOR"] = "RIGHT",
				["USE_OUTLINE"] = false,
				["SCALE"] = 20,
				["COLOR"] = {
					["TG"] = 0,
					["R"] = 0,
					["TB"] = 0,
					["G"] = 0,
					["TR"] = 1,
					["TO"] = 1,
					["useOpacity"] = true,
					["useText"] = true,
					["useBackground"] = true,
					["O"] = 1,
					["B"] = 0,
				},
				["USE_SHADOW"] = true,
				["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
			},
		},
		["MANA_BAR"] = {
			["TEXT_PROVIDER"] = {
				[0] = "",
			},
			["TEXT"] = {
				["X_ADJUST"] = 7,
				["USE_MONO"] = false,
				["Y_ADJUST"] = 2,
				["ANCHOR"] = "RIGHT",
				["USE_OUTLINE"] = false,
				["SCALE"] = 20,
				["COLOR"] = {
					["TG"] = 0.55,
					["R"] = 0,
					["TB"] = 1,
					["G"] = 0,
					["TR"] = 0.36,
					["TO"] = 1,
					["useOpacity"] = true,
					["useText"] = true,
					["useBackground"] = true,
					["O"] = 1,
					["B"] = 0,
				},
				["USE_SHADOW"] = true,
				["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
			},
		},
		["SIDE_LEFT"] = {
			["TEXT_PROVIDER"] = {
				[0] = "",
			},
			["TEXT"] = {
				["X_ADJUST"] = 3,
				["USE_MONO"] = false,
				["Y_ADJUST"] = 0,
				["ANCHOR"] = "BOTTOM",
				["USE_OUTLINE"] = true,
				["SCALE"] = 18,
				["COLOR"] = {
					["TG"] = 1,
					["R"] = 0,
					["TB"] = 1,
					["G"] = 0,
					["TR"] = 1,
					["TO"] = 1,
					["useOpacity"] = true,
					["useText"] = true,
					["useBackground"] = true,
					["O"] = 1,
					["B"] = 0,
				},
				["USE_SHADOW"] = false,
				["FONT"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
			},
		},
	},
}
