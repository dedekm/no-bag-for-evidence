CombinationsPlugin = require './combinations.coffee'

buildMap = require './build_map.coffee'

module.exports = ->
  @setTile = (x, y, object) ->
    @grid[y][x] = object
    
  @getTile = (x, y) ->
    @grid[y][x]
  
  @directionToXY = (dir, x = 0, y = 0) ->
    switch dir
      when 'up' then { x: x, y: y - 1 }
      when 'down' then { x: x, y: y + 1 }
      when 'left' then { x: x - 1, y: y }
      when 'right' then { x: x + 1, y: y }
    
  @tileSize = 32
  @tileSizeHalf = @tileSize / 2
  @combinations = new CombinationsPlugin @
  
  buildMap(@)
  
  @combinations.add 'key', 'car', [ 'destroy', 1],
                                  [ 'create', 2, 'magnifying_glass', 1, 0]
  
  @input.keyboard.on 'keydown', (event) ->
    @scene.scene.restart() if event.key == 'r'
