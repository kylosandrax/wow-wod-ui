local L = LibStub("AceLocale-3.0"):NewLocale("BloodShieldTracker", "deDE", false)

if not L then return end

L["Absorbed/Total Shields/Percent:"] = "Absorbiert/Alle Schilde/Prozent" -- Needs review
L["AppliedSoundDesc"] = "Sound der abgespielt wird, wenn ein Blutschild gewirkt wird." -- Needs review
L["Bar Color"] = "Balkenfarbe" -- Needs review
L["Bar Depleted Color"] = "Leere Balkenfarbe" -- Needs review
L["BarTexture_OptionDesc"] = "Textur für den Statusbalken." -- Needs review
L["Blizzard"] = true -- Needs review
L["Blood Shield Bar"] = "Blutschildbalken" -- Needs review
L["BloodShieldBarColor_OptionDesc"] = "Änder die Farbe des Blutschildbalkens." -- Needs review
L["BloodShieldBar_Desc"] = "Der Blutschildbalken wird jederzeit angezeigt sofern ein Blutschild auf dem Todesritter aktiv ist. Der Balken berechnet den anfänglichen maximalen Wert des Schilds und zeigt dann die verbleibende Größe des Schilds an, abhängig von den absorbierten Angriffen. Wenn das Schild vom Todesritter entfernt wird, wird auch der Balken entfernt." -- Needs review
L["Blood Shield bar height"] = "Höhe des Bludschildbalkens" -- Needs review
L["BloodShieldBarTextColor_OptionDesc"] = "Veränder die Farbe des Texts des Blutschildbalkens." -- Needs review
L["Blood Shield bar width"] = "Breite des Bludschildbalkens" -- Needs review
L["Blood Shield Data"] = "Blutschilddaten" -- Needs review
L["BloodShieldDepletedBarColor_OptionDesc"] = "Versänder die Farbe des leeren Blutschildbalkens. Dies verändert die Farbe des Teils des Balkens der nicht gefüllt ist." -- Needs review
L["Blood Shield Max Value"] = "Maximale Blutschildgröße" -- Needs review
L["BloodShieldTracker_Desc"] = "Blood Shield Tracker ist ein Addon für Bluttodesrittertanks. Es zeigt Balken an, um das Blutschild und die Größe der erwarteten Todesstoßheilung zu sehen." -- Needs review
L["Change the height of the blood shield bar."] = "Verändert die Höhe des Blutschildbalkens." -- Needs review
L["Change the height of the estimated healing bar."] = "Verändert die Breite des Geschätzeheilungsbalkens." -- Needs review
L["Change the width of the blood shield bar."] = "Verändert die Breite des Bludschildbalkens." -- Needs review
L["Change the width of the estimated healing bar."] = "Verändert die Breite des Geschätzeheilungsbalkens." -- Needs review
L["Colors"] = "Farben" -- Needs review
L["Colors for Minimum Heal"] = "Farbe für die Minimalheilung" -- Needs review
L["Colors for Optimal Heal"] = "Farbei für die optimale Heilung" -- Needs review
L["Config Mode"] = "Konfigurationsmodus" -- Needs review
L["Could not determine talents."] = "Talente nicht bestimmbar." -- Needs review
L["Current and Maximum"] = "Momentan und Maximum" -- Needs review
L["Dimensions"] = "Dimensionen" -- Needs review
L["Enabled"] = "An" -- Needs review
L["Enable the Blood Shield Bar."] = "Aktiviert den Geschätzeheilungsbalkens" -- Needs review
L["Enable the Estimated Healing Bar."] = "Aktiviert den Geschätzteheilungsbalken" -- Needs review
L["EstHealBarMinBackgroundColor_OptionDesc"] = "Verändert die Hintergrundfarbe des Geschätzenheilungsbalken für Minimal Todesstoß Heilungen." -- Needs review
L["EstHealBarMinColor_OptionDesc"] = "Verändert die Farbe des Geschätzteheilungsbalken für minimal Todesstoßheilungen." -- Needs review
L["EstHealBarMinTextColor_OptionDesc"] = "Verändert die Textfarbe des Geschätzteheilungsbalken für minimal Todesstoßheilungen." -- Needs review
L["EstHealBarOptColor_OptionDesc"] = "Verändert die Farbe des Geschätzteheilungsbalken für optimale Todesstoßheilungen (grösser als das Minimum)." -- Needs review
L["EstHealBarOptTextColor_OptionDesc"] = "Verändert die Textfarbe des Geschätzteheilungsbalken für optimale Todesstoßheilungen (grösser als das Minimum)." -- Needs review
L["Estimated Healing Bar"] = "Geschätzteheilungsbalken" -- Needs review
L["EstimatedHealingBar_Desc"] = "Der Geschätzteheilungsbalken zeigt die geschätze Heilung des Todesstoßes an, wenn der Todesstoß in diesem Augenblick gewirkt wird. Wenn die Heilung das Minimun (10% der maximalen Gesundheit) sein wird, dann ist der Balken standardmässig rot. Wenn die Heilung grösser als das Minimum, eine optimale Heilung, sein wird, dann ist der Balken standardmässig grün. Die Farben zeigen wann am besten der Todesstoß gewirkt wird. Die beiden Farben kann man untern verändern." -- Needs review
L["Estimated Healing bar height"] = "Breite des Geschätzeheilungsbalkens" -- Needs review
L["Estimated Healing bar width"] = "Breite des Geschätzeheilungsbalkens" -- Needs review
L["Fight Duration:"] = "Kampflänge" -- Needs review
L["Font"] = "Textart" -- Needs review
L["Font size"] = "Textgrösse" -- Needs review
L["Font size for the bars."] = "Textgrösse für die Balken." -- Needs review
L["Font to use."] = "Benutzte Textart." -- Needs review
L["Full"] = "Voll" -- Needs review
L["General Options"] = "Allgemeine Optionen" -- Needs review
L["HealBarText"] = "gesch. Heilung" -- Needs review
L["Height"] = "Höhe" -- Needs review
L["HideOOC_OptionDesc"] = "Verstekt den Geschätzteheilungsbalken ausserhalb des Kampfes." -- Needs review
L["Hide out of combat"] = "Ausserhalb des Kampfes verstecken" -- Needs review
L["Last Fight Data"] = "Daten des letzten Kampfs" -- Needs review
L["Left"] = "Links" -- Needs review
L["Lock bar"] = "Balken sperren" -- Needs review
L["Lock damage bar"] = "Schadensbalken sperren." -- Needs review
L["Lock estimated healing bar"] = "Balken sperren" -- Needs review
L["Lock shield bar"] = "Blutschildbalken sperren" -- Needs review
L["Lock status bar"] = "Statusbalken sperren" -- Needs review
L["Lock the damage bar from moving."] = "Verhinder das Verschieben des Schadensbalkens." -- Needs review
L["Lock the estimated healing bar from moving."] = "Verhinder das Verschieben des Geschätzeheilungsbalkens." -- Needs review
L["Lock the shield bar from moving."] = "Verhinder das Verschieben des Blutschildbalkens." -- Needs review
L["Lock the status bar from moving."] = "Verhindert das Verschieben des Statusbalkens." -- Needs review
L["Minimap Button"] = true -- Needs review
L["Minimum Bar Background Color"] = "Minimalbalkenhintergrundfarbe" -- Needs review
L["Minimum Bar Color"] = "Minimal Balkenfarbe" -- Needs review
L["Minimum Text Color"] = "Minimal Textfarbe" -- Needs review
L["Min - Max / Avg:"] = "Min - Max / Schnitt" -- Needs review
L["Monochrome"] = "Einfarbig" -- Needs review
L["Number of Minimum Shields:"] = "Anzahl der Minimalschilde" -- Needs review
L["Only Current"] = "Nur Momentan" -- Needs review
L["Only for Blood DK"] = "Nur für Bluttodesritter" -- Needs review
L["Only Maximum"] = "Nur Maximum" -- Needs review
L["Only Percent"] = "Nur Prozente" -- Needs review
L["Optimal Bar Color"] = "Optimal Balkenfarbe" -- Needs review
L["Optimal Text Color"] = "Optimal Textfarbe" -- Needs review
L["Outline"] = "Umrandung" -- Needs review
L["Position"] = true -- Needs review
L["RemovedSoundDesc"] = "Der Sound der abgespielt werden soll, wenn das Blutschild entfernt wurde." -- Needs review
L["Right"] = "Rechts" -- Needs review
L["Scale"] = "Skalierung" -- Needs review
L["ScaleDesc"] = "Verändert die Skalierung des Balkens." -- Needs review
L["seconds"] = "Sekunden" -- Needs review
L["Shield Frequency:"] = "Schildfrequenz" -- Needs review
L["ShieldSoundEnabledDesc"] = "Aktiviert einen Sound für das Blutschild." -- Needs review
L["Shields Total/Refreshed/Removed:"] = "Schilde Total/Aufgefrischt/Aufgebraucht" -- Needs review
L["Shift + Left-Click to reset."] = "Umschalttaste + Linksklick zum resetten." -- Needs review
L["ShowBar"] = "Zeige Hintergrund" -- Needs review
L["ShowBarDesc"] = "Zeigt den Balken und Rahmen an, falls deaktiviert erscheint nur der Text." -- Needs review
L["ShowBorder"] = "Zeige Rahmen" -- Needs review
L["ShowBorderDesc"] = "Zeigt den Rahmen um den Balken" -- Needs review
L["Show Text"] = "Text anzeigen" -- Needs review
L["Show Time"] = "Zeige Zeit" -- Needs review
L["ShowTime_OptionDesc"] = "Zeigt die verbleibende Zeit auf dem Balken an." -- Needs review
L["Sound"] = true -- Needs review
L["StatusBarTexture"] = "Statusbalkentextur" -- Needs review
L["Text Color"] = "Textfarbe" -- Needs review
L["Texture"] = "Textur" -- Needs review
L["Thick Outline"] = "Dicke Umrandung" -- Needs review
L["TimePosition_OptionDesc"] = "Position der verbleibenden Zeit auf dem Balken." -- Needs review
L["Time Remaining"] = "Verbleibende Zeit" -- Needs review
L["Total Data"] = "Alle Daten" -- Needs review
L["Width"] = "Breite" -- Needs review

