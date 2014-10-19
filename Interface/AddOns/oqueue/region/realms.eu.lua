--[[ 
  @file       realms.eu.lua
  @brief      realm list for region: eu

  @author     rmcinnis
  @date       november 26, 2012
  @par        copyright (c) 2012 Solid ICE Technologies, Inc.  All rights reserved.
              this file may be distributed so long as it remains unaltered
              if this file is posted to a web site, credit must be given to me along with a link to my web page
              no code in this file may be used in other works without expressed permission  
]]--
local addonName, OQ = ... ;

if (string.sub(GetCVar("portal") or "US",1,2) == "EU") then
 
OQ.REGION   = "eu" ;
OQ.SK_BTAG  = "OQSK#2404" ;
OQ.SK_NAME  = "Scorekeeper" ;
OQ.SK_REALM = "Magtheridon" ;
OQ.DEFAULT_PREMADE_TEXT = "teamspeak:  ts.overheatedpenguins.com" ;

OQ.BGROUP_ICON = { ["Blackout"    ] = "Interface\\Icons\\Spell_Shadow_Gathershadows",
                   ["Misery"      ] = "Interface\\Icons\\Spell_Shadow_Misery",
                   ["Vindication" ] = "Interface\\Icons\\Spell_Holy_Vindication",
                   ["Blutdurst"   ] = "Interface\\Icons\\Spell_Nature_Bloodlust",
                   ["Rampage"     ] = "Interface\\Icons\\Ability_Warrior_Rampage",
                   ["Saccage"     ] = "Interface\\Icons\\Ability_Warrior_Rampage",
                   ["Reckoning"   ] = "Interface\\Icons\\Spell_Holy_BlessingOfStrength",
                   ["Abrechnung"  ] = "Interface\\Icons\\Spell_Holy_BlessingOfStrength",
                   ["Cyclone"     ] = "Interface\\Icons\\Spell_Nature_Earthbind",
                   ["Wirbelsturm" ] = "Interface\\Icons\\Spell_Nature_Earthbind",
                   ["Vengeance"   ] = "Interface\\Icons\\Ability_Racial_Avatar",
                   ["Rache"       ] = "Interface\\Icons\\Ability_Racial_Avatar",
                   ["Glutsturm"   ] = "Interface\\Icons\\Spell_Fire_SelfDestruct",
                   ["Emberstorm"  ] = "Interface\\Icons\\Spell_Fire_SelfDestruct",
                   ["Frenzy"      ] = "Interface\\Icons\\Spell_Holy_Retributionaura",
                   ["Raserei"     ] = "Interface\\Icons\\Spell_Holy_Retributionaura",
                   ["Embuscade"   ] = "Interface\\Icons\\Ability_Druid_Disembowel",
                   ["Hinterhalt"  ] = "Interface\\Icons\\Ability_Druid_Disembowel",
                   ["Cruelty"     ] = "Interface\\Icons\\Spell_Shadow_Twilight",
                   ["Crueldad"    ] = "Interface\\Icons\\Spell_Shadow_Twilight",
                   ["Cataclysm"   ] = "Interface\\Icons\\Spell_Fire_Windsofwoe",
                   ["Cataclysme"  ] = "Interface\\Icons\\Spell_Fire_Windsofwoe",
                   ["Sturmangriff"] = "Interface\\Icons\\Ability_Warrior_Charge",
                   ["Charge"      ] = "Interface\\Icons\\Ability_Warrior_Charge",
                   ["Шквал"       ] = "Interface\\Icons\\Ability_Ghoulfrenzy",
                   ["Вихрь"       ] = "Interface\\Icons\\Ability_Whirlwind",
                 } ;

OQ.REALMNAMES_SPECIAL = { 
  ["Al'akir"             ] = "Al'Akir",
  ["ConseildesOmbres"    ] = "Conseil des Ombres",
  ["DerRatvonDalaran"    ] = "Der Rat von Dalaran",
  ["KultderVerdammten"   ] = "Kult der Verdammten",
  ["DieewigeWacht"       ] = "Die ewige Wacht",
  ["ChamberofAspects"    ] = "Chamber of Aspects",
  ["TheVentureCo"        ] = "The Venture Co",
  ["Confr�rieduThorium"   ] = "Confr�rie du Thorium",
  ["FestungderSt�rme"     ] = "Festung der Stürme",
  ["Festung der St�rme"   ] = "Festung der Stürme",
  ["FestungderStürme"    ] = "Festung der Stürme",
  ["Festung der Stürme"  ] = "Festung der Stürme",
  ["CultedelaRivenoire"  ] = "Culte de la Rive noire",
  ["DerabyssischeRat"    ] = "Der abyssische Rat",
  ["Der Abyssische Rat"  ] = "Der abyssische Rat",
  ["DieSilberneHand"     ] = "Die Silberne Hand",
  ["ZirkeldesCenarius"   ] = "Zirkel des Cenarius",
  ["pozzo dell'eternità" ] = "Well of Eternity",
  ["Pozzo dell'Eternità" ] = "Well of Eternity",
  ["Pozzodell'Eternità"  ] = "Well of Eternity",
  ["Confrérie du Thorium"] = "Thorium Brotherhood",
  ["La Croisade écarlate"] = "Scarlet Crusade",
  ["Marécage de Zangar"  ] = "Zangarmarsh",
  ["ВечнаяПесня"         ] = "Вечная Песня",
  ["Корольлич"           ] = "Король-лич",
  ["Пиратскаябухта"      ] = "Пиратская бухта",
  ["СвежевательДуш"      ] = "Свежеватель Душ",
  ["СтражСмерти"         ] = "Страж Смерти",
  ["ЧерныйШрам"          ] = "Черный Шрам",
  ["Ясеневыйлес"         ] = "Ясеневый лес",
  ["Борейскаятундра"     ] = "Борейская тундра",
  ["Ревущийфьорд"        ] = "Ревущий фьорд",
  ["ТкачСмерти"          ] = "Ткач Смерти",
  ["Aggra(Português)"    ] = "Aggra (Português)",
  ["AzjolNerub"          ] = "Azjol-Nerub",
  ["Templenoir"          ] = "Temple noir",
  ["Chantséternels"      ] = "Chants éternels",
--  ["Chants éternels"] = "",
} ;

