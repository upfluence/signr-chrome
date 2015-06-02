var gulp = require('gulp'),
    path = require('path'),
    del = require('del'),
    gutil = require('gulp-util'),
    shell = require('gulp-shell'),
    browserify = require('browserify'),
    pathmodify = require('pathmodify'),
    envify = require('envify'),
    source = require('vinyl-source-stream'),
    buffer = require('vinyl-buffer');

var manifest = require('./manifest.json');

var pathmodify_mapping = [
  pathmodify.mod.dir('app',path.join(__dirname, 'src'))
]

var entrypoints = [
  'src/content_scripts/gmail.coffee'
]

var assets = [
  "icons/icon16.png",
  "icons/icon48.png",
  "icons/icon128.png",
  "manifest.json"
]

gulp.task('template', function() {
 browserify({
    entries: entrypoints,
    extensions: ['.coffee']
  })
  .plugin(pathmodify(), { mods: pathmodify_mapping })
  .transform('coffeeify')
  .transform('envify')
  .bundle()
  .pipe(source('gmail.js'))
  .pipe(buffer())
  .pipe(gulp.dest('dist/'))
})

//gulp.task('template', function() {
  //gulp.src(
    //'src/*.coffee'
  //).pipe(coffee({bare: true})).on('error', gutil.log)
   //.pipe(replace(
    //'API_ENDPOINT', process.env.API_ENDPOINT || 'http://localhost:3000'
  //)).pipe(replace(
    //'APP_ENDPOINT', process.env.APP_ENDPOINT || 'http://localhost:4200'
  //)).pipe(gulp.dest('dist/'));
//});

gulp.task('watch', ['package'], function() {
  gulp.watch('src/**/*.coffee', ['template']);
});

gulp.task('default', ['watch'], function() {});

gulp.task('clean', function() {
  del(['dist/*', '*.crx'])
})

gulp.task('package', ['template'], function() {
  gulp.src(assets, {base: '.'})
      .pipe(gulp.dest('dist'))
      .pipe(shell([
        'crxmake --pack-extension=./dist --extension-output="signr-chrome.crx" --pack-extension-key=./contrib/signr-chrome.pem'
      ]))
})

gulp.task('release', ['package'], shell.task([
  'hub release create -a signr-chrome.crx -m "signr chrome plugin" v' + manifest.version
]));
