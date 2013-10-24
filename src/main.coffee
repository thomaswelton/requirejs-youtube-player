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
		video4 = new YouTubePlayer event.target, 'FzRH3iTQPrk', { autoplay: 1 }
		testEvents video4, 'Video 4'


	# Playlist
	playlistPlayer = null
	playlistVideo = document.getElementById 'playlist-video'

	onThumbClick = (event) ->
		ytID = event.target.getAttribute('data-yt-id')

		if playlistPlayer?
			playlistPlayer.loadVideoById ytID
		else
			playlistPlayer = new YouTubePlayer playlistVideo, ytID, { autoplay: 1 }

		nextItem = event.target.nextElementSibling

		if nextItem
			playlistPlayer.once 'onEnd', () ->
				ytID = nextItem.getAttribute('data-yt-id')
				playlistPlayer.loadVideoById ytID


	playlistThumbs = document.getElementById('playlist-videos').getElementsByTagName('img')
	thumb.addEventListener 'click', onThumbClick for thumb in playlistThumbs
		
