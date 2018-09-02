module.exports = ->
  for image in ['hero', 'car', 'key', 'magnifying_glass']
    @load.image(image, "/images/#{image}.png")
  
  @load.image('tiles', '/images/tiles.png')
  @load.tilemapCSV('tiles', '/tilemaps/map_tiles.csv')
  @load.tilemapCSV('objects', '/tilemaps/map_objects.csv')
