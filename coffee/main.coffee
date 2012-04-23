require(["Graphics","Input"], (Graphics,Input) ->
    imageFiles = 
        floor:"tile_floor.png"
        wall:"tile_wall.png"
        player:"player.png"
    
    images = new Graphics.ImageStore()
    tilemap = new Graphics.TileMap(50,50,"floor", 32)
    view = new Graphics.View(document.getElementById("canvas"))
    keyboard = new Input.Keyboard()	
    
    tilemap.setTile(x,0,"wall") for x in [0...50]
    tilemap.setTile(0,y,"wall") for y in [0...50]
    tilemap.setTile(Math.floor(Math.random()*50),Math.floor(Math.random()*50),"wall") for x in [0...100]

    player={x:640,y:480}
    
    updateGame = ->
        player.x-=4 if keyboard.isPressed(Input.Keys.LEFT)
        player.x+=4 if keyboard.isPressed(Input.Keys.RIGHT)
        player.y-=4 if keyboard.isPressed(Input.Keys.UP)
        player.y+=4 if keyboard.isPressed(Input.Keys.DOWN)
        
        view.moveTowards player
        
        view.clear()
        tilemap.draw images, view
        view.draw images.get("player"),player
    
    images.loadImages("img",imageFiles,->
        setInterval updateGame,25
    )
  )

