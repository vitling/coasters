(function() {
  var ImageStore, TileMap, nullFunction;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  nullFunction = function() {};
  ImageStore = (function() {
    function ImageStore() {
      this.store = {};
    }
    ImageStore.prototype.get = function(name) {
      return this.store[name];
    };
    ImageStore.prototype.loadImages = function(pathRoot, images, loadedCallback) {
      var allImagesCreated, filename, imagesWaiting, img, name;
      if (loadedCallback == null) {
        loadedCallback = nullFunction;
      }
      allImagesCreated = false;
      imagesWaiting = 0;
      for (name in images) {
        filename = images[name];
        img = new Image();
        imagesWaiting++;
        img.onload = __bind(function() {
          imagesWaiting--;
          if (allImagesCreated && imagesWaiting === 0) {
            return loadedCallback();
          }
        }, this);
        img.src = "" + pathRoot + "/" + filename;
        this.store[name] = img;
      }
      return allImagesCreated = true;
    };
    return ImageStore;
  })();
  TileMap = (function() {
    function TileMap(height, width, blankTile) {
      var x, y;
      this.height = height;
      this.width = width;
      this.tileArray = (function() {
        var _ref, _results;
        _results = [];
        for (y = 0, _ref = this.height; 0 <= _ref ? y < _ref : y > _ref; 0 <= _ref ? y++ : y--) {
          _results.push((function() {
            var _ref2, _results2;
            _results2 = [];
            for (x = 0, _ref2 = this.width; 0 <= _ref2 ? x < _ref2 : x > _ref2; 0 <= _ref2 ? x++ : x--) {
              _results2.push(blankTile);
            }
            return _results2;
          }).call(this));
        }
        return _results;
      }).call(this);
    }
    TileMap.prototype.setTile = function(x, y, name) {
      return this.tileArray[y][x] = name;
    };
    TileMap.prototype.drawTile = function(canvasContext, x, y, tile, scroll) {
      var xScreen, yScreen;
      xScreen = x * 64 - scroll.x;
      yScreen = y * 64 - scroll.y;
      return canvasContext.drawImage(tile, xScreen, yScreen);
    };
    TileMap.prototype.draw = function(canvasContext, imageStore, scroll) {
      var end, maxTiles, start, tileScroll, x, y, _ref, _ref2, _results;
      maxTiles = {
        x: Math.ceil(canvasContext.canvas.width / 64)+1,
        y: Math.ceil(canvasContext.canvas.width / 64)+1
      };
      tileScroll = {
        x: Math.floor(scroll.x / 64),
        y: Math.floor(scroll.y / 64)
      };
      start = {
        x: Math.max(0, tileScroll.x),
        y: Math.max(0, tileScroll.y)
      };
      end = {
        x: Math.min(this.width, tileScroll.x + maxTiles.x),
        y: Math.min(this.width, tileScroll.y + maxTiles.y)
      };
      _results = [];
      for (y = _ref = start.y, _ref2 = end.y; _ref <= _ref2 ? y < _ref2 : y > _ref2; _ref <= _ref2 ? y++ : y--) {
        _results.push((function() {
          var _ref3, _ref4, _results2;
          _results2 = [];
          for (x = _ref3 = start.x, _ref4 = end.x; _ref3 <= _ref4 ? x < _ref4 : x > _ref4; _ref3 <= _ref4 ? x++ : x--) {
            _results2.push(this.drawTile(canvasContext, x, y, imageStore.get(this.tileArray[y][x]), scroll));
          }
          return _results2;
        }).call(this));
      }
      return _results;
    };
    return TileMap;
  })();
  define({
    "ImageStore": ImageStore,
    "TileMap": TileMap
  });
}).call(this);
