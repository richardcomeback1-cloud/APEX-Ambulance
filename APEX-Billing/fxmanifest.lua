shared_script "@bt_defender/module/shared.lua"


fx_version 'adamant'

game 'gta5'

description 'ESX Billing'

version '1.0.0'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'locales/es.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'locales/es.lua',
	'config.lua',
	'client/main.lua'
}

ui_page "nui/index.html"

files {
	'nui/**/*',
}

lua54 'yes'