OQ.BGROUPS = {
["Blackout"] = {
						  "Agamaggan",
						  "Aggramar",
						  "Al'Akir",
						  "Arathor",
						  "Aszune",
						  "Azjol-Nerub",
						  "Bladefist",
						  "Bloodhoof",
						  "Bloodscalp",
						  "Burning Blade",
						  "Doomhammer",
						  "Draenor",
						  "Dragonblight",
						  "Emerald Dream",
						  "Sunstrider",
						  "Twilight's Hammer",
						  "Zenedar",
						  "Aggra (Português)",
},

["Cataclysm"] = {
						  "Argent Dawn",
						  "Burning Legion",
						  "Crushridge",
						  "Daggerspine",
						  "Deathwing",
						  "Dragonmaw",
						  "Dunemaul",
},

["Cataclysme"] = {
						  "Archimonde",
						  "Cho'gall",
						  "Dalaran",
						  "Elune",
						  "Hyjal",
						  "Illidan",
						  "Kael'Thas",
						  "Kirin Tor",
						  "Ner'zhul",
						  "Sargeras",
						  "Sinstralis",
},
						  
["Cruelty"] = {
						  "Alonsus",
						  "Anachronos",
						  "Bronze Dragonflight",
						  "Burning Steppes",
						  "Darkmoon Faire",
						  "Darkspear",
						  "Kor'gall",
						  "Lightbringer",
},

["Crueldad"] = {
						  "Colinas Pardas",
						  "C'Thun",
						  "Dun Modr",
						  "Exodar",
						  "Los Errantes",
						  "Minahonda",
						  "Sanguino",
						  "Shen'dralar",
						  "Tyrande",
						  "Uldum",
						  "Zul'jin",
},

["Cyclone"] = {
						  "Earthen Ring",
						  "Ravencrest",
						  "Runetotem",
						  "Shadowsong",
						  "Shattered Hand",
						  "Silvermoon",
						  "Skullcrusher",
						  "Spinebreaker",
						  "Stormrage",
						  "Stormreaver",
						  "Stormscale",
						  "Terenas",
						  "Thunderhorn",
						  "Turalyon",
},

["Wirbelsturm"] = {
						  "Alexstrasza",
						  "Alleria",
						  "Antonidas",
						  "Baelgun",
						  "Blackhand",
},

["Frenzy"] = {
						  "Balnazzar",
						  "Genjuros",
						  "Hellscream",
						  "Laughing Skull",
						  "Magtheridon",
						  "Nordrassil",
						  "Quel'Thalas",
},

["Raserei"] = {
						  "Aman'Thul",
						  "Anub'arak",
						  "Das Syndikat",
						  "Der Rat von Dalaran",
						  "Dun Morogh",
						  "Krag'jin",
						  "Kult der Verdammten",
						  "Nera'thor",
						  "Onyxia",
						  "Sen'jin",
						  "Terrordar",
						  "Theradras",
						  "Wrathbringer",
},

["Emberstorm"] = {
						  "Azuremyst",
						  "Blade's Edge",
						  "Hakkar",
						  "Scarshield Legion",
						  "Steamwheedle Cartel",
						  "Terokkar",
						  "Xavius",
},

["Glutsturm"] = {
						  "Anetheron",
						  "Arthas",
						  "Azshara",
						  "Blackmoore",
						  "Blackrock",
						  "Die Arguswacht",
						  "Die ewige Wacht",
						  "Die Todeskrallen",
						  "Durotan",
						  "Nazjatar",
						  "Nefarian",
						  "Thrall",
						  "Tichondrius",
},

["Misery"] = {
						  "Aerie Peak",
						  "Boulderfist",
						  "Chamber of Aspects",
						  "Eonar",
						  "Frostmane",
						  "Grim Batol",
						  "Jaedenar",
						  "Kazzak",
						  "Kilrogg",
						  "Outland",
						  "Ravenholdt",
						  "Saurfang",
						  "Tarren Mill",
						  "Vek'nilash",
						  "Wildhammer",
						  "Nemesis",
						  "Well of Eternity",
},

["Rampage"] = {
						  "Bloodfeather",
						  "Darksorrow",
						  "Defias Brotherhood",
						  "Frostwhisper",
						  "Haomarush",
						  "Lightning's Blade",
						  "Neptulon",
						  "Ragnaros",
						  "Sylvanas",
						  "The Maelstrom",
						  "The Venture Co",
						  "Twisting Nether",
						  "Vashj",
},

["Saccage"] = {
						  "Conseil des Ombres",
						  "Drek'Thar",
						  "Khaz Modan",
						  "Les Sentinelles",
						  "Rashgarroth",
						  "Throk'Feroth",
						  "Varimathras",
},

["Reckoning"] = {
						  "Ahn'Qiraj",
						  "Bronzebeard",
						  "Chromaggus",
						  "Dentarg",
						  "Drak'thul",
						  "Emeriss",
						  "Executus",
						  "Khadgar",
						  "Kul Tiras",
						  "Mazrigos",
						  "Moonglade",
						  "Talnivarr",
						  "Trollbane",
},

["Abrechnung"] = {
						  "Ahn'Qiraj",
						  "Bronzebeard",
						  "Chromaggus",
						  "Dentarg",
						  "Drak'thul",
						  "Emeriss",
						  "Executus",
						  "Khadgar",
						  "Kul Tiras",
						  "Mazrigos",
						  "Moonglade",
						  "Talnivarr",
						  "Trollbane",
},

["Vindication"] = {
						  "Auchindoun",
						  "Ghostlands",
						  "Hellfire",
						  "Karazhan",
						  "Nagrand",
						  "Shattered Halls",
						  "Sporeggar",
						  "The Sha'tar",
},

["Embuscade"] = {
						  "Arak-arahm",
						  "Confr�rie du Thorium",
						  "Eitrigg",
						  "Garona",
						  "La Croisade �écarlate",
						  "Medivh",
						  "Uldaman",
						  "Vol'jin",
},

["Hinterhalt"] = {
						  "Area 52",
						  "Arygos",
						  "Der Mithrilorden",
						  "Dethecus",
						  "Forscherliga",
						  "Garrosh",
						  "Norgannon",
						  "Teldrassil",
						  "Todeswache",
						  "Un'Goro",
},

["Sturmangriff"] = {
						  "Chants éternels",
						  "Les Clairvoyants",
						  "Mar�cage de Zangar",
						  "Naxxramas",
						  "Temple noir",
},

["Charge"] = {
						  "Blutkessel",
						  "Das Konsortium",
						  "Die Aldor",
						  "Echsenkessel",
						  "Festung der Stürme",
						  "Nethersturm",
						  "Shattrath",
},

["Vengeance"] = {
						  "Arathi",
						  "Culte de la Rive noire",
						  "Eldre'Thalas",
						  "Krasus",
						  "Suramar",
						  "Ysondre",
},

["Rache"] = {
						  "Ambossar",
						  "Dalvengyr",
						  "Der abyssische Rat",
						  "Die Nachtwache",
						  "Lordaeron",
						  "Malorne",
						  "Mug'thol",
						  "Rajaxx",
						  "Taerar",
						  "Tirion",
						  "Ulduar",
						  "Vek'lor",
},

["Blutdurst"] = {
						  "Aegwynn",
						  "Destromath",
						  "Die Silberne Hand",
						  "Eredar",
						  "Frostmourne",
						  "Frostwolf",
						  "Gorgonnash",
						  "Gul'dan",
						  "Kel'Thuzad",
						  "Kil'Jaeden",
						  "Madmortem",
						  "Malfurion",
						  "Mal'Ganis",
						  "Mannoroth",
						  "Nathrezim",
						  "Nozdormu",
						  "Perenolde",
						  "Proudmoore",
						  "Zirkel des Cenarius",
						  "Zuluhed",
},

["Шквал"] = {
                                                  "Азурегос",
                                                  "Вечная Песня",
                                                  "Голдринн",
                                                  "Гордунни",
                                                  "Гром",
                                                  "Король-лич",
                                                  "Пиратская бухта",
                                                  "Свежеватель Душ",
                                                  "Страж Смерти",
                                                  "Термоштепсель",
                                                  "Черный Шрам",
                                                  "Ясеневый лес",
},

["Вихрь"] = {
                                                  "Борейская тундра",
                                                  "Галакронд",
                                                  "Дракономор",
                                                  "Подземье",
                                                  "Разувий",
                                                  "Ревущий фьорд",
                                                  "Седогрив",
                                                  "Ткач Смерти",
},
} ;

