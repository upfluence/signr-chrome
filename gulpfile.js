var gulp = require('gulp'),
  path = require('path'),
  del = require('del'),
  bower = require('gulp-bower'),
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
  'src/app/signr-gmail.coffee',
  'src/app/signr-inbox.coffee'
]

var assets = [
  "icons/icon16.png",
  "icons/icon48.png",
  "icons/icon128.png",
  "bower_components/gmail.js/src/gmail.js",
  "assets/content-gmail.js",
  "manifest.json"
]

gulp.task('template', function() {
  entrypoints.forEach(function(file) {
    browserify({
      entries: file,
      extensions: ['.coffee']
    })
    .plugin(pathmodify(), { mods: pathmodify_mapping })
    .transform('coffeeify')
    .transform('envify')
    .bundle()
    .pipe(source(path.basename(file, '.coffee') + '.js'))
    .pipe(buffer())
    .pipe(gulp.dest('dist/app'))
  })
})

gulp.task('bower', function() {
  bower();
})

gulp.task('watch', ['package'], function() {
  gulp.watch('src/**/*.coffee', ['template']);
  gulp.watch('bower.json', ['bower']);
});

gulp.task('default', ['watch'], function() {});

gulp.task('clean', function() {
  del(['dist/*', '*.crx'])
})

gulp.task('package', ['template'], function() {
  gulp.src(assets, {base: '.'})
  .pipe(gulp.dest('dist'))
  .pipe(shell([
    'crxmake --pack-extension=./dist --extension-output="./signr-chrome.crx" --pack-extension-key=./contrib/signr-chrome.pem'
  ]))
})

gulp.task('release', ['package'], shell.task([
  'hub release create -a signr-chrome.crx -m "signr chrome plugin" v' + manifest.version
]));
