-- ------------------------------------------------------------------------------ --
--                           TradeSkillMaster_AuctionDB                           --
--           http://www.curse.com/addons/wow/tradeskillmaster_auctiondb           --
--                                                                                --
--             A TradeSkillMaster Addon (http://tradeskillmaster.com)             --
--    All Rights Reserved* - Detailed license information included with addon.    --
-- ------------------------------------------------------------------------------ --

-- TradeSkillMaster_AuctionDB Locale - deDE
-- Please use the localization app on CurseForge to update this
-- http://wow.curseforge.com/addons/TradeSkillMaster_AuctionDB/localization/

local L = LibStub("AceLocale-3.0"):NewLocale("TradeSkillMaster_AuctionDB", "deDE")
if not L then return end

L["A full auction house scan will scan every item on the auction house but is far slower than a GetAll scan. Expect this scan to take several minutes or longer."] = "Ein vollständiger Scan wird jeden einzelnen Gegenstand im Auktionshaus scannen, allerdings ist er weitaus langsamer als der GetAll-Scan. Dieser Scan kann mehrere Minuten dauern."
-- L["A full scan is a slow, manual scan of the entire auction house."] = ""
-- L["A 'GetAll' scan is an extremely fast way to manually scan the entire AH, but may run into bugs on Blizzard's end such as disconnection issues. It also has a 15 minute cooldown."] = ""
L["A GetAll scan is the fastest in-game method for scanning every item on the auction house. However, there are many possible bugs on Blizzard's end with it including the chance for it to disconnect you from the game. Also, it has a 15 minute cooldown."] = "Ein GetAll-Scan ist die schnellste Methode im Spiel zum Scannen von AH-Gegenständen. Allerdings können dabei einige Bugs seitens Blizzard auftreten, einschließlich der Chance eines Disconnects. Außerdem hat er eine Abklingzeit von 15 Minuten."
-- L["AuctionDB - Global Historical Price (via TSM App)"] = ""
-- L["AuctionDB - Global Market Value Average (via TSM App)"] = ""
-- L["AuctionDB - Global Minimum Buyout Average (via TSM App)"] = ""
-- L["AuctionDB - Global Sale Average (via TSM App)"] = ""
-- L["AuctionDB - Historical Price (via TSM App)"] = ""
L["AuctionDB - Market Value"] = "AuctionDB - Marktwert"
L["AuctionDB - Minimum Buyout"] = "AuctionDB - Mindestpreis"
L["Can't run a GetAll scan right now."] = "Momentan kann ein GetAll-Scan nicht durchgeführt werden."
-- L["%d auctions"] = ""
-- L["Display global historical price (via TSM Application) in the tooltip."] = ""
-- L["Display global market value avg (via TSM Application) in the tooltip."] = ""
-- L["Display global min buyout avg (via TSM Application) in the tooltip."] = ""
-- L["Display global sale avg (via TSM Application) in the tooltip."] = ""
-- L["Display historical price (via TSM Application) in the tooltip."] = ""
L["Display market value in tooltip."] = "Zeige Marktwert im Tooltip."
-- L["Display min buyout in tooltip."] = ""
L["Done Scanning"] = "Scannen beendet"
L["Download the FREE TSM desktop application which will automatically update your TSM_AuctionDB prices using Blizzard's online APIs (and does MUCH more). Visit %s for more info and never scan the AH again! This is the best way to update your AuctionDB prices."] = "Ladet die KOSTENLOSE TSM-Desktopsoftware herunter, die Eure TSM_AuctionDB-Preise mithilfe der Online-APIs von Blizzard aktualisiert (und noch VIELES mehr). Besucht %s, um weitere Informationen zu erhalten und das AH nie wieder scannen zu müssen! Das ist die beste Methode, um Eure AuctionDB-Preise aktuell zu halten."
L["General Options"] = "Allgemeine Optionen"
-- L["GetAll scan did not run successfully due to issues on Blizzard's end. Using the TSM desktop application for your scans is recommended."] = ""
-- L["Global Historical Price:"] = ""
-- L["Global Historical Price x%s:"] = ""
-- L["Global Market Value Avg:"] = ""
-- L["Global Market Value Avg x%s:"] = ""
-- L["Global Min Buyout Avg:"] = ""
-- L["Global Min Buyout Avg x%s:"] = ""
-- L["Global Sale Avg:"] = ""
-- L["Global Sale Avg x%s:"] = ""
-- L["Historical Price:"] = ""
-- L["Historical Price x%s:"] = ""
-- L["If checked, AuctionDB will add a tab to the AH to allow for in-game scans. If you are using the TSM app exclusively for your scans, you may want to hide it by unchecking this option. This option requires a reload to take effect."] = ""
-- L["If checked, the global historical price of the item will be displayed. This is provided exclusively via the TradeSkillMaster Application."] = ""
-- L["If checked, the global market value average of the item will be displayed. This is provided exclusively via the TradeSkillMaster Application."] = ""
-- L["If checked, the global minimum buyout average of the item will be displayed. This is provided exclusively via the TradeSkillMaster Application."] = ""
-- L["If checked, the global sale average of the item will be displayed. This is provided exclusively via the TradeSkillMaster Application."] = ""
-- L["If checked, the historical price of the item will be displayed. This is provided exclusively via the TradeSkillMaster Application."] = ""
L["If checked, the lowest buyout value seen in the last scan of the item will be displayed."] = "Wenn aktiviert, wird der niedrigste Sofortkaufpreis, der im letzten Scan des Gegenstands gefunden wurde, angezeigt."
L["If checked, the market value of the item will be displayed"] = "Wenn aktiviert, wird der Marktwert des Gegenstands angezeigt."
-- L["If you have created TSM groups, they will be listed here for selection."] = ""
L["Last updated from in-game scan %s ago."] = "Zuletzt aktualisiert vor %s via Ingame-Scan."
L["Last updated from the TSM Application %s ago."] = "Zuletzt aktualisiert vor %s via TSM-Anwendung."
-- L["Last Update Time"] = ""
L["Market Value:"] = "Marktwert:"
L["Market Value x%s:"] = "Marktwert x%s:"
L["Min Buyout:"] = "Mindest-Sofortkauf:" -- Needs review
L["Min Buyout x%s:"] = "Min. Sofortkauf x%s:" -- Needs review
L["No scans found."] = "Keine Scans gefunden."
L["Not Ready"] = "Nicht bereit"
L["Not Scanned"] = "Nicht gescannt"
-- L["Preparing Filters..."] = ""
L["Processing data..."] = "Verarbeite Daten..."
L["Ready"] = "Bereit"
L["Run Full Scan"] = "Vollständigen Scan starten"
L["Run GetAll Scan"] = "GetAll-Scan starten"
L["Running query..."] = "Abfrage läuft..."
L["%s ago"] = "Vor %s"
-- L["Scanning %d / %d (Page %d / %d)"] = ""
L["Scanning page %s/%s"] = "Scanne Seite %s/%s"
-- L["Scanning page %s/%s - Approximately %s remaining"] = ""
-- L["Scanning results..."] = ""
L["Scanning the auction house in game is no longer necessary!"] = "Das Auktionshaus muss im Spiel nicht mehr gescannt werden!"
-- L["Scan Selected Groups"] = ""
-- L["Show AuctionDB AH Tab (Requires Reload)"] = ""
-- L["This button will scan just the items in the groups you have selected."] = ""
-- L["This will do a slow auction house scan of every item in the selected groups and update their AuctionDB prices. This may take several minutes."] = ""
 