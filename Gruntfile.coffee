module.exports = (grunt) =>
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'

		bower:
			install: {}

		## Compile coffeescript
		coffee:
			compile:
				files: [
					{
						expand: true
						cwd: 'src'
						src: ['YouTubePlayer.coffee']
						dest: 'dist'
						ext: '.js'
					},
					{
						expand: true
						cwd: 'src'
						src: ['main.coffee']
						dest: 'demo'
						ext: '.js'
					}
				]

		watch:
			coffee:
				files: ['src/**/*.coffee']
				tasks: ['coffee']

		connect:
			server:
				options:
					keepalive: true
					port: 9001
					base: ''

		exec:
			server:
				command: 'grunt connect &'

			open:
				command: 'open http://localhost:9001/demo'

		
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-connect'
	grunt.loadNpmTasks 'grunt-exec'
	grunt.loadNpmTasks 'grunt-bower-task'
	
	grunt.registerTask 'default', ['bower' ,'compile']
	grunt.registerTask 'server', ['exec:server', 'compile', 'exec:open', 'watch']
	
	grunt.registerTask 'travis', 'Travis build tasks', ['default']
	grunt.registerTask 'compile', 'Compile coffeescript', ['coffee']
