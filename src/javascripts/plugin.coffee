class GameObjectPlugin extends Phaser.Plugins.BasePlugin
  constructor: (pluginManager) ->
    super(pluginManager);
    pluginManager.registerGameObject('object', @createObject)

  createObject: (klass, x, y, key, frame) ->
    object = new klass(@scene, x, y, key, frame)
    @displayList.add object

module.exports = GameObjectPlugin
