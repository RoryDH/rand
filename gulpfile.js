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

// var nodemonInstance;
// Backend
// gulp.task('back-lint', ['runApp'], function() {
//   gulp.src(fileLocations.back)
//     .pipe(jshint({expr: false}))
//     .pipe(jshint.reporter(stylish));
// });

//Concat & Minify JS
gulp.task('ng-concat', function() {
  gulp.src(fileLocations.front)
    .pipe(coffee({bare: true}).on('error', console.log))
    .pipe(concat('comp.js'))
    // .pipe(gulp.dest('./dist'))
    // .pipe(rename('all.min.js'))
    // .pipe(uglify())
    .pipe(gulp.dest('./public/js'));
});

// Nodemon
// gulp.task('runApp', function() {
//   nodemonInstance && nodemonInstance.emit('quit'); // restart node app
//   nodemonInstance = nodemon({
//     script: 'xtra.js',
//     options: '--ignore *'
//   });
// });

// Default
gulp.task('default', ['front-lint', 'ng-concat', 'css'], function() {
  // Watch JS Files
  gulp.watch(fileLocations.front, ['front-lint', 'ng-concat']);
  // gulp.watch(fileLocations.back, ['back-lint']);
  gulp.watch("./assets/style.scss", ['css']);
});