GameObject = require './game_objects/game_object.coffee'

class CombinationsPlugin
  constructor: (scene) ->
    @scene = scene
    @_TABLE = []
    
  add: (item1, item2, actions...) ->
    @_TABLE.push [item1, item2, actions]
    
  combine: (item1, item2) ->
    success = false
    for combination in @_TABLE
      if item1.id == combination[0] && item2.id == combination[1]
        success = true
      else if item2.id == combination[0] && item1.id == combination[1]
        temp = item1
        item1 = item2
        item2 = item1
        success = true
      
      if success
        for action in combination[2]
          item = @_targetItem(item1, item2, action[1])
          @[action[0]](item, action.slice(2))
        return true
      else
        return false
  
  # args = [key, x, y]
  create: (item, args) ->
    x = item.tileX + args[1]
    y = item.tileY + args[2]
    @scene.add.object(GameObject, x, y, args[0])
  
  destroy: (item) ->
    item.destroy()
    
  _targetItem: (item1, item2, n) ->
    [item1, item2][n - 1]
    
module.exports = CombinationsPlugin
