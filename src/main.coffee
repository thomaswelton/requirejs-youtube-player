require ['YouTubePlayer', 'domReady!'], (YouTubePlayer) ->
	console.log 'main init'

	$ = (id) -> document.getElementById id

	testEvents = (el, id) ->
		el.addEvent 'onPlayerReady', () -> console.log "#{id} onPlayerReady"
		el.addEvent 'onPlay', () -> console.log "#{id} onPlay"
		el.addEvent 'onPause', () -> console.log "#{id} onPause"
		el.addEvent 'onEnd', () -> console.log "#{id} onEnd"
		el.addEvent 'onBuffer', () -> console.log "#{id} onBuffer"
		el.addEvent 'onCued', () -> console.log "#{id} onCued"

	## Two videos loaded at the sane time, both needing to load YT API
	video1 = new YouTubePlayer $('player1'), '_OBlgSz8sSM', { width: 500 }
	video2 = new YouTubePlayer $('player2'), 'J---aiyznGQ'

	testEvents video1, 'Video 1'
	testEvents video2, 'Video 2'

	setTimeout () ->
		## A video loaded after the YT API should have loaded
		video3 = new YouTubePlayer $('player3'), 'FzRH3iTQPrk', { width: 200, height:200 }
		testEvents video3, 'Video 3'
	, 2000

	player4 = $('player4')

	player4.addEventListener 'click', () ->
		new YouTubePlayer event.target, 'FzRH3iTQPrk', { width: 50, autoplay: 1 }

