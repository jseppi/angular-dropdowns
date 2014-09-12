'use strict';

var gulp = require('gulp');
var uglify = require('gulp-uglify');
var rimraf = require('gulp-rimraf');
var jshint = require('gulp-jshint');
var rename = require('gulp-rename');
var stylish = require('jshint-stylish');

var srcFile = 'angular-dropdowns.js';
var srcCss = 'angular-dropdowns.css';
var distDir = './dist';

gulp.task('default', ['jshint', 'copy', 'uglify']);

gulp.task('jshint', function () {
  return gulp.src(srcFile)
    .pipe(jshint())
    .pipe(jshint.reporter(stylish));
});

gulp.task('copy', function () {
  return gulp.src([srcFile, srcCss])
    .pipe(gulp.dest(distDir));
});

gulp.task('uglify', function () {
  return gulp.src(srcFile)
    .pipe(uglify({
      preserveComments: 'some'
    }))
    .pipe(rename({
      suffix: '.min'
    }))
    .pipe(gulp.dest(distDir));
});

gulp.task('clean', function () {
  return gulp.src(distDir)
    .pipe(rimraf());
});
