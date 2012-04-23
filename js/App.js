(function() {
  var App, Graph;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  Graph = (function() {
    function Graph(canvas) {
      this.canvas = canvas;
      this.context = canvas.getContext('2d');
    }
    Graph.prototype.fill = function(x, y, w, h, c) {
      if (c == null) {
        c = 'black';
      }
      this.context.fillStyle = c;
      return this.context.fillRect(x, y, w, h);
    };
    return Graph;
  })();
  App = (function() {
    function App(graph) {
      this.graph = graph;
    }
    App.prototype.start = function() {
      return setInterval(__bind(function() {
        return this.update();
      }, this), 10);
    };
    App.prototype.update = function() {
      this.graph.fill(0, 0, 500, 500, "white");
      return this.graph.fill(Math.random() * 500, Math.random() * 500, 10, 10);
    };
    return App;
  })();
  define({
    "Graph": Graph,
    "App": App
  });
}).call(this);
