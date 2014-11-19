﻿if GetLocale() == "zhTW" then
	BINDING_HEADER_GOGOHEADER = "GoGoMount"
	BINDING_NAME_GOGOBINDING = "坐騎/解除坐騎"
	BINDING_NAME_GOGOBINDING2 = "坐騎/解除坐騎(無飛行)"
	BINDING_NAME_GOGOBINDING3 = "坐騎/解除有乘客的坐騎"
	GoGo_Variables.Localize = {
	Skill = {
		Engineering = "工程學",
		Riding = "騎術",
		Tailoring = "裁縫",
	},
	String = {
		AutoExcludeFlyingMountsInNoFlyAreas = "Automatically exclude flying mounts in \"no fly\" areas", -- Requires localization
		AutoExcludeFlyingMountsInNoFlyAreas_Long = "With this option enabled, GoGoMount will automatically remove all mounts that can fly from the random mount selection when it believes you can't actually fly.  This is almost the same as using key binding #2 for GoGoMount.  This will be useful while leveling up, in battle grounds, etc.  Note that if your list of favorite mounts contains all mounts that can fly and you trying mounting in a battle ground with this option enabled, you may not mount at all.", -- Requires localization
		AutomaticallyRemoveBuffs = "自動移除防止騎乘的增益",
		AutoStartCrusaderAura = "Auto start Crusader Aura", -- Requires localization
		AutoStartCrusaderAura_Long = "Automatically start Crusader Aura when using GoGoMount to mount.", -- Requires localization
		Clear = "清除", -- Needs review
		ClearGlobalFavoriteMounts = "Clear global favorite mounts", -- Requires localization
		CurrentZone = "當前地區", -- Needs review
		CurrentZoneDescription = "Mounts flagged here as zone favorites will be the only mounts GoGoMount will use in this zone.  All other mounts and shape forms will be ignored.  Clearing this list will allow GoGoMount to use all mounts (or global favorites if set).", -- Requires localization
		CurrentZoneExclusions = "目前區域停用", -- Needs review
		CurrentZoneFavorites = "當前地區的偏好",
		DisableFlyingFromWater = "在水中時停用飛行座騎", -- Needs review
		DisableInCombat = "戰鬥時停用隨機坐騎", -- Needs review
		DisableInCombat_Long = "This option disables GoGoMount buttons while in combat.  Useful for Druids who tank in bear form and accidently press their GoGoMount buttons.  Must be enabled or disabled before entering combat.", -- Requires localization
		DisableUnknownMountNotices = "停用未知的坐騎通知",
		DisableUpdateNotices = "停用更新通知",
		DruidFlightPreference = "當角色移動時使用飛行型態取代座騎",
		DruidOptions = "德魯伊選項",
		DruidSingleClick = "單擊後從變身形態轉換為旅行形態",
		EnableAutoDismount = "啟用自動解除坐騎",
		ExtraPassengerMounts = "Extra Passenger Mounts", -- Requires localization
		ExtraPassengerMountsDescription = "This list of passenger mounts is used to add passenger mounts to the random selection only when the Passenger Mount button is pressed.  This will allow you to set preferred mount lists excluding passenger mounts but still have them available when using the Passenger Mount button.  These mounts will not be used if they are marked as excluded mounts globally or for the current zone you are in.", -- Requires localization
		Favorites = "偏好",
		GlobalExclusions = "全區例外", -- Needs review
		GlobalExclusionsDescription = "這些坐騎會被忽略。即使這些坐騎在你的最愛清單裡面，他們仍然不會被使用", -- Needs review
		GlobalFavorites = "總體偏好",
		GlobalPreferences = "總體優先",
		GlobalZoneDescription = "Preferred mounts defined here will only take effect if there are no zone specific mount favorites set for the current zone you are in.", -- Requires localization
		HunterOptions = "獵人選項",
		NewVersionFound = "已有GoGoMount的更新版本",
		NoShapeInRandom = "Do not randomize shape forms with mounts", -- Requires localization
		PaladinOptions = "聖騎士選項", -- Needs review
		RemoveBuffs = "自動移除讓你無法上坐騎的BUFF", -- Needs review
		RemoveBuffs_Long = "GoGoMount will attempt to remove buffs and shapeforms that come from spells and items that prevent mounting.  This only works for known buffs and in some cases require 2 clicks of your GoGoMount button to mount.", -- Requires localization
		ShamanOptions = "Shaman Options", -- Requires localization
		ShamanSingleClick = "Single click mount from Ghost Wolf Form instead of dismounting", -- Requires localization
		UnknownMountFound = "在你的坐騎清單中找到未知的坐騎。請回報它，以便加入到GoGoMount的新版本中。",
		UseAspectOfThePackInstead = "Use Aspect Of The Pack instead of Aspect Of The Cheeta", -- Requires localization
		UseAspectOfThePackInstead_Long = "When enabled, GoGoMount will cast Aspect of the Pack instead of Aspect of the Cheetah.  Local zone or global settings override this setting.  If this is set to use Aspect of the Pack and you have Aspect of the Cheetah as a zone favorite, Aspect of the Cheetah will be used.", -- Requires localization
		ZoneExclusionsDescription = "和全區停用有類似的作用，任何底下選擇的坐騎在本區域不會被召喚", -- Needs review
	},
	Talent = {
		AncestralSwiftness = "先祖迅捷",
		FeralSwiftness = "迅捷飛行形態",
	},
	Zone = {
		AbyssalDepths = "地獄深淵",
		AmaniMountains = "阿曼尼山脈",
		AQ40 = "安其拉",
		AzuremystIsle = "藍謎島",
		BloodmystIsle = "血謎島",
		CrumblingDepths = "破碎深淵",
		Dalaran = "達拉然",
		DarkbreakCove = "黑裂灣",
		Deepholm = "地深之源",
		DireMaul = "厄運之槌",
		EversongWoods = "永歌森林",
		Ghostlands = "鬼魂之地",
		Icecrown = "寒冰皇冠",
		Ironforge = "鐵爐堡",
		IsleOfQuelDanas = "奎爾達納斯之島",
		KrasusLanding = "卡薩斯平臺",
		LegionsRest = "軍團之眠",
		Lghorek = "勒苟雷克",
		Nespirah = "奈斯畢拉",
		ShimmeringExpanse = "閃光瀚洋",
		SholazarBasin = "休拉薩盆地",
		SilvermoonCity = "銀月城",
		SilverTideHollow = "銀浪谷地",
		TempleOfBethekk = "比塞克神廟",
		TempleOfEarth = "大地神殿",
		TenebrousCavern = "陰暗洞穴",
		ThalassianPass = "薩拉斯小徑",
		ThalassianRange = "薩拉斯海脊",
		TheCerebrillum = "腦室",
		TheExodar = "艾克索達",
		TheFrozenSea = "冰凍之海",
		TheOculus = "奧核之眼",
		TheStormPeaks = "風暴群山",
		TheTempleOfAtalHakkar = "阿塔哈卡神廟",
		TheUnderbelly = "城底區",
		TheVioletCitadel = "紫羅蘭城塞",
		TheVortexPinnacle = "漩渦尖塔",
		TolBarad = "托巴拉德",
		TolBaradPeninsula = "托巴拉德半島",
		TwistingNether = "扭曲虛空",
		Vashjir = "瓦許爾",
		Wintergrasp = "冬握湖",
	},
}

end --if