OQ.SHORT_BGROUPS = {
		"Aegwynn", -- [1]
		"Akama", -- [2]
		"Chromaggus", -- [3]
		"Drak'thul", -- [4]
		"Draka", -- [5]
		"Eitrigg", -- [6]
		"Garithos", -- [7]
		"Gundrak", -- [8]
		"Hakkar", -- [9]
		"Jubei'Thos", -- [10]
		"Khaz Modan", -- [11]
		"Korgath", -- [12]
		"Kul Tiras", -- [13]
		"Malorne", -- [14]
		"Mug'thol", -- [15]
		"Muradin", -- [16]
		"Rexxar", -- [17]
		"Runetotem", -- [18]
		"Saurfang", -- [19]
		"Thorium Brotherhood", -- [20]
		"Arathor", -- [21]
		"Bonechewer", -- [22]
		"Dragonmaw", -- [23]
		"Eldre'Thalas", -- [24]
		"Firetree", -- [25]
		"Frostmane", -- [26]
		"Gurubashi", -- [27]
		"Nathrezim", -- [28]
		"Scarlet Crusade", -- [29]
		"Shadow Council", -- [30]
		"Shadowsong", -- [31]
		"Silvermoon", -- [32]
		"Skywall", -- [33]
		"Smolderthorn", -- [34]
		"Spirestone", -- [35]
		"Terenas", -- [36]
		"Windrunner", -- [37]
		"Anub'arak", -- [38]
		"Blackwater Raiders", -- [39]
		"Bladefist", -- [40]
		"Cenarion Circle", -- [41]
		"Cenarius", -- [42]
		"Darrowmere", -- [43]
		"Echo Isles", -- [44]
		"Fenris", -- [45]
		"Hyjal", -- [46]
		"Korialstrasz", -- [47]
		"Lightbringer", -- [48]
		"Maiev", -- [49]
		"Misha", -- [50]
		"Ravenholdt", -- [51]
		"Shu'halo", -- [52]
		"Sisters of Elune", -- [53]
		"The Forgotten Coast", -- [54]
		"Uther", -- [55]
		"Vashj", -- [56]
		"Winterhoof", -- [57]
		"Aggramar", -- [58]
		"Burning Blade", -- [59]
		"Burning Legion", -- [60]
		"Drakkari", -- [61]
		"Earthen Ring", -- [62]
		"Eonar", -- [63]
		"Eredar", -- [64]
		"Gilneas", -- [65]
		"Gorefiend", -- [66]
		"Kargath", -- [67]
		"Laughing Skull", -- [68]
		"Lightning's Blade", -- [69]
		"Llane", -- [70]
		"Malygos", -- [71]
		"Quel'Thalas", -- [72]
		"Ragnaros", -- [73]
		"Shadowmoon", -- [74]
		"Thunderhorn", -- [75]
		"Thunderlord", -- [76]
		"Aman'Thul", -- [77]
		"Barthilas", -- [78]
		"Blackrock", -- [79]
		"Caelestrasz", -- [80]
		"Dath'Remar", -- [81]
		"Dreadmaul", -- [82]
		"Frostmourne", -- [83]
		"Frostwolf", -- [84]
		"Khaz'goroth", -- [85]
		"Kil'jaeden", -- [86]
		"Kilrogg", -- [87]
		"Nagrand", -- [88]
		"Ner'zhul", -- [89]
		"Proudmoore", -- [90]
		"Sen'jin", -- [91]
		"Silver Hand", -- [92]
		"Thaurissan", -- [93]
		"Tichondrius", -- [94]
		"Vek'nilash", -- [95]
		"Area 52", -- [96]
		"Auchindoun", -- [97]
		"Azuremyst", -- [98]
		"Blade's Edge", -- [99]
		"Blood Furnace", -- [100]
		"Coilfang", -- [101]
		"Dawnbringer", -- [102]
		"Exodar", -- [103]
		"Fizzcrank", -- [104]
		"Galakrond", -- [105]
		"Ghostlands", -- [106]
		"Grizzly Hills", -- [107]
		"Shattered Halls", -- [108]
		"Terokkar", -- [109]
		"The Scryers", -- [110]
		"The Underbog", -- [111]
		"Velen", -- [112]
		"Zangarmarsh", -- [113]
		"Argent Dawn", -- [114]
		"Arthas", -- [115]
		"Azgalor", -- [116]
		"Bleeding Hollow", -- [117]
		"Bloodhoof", -- [118]
		"Durotan", -- [119]
		"Elune", -- [120]
		"Lothar", -- [121]
		"Madoran", -- [122]
		"Magtheridon", -- [123]
		"Mannoroth", -- [124]
		"Medivh", -- [125]
		"Shattered Hand", -- [126]
		"Skullcrusher", -- [127]
		"Stormrage", -- [128]
		"Trollbane", -- [129]
		"Warsong", -- [130]
		"Zul'jin", -- [131]
		"Agamaggan", -- [132]
		"Azshara", -- [133]
		"Baelgun", -- [134]
		"Dark Iron", -- [135]
		"Detheroc", -- [136]
		"Emerald Dream", -- [137]
		"Greymane", -- [138]
		"Kalecgos", -- [139]
		"Lightninghoof", -- [140]
		"Maelstrom", -- [141]
		"Malfurion", -- [142]
		"Moonrunner", -- [143]
		"Nazjatar", -- [144]
		"Sargeras", -- [145]
		"Staghelm", -- [146]
		"Twisting Nether", -- [147]
		"Ursin", -- [148]
		"Wildhammer", -- [149]
		"Antonidas", -- [150]
		"Borean Tundra", -- [151]
		"Cairne", -- [152]
		"Drak'Tharon", -- [153]
		"Drenden", -- [154]
		"Farstriders", -- [155]
		"Garrosh", -- [156]
		"Hydraxis", -- [157]
		"Mok'Nathal", -- [158]
		"Moon Guard", -- [159]
		"Nazgrel", -- [160]
		"Nesingwary", -- [161]
		"Nordrassil", -- [162]
		"Quel'dorei", -- [163]
		"Rivendare", -- [164]
		"Shandris", -- [165]
		"Tortheldrin", -- [166]
		"Wyrmrest Accord", -- [167]
		"Andorhal", -- [168]
		"Anetheron", -- [169]
		"Archimonde", -- [170]
		"Black Dragonflight", -- [171]
		"Dalaran", -- [172]
		"Dalvengyr", -- [173]
		"Dentarg", -- [174]
		"Duskwood", -- [175]
		"Executus", -- [176]
		"Haomarush", -- [177]
		"Khadgar", -- [178]
		"Mal'Ganis", -- [179]
		"Norgannon", -- [180]
		"Scilla", -- [181]
		"Steamwheedle Cartel", -- [182]
		"Thrall", -- [183]
		"Turalyon", -- [184]
		"Ysera", -- [185]
		"Ysondre", -- [186]
		"Zuluhed", -- [187]
		"Alexstrasza", -- [188]
		"Alleria", -- [189]
		"Balnazzar", -- [190]
		"Blackhand", -- [191]
		"Cho'gall", -- [192]
		"Destromath", -- [193]
		"Dethecus", -- [194]
		"Garona", -- [195]
		"Gorgonnash", -- [196]
		"Gul'dan", -- [197]
		"Hellscream", -- [198]
		"Illidan", -- [199]
		"Kael'thas", -- [200]
		"Kirin Tor", -- [201]
		"Ravencrest", -- [202]
		"Spinebreaker", -- [203]
		"Stormreaver", -- [204]
		"Whisperwind", -- [205]
		"Aerie Peak", -- [206]
		"Altar of Storms", -- [207]
		"Alterac Mountains", -- [208]
		"Anvilmar", -- [209]
		"Arygos", -- [210]
		"Blackwing Lair", -- [211]
		"Deathwing", -- [212]
		"Demon Soul", -- [213]
		"Doomhammer", -- [214]
		"Gnomeregan", -- [215]
		"Icecrown", -- [216]
		"Jaedenar", -- [217]
		"Kel'Thuzad", -- [218]
		"Lethon", -- [219]
		"Onyxia", -- [220]
		"Sentinels", -- [221]
		"Tanaris", -- [222]
		"The Venture Co", -- [223]
		"Uldaman", -- [224]
		"Undermine", -- [225]
		"Azjol-Nerub", -- [226]
		"Bloodscalp", -- [227]
		"Boulderfist", -- [228]
		"Bronzebeard", -- [229]
		"Crushridge", -- [230]
		"Daggerspine", -- [231]
		"Darkspear", -- [232]
		"Draenor", -- [233]
		"Dragonblight", -- [234]
		"Dunemaul", -- [235]
		"Feathermoon", -- [236]
		"Perenolde", -- [237]
		"Stonemaul", -- [238]
		"Stormscale", -- [239]
		"Suramar", -- [240]
		"Uldum", -- [241]

                "Lost Isles (US)", -- [242]
                "Gilneas (US)", -- [243]
                "Hamuul (KR)", -- [244]
                "Mekkatorque (EU)", -- [245]
                
                "Azralon", -- [246]
                "Goldrinn", -- [247]
                "Nemesis", -- [248]
                "Gallywix", -- [249]
                "Tol Barad", -- [250]
                "Anasterian (US)", -- [251]

-- EU Missing realms added here by Andrai
		"Al'Akir", -- [252]
		"Aszune", -- [253]
		"Sunstrider", -- [254]
		"Twilight's Hammer", -- [255]
		"Zenedar", -- [256]

		"Alonsus", -- [257]
		"Anachronos", -- [258]
		"Bronze Dragonflight", -- [259]
		"Burning Steppes", -- [260]
		"Darkmoon Faire", -- [261]
		"Kor'gall", -- [262]

		"Genjuros", -- [263]

		"Scarshield Legion", -- [264]
		"Xavius", -- [265]

		"Chamber of Aspects", -- [266]
		"Grim Batol", -- [267]
		"Kazzak", -- [268]
		"Outland", -- [269]
		"Tarren Mill", -- [270]

		"Bloodfeather", -- [271]
		"Darksorrow", -- [272]
		"Defias Brotherhood", -- [273]
		"Frostwhisper", -- [274]
		"Neptulon", -- [275]
		"Sylvanas", -- [276]
		"The Maelstrom", -- [277]

		"Ahn'Qiraj", -- [278]
		"Emeriss", -- [279]
		"Mazrigos", -- [280]
		"Moonglade", -- [281]
		"Talnivarr", -- [282]

		"Hellfire", -- [283]
		"Karazhan", -- [284]
		"Sporeggar", -- [285]
		"The Sha'tar", -- [286]
		
		"Aggra (Português)", -- [287]
		"Well of Eternity", -- [288]

		"Elune", -- [289]
		"Sinstralis", -- [290]

		"Arak-arahm", -- [291]
		"Confr�rie du Thorium", -- [292]
		"La Croisade �écarlate", -- [293]
		"Vol'jin", -- [294]

		"Conseil des Ombres", -- [295]
		"Drek'Thar", -- [296]
		"Les Sentinelles", -- [297]
		"Rashgarroth", -- [298]
		"Throk'Feroth", -- [299]
		"Varimathras", -- [300]

		"Chants éternels", -- [301]
		"Les Clairvoyants", -- [302]
		"Mar�cage de Zangar", -- [303]
		"Naxxramas", -- [304]
		"Temple noir", -- [305]

		"Arathi", -- [306]
		"Culte de la Rive noire", -- [307]
		"Krasus", -- [308]

		"Die Silberne Hand", -- [309]
		"Madmortem", -- [310]
		"Nozdormu", -- [311]
		"Zirkel des Cenarius", -- [312]

		"Der Mithrilorden", -- [313]
		"Forscherliga", -- [314]
		"Teldrassil", -- [315]
		"Todeswache", -- [316]
		"Un'Goro", -- [317]
		
		"Das Syndikat", -- [318]
		"Der Rat von Dalaran", -- [319]
		"Dun Morogh", -- [320]
		"Krag'jin", -- [321]
		"Kult der Verdammten", -- [322]
		"Nera'thor", -- [323]
		"Terrordar", -- [324]
		"Theradras", -- [325]
		"Wrathbringer", -- [326]

		"Blackmoore", -- [327]
		"Die Arguswacht", -- [328]
		"Die ewige Wacht", -- [329]
		"Die Todeskrallen", -- [330]
		"Nefarian", -- [331]

		"Blutkessel", -- [332]
		"Das Konsortium", -- [333]
		"Die Aldor", -- [334]
		"Echsenkessel", -- [335]
		"Festung der Stürme", -- [336]
		"Nethersturm", -- [337]
		"Shattrath", -- [338]

		"Ambossar", -- [339]
		"Der abyssische Rat", -- [340]
		"Die Nachtwache", -- [341]
		"Lordaeron", -- [342]
		"Rajaxx", -- [343]
		"Taerar", -- [344]
		"Tirion", -- [345]
		"Ulduar", -- [346]
		"Vek'lor", -- [347]

		"Colinas Pardas", -- [348]
		"C'Thun", -- [349]
		"Dun Modr", -- [350]
		"Los Errantes", -- [351]
		"Minahonda", -- [352]
		"Sanguino", -- [353]
		"Shen'dralar", -- [354]
		"Tyrande", -- [355]

                -- Russin Reamls:
                "Черный Шрам", -- [356]
                "Азурегос", -- [357]
                "Вечная Песня", -- [358]
                "Голдринн", -- [359]
                "Гордунни", -- [360]
                "Гром", -- [361]
                "Король-лич", -- [362]
                "Пиратская бухта", -- [363]
                "Свежеватель Душ", -- [364]
                "Страж Смерти", -- [365]
                "Термоштепсель", -- [366]
                "Ясеневый лес", -- [367]

                "Борейская тундра", -- [368]
                "Галакронд", -- [369]
                "Дракономор", -- [370]
                "Подземье", -- [371]
                "Разувий", -- [372]
                "Ревущий фьорд", -- [373]
                "Седогрив", -- [374]
                "Ткач Смерти", -- [375]

                ["Lost Isles (US)"] = 242,
                ["Gilneas (US)"] = 243,
                ["Hamuul (KR)"] = 244,
                ["Mekkatorque (EU)"] = 245,
                
                ["Azralon"] = 246,
                ["Goldrinn"] = 247,
                ["Nemesis"] = 248,
                ["Gallywix"] = 249,
                ["Tol Barad"] = 250,                
                ["Anasterian (US)"] = 251,
		
		["Nordrassil"] = 162,
		["Silvermoon"] = 32,
		["Akama"] = 2,
		["Hyjal"] = 46,
		["Kael'thas"] = 200,
		["Terokkar"] = 109,
		["Bloodhoof"] = 118,
		["Mug'thol"] = 15,
		["Kil'jaeden"] = 86,
		["Andorhal"] = 168,
		["Frostwolf"] = 84,
		["Nazgrel"] = 160,
		["Boulderfist"] = 228,
		["Uldum"] = 241,
		["Baelgun"] = 134,
		["Maelstrom"] = 141,
		["Jubei'Thos"] = 10,
		["Deathwing"] = 212,
		["Sentinels"] = 221,
		["Gilneas"] = 65,
		["Stormscale"] = 239,
		["Stonemaul"] = 238,
		["Agamaggan"] = 132,
		["Perenolde"] = 237,
		["Gundrak"] = 8,
		["Feathermoon"] = 236,
		["Blackwing Lair"] = 211,
		["Quel'Thalas"] = 72,
		["Azgalor"] = 116,
		["Ursin"] = 148,
		["Dalaran"] = 172,
		["Rivendare"] = 164,
		["Blackrock"] = 79,
		["Dragonblight"] = 234,
		["Stormrage"] = 128,
		["Archimonde"] = 170,
		["Darkspear"] = 232,
		["Daggerspine"] = 231,
		["Eonar"] = 63,
		["Crushridge"] = 230,
		["Skywall"] = 33,
		["Madoran"] = 122,
		["Malorne"] = 14,
		["Thaurissan"] = 93,
		["Trollbane"] = 129,
		["Bronzebeard"] = 229,
		["Bloodscalp"] = 227,
		["Tortheldrin"] = 166,
		["Argent Dawn"] = 114,
		["Staghelm"] = 146,
		["Kargath"] = 67,
		["Borean Tundra"] = 151,
		["The Scryers"] = 110,
		["Spinebreaker"] = 203,
		["The Venture Co"] = 223,
		["Executus"] = 176,
		["Nazjatar"] = 144,
		["Shu'halo"] = 52,
		["Tanaris"] = 222,
		["Dentarg"] = 174,
		["Coilfang"] = 101,
		["Sargeras"] = 145,
		["Kel'Thuzad"] = 218,
		["Muradin"] = 16,
		["Jaedenar"] = 217,
		["Icecrown"] = 216,
		["Lightninghoof"] = 140,
		["Anvilmar"] = 209,
		["Doomhammer"] = 214,
		["Demon Soul"] = 213,
		["Earthen Ring"] = 62,
		["Dragonmaw"] = 23,
		["Dreadmaul"] = 82,
		["Gnomeregan"] = 215,
		["Winterhoof"] = 57,
		["Shadowmoon"] = 74,
		["Dawnbringer"] = 102,
		["Malfurion"] = 142,
		["Blade's Edge"] = 99,
		["Grizzly Hills"] = 107,
		["Aerie Peak"] = 206,
		["Altar of Storms"] = 207,
		["Windrunner"] = 37,
		["Stormreaver"] = 204,
		["Garrosh"] = 156,
		["Khaz Modan"] = 11,
		["Area 52"] = 96,
		["Kirin Tor"] = 201,
		["Mannoroth"] = 124,
		["Ner'zhul"] = 89,
		["Eldre'Thalas"] = 24,
		["Greymane"] = 138,
		["Gul'dan"] = 197,
		["Thrall"] = 183,
		["Khadgar"] = 178,
		["Dethecus"] = 194,
		["Destromath"] = 193,
		["Ragnaros"] = 73,
		["Cho'gall"] = 192,
		["Thunderlord"] = 76,
		["Korialstrasz"] = 47,
		["Lightning's Blade"] = 69,
		["Medivh"] = 125,
		["Blackhand"] = 191,
		["Galakrond"] = 105,
		["Nesingwary"] = 161,
		["Balnazzar"] = 190,
		["Laughing Skull"] = 68,
		["Runetotem"] = 18,
		["Dath'Remar"] = 81,
		["Dark Iron"] = 135,
		["Aman'Thul"] = 77,
		["Nagrand"] = 88,
		["Moon Guard"] = 159,
		["Drakkari"] = 61,
		["Smolderthorn"] = 34,
		["Bleeding Hollow"] = 117,
		["Elune"] = 120,
		["Garithos"] = 7,
		["Ysondre"] = 186,
		["Ysera"] = 185,
		["Spirestone"] = 35,
		["Kilrogg"] = 87,
		["Velen"] = 112,
		["Tichondrius"] = 94,
		["The Underbog"] = 111,
		["Alexstrasza"] = 188,
		["Skullcrusher"] = 127,
		["Arathor"] = 21,
		["Scarlet Crusade"] = 29,
		["Gorefiend"] = 66,
		["Sisters of Elune"] = 53,
		["Lothar"] = 121,
		["Fenris"] = 45,
		["Lightbringer"] = 48,
		["Anetheron"] = 169,
		["Blackwater Raiders"] = 39,
		["Undermine"] = 225,
		["Drak'thul"] = 4,
		["Garona"] = 195,
		["Ravencrest"] = 202,
		["Draenor"] = 233,
		["Alleria"] = 189,
		["Kalecgos"] = 139,
		["Steamwheedle Cartel"] = 182,
		["Twisting Nether"] = 147,
		["Scilla"] = 181,
		["Bonechewer"] = 22,
		["The Forgotten Coast"] = 54,
		["Norgannon"] = 180,
		["Cenarius"] = 42,
		["Aegwynn"] = 1,
		["Caelestrasz"] = 80,
		["Blood Furnace"] = 100,
		["Lethon"] = 219,
		["Vashj"] = 56,
		["Durotan"] = 119,
		["Detheroc"] = 136,
		["Gorgonnash"] = 196,
		["Terenas"] = 36,
		["Fizzcrank"] = 104,
		["Korgath"] = 12,
		["Drenden"] = 154,
		["Misha"] = 50,
		["Haomarush"] = 177,
		["Burning Blade"] = 59,
		["Dalvengyr"] = 173,
		["Warsong"] = 130,
		["Shattered Hand"] = 126,
		["Suramar"] = 240,
		["Drak'Tharon"] = 153,
		["Farstriders"] = 155,
		["Burning Legion"] = 60,
		["Maiev"] = 49,
		["Vek'nilash"] = 95,
		["Eredar"] = 64,
		["Magtheridon"] = 123,
		["Wyrmrest Accord"] = 167,
		["Azjol-Nerub"] = 226,
		["Sen'jin"] = 91,
		["Nathrezim"] = 28,
		["Shandris"] = 165,
		["Aggramar"] = 58,
		["Hakkar"] = 9,
		["Saurfang"] = 19,
		["Kul Tiras"] = 13,
		["Shattered Halls"] = 108,
		["Shadowsong"] = 31,
		["Gurubashi"] = 27,
		["Thunderhorn"] = 75,
		["Zuluhed"] = 187,
		["Azuremyst"] = 98,
		["Bladefist"] = 40,
		["Barthilas"] = 78,
		["Onyxia"] = 220,
		["Cairne"] = 152,
		["Dunemaul"] = 235,
		["Frostmourne"] = 83,
		["Black Dragonflight"] = 171,
		["Arthas"] = 115,
		["Zul'jin"] = 131,
		["Eitrigg"] = 6,
		["Rexxar"] = 17,
		["Antonidas"] = 150,
		["Khaz'goroth"] = 85,
		["Frostmane"] = 26,
		["Shadow Council"] = 30,
		["Hydraxis"] = 157,
		["Alterac Mountains"] = 208,
		["Silver Hand"] = 92,
		["Thorium Brotherhood"] = 20,
		["Anub'arak"] = 38,
		["Exodar"] = 103,
		["Duskwood"] = 175,
		["Cenarion Circle"] = 41,
		["Uther"] = 55,
		["Uldaman"] = 224,
		["Ghostlands"] = 106,
		["Zangarmarsh"] = 113,
		["Llane"] = 70,
		["Hellscream"] = 198,
		["Wildhammer"] = 149,
		["Auchindoun"] = 97,
		["Moonrunner"] = 143,
		["Whisperwind"] = 205,
		["Emerald Dream"] = 137,
		["Mal'Ganis"] = 179,
		["Firetree"] = 25,
		["Arygos"] = 210,
		["Darrowmere"] = 43,
		["Turalyon"] = 184,
		["Draka"] = 5,
		["Mok'Nathal"] = 158,
		["Azshara"] = 133,
		["Illidan"] = 199,
		["Echo Isles"] = 44,
		["Malygos"] = 71,
		["Ravenholdt"] = 51,
		["Proudmoore"] = 90,
		["Chromaggus"] = 3,
		["Quel'dorei"] = 163,
		
-- EU missing realms again for lookup by name
		["Al'Akir"] = 252,
		["Aszune"] = 253,
		["Sunstrider"] = 254,
		["Twilight's Hammer"] = 255,
		["Zenedar"] = 256,

		["Alonsus"] = 257,
		["Anachronos"] = 258,
		["Bronze Dragonflight"] = 259,
		["Burning Steppes"] = 260,
		["Darkmoon Faire"] = 261,
		["Kor'gall"] = 262,

		["Genjuros"] = 263,

		["Scarshield Legion"] = 264,
		["Xavius"] = 265,

		["Chamber of Aspects"] = 266,
		["Grim Batol"] = 267,
		["Kazzak"] = 268,
		["Outland"] = 269,
		["Tarren Mill"] = 270,

		["Bloodfeather"] = 271,
		["Darksorrow"] = 272,
		["Defias Brotherhood"] = 273,
		["Frostwhisper"] = 274,
		["Neptulon"] = 275,
		["Sylvanas"] = 276,
		["The Maelstrom"] = 277,

		["Ahn'Qiraj"] = 278,
		["Emeriss"] = 279,
		["Mazrigos"] = 280,
		["Moonglade"] = 281,
		["Talnivarr"] = 282,

		["Hellfire"] = 283,
		["Karazhan"] = 284,
		["Sporeggar"] = 285,
		["The Sha'tar"] = 286,
		
		["Aggra (Português)"] = 287,
		["Well of Eternity"] = 288,

		["Elune"] = 289,
		["Sinstralis"] = 290,

		["Arak-arahm"] = 291,
		["Confr�rie du Thorium"] = 292,
		["La Croisade �écarlate"] = 293,
		["Vol'jin"] = 294,

		["Conseil des Ombres"] = 295,
		["Drek'Thar"] = 296,
		["Les Sentinelles"] = 297,
		["Rashgarroth"] = 298,
		["Throk'Feroth"] = 299,
		["Varimathras"] = 300,

		["Chants éternels"] = 301,
		["Les Clairvoyants"] = 302,
		["Mar�cage de Zangar"] = 303,
		["Naxxramas"] = 304,
		["Temple noir"] = 305,

		["Arathi"] = 306,
		["Culte de la Rive noire"] = 307,
		["Krasus"] = 308,

		["Die Silberne Hand"] = 309,
		["Madmortem"] = 310,
		["Nozdormu"] = 311,
		["Zirkel des Cenarius"] = 312,

		["Der Mithrilorden"] = 313,
		["Forscherliga"] = 314,
		["Teldrassil"] = 315,
		["Todeswache"] = 316,
		["Un'Goro"] = 317,

		["Das Syndikat"] = 318,
		["Der Rat von Dalaran"] = 319,
		["Dun Morogh"] = 320,
		["Krag'jin"] = 321,
		["Kult der Verdammten"] = 322,
		["Nera'thor"] = 323,
		["Terrordar"] = 324,
		["Theradras"] = 325,
		["Wrathbringer"] = 326,

		["Blackmoore"] = 327,
		["Die Arguswacht"] = 328,
		["Die ewige Wacht"] = 329,
		["Die Todeskrallen"] = 330,
		["Nefarian"] = 331,

		["Blutkessel"] = 332,
		["Das Konsortium"] = 333,
		["Die Aldor"] = 334,
		["Echsenkessel"] = 335,
		["Festung der Stürme"] = 336,
		["Nethersturm"] = 337,
		["Shattrath"] = 338,

		["Ambossar"] = 339,
		["Der abyssische Rat"] = 340,
		["Die Nachtwache"] = 341,
		["Lordaeron"] = 342,
		["Rajaxx"] = 343,
		["Taerar"] = 344,
		["Tirion"] = 345,
		["Ulduar"] = 346,
		["Vek'lor"] = 347,

		["Colinas Pardas"] = 348,
		["C'Thun"] = 349,
		["Dun Modr"] = 350,
		["Los Errantes"] = 351,
		["Minahonda"] = 352,
		["Sanguino"] = 353,
		["Shen'dralar"] = 354,
		["Tyrande"] = 355,

                -- RU
                ["Черный Шрам"] = 356,
                ["Азурегос"] = 357,
                ["Вечная Песня"] = 358,
                ["Голдринн"] = 359,
                ["Гордунни"] = 360,
                ["Гром"] = 361,
                ["Король-лич"] = 362,
                ["Пиратская бухта"] = 363,
                ["Свежеватель Душ"] = 364,
                ["Страж Смерти"] = 365,
                ["Термоштепсель"] = 366,
                ["Ясеневый лес"] = 367,

                ["Борейская тундра"] = 368,
                ["Галакронд"] = 369,
                ["Дракономор"] = 370,
                ["Подземье"] = 371,
                ["Разувий"] = 372,
                ["Ревущий фьорд"] = 373,
                ["Седогрив"] = 374,
                ["Ткач Смерти"] = 375,} ;


