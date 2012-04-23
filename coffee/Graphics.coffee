nullFunction=->

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
    constructor: (@height, @width, blankTile) ->
        @tileArray = ((blankTile for x in [0...@width]) for y in [0...@height])
        
    setTile: (x,y,name) ->
        @tileArray[y][x]=name

    drawTile: (canvasContext,x,y,tile,scroll) ->
        xScreen = x*64-scroll.x
        yScreen = y*64-scroll.y
        canvasContext.drawImage(tile,xScreen,yScreen)
    
    draw: (canvasContext, imageStore, scroll) ->
        maxTiles={x: Math.ceil(canvasContext.width/ 64),y: Math.ceil(canvasContext.width/64)}
        tileScroll={x: Math.floor(scroll.x/ 64),y: Math.floor(scroll.y/64)}
        start={x:Math.max(0,tileScroll.x),y:Math.max(0,tileScroll.y)}
        end={x:Math.min(@width, tileScroll.x+maxTiles.x),y:Math.min(@width, tileScroll.y+maxTiles.y)}
        
        ((@drawTile(canvasContext
                    x
                    y
                    imageStore.get(@tileArray[y][x])
                    scroll
          ) for x in [start.x...end.x]) for y in [start.y...end.y])


define(
    "ImageStore": ImageStore
    "TileMap": TileMap
    )
