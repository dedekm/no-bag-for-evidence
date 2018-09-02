GameObject = require './game_objects/game_object.coffee'
StaticObject = require './game_objects/static_object.coffee'

CUSTOM_CLASSES =
  Hero: require './game_objects/hero.coffee'

GAME_OBJECTS =
  1: {
    key: 'car',
    static: true
  }
  2: {
    key: 'key'
  }
  3: {
    key: 'hero',
    customClass: 'Hero'
  }


addObjectByIndex = (scene, index, x, y) ->
  object = GAME_OBJECTS[index]
  
  if object.customClass
    klass = CUSTOM_CLASSES[object.customClass]
    console.error "unknown class #{object.customClass}" unless klass
  else if object.static
    klass = StaticObject
  else
    klass = GameObject

  scene.add.object klass, x, y, object.key
  
module.exports = (scene) ->
  map = scene.make.tilemap(
    key: 'tiles'
    tileWidth: scene.tileSize
    tileHeight: scene.tileSize
  )
  map.createStaticLayer(0, map.addTilesetImage 'tiles')
  
  objects = scene.make.tilemap(key: 'objects')
  
  scene.grid = []
  for y in [0...map.height]
    col = []
    for x in [0...map.width]
      tile = map.getTileAt(x, y)
      if tile && tile.index == 1
        col[x] = 1
      else
        col[x] = 0
    scene.grid.push col
  
  for y in [0...map.height]
    for x in [0...map.width]
      object = objects.getTileAt(x, y)
      if object
        col[x] = addObjectByIndex(scene, object.index, x, y)
