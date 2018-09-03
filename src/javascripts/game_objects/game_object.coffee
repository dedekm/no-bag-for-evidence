class GameObject extends Phaser.GameObjects.Image
  constructor: (scene, x, y, key, frame) ->
    super scene, x, y, key, frame
    @id = key
    @combinable = true
    @movable = true
    
  _checkMoveTo: (direction) ->
    return false unless @movable
    helperPosition = @futurePosition || @tilePosition
    @futurePosition = @scene.directionToXY(direction, helperPosition.x, helperPosition.y)
    targetTile = @scene.getFutureTile(@futurePosition.x, @futurePosition.y)
    if targetTile
      if @combineWith(targetTile) || targetTile.moveTo(direction)
        @scene.setFutureTile(@futurePosition.x, @futurePosition.y, @)
      else
        return false
    
    targetTile = @scene.getTile(@futurePosition.x, @futurePosition.y)

    return false if targetTile == 1
    
    if targetTile == 0
      true
    else if @combineWith(targetTile) || targetTile.moveTo(direction)
      true
    else
      false
  
  moveTo: (direction) ->
    @direction = direction
    if @_checkMoveTo(direction)
      @_makeAMove()
      true
    else
      if @futurePosition
        @scene.setFutureTile(@futurePosition.x, @futurePosition.y, undefined)
        @futurePosition = undefined
      false
  
  _makeAMove: () ->
    unless @destroyed
      @scene.setFutureTile(@futurePosition.x, @futurePosition.y, undefined)
      @setPosition(@futurePosition.x, @futurePosition.y, false)
      @futurePosition = undefined
  
  combineWith: (item) ->
    return unless @combinable && item.combinable
    
    @scene.combinations.combine(@, item)
  
  setPosition: (x, y, futureOnly = true) ->
    return if @destroyed
    
    if futureOnly
      @futurePosition = { x: x, y: y }
      @scene.setFutureTile(@futurePosition.x, @futurePosition.y, @)
    else
      @scene.setTile(@tilePosition.x, @tilePosition.y, 0) if @tilePosition
      @tilePosition = { x: x, y: y }
      @scene.setTile(@tilePosition.x, @tilePosition.y, @)
    
    super x * @scene.tileSize + @scene.tileSizeHalf,
          y * @scene.tileSize + @scene.tileSizeHalf
  
  destroy: () ->
    @scene.setFutureTile(@futurePosition.x, @futurePosition.y, undefined) if @futurePosition
    @scene.setTile(@tilePosition.x, @tilePosition.y, 0) if @tilePosition
    @destroyed = true
    super()
  
module.exports = GameObject
