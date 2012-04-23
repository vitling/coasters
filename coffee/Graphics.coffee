nullFunction=->

zeroVector={x:0,y:0}

class ImageStore
    constructor: ->
        @store = {}
        
    get: (name) ->
        @store[name]
        
    loadImages: (pathRoot, images, loadedCallback = nullFunction) ->
        allImagesCreated = false
        imagesWaiting = 0
        for name, filename of images
            img = new Image()
            imagesWaiting++
            img.onload = =>
                imagesWaiting--
                if allImagesCreated and imagesWaiting==0 then loadedCallback()
            img.src = "#{pathRoot}/#{filename}"
            @store[name]=img
        allImagesCreated=true


class TileMap
    constructor: (@height, @width, blankTile, @tileSize=64) ->
        @tileArray = ((blankTile for x in [0...@width]) for y in [0...@height])
        
    setTile: (x,y,name) ->
        @tileArray[y][x]=name

    drawTile: (canvasContext,x,y,tile,scroll) ->
        drawPos = View.transform {x:x*@tileSize,y:y*@tileSize},scroll,canvasContext.canvas
        if -@tileSize < drawPos.x < canvasContext.canvas.width+@tileSize and -@tileSize < drawPos.y < canvasContext.canvas.height+@tileSize
            canvasContext.drawImage(tile,drawPos.x,drawPos.y)
    
    draw: (canvasContext, imageStore, scroll) ->
        #maxTiles={x: Math.ceil(canvasContext.canvas.width/ @tileSize)+1,y: Math.ceil(canvasContext.canvas.height/@tileSize)+1}
        #tileScroll={x: Math.floor((scroll.x-canvasContext.canvas.width)/ @tileSize),y: Math.floor((scroll.y-canvasContext.canvas.height)/@tileSize)}
        #start={x:Math.max(0,tileScroll.x),y:Math.max(0,tileScroll.y)}
        #end={x:Math.min(@width, tileScroll.x+maxTiles.x),y:Math.min(@width, tileScroll.y+maxTiles.y)}
        
        ((@drawTile(canvasContext
                    x
                    y
                    imageStore.get(@tileArray[y][x])
                    scroll
          ) for x in [0...@width]) for y in [0...@height])

View = 
    transform: (position, focus, dimensions) ->
        x: position.x-focus.x+(dimensions.width/2)
        y: position.y-focus.y+(dimensions.height/2)


define(
    "ImageStore": ImageStore
    "TileMap": TileMap
    "View": View
    )
