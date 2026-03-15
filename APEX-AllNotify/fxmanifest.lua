shared_script "@bt_defender/module/shared.lua"

-- --  

fx_version 'adamant'

game 'gta5'
description 'Notify' 
author 'Nakins'
version '1.0'
lua54 'yes'

client_script {
  'config.lua',
  'client.lua',
}

server_script {
  'config.lua',
	'server.lua',
}

ui_page "html_mod/index.html"
files {
    'html_mod/index.html',
    'html_mod/script.js',
    'html_mod/style.css',
    'html_mod/img/*.png',
    'html_mod/img/*.jpg',
    'html_mod/img/*.gif',
    'html_mod/*.mp3',
    'html_mod/*.png',
}

export 'AddNotify'