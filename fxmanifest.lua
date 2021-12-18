fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'szxna'
description 'złomowanie pojazdów'
version '1.0.0'

client_scripts {
    'client/client.lua',
    'config.lua'
}

server_scripts {
    'server/server.lua',
    'config.lua',
    '@mysql-async/lib/MySQL.lua',
    '@async/async.lua'
}