var gulp = require('gulp'),
  path = require('path'),
  del = require('del'),
  bower = require('gulp-bower'),
  gutil = require('gulp-util'),
  shell = require('gulp-shell'),
  dest = require('gulp-dest'),
  browserify = require('browserify'),
  pathmodify = require('pathmodify'),
  envify = require('envify'),
  source = require('vinyl-source-stream'),
  buffer = require('vinyl-buffer');

var manifest = require('./assets/chrome/manifest.json');

var pathmodify_mapping = [
  pathmodify.mod.dir('app',path.join(__dirname, 'src'))
]

var entrypoints = [
  'src/app/signr-gmail.coffee'
]

var chrome_assets = [
  "icons/icon16.png",
  "icons/icon48.png",
  "icons/icon128.png",
  "bower_components/gmail.js/src/gmail.js"
]

gulp.task('template', function() {
  entrypoints.forEach(function(file) {
    browserify({
      entries: entrypoints,
      extensions: ['.coffee']
    })
    .plugin(pathmodify(), { mods: pathmodify_mapping })
    .transform('coffeeify')
    .transform('envify')
    .bundle()
    .pipe(source(path.basename(file, '.coffee') + '.js'))
    .pipe(buffer())
    .pipe(gulp.dest('dist/chrome/app'))
    .pipe(gulp.dest('dist/firefox/data'))
  })
})

gulp.task('bower', function() {
  bower();
})

gulp.task('watch', ['package-chrome'], function() {
  gulp.watch('src/**/*.coffee', ['template']);
  gulp.watch('bower.json', ['bower']);
});

gulp.task('default', ['watch'], function() {});

gulp.task('clean', function() {
  del(['dist/*', '*.crx'])
})

gulp.task('package-chrome', ['template'], function() {
  gulp.src(['assets/chrome/content-gmail.js','assets/chrome/manifest.json'])
    .pipe(dest('.'))
    .pipe(gulp.dest('dist/chrome'))

  gulp.src(chrome_assets, {base: '.'})
    .pipe(gulp.dest('dist/chrome'))
    .pipe(shell([
      'crxmake --pack-extension=./dist/chrome --extension-output="signr-chrome.crx" --pack-extension-key=./contrib/signr-chrome.pem'
  ]))
})

gulp.task('release', ['package'], shell.task([
  'hub release create -a signr-chrome.crx -m "signr chrome plugin" v' + manifest.version
]));
