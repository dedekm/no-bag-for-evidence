class GameObject extends Phaser.GameObjects.Image
  constructor: (scene, x, y, key, frame) ->
    super scene, x, y, key, frame
    
  moveTo: (direction) ->
    switch direction
      when 'up' then y = -1
      when 'down' then y = 1
      when 'left' then x = -1
      when 'right' then x = 1
    
    targetPositionX = @tileX + (x || 0)
    targetPositionY = @tileY + (y || 0)
    targetTile = @scene.getTile(targetPositionX, targetPositionY)
    
    return false if targetTile == 1
    
    if targetTile == 0 || targetTile.moveTo(direction)
      @setPosition(targetPositionX, targetPositionY)
      true
    else
      false
  
  setPosition: (x, y) ->
    @scene.setTile(@tileX, @tileY, 0) if @tileY && @tileX
    
    @tileX = x
    @tileY = y
    @scene.setTile(@tileX, @tileY, @)
    
    super x * @scene.tileSize + @scene.tileSizeHalf,
          y * @scene.tileSize + @scene.tileSizeHalf
  
module.exports = GameObject
