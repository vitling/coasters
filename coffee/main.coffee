require(["Graphics","Input"], (Graphics,Input) ->
    images = 
        floor:"tile_floor.gif"
        wall:"tile_wall.jpg"
    
    store = new Graphics.ImageStore()
    tilemap = new Graphics.TileMap(50,50,"floor")
    keyboard = new Input.Keyboard()
    tilemap.setTile(1,2,"wall")
    canvasContext = document.getElementById("canvas").getContext("2d")
    camera={x:0,y:0}
    player={x:0,y:0}

    
    redrawTiles = ->
        player.x-=4 if keyboard.isPressed(Input.Keys.LEFT)
        player.x+=4 if keyboard.isPressed(Input.Keys.RIGHT)
        player.y-=4 if keyboard.isPressed(Input.Keys.UP)
        player.y+=4 if keyboard.isPressed(Input.Keys.DOWN)
        
        camera.x+=(player.x-camera.x)/20
        camera.y+=(player.y-camera.y)/20
        
        tilemap.draw canvasContext, store, camera 
    
    store.loadImages("img",images,->
        setInterval redrawTiles,10
    )
  )

