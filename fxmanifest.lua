author 'beka'
version '1.0.0'
description 'rainforced lasso'

fx_version "adamant"
lua54 "on"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game "rdr3"

client_scripts {
	'client/client.lua',
}

shared_scripts {
    'config.lua',
}

server_scripts {
	'server/server.lua',
}