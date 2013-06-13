(function() {
  require(['YouTubePlayer', 'domReady!'], function(YouTubePlayer) {
    var $, testEvents, video1, video2;
    console.log('main init');
    $ = function(id) {
      return document.getElementById(id);
    };
    testEvents = function(el, id) {
      el.addEvent('onPlayerReady', function() {
        return console.log("" + id + " onPlayerReady");
      });
      el.addEvent('onPlay', function() {
        return console.log("" + id + " onPlay");
      });
      el.addEvent('onPause', function() {
        return console.log("" + id + " onPause");
      });
      el.addEvent('onEnd', function() {
        return console.log("" + id + " onEnd");
      });
      el.addEvent('onBuffer', function() {
        return console.log("" + id + " onBuffer");
      });
      return el.addEvent('onCued', function() {
        return console.log("" + id + " onCued");
      });
    };
    video1 = new YouTubePlayer($('player1'), '_OBlgSz8sSM', {
      width: 500
    });
    video2 = new YouTubePlayer($('player2'), 'J---aiyznGQ');
    testEvents(video1, 'Video 1');
    testEvents(video2, 'Video 2');
    return setTimeout(function() {
      var video3;
      video3 = new YouTubePlayer($('player3'), 'FzRH3iTQPrk', {
        width: 200,
        height: 200
      });
      return testEvents(video3, 'Video 3');
    }, 2000);
  });

}).call(this);
