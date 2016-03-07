local lang = GetLocale()

-- Custom Search
HOPADDON_ENTERKEYWORDS = "Enter keywords separated by space\n(any match in all language filters)\nEx: fist horropuño veng invasion"
HOPADDON_SEARCHING = "Searching"
HOPADDON_SEARCHPAUSED = "Search paused"
HOPADDON_AUTOINVITE = "Auto invite"
HOPADDON_STOPSEARCH = "Stop search"
HOPADDON_CLEARSEARCH = "Clear search field"

-- Hop Search
HOPADDON_HOPHELP = "Time interval in which your character won't be tranferred to already visited realm again."
HOPADDON_NEXTREALM = "Next"
HOPADDON_HOPPING = "Hopping..."
HOPADDON_LASTBUTTON = "Last"

-- Applications list
HOPADDON_CANCELAPP = "Cancel"
HOPADDON_DECLINEAPP = "Decline"
HOPADDON_APPLY = "Apply"
HOPADDON_BLACKLIST = "Add to blacklist"
HOPADDON_LMB = "LMB"
HOPADDON_RMB = "RMB"

-- Favourites
HOPADDON_FAVOURITES = "Favourites"
HOPADDON_KEYWORDS = "Keywords"
HOPADDON_FAVDESC = "Pressing on a favourite query initiates search for it's keywords"

-- ServerHop
HOPADDON_CHANGEMODE = "Change mode"
HOPADDON_TOGGLE = "Show/hide addon window."

-- Settings
HOPADDON_ROLETOOLTIP = "Use this role when manually queuing for groups."
HOPADDON_SOUNDTOOLTIP = "Enable sound when group is found."
HOPADDON_ENDLESSCHECK = "Stop search while in party"
HOPADDON_ENDLESSTOOLTIP = "Don't allow addon to search while you stay in party."

-- v1.1
HOPADDON_NOTIFY = "Notifications:"
HOPADDON_SEARCHOPTIONS = "Search options:"
HOPADDON_UPDATESTRING = "You can download the latest version of this addon, leave a suggestion or simply comment at:"
HOPADDON_AUTHOR = "Author: "
HOPADDON_SEARCHMODE = "Search mode"
HOPADDON_HOPMODE = "Hop mode"
HOPADDON_AUTOINVITE_OPTIONS = "Non auto-accept groups"
HOPADDON_AUTOINVITE_TOOLTIP = "Allow addon to send applications to groups without auto-accept option set enabled. Leader of such groups has to invite you manually. You can set wait time duration for the invite in the slider below."
HOPADDON_INBLACKLIST = "Visited: "

-- v1.2
HOPADDON_INRAID = "You're in raid"
HOPADDON_INGROUP = "You're in group"
HOPADDON_NOTLFGGROUP = "Normal group"

-- v1.3
HOPADDON_ANYSIZE = "Any size"
HOPADDON_LASTREALM = "Last realm:"

-- v1.4
HOPADDON_MINIMAPOPTIONS = "Minimap icon"
HOPADDON_MINIMAPOPTIONS_DESCR = "Toggles minimap icon for this addon."

-- v1.6
HOPADDON_OLDCONTENT = "Old Content"
HOPADDON_QUICKFAVOURITES = "Quick access"

-- v1.8
HOPADDON_SEARCHINGWARNING = "Server Hop is searching right now!\nDo you want to finish search?"

-- v1.9
HOPADDON_BLDURATION = "Ignore visited realms"
HOPADDON_NONSAVESETTING = "Resets on logout!"
HOPADDON_SHOWSTATUSOPTION = "Group information panel"
HOPADDON_SHOWSTATUSTOOLTIP = "Show information about current group in the right side of the addon."

HOPADDON_HOPHELP_1 = "This string shows realm you’re currently on!\n\nServer Hop uses all language filters automatically, that means you’re going to see a lot of unknown words in this frame.\n\nRealm variety speeds up completion of your objective, but please try not to anger locals."
HOPADDON_HOPHELP_2 = "Party size filter allows you to adjust hopping for your objective.\n\nIf you’re doing quests, then select group filter, because quests can’t be completed in raids.\n\nHopping in raids doesn’t irritate people as much as hopping in groups. Use raid filter if you care."
HOPADDON_HOPHELP_3 = "Allows you to return to previous visited realm, this action ignores blacklisted realms.\n\nParty size filter continues to apply to searched groups. To speed backward hopping reset your party size filter.\n\nWhen pressing this button you’ll leave your current group, but current realm won’t be blacklisted!"
HOPADDON_HOPHELP_4 = "Pressing this button makes you leave current group and start searching for new, not yet visited by your character, realm.\n\nVisited realms automatically become blacklisted for a fixed duration (15 minutes by default). You can change this time in options."

