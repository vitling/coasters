require(["Graphics","Input"], (Graphics,Input) ->
    imageFiles = 
        floor:"tile_floor.gif"
        wall:"tile_wall.jpg"
        player:"player.jpg"
    
    images = new Graphics.ImageStore()
    tilemap = new Graphics.TileMap(50,50,"floor")
    view = new Graphics.View(document.getElementById("canvas"))
    keyboard = new Input.Keyboard()
    
    tilemap.setTile(0,0,"wall")

    camera={x:0,y:0}
    player={x:0,y:0}
    
    updateGame = ->
        player.x-=4 if keyboard.isPressed(Input.Keys.LEFT)
        player.x+=4 if keyboard.isPressed(Input.Keys.RIGHT)
        player.y-=4 if keyboard.isPressed(Input.Keys.UP)
        player.y+=4 if keyboard.isPressed(Input.Keys.DOWN)
        
        view.moveTowards player
        tilemap.draw images, view
        view.draw images.get("player"),player
    
    images.loadImages("img",imageFiles,->
        setInterval updateGame,10
    )
  )

