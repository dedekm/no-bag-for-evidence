GameObject = require './game_objects/game_object.coffee'

COMBINATIONS =
  key:
    car: [
      { type: 'create', item: 2, key: 'magnifying_glass', direction: 'right' }
      { type: 'create', item: 2, key: 'gun', direction: 'right' }
      { type: 'destroy', item: 1 }
    ]
  magnifying_glass:
    body: [
      { type: 'create', item: 2, key: 'hair', direction: 'right' }
      { type: 'destroy', item: 1 }
      { type: 'text', text: 'I got him now! \nThanks for playin!' }
    ]
  gun:
    smoker: [
      { type: 'destroy', item: 2 }
      { type: 'create', item: 1, key: 'cigarette', direction: 'right' }
      { type: 'destroy', item: 1 }
    ]
  cigarette:
    newspapers: [
      { type: 'destroy', item: 2 }
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
        item2 = temp
        success = true
    
    # result: not valid combination
    return false if not success
    
    for action in COMBINATIONS[item1.id][item2.id]
      item = @_targetItem(item1, item2, action.item)
      @[action.type](item, action)
      
    return true
  
  create: (item, opts) ->
    targetPosition = @scene.directionToXY(opts.direction, item.tilePosition.x, item.tilePosition.y)
    targetTile = @scene.getTile(targetPosition.x, targetPosition.y)
    
    if targetTile == 1
      false
    else
      object = new GameObject(@scene, item.tilePosition.x, item.tilePosition.y, opts.key)
      
      if object.moveTo(opts.direction)
        @scene.children.add(object)
        true
      else
        object.destroy()
        false
  
  destroy: (item) ->
    item.destroy()
    
  text: (item, opts) ->
    graphics = @scene.add.graphics()
    graphics.lineStyle(1, 0xfff)
    graphics.fillStyle(0x000)
    graphics.fillRect(20, 20, 280, 100)
    
    @scene.add.text(30, 30, opts.text, { fontSize: 16 })
    
  _actionPossible: (item, action) ->
    switch action.type
      when 'create'
        targetPosition = @scene.directionToXY(action.direction, item.tilePosition.x, item.tilePosition.y)
        
        @scene.getTile(targetPosition.x, targetPosition.y)
              .checkMoveTo(action.direction)
      else
        true
      
  _targetItem: (item1, item2, n) ->
    [item1, item2][n - 1]
    
module.exports = CombinationsPlugin
