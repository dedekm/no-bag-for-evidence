GameObject = require './game_object.coffee'

class StaticObject extends GameObject
  constructor: (scene, x, y, key, frame) ->
    super scene, x, y, key, frame
    @movable = false
  
module.exports = StaticObject
