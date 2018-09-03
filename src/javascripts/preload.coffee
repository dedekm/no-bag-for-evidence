IMAGES = [
  'hero', 'car', 'key', 'magnifying_glass', 'gun',
  'body', 'hair', 'bin', 'newspapers',
  'smoker', 'cigarette', 'door'
]

module.exports = ->
  for image in IMAGES
    @load.image(image, "images/#{image}.png", { frameWidth: 32, frameHeight: 32 })
  
  @load.image('tiles', '/images/tiles.png')
  @load.tilemapCSV('tiles', '/tilemaps/map_tiles.csv')
  @load.tilemapCSV('objects', '/tilemaps/map_objects.csv')
