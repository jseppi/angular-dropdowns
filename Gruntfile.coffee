path = require 'path'

# Build configurations.
module.exports = (grunt) ->
  grunt.initConfig
    # Deletes Compiled script directory
    # These directories should be deleted before subsequent builds.
    # These directories are not committed to source control.
    clean:
      working:
        scripts: [
          './scripts/*'
        ]
      
    # Compile CoffeeScript (.coffee) files to JavaScript (.js).
    coffee:
      src:
        files: [
          cwd: './src'
          src: '**/*.coffee'
          dest: './scripts'
          expand: true
          ext: '.js'
        ]
        options:
          # Don't include a surrounding Immediately-Invoked Function Expression (IIFE) in the compiled output.
          # For more information on IIFEs, please visit http://benalman.com/news/2010/11/immediately-invoked-function-expression/
          bare: true

    # Runs unit tests using karma
    karma:
      unit:
        options:
          autoWatch: true
          browsers: ['PhantomJS']
          colors: true
          configFile: './Scripts/Compiled/ngMapApp/test/karma-conf.js'
          port: 8081
          reporters: ['progress']
          runnerPort: 9100
          singleRun: true

    # Sets up file watchers and runs tasks when watched files are changed.
    watch:
      coffee:
        files: './src/**'
        tasks: [
          'coffee:src'
        ]

  # Register grunt tasks supplied by grunt-contrib-*.
  # Referenced in package.json.
  # https://github.com/gruntjs/grunt-contrib
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  # Register grunt tasks supplied by grunt-karma.
  # Referenced in package.json.
  # https://github.com/Dignifiedquire/grunt-testacular
  grunt.loadNpmTasks 'grunt-karma'

  # Compiles the app with non-optimized build settings and runs unit tests.
  # Enter the following command at the command line to execute this build task:
  # grunt test
  grunt.registerTask 'test', [
    'clean:working'
    'default'
    'karma'
  ]

  # Compiles the app with non-optimized build settings.
  # Enter the following command at the command line to execute this build task:
  # grunt
  grunt.registerTask 'default', [
    'coffee:scripts'
  ]


  # Compiles the app with non-optimized build settings and watches changes.
  # Enter the following command at the command line to execute this build task:
  # grunt dev
  grunt.registerTask 'dev', [
    'coffee:scripts'
    'watch'
  ]