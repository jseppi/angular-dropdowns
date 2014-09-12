path = require 'path'

# Build configurations.
module.exports = (grunt) ->
  grunt.initConfig
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

    # Copy dropdowns.js to the dist folder
    copy:
      dist:
        files: [
          src: ['./scripts/dropdowns.js']
          dest: './dist/angular-dropdowns.js'
          filter: 'isFile'
        ]

    uglify:
      dist:
        options: {
          #beautify: true
        }
        files: {
          './dist/angular-dropdowns.min.js': ['./dist/angular-dropdowns.js']
        }

    # Runs unit tests using karma
    karma:
      unit:
        options:
          autoWatch: true
          browsers: ['Chrome']
          colors: true
          configFile: './test/karma-conf.js'
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
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  # Register grunt tasks supplied by grunt-karma.
  # Referenced in package.json.
  # https://github.com/Dignifiedquire/grunt-testacular
  grunt.loadNpmTasks 'grunt-karma'

  # Compiles the app with non-optimized build settings and runs unit tests.
  # Enter the following command at the command line to execute this build task:
  # grunt test
  grunt.registerTask 'test', [
    'default'
    'karma'
  ]

  # Compiles the app with non-optimized build settings.
  # Enter the following command at the command line to execute this build task:
  # grunt
  grunt.registerTask 'default', [
    'copy:dist'
    'uglify:dist'
  ]
