var gulp = require('gulp');
var bower = require('gulp-bower');
var coffee = require('gulp-coffee');
var gutil = require('gulp-util');
var replace = require('gulp-replace');
var shell = require('gulp-shell');
var fs = require('fs');

var manifest = require('./manifest.json')

gulp.task('template', ['coffee'], function() {
  gulp.src(
    fs.readdirSync('./tmp').map(function(p) { return './tmp/' + p; })
  ).pipe(replace(
    'API_ENDPOINT', process.env.API_ENDPOINT || 'http://localhost:3000'
  )).pipe(gulp.dest('./dist/'));
});

gulp.task('bower', function() {
    bower();
});

gulp.task('coffee', function() {
  gulp.src('./src/*.coffee').pipe(coffee({bare: true})).on('error', gutil.log)
      .pipe(gulp.dest('./tmp/'));
});

gulp.task('watch', function() {
  gulp.watch('./src/*.coffee', ['coffee', 'template']);
  gulp.watch('./bower.json', ['bower']);
});

gulp.task('default', ['bower', 'template', 'watch'], function() {});

gulp.task('package', ['bower', 'template'], shell.task([
  'crxmake --pack-extension=./ --pack-extension-key=./contrib/signr-chrome.pem'
]));

gulp.task('release', ['package'], shell.task([
  'hub release create -a signr-chrome.crx -m "signr chrome plugin" v' + manifest.version
]));
