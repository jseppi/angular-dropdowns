
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
          src: '*.coffee'
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
          {
            src: ['./scripts/dropdowns.js']
            dest: './dist/angular-dropdowns.js'
            filter: 'isFile'
          }
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
          frameworks: ['jasmine']
          browsers: ['PhantomJS']
          files: [
            './lib/angular-1.1.5/angular.min.js'
            './lib/angular-1.1.5/angular-mocks.js'
            './lib/test/chai.js'
            './src/*.coffee'
            './src/test/*.coffee'
          ]
          colors: true
          port: 8081
          runnerPort: 9100
          autoWatch: true

    # Sets up file watchers and runs tasks when watched files are changed.
    watch:
      src:
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
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  # Register grunt tasks supplied by grunt-karma.
  # Referenced in package.json.
  # https://github.com/Dignifiedquire/grunt-testacular
  grunt.loadNpmTasks 'grunt-karma'

  # Runs unit tests using the karma:unit task.
  # Enter the following command at the command line to execute this build task:
  # grunt test
  grunt.registerTask 'test', [
    'karma:unit'
  ]

  # Compiles the app with non-optimized build settings.
  # Enter the following command at the command line to execute this build task:
  # grunt
  grunt.registerTask 'default', [
    'coffee:src'
    'copy:dist'
    'uglify:dist'
  ]


  # Compiles the app with non-optimized build settings and watches changes.
  # Enter the following command at the command line to execute this build task:
  # grunt dev
  grunt.registerTask 'dev', [
    'coffee:src'
    'watch:src'
  ]