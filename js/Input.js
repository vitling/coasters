(function() {
  var Keyboard, Keys;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  Keys = {
    LEFT: 37,
    UP: 38,
    RIGHT: 39,
    DOWN: 40
  };
  Keyboard = (function() {
    function Keyboard() {
      this.keyUp = __bind(this.keyUp, this);
      this.keyDown = __bind(this.keyDown, this);      var x;
      window.addEventListener("keydown", this.keyDown);
      window.addEventListener("keyup", this.keyUp);
      this.keyStates = (function() {
        var _results;
        _results = [];
        for (x = 0; x < 256; x++) {
          _results.push(false);
        }
        return _results;
      })();
    }
    Keyboard.prototype.isPressed = function(key) {
      return this.keyStates[key];
    };
    Keyboard.prototype.keyDown = function(evt) {
      return this.keyStates[evt.keyCode] = true;
    };
    Keyboard.prototype.keyUp = function(evt) {
      return this.keyStates[evt.keyCode] = false;
    };
    return Keyboard;
  })();
  define({
    "Keyboard": Keyboard,
    "Keys": Keys
  });
}).call(this);
