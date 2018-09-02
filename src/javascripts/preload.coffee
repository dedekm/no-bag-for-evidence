module.exports = ->
  for image in ['hero', 'car', 'key', 'magnifying_glass']
    @load.image(image, "/images/#{image}.png")
  
  @load.image('tiles', '/images/tiles.png')
  @load.tilemapCSV('map', '/tilemaps/map.csv')
