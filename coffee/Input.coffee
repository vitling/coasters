Keys = 
    LEFT: 37
    UP: 38
    RIGHT: 39
    DOWN: 40

class Keyboard
    constructor: ->
        window.addEventListener("keydown",@keyDown)
        window.addEventListener("keyup",@keyUp)
        @keyStates=(false for x in [0...256])
        
    isPressed: (key) ->
        return @keyStates[key]
        
    keyDown: (evt) =>
        @keyStates[evt.keyCode]=true
    
    keyUp: (evt) =>
        @keyStates[evt.keyCode]=false


define(
    "Keyboard": Keyboard
    "Keys": Keys
    )