OQ.gbl = { ["scintilla#2342"   ] = "exploiting",  -- OQ exploiter; eu-yt
           ["Furïïøuz#2521"    ] = "exploiting",  -- OQ exploiter; gold dragon 
           ["zeus#2722"        ] = "exploiting",  -- OQ exploiter; gold dragon 
           ["pumpkinhead#2172" ] = "exploiting",  -- OQ exploiter; gold dragon 
           ["enes#2215"        ] = "exploiting",  -- OQ exploiter; eu-yt
         } ;

-- any modification to oqueue is considered an exploit and is reported to the scorekeeper 
-- and has been for a while
-- 
OQ.naughty_list = { ["dummsau1000#2997"] = 1,
		["kingzz#2404"] = 1,
		["rayray#2954"] = 1,
		["freimaurer#2240"] = 1,
		["lokenpro#2486"] = 1,
		["freimaurer#2755"] = 1,
		["ultrasnow#2968"] = 1,
		["pooky#2324"] = 1,
		["bogi#2462"] = 1,
		["groghar#2179"] = 1,
		["ruukio#2711"] = 1,
		["strzelcy#2874"] = 1,
		["naessahui#2209"] = 1,
		["hallonbåten#2199"] = 1,
		["shottino#2861"] = 1,
		["duster#2922"] = 1,
		["trackerz#1305"] = 1,
		["shinzle#2915"] = 1,
		["diablo#21311"] = 1,
		["elmonty#2290"] = 1,
		["nirvash#2406"] = 1,
		["yhelijep#1861"] = 1,
		["soibéni#2642"] = 1,
		["whityqt#2856"] = 1,
		["hcxo#2228"] = 1,
		["vera#2404"] = 1,
		["snook#2534"] = 1,
		["daisy#2357"] = 1,
		["mvcage#2157"] = 1,
		["nekit1232011#2395"] = 1,
		["ulticrow#2355"] = 1,
		["hego#2692"] = 1,
		["diabolica#2593"] = 1,
		["absinthie#2935"] = 1,
		["nancy#2453"] = 1,
		["ifrit#2145"] = 1,
		["foks686#2258"] = 1,
		["utrod#2489"] = 1,
		["muske#2605"] = 1,
		["shaoliine#2741"] = 1,
		["limits#2778"] = 1,
		["kirknes#2400"] = 1,
		["kryo#2432"] = 1,
		["dpk#2260"] = 1,
		["jigs#2638"] = 1,
		["marcoman#2611"] = 1,
		["hatepulse#2491"] = 1,
		["nessabee#2272"] = 1,
		["paramon#2638"] = 1,
		["thakrull#2802"] = 1,
		["headchopperz#1592"] = 1,
		["russo#2644"] = 1,
		["phindo#2570"] = 1,
		["szycha#2680"] = 1,
		["gomez#2897"] = 1,
		["klaudoz#2428"] = 1,
		["challenger#2872"] = 1,
		["deanking#2813"] = 1,
		["spanky#2630"] = 1,
		["terrablast#2548"] = 1,
		["teez#1735"] = 1,
		["speedfox#2391"] = 1,
		["lophi#2248"] = 1,
		["salhi#2498"] = 1,
		["karoline#2176"] = 1,
		["lylrok#2330"] = 1,
		["unstable#2887"] = 1,
		["noizdude#2275"] = 1,
		["soulreaper#2644"] = 1,
		["insanepotato#2683"] = 1,
		["daniramsey19#2284"] = 1,
		["lynx#2698"] = 1,
		["lucra#2744"] = 1,
		["marck#2876"] = 1,
		["cr3ma1or#2795"] = 1,
		["dora#2930"] = 1,
		["chakah#2350"] = 1,
		["gilldoan#2518"] = 1,
		["mads#2663"] = 1,
		["soma#2659"] = 1,
		["geron#2586"] = 1,
		["shine#2814"] = 1,
		["redfeather#2290"] = 1,
		["nazgad#2962"] = 1,
		["andy#2410"] = 1,
		["avendalia#2360"] = 1,
		["vinos1994#2516"] = 1,
		["hokram#2209"] = 1,
		["reachy#2972"] = 1,
		["esherlock#2818"] = 1,
		["купер#2258"] = 1,
		["execom#2175"] = 1,
		["kestudi#2519"] = 1,
		["cortexrpz#2628"] = 1,
		["essveh#2513"] = 1,
		["wombat#2189"] = 1,
		["blackcheep#2898"] = 1,
		["blackdeath#2500"] = 1,
		["morshock#2412"] = 1,
		["mokko#2278"] = 1,
		["gauhl#2419"] = 1,
		["bloodynight1#2449"] = 1,
		["prozac#2606"] = 1,
		["reivilo#2581"] = 1,
		["nitrouz#2157"] = 1,
		["zau#2533"] = 1,
		["atarax#2286"] = 1,
		["tailu#2918"] = 1,
		["darudei#2477"] = 1,
		["bullet#2543"] = 1,
		["peek3boo#2376"] = 1,
		["ammaterasu#2753"] = 1,
		["mccormick#2528"] = 1,
		["kuriouschild#2635"] = 1,
		["rumpchock#2398"] = 1,
		["kuchiking#2664"] = 1,
		["atanorr#2787"] = 1,
		["wssa#1200"] = 1,
		["beastmode#1662"] = 1,
		["moxter#2983"] = 1,
		["adellarn#2960"] = 1,
		["bajjan2k#2865"] = 1,
		["luke1703#2599"] = 1,
		["shotgun#2841"] = 1,
		["ubalhrozny#2548"] = 1,
		["nat#2400"] = 1,
		["eogwyn#2435"] = 1,
		["n3m0#1378"] = 1,
		["reiran#2770"] = 1,
		["doublestyle#2480"] = 1,
		["whisper#2106"] = 1,
		["tagu600#2429"] = 1,
		["никитос#2915"] = 1,
		["power9#2362"] = 1,
		["bullvai#2846"] = 1,
		["tinhay#2854"] = 1,
		["maronne#2875"] = 1,
		["naxos#2324"] = 1,
		["freimaurer#2627"] = 1,
		["neuralgia#2265"] = 1,
		["nizku#2221"] = 1,
		["klaes#2617"] = 1,
		["maurits#2632"] = 1,
		["palkan#2233"] = 1,
		["huggies#2310"] = 1,
		["igryl9l#2299"] = 1,
		["dehanz#2367"] = 1,
		["surab#2971"] = 1,
		["franciscomag#2722"] = 1,
		["charlemagne#2463"] = 1,
		["emile#2379"] = 1,
		["gena#2610"] = 1,
		["malign#2837"] = 1,
		["nethridius#2369"] = 1,
		["minatrixy#2472"] = 1,
		["barel#2618"] = 1,
		["navi#2156"] = 1,
		["gnevion#2207"] = 1,
		["skizz#2754"] = 1,
		["worgnfreeman#2528"] = 1,
		["ridikul#2625"] = 1,
		["daftcrab#2687"] = 1,
		["novaveteran#2746"] = 1,
                  } ;

end
