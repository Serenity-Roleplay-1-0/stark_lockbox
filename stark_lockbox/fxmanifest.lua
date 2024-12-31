fx_version 'cerulean'

lua54 'yes'

game 'gta5'

name 'stark_lockbox'

author 'Adam Biegert'

version '1.0.3'

description 'A LEO Lockbox Script for QBCore'

shared_script {
    'config.lua',
    '@ox_lib/init.lua' -- Can be commented out or removed if you don't want to use Ox
}

client_scripts{
    'client/*.lua'
}

server_scripts{
    'server/*.lua'
}