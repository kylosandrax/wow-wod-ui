if not(GetLocale() == "deDE") then
    return;
end

local L = WeakAuras.L

-- Options translation
L["<"] = "< (Kleiner)"
L["<="] = "<= (Kleinergleich)"
L["="] = "= (Gleich)"
L[">"] = "> (Größer)"
L[">="] = ">= (Größergleich)"
L["!="] = "!= (Ungleich)"
L["10 Man Raid"] = "10er-Schlachtzug"
L["25 Man Raid"] = "25er-Schlachtzug"
L["5 Man Dungeon"] = "5er Gruppe"
L["Absorb"] = "Absorbieren"
L["Absorbed"] = "Absorbiert"
L["Action Usable"] = "Aktion nutzbar"
L["Affected"] = "Betroffen"
L["Air"] = "Luft"
L["Alive"] = "Am Leben"
L["All Triggers"] = "Alle Auslöser (UND)"
L["Alternate Power"] = "Alternative Energie"
L["Ambience"] = "Umgebung"
L["Amount"] = "Anzahl"
L["Any Triggers"] = "Ein Auslöser (ODER)"
L["Arena"] = "Arena"
L["Ascending"] = "Aufsteigend"
L["At Least One Enemy"] = "Zumindest ein Feind"
L["Attackable"] = "Angreifbar"
L["Aura"] = "Aura (Buff/Debuff)"
L["Aura:"] = "Aura:"
L["Aura Applied"] = "Aura angewant (AURA_APPLIED)"
L["Aura Applied Dose"] = "Aura angewant, Stack erhöht (AURA_APPLIED_DOSE)"
L["Aura Broken"] = "Aura gebrochen, Nahkampf (AURA_BROKEN)"
L["Aura Broken Spell"] = "Aura gebrochen, Zauber (AURA_BROKEN_SPELL)"
L["Aura Name"] = "Auraname"
L["Aura Refresh"] = "Aura erneuert (AURA_REFRESH)"
L["Aura Removed"] = "Aura entfernt (AURA_REMOVED)"
L["Aura Removed Dose"] = "Aura entfernt, Stack verringert (AURA_REMOVED_DOSE)"
L["Auras:"] = "Auren:"
L["Aura Stack"] = "Aurastacks"
L["Aura Type"] = "Auratyp"
L["Automatic"] = "Automatisch"
L["Back and Forth"] = "Vor und zurück"
L["Battleground"] = "Schlachtfeld"
L["Battle.net Whisper"] = "Battle.net-Flüster"
L["BG>Raid>Party>Say"] = "Schlachtfeld>Schhlachtzug>Gruppe>Sagen"
L["BG-System Alliance"] = "BG-System Allianz"
L["BG-System Horde"] = "BG-System Horde"
L["BG-System Neutral"] = "BG-System Neutral"
L["Blizzard Combat Text"] = "Kampflog"
L["Block"] = "Blocken"
L["Blocked"] = "Geblockt"
L["Blood Rune #1"] = "Blutrune #1"
L["Blood Rune #2"] = "Blutrune #2"
L["Blood runes"] = "Blutrunen" -- Needs review
L["Boss Emote"] = "Bossemote"
L["Bottom"] = "Unten"
L["Bottom Left"] = "Unten Links"
L["Bottom Right"] = "Unten Rechts"
L["Bottom to Top"] = "Von unten nach oben"
L["Bounce"] = "Hüpfen"
L["Bounce with Decay"] = "Abklingendes Hüpfen"
L["Buff"] = "Buff"
L["Burning Embers"] = "Instabile Funken"
L["By |cFF69CCF0Mirrored|r of Dragonmaw(US) Horde"] = "Von |cFF69CCF0Mirrored|r auf Dragonmaw(US) Horde"
L["Cast"] = "Zaubern"
L["Cast Failed"] = "Zauber fehlgeschlagen (CAST_FAILED)"
L["Cast Start"] = "Zauber gestartet (CAST_START)"
L["Cast Success"] = "Zauber gelungen (CAST_SUCCESS)"
L["Cast Type"] = "Zaubertyp"
L["Center"] = "Mitte"
L["Centered Horizontal"] = "Horizontal-Zentriert"
L["Centered Vertical"] = "Vertikal zentriert"
L["Channel"] = "Chatkanal"
L["Channel (Spell)"] = "Kanalisieren (Zauber)"
L["Character Type"] = "Charaktertyp"
L["Chat Frame"] = "Chatframe"
L["Chat Message"] = "Chatnachricht"
L["Children:"] = "Kinder:"
L["Chi Power"] = "Chi"
L["Circle"] = "Kreis"
L["Circular"] = "Kreisförmig"
L["Class"] = "Klasse"
L["Click to close configuration"] = "|cFF8080FF(Klick)|r Config-GUI schließen"
L["Click to open configuration"] = "|cFF8080FF(Klick)|r Config-GUI öffnen"
L["Combat Log"] = "Kampflog"
L["Combo Points"] = "Kombopunkte"
L["Conditions"] = "Bedingungen"
L["Contains"] = "Enthält"
L["Cooldown Progress (Item)"] = "Abklingzeit (Gegenstand)"
L["Cooldown Progress (Spell)"] = "Abklingzeit (Zauber)"
L["Cooldown Ready (Item)"] = "Abklingzeit vorbei (Gegenstand)"
L["Cooldown Ready (Spell)"] = "Abklingzeit vorbei (Zauber)"
L["Create"] = "Erstellen"
L["Critical"] = "Kritisch"
L["Crowd Controlled"] = "Kontrollverlust"
L["Crushing"] = "Zerschmettern"
L["Curse"] = "Fluch"
L["Custom"] = "Benutzerdefiniert"
L["Custom Function"] = "Benutzerdefinierte Funktion"
L["Damage"] = "Schaden (DAMAGE)"
L["Damager"] = "Schadensausteiler"
L["Damage Shield"] = "Schadensschild (DAMAGE_SHIELD)"
L["Damage Shield Missed"] = "Schadensschild verfehlt (DAMAGE_SHIELD_MISSED)"
L["Damage Split"] = "Schadensteilung (DAMAGE_SPLIT)"
L["Death Knight"] = "Todesritter"
L["Death Knight Rune"] = "Todesritter Runen"
L["Death Rune"] = "Todes Rune"
L["Debuff"] = "Debuff"
L["Deflect"] = "Umlenken"
L["Demonic Fury"] = "Dämonischer Furor"
L["Descending"] = "Absteigend"
L["Destination Name"] = "Zielname"
L["Destination Unit"] = "Zieleinheit"
L["Disease"] = "Krankheit"
L["Dispel"] = "Bannen (DISPEL)"
L["Dispel Failed"] = "Bannen fehlgeschlagen (DISPEL_FAILED)"
L["Dodge"] = "Ausweichen (DODGE)"
L["Done"] = "Fertiggestellt"
L["Down"] = "Runter"
L["Drain"] = "Saugen (DRAIN)"
L["Drowning"] = "Ertinken (DROWNING)"
L["Druid"] = "Druide"
L["Dungeon Difficulty"] = "Instanzschwierigkeit"
L["Durability Damage"] = "Haltbarkeitsschaden (DURABILITY_DAMAGE)"
L["Durability Damage All"] = "Haltbarkeitsschaden, Alle (DURABILITY_DAMAGE_ALL)"
L["Earth"] = "Erde"
L["Eclipse Direction"] = "Finsternisausrichtung"
L["Eclipse Power"] = "Finsternisenergie"
L["Eclipse Type"] = "Finsternistyp"
L["Emote"] = "Emote"
L["Energize"] = "Aufladen (ENERGIZE)"
L["Energy"] = "Energie"
L["Enrage"] = "Wut"
L["Environmental"] = "Umgebung (ENVIRONMENTAL)"
L["Environment Type"] = "Umgebungstyp"
L["Evade"] = "Entkommen (EVADE)"
L["Event"] = "Ereignis"
L["Event(s)"] = "Ereignisse"
L["Every Frame"] = "Bei jedem OnUpdate"
L["Extra Amount"] = "Extra Betrag"
L["Extra Attacks"] = "Extra Angriffe (EXTRA_ATTACKS)"
L["Extra Spell Name"] = "Extra Zaubername"
L["Fade In"] = "Aufblenden"
L["Fade Out"] = "Abblenden"
L["Falling"] = "Fallen (FALLING)"
L["Fatigue"] = "Erschöpfung (FATIGUE)"
L["Fire"] = "Feuer"
L["First Tree"] = "Erster Talentbaum"
L["Flash"] = "Aufblitzen"
L["Flip"] = "Umdrehen"
L["Focus"] = "Fokus"
L["Form"] = "Form"
L["Friendly"] = "Freundlich"
L["From"] = "Von"
L["Frost Rune #1"] = "Frost Rune #1"
L["Frost Rune #2"] = "Frost Rune #2"
L["Frost Runes"] = "Frostrunen" -- Needs review
L["Glancing"] = "Gestreift (GLANCING)"
L["Global Cooldown"] = "Globale Abklingzeit"
L["Glow"] = "Leuchten"
L["Gradient"] = "Gradient"
L["Gradient Pulse"] = "Gradient Pulse"
L["Group"] = "Gruppe"
L["Group %s"] = "Gruppe %s"
L["Grow"] = "Wachsen"
L["Guild"] = "Gilde"
L["Happiness"] = "Zufriedenheit"
L["HasPet"] = "Begleiter aktiv"
L["Heal"] = "Heilen"
L["Healer"] = "Heiler"
L["Health"] = "Lebenspunkte"
L["Health (%)"] = "Lebenspunkte (%)"
L["Heroic"] = "Heroisch"
L["Hide"] = "Verbergen"
L["Higher Than Tank"] = "Höher als der Tank"
L["Holy Power"] = "Heilige Kraft"
L["Hostile"] = "Feindlich"
L["Hostility"] = "Ausrichtung"
L["Humanoid"] = "Humanoid"
L["Hunter"] = "Jäger"
L["Icon"] = "Symbol"
L["Ignore Rune CD"] = "Runen CD ignorieren"
L["Immune"] = "Immun (IMMUNE)"
L["Include Bank"] = "Bank einbeziehen"
L["Include Charges"] = "Aufladungen einbeziehen"
L["Include Death Runes"] = "Todesrunen miteinbeziehen" -- Needs review
L["In Combat"] = "Im Kampf"
L["Inherited"] = "Vererbt"
L["In Pet Battle"] = "Im Haustierkampf"
L["Inside"] = "Innerhalb"
L["Instakill"] = "Sofortiger Tod (INSTAKILL)"
L["Instance Type"] = "Instanztyp"
L["Interrupt"] = "Unterbrechen (INTERRUPT)"
L["Interruptible"] = "Unterbrechbar"
L["In Vehicle"] = "In Fahrzeug"
L["Inverse"] = "Invertieren"
L["Is Exactly"] = "Strikter Vergleich"
L["Item"] = "Gegenstand"
L["Item Count"] = "Gegenstandsanzahl"
L["Item Equipped"] = "Gegenstand angelegt"
L["Lava"] = "Lava"
L["Leech"] = "Saugen (LEECH)"
L["Left"] = "Links"
L["Left to Right"] = "Links -> Rechts"
L["Level"] = "Level"
L["Lower Than Tank"] = "Niedriger als der Tank"
L["Lunar"] = "Lunar"
L["Lunar Power"] = "Lunarenergie"
L["Mage"] = "Magier"
L["Magic"] = "Magie"
L["Main Hand"] = "Haupthand"
L["Mana"] = "Mana"
L["Master"] = "Master"
L["Matches (Pattern)"] = "Abgleichen (Muster)"
L["Message"] = "Nachricht"
L["Message type:"] = "Nachrichtentyp:"
L["Message Type"] = "Nachrichtentyp"
L["Miss"] = "Verfehlen"
L["Missed"] = "Verfehlt (MISSED)"
L["Missing"] = "Fehlend"
L["Miss Type"] = "Verfehlengrund"
L["Monochrome Outline"] = "Schwarz-Weiß" -- Needs review
L["Monster Yell"] = "NPC-Schrei"
L["Mounted"] = "Reiten"
L["Multi-target"] = "Mehrfachziel"
L["Music"] = "Musik"
L["Name"] = "Name"
L["Never"] = "Nie"
L["Next"] = "Weiter"
L["No Children:"] = "Keine Kinder:"
L["No Instance"] = "Keine Instanz"
L["None"] = "Keine(r)"
L["Non-player Character"] = "Nicht-Spieler Charakter (NPC)"
L["Normal"] = "Normal"
L["Not On Threat Table"] = "Nicht auf der Bedrohungsliste"
L["Number"] = "Nummer"
L["Number Affected"] = "Betroffene Anzahl"
L["Off Hand"] = "Nebenhand"
L["Officer"] = "Offizier"
L["Opaque"] = "Deckend"
L["Orbit"] = "Orbit"
L["Outline"] = "Kontur" -- Needs review
L["Outside"] = "Außerhalb"
L["Overhealing"] = "Überheilung"
L["Overkill"] = "Overkill"
L["Paladin"] = "Paladin"
L["Parry"] = "Parieren"
L["Party"] = "Gruppe"
L["Party Kill"] = "Gruppen Tod (PARTY_KILL)"
L["Paused"] = "Pausiert"
L["Periodic Spell"] = "Periodischer Zauber (PERIODIC_SPELL)"
L["Pet"] = "Begleiter"
L["Pet Behavior"] = "Begleiter-Verhalten"
L["Player"] = "Spieler (Selbst)"
L["Player Character"] = "Spieler Charakter (PC)"
L["Player Class"] = "Spielerklasse"
L["Player Dungeon Role"] = "Spieler Gruppenrole"
L["Player Level"] = "Spielerlevel"
L["Player Name"] = "Spielername"
L["Player(s) Affected"] = "Beeinträchtigte Spieler"
L["Player(s) Not Affected"] = "Nicht betroffene Spieler"
L["Poison"] = "Gift"
L["Power"] = "Energie"
L["Power (%)"] = "Energie (%)"
L["Power Type"] = "Energietyp"
L["Preset"] = "Standard"
L["Priest"] = "Priester"
L["Progress"] = "Fortschritt"
L["Pulse"] = "Pulsieren"
L["PvP Flagged"] = "PvP aktiv"
L["Radius"] = "Raduis"
L["Rage"] = "Wut"
L["Raid"] = "Raid"
L["Raid Warning"] = "Raidwarnung"
L["Range"] = "Reichweite"
L["Ranged"] = "Distanz"
L["Receiving display information"] = "Erhalte Anzeigeinformationen von %s"
L["Reference Spell"] = "Referenzzauber"
L["Reflect"] = "Reflektieren (REFLECT)"
L["Relative"] = "Relativ"
L["Remaining Time"] = "Verbleibende Zeit"
L["Requested display does not exist"] = "Angeforderte Anzeige existiert nicht"
L["Requested display not authorized"] = "Angeforderte Anzeige ist nicht autorisiert"
L["Require Valid Target"] = "Erfordert gültiges Ziel"
L["Resist"] = "Wiederstehen"
L["Resisted"] = "Wiederstanden (RESISTED)"
L["Resolve collisions dialog"] = [=[
Ein externes Addon definiert |cFF8800FFWeakAuras|r Anzeigen die den selben Namen besitzten wie bereits existierende Anzeigen.

|cFF8800FFWeakAuras|r Anzeigen müssen umbenannt werden um Platz für die externen Anzeigen zu machen.

Gelöst: |cFFFF0000]=]
L["Resolve collisions dialog singular"] = [=[
Ein externes Addon definiert eine |cFF8800FFWeakAuras|r Anzeige die den selben Namen besitzten wie eine bereits existierende Anzeige.

|cFF8800FFWeakAuras|r Anzeige muss umbenannt werden um Platz für die externe Anzeige zu machen.

Gelöst: |cFFFF0000]=]
L["Resolve collisions dialog startup"] = [=[
Ein externes Addon definiert |cFF8800FFWeakAuras|r Anzeigen die den selben Namen besitzten wie bereits existierende Anzeigen.

|cFF8800FFWeakAuras|r Anzeigen müssen umbenannt werden um Platz für die externen Anzeigen zu machen.

Gelöst: |cFFFF0000]=]
L["Resolve collisions dialog startup singular"] = [=[
Ein externes Addon definiert eine |cFF8800FFWeakAuras|r Anzeige die den selben Namen besitzten wie eine bereits existierende Anzeige.

|cFF8800FFWeakAuras|r Anzeige muss umbenannt werden um Platz für die externe Anzeige zu machen.

Gelöst: |cFFFF0000]=]
L["Resting"] = "Erholen"
L["Resurrect"] = "Wiederbeleben"
L["Right"] = "Rechts"
L["Right to Left"] = "Rechts -> Links"
L["Rogue"] = "Schurke"
L["Rotate Left"] = "Nach links rotieren"
L["Rotate Right"] = "Nach rechts rotieren"
L["Rune"] = "Rune"
L["Runic Power"] = "Runenmacht"
L["Say"] = "Sagen"
L["Seconds"] = "Sekunden"
L["Second Tree"] = "Zweiter Talentbaum"
L["Shadow Orbs"] = "Schattenkugeln"
L["Shake"] = "Beben"
L["Shaman"] = "Schamane"
L["Shards"] = "Splitter"
L["Shift-Click to pause"] = "|cFF8080FF(Shift-Klick)|r Pause"
L["Shift-Click to resume"] = "|cFF8080FF(Shift-Klick)|r Fortsetzten"
L["Show"] = "Zeigen"
L["Shrink"] = "Schrumpfen"
L["Slide from Bottom"] = "Von unten eingleiten"
L["Slide from Left"] = "Von links eingleiten"
L["Slide from Right"] = "Von rechts eingleiten"
L["Slide from Top"] = "Von oben eingleiten"
L["Slide to Bottom"] = "Nach unten entgleiten"
L["Slide to Left"] = "Nach links entgleiten"
L["Slide to Right"] = "Nach rechts entgleiten"
L["Slide to Top"] = "Nach oben entgleiten"
L["Slime"] = "Schleim"
L["Solar"] = "Solar"
L["Solar Power"] = "Solarenergie"
L["Sound Effects"] = "Soundeffekte"
L["Source Name"] = "Quellname"
L["Source Unit"] = "Quelleinheit"
L["Spacing"] = "Abstand"
L["Specific Unit"] = "Konkrete Einheit"
L["Spell"] = "Zauber"
L["Spell (Building)"] = "Zauber, Gebäude (SPELL_BUILDING)"
L["Spell Name"] = "Zaubername"
L["Spin"] = "Drehen"
L["Spiral"] = "Winden"
L["Spiral In And Out"] = "Ein- und Auswinden"
L["Stacks"] = "Stacks"
L["Stance/Form/Aura"] = "Haltung/Form/Aura"
L["Status"] = "Status"
L["Stolen"] = "Gestohlen (STOLEN)"
L["Summon"] = "Herbeirufen (SUMMON)"
L["Swing"] = "Schwingen (SWING)"
L["Swing Timer"] = "Schlagtimer"
L["Talent selected"] = "Gewähltes Talent"
L["Talent Specialization"] = "Talentspezialisierung"
L["Tank"] = "Tank"
L["Tanking And Highest"] = "Höchster und Aggro"
L["Tanking But Not Highest"] = "Aggro aber nicht höchster"
L["Target"] = "Ziel"
L["Thick Outline"] = "Dicke Kontur" -- Needs review
L["Third Tree"] = "Dritter Talentbaum"
L["Threat Situation"] = "Bedrohungssituation"
L["Thrown"] = "Wurfwaffe"
L["Timed"] = "Zeitgesteuert"
L["Top"] = "Oben"
L["Top Left"] = "Oben Links"
L["Top Right"] = "Oben Rechts"
L["Top to Bottom"] = "Oben -> Unten"
L["Total"] = "Gesamt"
L["Totem"] = "Totem"
L["Totem Name"] = "Totemname"
L["Totem Type"] = "Totemtyp"
L["Transmission error"] = "Übertragungsfehler"
L["Trigger:"] = "Auslöser:"
L["Trigger Update"] = "Auslöser Aktualisierung"
L["Undefined"] = "Undefiniert"
L["Unholy Rune #1"] = "Unheilig Rune #1"
L["Unholy Rune #2"] = "Unheilig Rune #2"
L["Unholy Runes"] = "Unheilige Runen" -- Needs review
L["Unit"] = "Einheit"
L["Unit Characteristics"] = "Einheitencharakterisierung"
L["Unit Destroyed"] = "Einheit zerstört"
L["Unit Died"] = "Einheit gestorben"
L["Up"] = "Hoch"
L["Version error recevied higher"] = "Diese Anzeige ist inkompatibel zu dieser Version von Weakauras. Benötigte Version lautet %s, du besitzt Version %s. Bitte aktualisiere WeakAuras."
L["Version error recevied lower"] = "Diese Anzeige ist inkompatibel zu dieser Version von Weakauras. Benötigte Version lautet %s, du besitzt Version %s. Bitte lass die andere Person WeakAuras aktualisieren."
L["Warlock"] = "Hexenmeister"
L["Warrior"] = "Krieger"
L["Water"] = "Wasser"
L["WeakAuras"] = "WeakAuras"
L["WeakAurasModelPaths"] = "WeakAuras - 3D Modell Pfade"
L["WeakAurasModelPaths .toc Notes"] = "Stellt eine Liste der meisten 3D Modelle für WA Displays zur Verfügung."
L["WeakAurasOptions"] = "WeakAuras Optionen"
L["WeakAurasOptions .toc Notes"] = "Optionen für WeakAuras"
L["WeakAuras .toc Notes"] = "Eine leistungsfähiges, umfassendes Addon zur grafischen Darstellung von Informationen über Auren, Cooldowns, Timern und vielem mehr."
L["WeakAurasTutorials"] = "WeakAuras - Tutorials"
L["WeakAurasTutorials .toc Notes"] = "3D-Model Pfade für WeakAuras"
L["Weapon"] = "Waffen"
L["Weapon Enchant"] = "Waffenverzauberung"
L["Whisper"] = "Flüstern"
L["Wobble"] = "Wackeln"
L["Yell"] = "Schreien"
L["Zone"] = "Zone"



