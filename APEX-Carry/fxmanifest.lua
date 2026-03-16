shared_script "@bt_defender/module/shared.lua"

fx_version 'cerulean'
game 'gta5'

server_scripts {
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'config-key.lua',
	'client/main.lua',
}

files {
	"stream/**.**",
	"ui/index.html",
	"ui/img/***.***",
	"ui/sounds/***.***",
	"ui/style.css",
	"ui/app.js"
}
ui_page "ui/index.html"

lua54 'yes'

dependencies {
	'es_extended',
	'APEX-AllNotify'
}
