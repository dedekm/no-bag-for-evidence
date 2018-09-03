GameObjectPlugin = require './plugin.coffee'

preload = require './preload.coffee'
create = require './create.coffee'
update = require './update.coffee'


config =
  type: Phaser.AUTO
  title: 'No Bag For Evidence'
  width: 320
  height: 240
  pixelArt: true
  zoom: 2
  plugins:
    global: [
        { key: 'GameObjectPlugin', plugin: GameObjectPlugin, start: true }
    ]
  scene:
    preload: preload
    create: create
    update: update

game = new (Phaser.Game)(config)
