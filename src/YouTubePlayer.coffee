##############################################################
#
#	Class: YouTubePlayer
#	https://developers.google.com/youtube/iframe_api_reference
#	
##############################################################

define ['EventEmitter'], (EventEmitter) ->
	class YouTube extends EventEmitter
		constructor: (@el, @ytID, options) ->
			super()

			if YT? and YT.Player?
				@injectVideo @el, @ytID, options
			else
				## Create a global variable to act as an event emitter for all YouTube instances
				window.youtubeIframeApiLoader = window.youtubeIframeApiLoader ? new EventEmitter()

				## Create global function required by youtube for onReady
				window.onYouTubeIframeAPIReady = () ->
					## Fire the apiReady event for all 
					youtubeIframeApiLoader.fireEvent 'apiReady'
				
				## When the api is ready inject the video
				youtubeIframeApiLoader.addEvent 'apiReady', () =>
					@injectVideo @el, @ytID, options

				## Load the API
				requirejs ['https://youtube.com/iframe_api']

		injectVideo: (el, id, options = false) =>
			@player = new YT.Player el,
				height: options.height,
				width: options.width,
				playerVars: options,
				videoId: id,
				events:
					'onReady': @onPlayerReady

		onPlayerReady: () =>
			@fireEvent 'onPlayerReady'

			# This implmentation is a bug fix
			# http://stackoverflow.com/questions/17078989/youtube-iframe-api-onstatechange-suddenly-not-working
			@player.addEventListener 'onStateChange', @onPlayerStateChange

		onPlayerStateChange: (state) =>
			## Convenience method for YT playerstate changes
			switch state.data
				when YT.PlayerState.ENDED then @fireEvent 'onEnd'
				when YT.PlayerState.PLAYING then @fireEvent 'onPlay'
				when YT.PlayerState.PAUSED then @fireEvent 'onPause'
				when YT.PlayerState.BUFFERING then @fireEvent 'onBuffer'
				when YT.PlayerState.CUED then @fireEvent 'onCued'

###
