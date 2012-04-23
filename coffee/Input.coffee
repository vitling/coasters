# Add to this as required, but dont forget the are builtin things to convert non-special keys to keycodes and vice versa
Keys = 
    LEFT: 37
    UP: 38
    RIGHT: 39
    DOWN: 40

# Monitors keyboard state to facilitate "isPressed" state queries
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
