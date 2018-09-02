class GameObject extends Phaser.GameObjects.Image
  constructor: (scene, x, y, key, frame) ->
    super scene, x, y, key, frame
    @id = key
    @combinable = true
    @movable = true
    
  moveTo: (direction) ->
    return false unless @movable
    
    targetPosition = @scene.directionToXY(direction, @tileX, @tileY)
    targetTile = @scene.getTile(targetPosition.x, targetPosition.y)
    
    return false if targetTile == 1
    
    if targetTile == 0
      @setPosition(targetPosition.x, targetPosition.y)
      true
    else if @combineWith(targetTile) || targetTile.moveTo(direction)
      @setPosition(targetPosition.x, targetPosition.y)
      true
    else
      false
  
  combineWith: (item) ->
    return unless @combinable && item.combinable
    
    @scene.combinations.combine(@, item)
  
  setPosition: (x, y) ->
    return if @destroyed
    
    @scene.setTile(@tileX, @tileY, 0) if @tileY && @tileX
    
    @tileX = x
    @tileY = y
    @scene.setTile(@tileX, @tileY, @)
    
    super x * @scene.tileSize + @scene.tileSizeHalf,
          y * @scene.tileSize + @scene.tileSizeHalf
  
  destroy: () ->
    @scene.setTile(@tileX, @tileY, 0)
    @destroyed = true
    super()
  
module.exports = GameObject
