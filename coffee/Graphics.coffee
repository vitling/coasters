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
        for own name, filename of images
            img = new Image()
            imagesWaiting++
            img.onload = =>
                imagesWaiting--
                if allImagesCreated and imagesWaiting==0 then loadedCallback()
            img.src = "#{pathRoot}/#{filename}"
            @store[name]=img
        allImagesCreated=true

class View
    constructor: (canvas) ->
        @focus = {x:0,y:0}
        @dimensions = {w:canvas.width, h:canvas.height}
        @context = canvas.getContext('2d')
    
    moveTowards: (position) ->
        @focus.x+=(position.x-@focus.x)/20
        @focus.y+=(position.y-@focus.y)/20
        
    draw: (image, worldPosition, borderSize) ->
        drawPos = @transform worldPosition,@focus,@dimensions
        if !borderSize? or ( -borderSize < drawPos.x < @dimensions.w+borderSize and -borderSize < drawPos.y < @dimensions.h+borderSize )
            @context.drawImage(image,drawPos.x,drawPos.y)
        
    transform: (point) ->
        x: point.x-@focus.x+(@dimensions.w/2)
        y: point.y-@focus.y+(@dimensions.h/2)


class TileMap
    constructor: (@height, @width, blankTile, @tileSize=64) ->
        @tileArray = ((blankTile for x in [0...@width]) for y in [0...@height])
        
    setTile: (x,y,name) ->
        @tileArray[y][x]=name
    
    draw: (imageStore, view) ->
        ((view.draw(imageStore.get(@tileArray[yTile][xTile])
                    {x:xTile*@tileSize, y:yTile*@tileSize}
                    @tileSize
          ) for xTile in [0...@width]) for yTile in [0...@height])

define(
    "ImageStore": ImageStore
    "TileMap": TileMap
    "View": View
    )
