nullFunction=->

# Loads and stores HTML Image elements keyed by name
class ImageStore
    constructor: ->
        @store = {}
    
    # Retrieve image from store
    get: (name) ->
        @store[name]
    
    # Loads images into the store
    # pathRoot - string to prepend to paths
    # images   - name->filename map
    # loadedCallback - function to call when all images are loaded
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

# Encapsulates canvas and a "camera" distinct from world coordinates
class View
    constructor: (canvas) ->
        @focus = {x:0,y:0}
        @dimensions = {w:canvas.width, h:canvas.height}
        @context = canvas.getContext('2d')
        
    clear: ->
        @context.fillRect(0,0,@dimensions.w,@dimensions.h,"black")
    
    # Moves the view to focus on position in a smooth scrolling fashion
    moveTowards: (position) ->
        @focus.x+=(position.x-@focus.x)/20
        @focus.y+=(position.y-@focus.y)/20
    
    # Draw image at worldPosition to canvas.
    draw: (image, worldPosition) ->
        drawPos = @transform worldPosition,@focus,@dimensions
        # Don't bother drawing if no part will be visible
        if -image.width < drawPos.x < @dimensions.w+image.width and -image.height < drawPos.y < @dimensions.h+image.height
            @context.drawImage(image,drawPos.x,drawPos.y)
    
    # Transforms a world coordinate to a screen coordinate
    transform: (point) ->
        x: point.x-@focus.x+(@dimensions.w/2)
        y: point.y-@focus.y+(@dimensions.h/2)

# Grid of tiles to draw, generally used for levels or maps
# Tiles are stored as strings to be looked up in an ImageStore, but this might change
class TileMap
    #blanktile - image to set all tiles to by default
    constructor: (@height, @width, blankTile, @tileSize) ->
        @tileArray = ((blankTile for x in [0...@width]) for y in [0...@height])
    
    # Set state of one tile
    setTile: (x,y,name) ->
        @tileArray[y][x]=name
    
    # Draw all tiles to the view using images from imageStore
    draw: (imageStore, view) ->
        ((view.draw(imageStore.get(@tileArray[yTile][xTile]), {x:xTile*@tileSize, y:yTile*@tileSize}) for xTile in [0...@width]) for yTile in [0...@height])

define(
    "ImageStore": ImageStore
    "TileMap": TileMap
    "View": View
    )
