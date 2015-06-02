var gulp = require('gulp');
var bower = require('gulp-bower');
var coffee = require('gulp-coffee');
var gutil = require('gulp-util');
var replace = require('gulp-replace');
var shell = require('gulp-shell');
var clean = require('gulp-clean');
var concat = require('gulp-concat');
var fs = require('fs');

var manifest = require('./manifest.json')

var resources = [
  "icons/icon16.png",
  "icons/icon48.png",
  "icons/icon128.png",
  "bower_components/jquery/dist/jquery.min.js",
  "bower_components/gmail.js/src/gmail.js",
  "content.js",
  "manifest.json"
]

gulp.task('template', function() {
  gulp.src(
    'src/*.coffee'
  ).pipe(coffee({bare: true})).on('error', gutil.log)
   .pipe(replace(
    'API_ENDPOINT', process.env.API_ENDPOINT || 'http://localhost:3000'
  )).pipe(replace(
    'APP_ENDPOINT', process.env.APP_ENDPOINT || 'http://localhost:4200'
  )).pipe(concat('main.js'))
    .pipe(gulp.dest('dist/'));
});

gulp.task('bower', function() {
  bower();
});

gulp.task('watch', ['package'], function() {
  gulp.watch('src/*.coffee', ['template']);
  gulp.watch('bower.json', ['bower']);
});

gulp.task('default', ['bower', 'watch'], function() {});

gulp.task('clean', function() {
  gulp.src('dist/*', {read: false}).pipe(clean())
  gulp.src('*.crx', {read: false}).pipe(clean())
})

gulp.task('package', ['template'], function() {
  gulp.src(resources, {base: './'})
      .pipe(gulp.dest('dist'))
      .pipe(shell([
        'crxmake --pack-extension=./dist --extension-output="signr-chrome.crx" --pack-extension-key=./contrib/signr-chrome.pem'
      ]))
})

gulp.task('release', ['package'], shell.task([
  'hub release create -a signr-chrome.crx -m "signr chrome plugin" v' + manifest.version
]));