HOPADDON_SEARCHHELP_1 = "Additional filter becomes visible only for dungeon and raids categories. Selecting a filter in this string immediately starts a search.\n\nYou can use keywords in addition to instance filter.\n\nExample: initiate a search for world bosses in instance filter and use this search string\n\"-kaz -lord\" to filter out Lords Kazzak killers."
HOPADDON_SEARCHHELP_2 = "You can only search in one category at a time.\n\nChanging your current category will automatically finish searches."
HOPADDON_SEARCHHELP_3 = "To initiate a search, press Enter while in the search field. To end it, click on cross button, appearing in the end of search field.\n\nWrite your keywords separated by a space. If you want to exclude a word, then add minus in front of it,\ni.e. \"-sabertooth\". All of the keywords are being searched at the same time.\n\nMost group leaders tend to cut their words when creating groups. Try to separate long words into a few keywords to find or exclude even more groups."
HOPADDON_SEARCHHELP_4 = "This field shows search results. Groups with names colored in green accept players automatically.\n\nApply to a group by left clicking. Roles can be selected in addons settings. If a found group doesn’t meet your need, hide it by right clicking.\n\nOnce all groups were hidden, addon initiates new continuous search for groups that match all filters. Hidden groups won’t be shown to you again until you initiate a new search by pressing Enter in the search field or changing a filter.\n\nWhile addon is searching, it can be closed. Once a new group is found, addon will make a noise and reappear again."

-- v1.10
HOPADDON_TASKBAROPTION = "Flash taskbar"
HOPADDON_TASKBARTOOLTIP = "Allow addon to flash your WoW icon on the taskbar when group is found."

HOPADDON_ADDITIONALFILTERS = "Additional filters"

HOPADDON_TIMEOPTION = "Group Age"
HOPADDON_TIMETOOLTIP = "Maximum amount of time (in seconds) passed since group creation. Older groups won't be showing up."
HOPADDON_ITEMLEVEL = "Item Level"
HOPADDON_ITEMLEVELTOOLTIP = "Minimum item level, required to join a group. Groups without item level setting won't be showing up."
HOPADDON_AUTOACCEPT = "Always accept invites"
HOPADDON_AUTOACCEPTTOOLTIP = "Allow addon to automatically accept all invites from premade groups system. Addon accepts invitations regardless of assigned role."
HOPADDON_SEARCHAUTOINVITETOOLTIP = "Show groups that only accept players automatically."

-- v1.11
HOPADDON_PVPTOOLTIP = "By disabling this option, you'll stop hopping to PVP realms."

-- v1.14
HOPADDON_CREDITS = "Credits"
HOPADDON_AUTHORCONT = "Author's contacts:"
HOPADDON_TESTERS = "Testers:"
HOPADDON_COMMUNITYTHANKS = "Big thanks to gaming community for spreading the addon!"

--v1.15
HOPADDON_NOTIFCHECK = "Notifications in chat"
HOPADDON_NOTIFTOOLTIP = "Allow addon to send messages in chat when you switch realms."

--v1.17
HOPADDON_NEXTMACRO = 'Macro for "Next" button'
HOPADDON_LASTMACRO = 'Macro for "Last" button'
HOPADDON_QUEUEWAITTIME = "Wait for invite"
HOPADDON_SEARCH_AUTOINVITE = "Auto-invite only"

