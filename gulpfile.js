var gulp = require('gulp'),
  path = require('path'),
  del = require('del'),
  bower = require('gulp-bower'),
  gutil = require('gulp-util'),
  shell = require('gulp-shell'),
  dest = require('gulp-dest'),
  replace = require('gulp-replace'),
  browserify = require('browserify'),
  pathmodify = require('pathmodify'),
  envify = require('envify'),
  source = require('vinyl-source-stream'),
  buffer = require('vinyl-buffer');

var version = '0.0.12'

var pathmodify_mapping = [
  pathmodify.mod.dir('app',path.join(__dirname, 'src'))
]

var entrypoints = [
  'src/app/signr-gmail.coffee'
]

var assets = [
  "icons/icon16.png",
  "icons/icon48.png",
  "icons/icon128.png",
  "bower_components/gmail.js/src/gmail.js"
]

var chrome_assets = [
  'assets/chrome/content-gmail.js',
  'assets/chrome/manifest.json'
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

gulp.task('watch', ['package'], function() {
  gulp.watch('src/**/*.coffee', ['template']);
  gulp.watch('bower.json', ['bower']);
});

gulp.task('default', ['watch'], function() {});

gulp.task('clean', function() {
  del(['dist/*', '*.crx', '*.xpi'])
})

gulp.task('package-chrome', ['template'], function() {
  gulp.src(chrome_assets)
    .pipe(dest('.'))
    .pipe(replace('%VERSION%', version))
    .pipe(gulp.dest('dist/chrome'))

  gulp.src(assets, {base: '.'})
    .pipe(gulp.dest('dist/chrome'))
    .pipe(shell([
      'crxmake --pack-extension=./dist/chrome --extension-output="signr-chrome.crx" --pack-extension-key=./contrib/signr-chrome.pem'
  ]))
})

gulp.task('package-firefox', ['template'], function() {
  gulp.src(assets)
    .pipe(dest('.'))
    .pipe(gulp.dest('dist/firefox/data'))

  gulp.src('assets/firefox/main.js')
    .pipe(dest('.'))
    .pipe(gulp.dest('dist/firefox/lib'))

  gulp.src('assets/firefox/package.json')
    .pipe(dest('.'))
    .pipe(replace('%VERSION%', version))
    .pipe(gulp.dest('dist/firefox'))
    .pipe(shell([
      'cfx xpi --pkgdir=./dist/firefox'
    ]))
})

gulp.task('package', ['package-chrome', 'package-firefox'])

gulp.task('release', ['package'], shell.task([
  'hub release create -a signr-chrome.crx  -a signr-firefox.xpi -m "signr plugin" v' + version
]));
