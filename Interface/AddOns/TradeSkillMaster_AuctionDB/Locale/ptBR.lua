-- ------------------------------------------------------------------------------ --
--                           TradeSkillMaster_AuctionDB                           --
--           http://www.curse.com/addons/wow/tradeskillmaster_auctiondb           --
--                                                                                --
--             A TradeSkillMaster Addon (http://tradeskillmaster.com)             --
--    All Rights Reserved* - Detailed license information included with addon.    --
-- ------------------------------------------------------------------------------ --

-- TradeSkillMaster_AuctionDB Locale - ptBR
-- Please use the localization app on CurseForge to update this
-- http://wow.curseforge.com/addons/TradeSkillMaster_AuctionDB/localization/

local L = LibStub("AceLocale-3.0"):NewLocale("TradeSkillMaster_AuctionDB", "ptBR")
if not L then return end

L["A full auction house scan will scan every item on the auction house but is far slower than a GetAll scan. Expect this scan to take several minutes or longer."] = "Um escaneamento completo da casa de leilões irá escanear todos os itens da casa de leilões, porém é bem mais lento que um escaneamento PegaTudo. Espere que este escaneamento demore vários minutos ou mais."
-- L["A full scan is a slow, manual scan of the entire auction house."] = ""
-- L["A 'GetAll' scan is an extremely fast way to manually scan the entire AH, but may run into bugs on Blizzard's end such as disconnection issues. It also has a 15 minute cooldown."] = ""
-- L["A GetAll scan is the fastest in-game method for scanning every item on the auction house. However, there are many possible bugs on Blizzard's end with it including the chance for it to disconnect you from the game. Also, it has a 15 minute cooldown."] = ""
-- L["AuctionDB - Global Historical Price (via TSM App)"] = ""
-- L["AuctionDB - Global Market Value Average (via TSM App)"] = ""
-- L["AuctionDB - Global Minimum Buyout Average (via TSM App)"] = ""
-- L["AuctionDB - Global Sale Average (via TSM App)"] = ""
-- L["AuctionDB - Historical Price (via TSM App)"] = ""
L["AuctionDB - Market Value"] = "AuctionDB - Valor de Mercado"
L["AuctionDB - Minimum Buyout"] = "AuctionDB - Arremate Mínimo"
-- L["AuctionDB - Region Historical Price (via TSM App)"] = ""
-- L["AuctionDB - Region Market Value Average (via TSM App)"] = ""
-- L["AuctionDB - Region Minimum Buyout Average (via TSM App)"] = ""
-- L["AuctionDB - Region Sale Average (via TSM App)"] = ""
-- L["Can't run a GetAll scan right now."] = ""
-- L["%d auctions"] = ""
-- L["Display global historical price (via TSM Application) in the tooltip."] = ""
-- L["Display global market value avg (via TSM Application) in the tooltip."] = ""
-- L["Display global min buyout avg (via TSM Application) in the tooltip."] = ""
-- L["Display global sale avg (via TSM Application) in the tooltip."] = ""
-- L["Display historical price (via TSM Application) in the tooltip."] = ""
-- L["Display market value in tooltip."] = ""
-- L["Display min buyout in tooltip."] = ""
-- L["Display region average daily sold quantity (via TSM Application) in the tooltip."] = ""
-- L["Display region historical price (via TSM Application) in the tooltip."] = ""
-- L["Display region market value avg (via TSM Application) in the tooltip."] = ""
-- L["Display region min buyout avg (via TSM Application) in the tooltip."] = ""
-- L["Display region sale avg (via TSM Application) in the tooltip."] = ""
-- L["Display region sale rate (via TSM Application) in the tooltip."] = ""
L["Done Scanning"] = "Escaneamento Completo"
-- L["Download the FREE TSM desktop application which will automatically update your TSM_AuctionDB prices using Blizzard's online APIs (and does MUCH more). Visit %s for more info and never scan the AH again! This is the best way to update your AuctionDB prices."] = ""
L["General Options"] = "Opções Gerais"
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
-- L["If checked, the lowest buyout value seen in the last scan of the item will be displayed."] = ""
-- L["If checked, the market value of the item will be displayed"] = ""
-- L["If checked, the region average daily sold quantity of the item will be displayed. This is provided exclusively via the TradeSkillMaster Application."] = ""
-- L["If checked, the region historical price of the item will be displayed. This is provided exclusively via the TradeSkillMaster Application."] = ""
-- L["If checked, the region market value average of the item will be displayed. This is provided exclusively via the TradeSkillMaster Application."] = ""
-- L["If checked, the region minimum buyout average of the item will be displayed. This is provided exclusively via the TradeSkillMaster Application."] = ""
-- L["If checked, the region sale average of the item will be displayed. This is provided exclusively via the TradeSkillMaster Application."] = ""
-- L["If checked, the region sale rate of the item will be displayed. This is provided exclusively via the TradeSkillMaster Application."] = ""
-- L["If you have created TSM groups, they will be listed here for selection."] = ""
-- L["Last updated from in-game scan %s ago."] = ""
-- L["Last updated from the TSM Application %s ago."] = ""
-- L["Last Update Time"] = ""
L["Market Value:"] = "Preço de mercado"
-- L["Market Value x%s:"] = ""
L["Min Buyout:"] = "Arremate minimo"
-- L["Min Buyout x%s:"] = ""
-- L["No scans found."] = ""
L["Not Ready"] = "Não está pronto"
-- L["Not Scanned"] = ""
-- L["Preparing Filters..."] = ""
-- L["Processing data..."] = ""
L["Ready"] = "Pronto"
-- L["Region Avg Daily Sold:"] = ""
-- L["Region Avg Daily Sold x%s:"] = ""
-- L["Region Historical Price:"] = ""
-- L["Region Historical Price x%s:"] = ""
-- L["Region Market Value Avg:"] = ""
-- L["Region Market Value Avg x%s:"] = ""
-- L["Region Min Buyout Avg:"] = ""
-- L["Region Min Buyout Avg x%s:"] = ""
-- L["Region Sale Avg:"] = ""
-- L["Region Sale Avg x%s:"] = ""
-- L["Region Sale Rate:"] = ""
-- L["Region Sale Rate x%s:"] = ""
L["Run Full Scan"] = "Escaneamento Completo" -- Needs review
L["Run GetAll Scan"] = "PegaTudo" -- Needs review
-- L["Running query..."] = ""
L["%s ago"] = "%s atrás"
-- L["Scanning %d / %d (Page %d / %d)"] = ""
L["Scanning page %s/%s"] = "Escaneando página %s/%s" -- Needs review
-- L["Scanning page %s/%s - Approximately %s remaining"] = ""
-- L["Scanning results..."] = ""
L["Scanning the auction house in game is no longer necessary!"] = "Escanear a Casa de Leilões não é mais necessário." -- Needs review
-- L["Scan Selected Groups"] = ""
-- L["Show AuctionDB AH Tab (Requires Reload)"] = ""
-- L["This button will scan just the items in the groups you have selected."] = ""
-- L["This will do a slow auction house scan of every item in the selected groups and update their AuctionDB prices. This may take several minutes."] = ""
 