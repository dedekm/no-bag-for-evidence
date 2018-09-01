GameObject = require './game_object.coffee'

class Hero extends GameObject
  constructor: (scene, x, y, key, frame) ->
    super scene, x, y, key, frame
    
    hero = @
    @scene.input.keyboard.on 'keydown', (event) ->
      return if event.key not in [
        'w', 's', 'a', 'd',
        'ArrowUp', 'ArrowDown', 'ArrowLeft', 'ArrowRight'
      ]

      switch event.key
        when 'w', 'ArrowUp' then hero.moveTo('up')
        when 's', 'ArrowDown' then hero.moveTo('down')
        when 'a', 'ArrowLeft' then hero.moveTo('left')
        when 'd', 'ArrowRight' then hero.moveTo('right')
  
module.exports = Hero
