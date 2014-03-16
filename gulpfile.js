var gulp = require('gulp');
var coffeelint = require('gulp-coffeelint');
var coffee = require('gulp-coffee');
var concat = require('gulp-concat');
var rename = require('gulp-rename');
// var uglify = require('gulp-uglify');
var nodemon = require('gulp-nodemon');
var sass = require('gulp-sass');
var StreamQueue = require('streamqueue');

var fileLocations = {
  front: [
    "./assets/ng/main.coffee",
    "./assets/ng/services.coffee",
    "./assets/ng/controllers.coffee",
    "./assets/ng/directives.coffee"
  ],
  frontLibs: [
    "./assets/jslib/*"
  ],
  cssLibs: ["./assets/csslib/*.css"]
};

// Sass and css libs
gulp.task('css', function () {
  var sassStream = gulp.src('./assets/*.scss').pipe(sass());
  var cssFiles = gulp.src('./assets/csslib/*.css');
  new StreamQueue({objectMode: true},
    cssFiles,
    sassStream
  ).pipe(concat('comp.css'))
    .pipe(gulp.dest('./public/css'));
});
// Lint JS
// Frontend
gulp.task('front-lint', function() {
  gulp.src(fileLocations.front)
    .pipe(coffeelint())
    .pipe(coffeelint.reporter());
});

//Concat & Minify JS
gulp.task('js-compile', function() {
  var lib = gulp.src(fileLocations.frontLibs);
  var cs = gulp.src(fileLocations.front)
            .pipe(coffee({bare: true})
            .on('error', console.log));
  new StreamQueue({objectMode: true},
    lib,
    cs
  ).pipe(concat('comp.js'))
    .pipe(gulp.dest('./public/js'));
});

// Default
gulp.task('default', ['front-lint', 'js-compile', 'css'], function() {
  // Watch JS Files
  gulp.watch(fileLocations.front, ['front-lint', 'js-compile']);
  // gulp.watch(fileLocations.back, ['back-lint']);
  gulp.watch("./assets/style.scss", ['css']);
});