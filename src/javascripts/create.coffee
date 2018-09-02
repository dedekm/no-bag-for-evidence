GameObject = require './game_objects/game_object.coffee'
Hero = require './game_objects/hero.coffee'
CombinationsPlugin = require './combinations.coffee'

module.exports = ->
  @setTile = (x, y, object) ->
    @grid[y][x] = object
    
  @getTile = (x, y) ->
    @grid[y][x]
    
  @tileSize = 32
  @tileSizeHalf = @tileSize / 2
  @combinations = new CombinationsPlugin @
  
  map = @make.tilemap(
    key: 'map'
    tileWidth: @tileSize
    tileHeight: @tileSize
  )
  map.createStaticLayer(0, map.addTilesetImage 'tiles')
  
  @grid = []
  for y in [0...map.height]
    col = []
    for x in [0...map.width]
      if map.getTileAt(x, y).index == 1
        col[x] = 1
      else
        col[x] = 0
    @grid.push col
  
  @add.object GameObject, 2, 2, 'key'
  @add.object GameObject, 3, 2, 'car'
  @combinations.add 'key', 'car', [ 'destroy', 1],
                                  [ 'create', 2, 'magnifying_glass', 1, 0]
  
  @add.object Hero, 3, 3, 'hero'
  @input.keyboard.on 'keydown', (event) ->
    @scene.scene.restart() if event.key == 'r'
