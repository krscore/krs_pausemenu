fx_version "cerulean"
use_fxv2_oal "yes"
lua54 "yes"
game "gta5"
version "1.0.0"
description "A simple pausemenu system"
name 'krs_pausemenu'
author "karos7804"

shared_scripts {
    '@ox_lib/init.lua',
}

client_scripts {
    'client/*.lua', 
}

server_scripts {
    'server/*.lua', 
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/style.css',
    'ui/script.js',
    'ui/map.png',
}

dependencies {
    'ox_lib',
}