if lang == "ruRU" then
	-- Custom Search
	HOPADDON_ENTERKEYWORDS = "Введите слова через пробел\n(поиск по любому, на всех языках)\nПример: fist отм talon пушка"
	HOPADDON_SEARCHING = "Идет поиск"
	HOPADDON_SEARCHPAUSED = "Поиск приостановлен"
	HOPADDON_AUTOINVITE = "Автоматическое приглашение"
	HOPADDON_STOPSEARCH = "Остановить поиск"
	HOPADDON_CLEARSEARCH = "Очистить поисковую строку"

	-- Hop Search
	HOPADDON_HOPHELP = "Интервал, в течение которого персонаж не попадет на уже посещенный сервер еще раз."
	HOPADDON_NEXTREALM = "Следующий"
	HOPADDON_HOPPING = "Прыжок..."
	HOPADDON_LASTBUTTON = "Прошлый"
	
	-- Applications list
	HOPADDON_CANCELAPP = "Отменить"
	HOPADDON_DECLINEAPP = "Отклонить"
	HOPADDON_APPLY = "Подписаться"
	HOPADDON_BLACKLIST = "Черный список"
	HOPADDON_LMB = "ЛКМ"
	HOPADDON_RMB = "ПКМ"

	-- Favourites
	HOPADDON_FAVOURITES = "Избранные запросы"
	HOPADDON_KEYWORDS = "Ключевые слова"
	HOPADDON_FAVDESC = "Нажатие на избранный запрос начнет поиск по указанным в нём ключевым словам "
	
	-- ServerHop
	HOPADDON_CHANGEMODE = "Сменить режим"
	HOPADDON_TOGGLE = "Показать/скрыть окно аддона."
	
	-- Settings
	HOPADDON_ROLETOOLTIP = "Выбирать эту роль, запрашивая приглашение в группу."
	HOPADDON_SOUNDTOOLTIP = "Воспроизводить звук при успешном поиске."
	HOPADDON_ENDLESSCHECK = "Прекращать поиск в группе"
	HOPADDON_ENDLESSTOOLTIP = "Не позволять аддону производить поиск пока вы находитесь в группе."
	
	-- v1.1
	HOPADDON_NOTIFY = "Уведомления:"
	HOPADDON_SEARCHOPTIONS = "Настройки поиска:"
	HOPADDON_UPDATESTRING = "Загрузить последнюю версию аддона, оставить пожелание или комментарий можно на сайте:"
	HOPADDON_AUTHOR = "Автор: "
	HOPADDON_SEARCHMODE = "Режим поиска"
	HOPADDON_HOPMODE = "Режим прыжка"
	HOPADDON_AUTOINVITE_OPTIONS = "Группы без автоприглашения"
	HOPADDON_AUTOINVITE_TOOLTIP = "Подавать заявки в группы, в настройках которых не отмечена настройка автоматического приглашения игроков. Лидер таких групп обязать принять вас самостоятельно. Настроить время ожидания приглашения вы можете в ползунке ниже."
	HOPADDON_INBLACKLIST = "Посещено: "
	-- v1.2
	HOPADDON_INRAID = "Вы в рейде"
	HOPADDON_INGROUP = "Вы в группе"
	HOPADDON_NOTLFGGROUP = "Обычная группа"
	
	-- v1.3
	HOPADDON_ANYSIZE = "Все размеры"
	HOPADDON_LASTREALM = "Прошлый мир:"
	
	-- v1.4
	HOPADDON_MINIMAPOPTIONS = "Иконка у миникарты"
	HOPADDON_MINIMAPOPTIONS_DESCR = "Включить/выключить отображение иконки аддона у миникарты."
	
	-- v1.6
	HOPADDON_OLDCONTENT = "Устаревшее"
	HOPADDON_QUICKFAVOURITES = "Быстрый доступ"
	
	-- v1.8
	HOPADDON_SEARCHINGWARNING = "Server Hop совершает поиск!\nОстановить?"
	
	-- v1.9
	HOPADDON_BLDURATION = "Игнорировать посещенные сервера"
	HOPADDON_NONSAVESETTING = "Сбрасывается при перезаходе!"
	HOPADDON_SHOWSTATUSOPTION = "Панель информации о группе"
	HOPADDON_SHOWSTATUSTOOLTIP = "Отображать информацию о текущей группе в правой части аддона."
	
	HOPADDON_HOPHELP_1 = "В этой строке показывается текущий игровой мир!\n\nServer Hop автоматически использует все языковые фильтры, так что в своих путешествиях вы увидите множество невиданных ранее слов в этом окне.\n\nРазнообразие игровых миров ускоряет выполнение вашей цели, но старайтесь не злить местное население."
	HOPADDON_HOPHELP_2 = "Фильтр размера группы позволяет настроить прыжки по серверам под ваше занятие.\n\nЕсли вы занимаетесь выполнением заданий, выбирайте фильтр групп, т.к. задания не выполняются в рейдах.\n\nПрыжки по серверам не так сильно влияют на рейды, как на обычные группы, старайтесь использовать их, чтобы не нервировать других людей."
	HOPADDON_HOPHELP_3 = "Позволяет вернуться на предыдущий посещенный сервер, черный список при этом игнорируется.\n\nФильтр размера группы продолжает действовать. Для ускорения прыжка назад можно переключить фильтрф.\n\nПри нажатии на кнопку вы покинете группу, а текущий игровой мир не будет занесен в черный список!"
	HOPADDON_HOPHELP_4 = "Нажатие приведет к выходу из группы и поиску нового игрового мира, где ваш персонаж еще не бывал.\n\nПосещенные игровые миры заносятся в черный список на определенное время (обычно 15 минут). Этот интервал можно изменить в настройках."
	
	HOPADDON_SEARCHHELP_1 = "Строка дополнительного фильтра появляется только для категорий подземелий и рейдов. Выбор параметра в этом фильтре сразу же начинает поиск.\n\nЭтот фильтр применяется в первую очередь и может работать как с ключевыми словами, так и без.\n\nПример: начните поиск мировых боссов и введите в поисковую строку \"-kaz -lord -каз -влад\" для исключения убийц Владыки Каззака."
	HOPADDON_SEARCHHELP_2 = "Поиск можно производить только в одной категории одновременно.\n\Смена категории автоматически завершает поиск."
	HOPADDON_SEARCHHELP_3 = "Для начала поиска нажмите кнопку Enter в поисковой строке. Для завершения - появившийся крестик в конце строки.\n\nВводите ключевые слова через пробел. Для исключения слова, добавьте минус в его начале, например \"-саблерон\". Поиск проводится по всем ключевым словам одновременно.\n\nБольшинство людей сокращают слова, создавая группы. Старайтесь разбивать слова на составляющие, чтобы находить, или, наоборот, исключать больше групп."
	HOPADDON_SEARCHHELP_4 = "В этой области отображаются результаты поиска. Группы с зелеными именами принимают автоматически.\n\nДля подачи заявки в группу, нажмите на нее левой кнопкой мыши. Роли можно задать в настройках аддона. Если группа вам не нравится, скройте ее правой кнопкой мыши.\n\nКогда в результатах больше не останется групп, аддон автоматически начнет искать новые группы, подходящие по критериям поиска. Скрытые группы не будут отображаться до тех пор, пока вы не начнете поиск заново, нажав Enter или сменив фильтр.\n\nАддон можно закрыть во время поиска - он появится вновь, когда будет найдена подходящая группа."

	-- v1.10
	HOPADDON_TASKBAROPTION = "Панель задач"
	HOPADDON_TASKBARTOOLTIP = "Позволить аддону подсвечивать иконку WoW на панели задач, когда находится группа."
	
	HOPADDON_ADDITIONALFILTERS = "Допольнительные фильтры"
	
	HOPADDON_TIMEOPTION = "Не старше"
	HOPADDON_TIMETOOLTIP = "Максимальное количество секунд, прошедших со времени создания группы. Группы старше показываться не будут."
	HOPADDON_ITEMLEVEL = "Ур. предметов"
	HOPADDON_ITEMLEVELTOOLTIP = "Минимальный уровень предметов, требуемый для вступления в группу. Группы, в которых не указан минимальный уровень предметов, показываться не будут."
	HOPADDON_AUTOACCEPT = "Всегда принимать приглашения"
	HOPADDON_AUTOACCEPTTOOLTIP = "Разрешать аддону автоматически принимать приглашения от системы заранее собранных групп. Аддон будет принимать вас в группу не зависимо от предложенной вам роли."
	HOPADDON_SEARCHAUTOINVITETOOLTIP = "Находить только группы, которые принимают автоматически."
	
	-- v1.11
	HOPADDON_PVPTOOLTIP = "При отключении этой опции вы перестанете попадать на PVP сервера."
	
	-- v1.14
	HOPADDON_CREDITS = "Благодарности"
	HOPADDON_AUTHORCONT = "Контакты автора:"
	HOPADDON_TESTERS = "Тестеры:"
	HOPADDON_COMMUNITYTHANKS = "Спасибо игровому сообществу за распространение аддона!"
	
	--v1.15
	HOPADDON_NOTIFCHECK = "Уведомления в чате"
	HOPADDON_NOTIFTOOLTIP = "Позволять аддону отправлять в чат сообщения о перемещении между серверами."
	
	--v1.17
	HOPADDON_NEXTMACRO = 'Макрос для кнопки "Следующий"'
	HOPADDON_LASTMACRO = 'Макрос для кнопки "Прошлый"'
	HOPADDON_QUEUEWAITTIME = "Ожидать приглашение"
	HOPADDON_SEARCH_AUTOINVITE = "Только автоприглашение"
end