class GameObject extends Phaser.GameObjects.Image
  constructor: (scene, x, y, key, frame) ->
    super scene, x, y, key, frame
  
  setPosition: (x, y) ->
    @scene.setTile(@tileX, @tileY, 0) if @tileY && @tileX
    
    @tileX = x
    @tileY = y
    @scene.setTile(@tileX, @tileY, @)
    
    super x * @scene.tileSize + @scene.tileSizeHalf,
          y * @scene.tileSize + @scene.tileSizeHalf
  
module.exports = GameObject
