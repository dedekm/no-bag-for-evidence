GameObject = require './game_objects/game_object.coffee'

COMBINATIONS =
  key:
    car: [
      { type: 'create', item: 2, key: 'magnifying_glass', direction: 'right' }
      { type: 'destroy', item: 1 }
    ]
  magnifying_glass:
    body: [
      { type: 'create', item: 2, key: 'hair', direction: 'right' }
      { type: 'destroy', item: 1 }
    ]

class CombinationsPlugin
  constructor: (scene) ->
    @scene = scene
    
  combine: (item1, item2) ->
    if COMBINATIONS[item1.id]
      if COMBINATIONS[item1.id][item2.id]
        success = true
    else if COMBINATIONS[item2.id]
      if COMBINATIONS[item2.id][item1.id]
        success = true

        temp = item1
        item1 = item2
        item2 = item1
        success = true
    
    # result: not valid combination
    return false if not success
    
    for action in COMBINATIONS[item1.id][item2.id]
      item = @_targetItem(item1, item2, action.item)
      @[action.type](item, action)
      
    return true
  
  create: (item, opts) ->
    targetPosition = @scene.directionToXY opts.direction, item.tileX, item.tileY
    @scene.add.object(GameObject, targetPosition.x, targetPosition.y, opts.key)
  
  destroy: (item) ->
    item.destroy()
    
  _targetItem: (item1, item2, n) ->
    [item1, item2][n - 1]
    
module.exports = CombinationsPlugin
