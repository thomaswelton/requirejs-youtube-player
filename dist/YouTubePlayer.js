(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['EventEmitter'], function(EventEmitter) {
    var YouTube;
    return YouTube = (function(_super) {
      __extends(YouTube, _super);

      function YouTube(el, ytID, options) {
        var _ref,
          _this = this;
        this.el = el;
        this.ytID = ytID;
        this.onPlayerStateChange = __bind(this.onPlayerStateChange, this);
        this.onPlayerReady = __bind(this.onPlayerReady, this);
        this.injectVideo = __bind(this.injectVideo, this);
        YouTube.__super__.constructor.call(this);
        if ((typeof YT !== "undefined" && YT !== null) && (YT.Player != null)) {
          this.injectVideo(this.el, this.ytID, options);
        } else {
          window.youtubeIframeApiLoader = (_ref = window.youtubeIframeApiLoader) != null ? _ref : new EventEmitter();
          window.onYouTubeIframeAPIReady = function() {
            return youtubeIframeApiLoader.fireEvent('apiReady');
          };
          youtubeIframeApiLoader.addEvent('apiReady', function() {
            return _this.injectVideo(_this.el, _this.ytID, options);
          });
          requirejs(['https://youtube.com/iframe_api']);
        }
      }

      YouTube.prototype.injectVideo = function(el, id, options) {
        if (options == null) {
          options = false;
        }
        return this.player = new YT.Player(el, {
          height: options.height,
          width: options.width,
          playerVars: options,
          videoId: id,
          events: {
            'onReady': this.onPlayerReady
          }
        });
      };

      YouTube.prototype.onPlayerReady = function() {
        this.fireEvent('onPlayerReady');
        return this.player.addEventListener('onStateChange', this.onPlayerStateChange);
      };

      YouTube.prototype.onPlayerStateChange = function(state) {
        switch (state.data) {
          case YT.PlayerState.ENDED:
            return this.fireEvent('onEnd');
          case YT.PlayerState.PLAYING:
            return this.fireEvent('onPlay');
          case YT.PlayerState.PAUSED:
            return this.fireEvent('onPause');
          case YT.PlayerState.BUFFERING:
            return this.fireEvent('onBuffer');
          case YT.PlayerState.CUED:
            return this.fireEvent('onCued');
        }
      };

      return YouTube;

    })(EventEmitter);
  });

}).call(this);
