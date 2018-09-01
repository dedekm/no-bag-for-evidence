module.exports = ->
  @load.image('car', 'http://labs.phaser.io/assets/sprites/car.png')
  @load.image('key', 'http://labs.phaser.io/assets/sprites/mushroom-32x32.png')
  @load.image('tiles', '/images/tiles.png')
  @load.tilemapCSV('map', '/tilemaps/map.csv')
