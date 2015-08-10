var gulp = require('gulp'),
  path = require('path'),
  exec = require('child_process').exec,
  del = require('del'),
  bower = require('gulp-bower'),
  gutil = require('gulp-util'),
  shell = require('gulp-shell'),
  dest = require('gulp-dest'),
  zip = require('gulp-zip'),
  replace = require('gulp-replace'),
  browserify = require('browserify'),
  pathmodify = require('pathmodify'),
  envify = require('envify'),
  source = require('vinyl-source-stream'),
  buffer = require('vinyl-buffer'),
  es = require('event-stream');

var version = '0.0.24';

var pathmodify_mapping = [
  pathmodify.mod.dir('app',path.join(__dirname, 'src')),
  pathmodify.mod.dir('bower_components',path.join(__dirname, 'bower_components'))
];

var entrypoints = [
  'src/app/signr-gmail.coffee',
  'src/app/signr-inbox.coffee',
  'src/app/signr.coffee'
];

var assets = [
  "icons/icon16.png",
  "icons/icon48.png",
  "icons/icon128.png",
];

gulp.task('template', function() {
  streams = entrypoints.map(function(file) {
    return browserify({
      entries: file,
      extensions: ['.coffee']
    })
    .plugin(pathmodify(), { mods: pathmodify_mapping })
    .transform('coffeeify')
    .transform('envify')
    .bundle()
    .on('error', gutil.log)
    .pipe(source(path.basename(file, '.coffee') + '.js'))
    .pipe(buffer())
    .pipe(gulp.dest('dist/chrome/app'))
    .pipe(gulp.dest('dist/firefox/data'))
  })
  return es.merge.apply(null, streams)
});

gulp.task('bower', function() {
  bower();
});

gulp.task('watch', ['package'], function() {
  gulp.watch('src/**/*.coffee', ['template']);
  gulp.watch('bower.json', ['bower']);
});

gulp.task('default', ['watch'], function() {});

gulp.task('clean', function() {
  return del(['dist/*', '*.crx', '*.zip','*.xpi'])
});

gulp.task('manifest-chrome', function() {
  return gulp.src('assets/chrome/manifest.json')
    .pipe(dest('.'))
    .pipe(replace('%VERSION%', version))
    .pipe(gulp.dest('dist/chrome'))
});

gulp.task('assets-chrome', ['template', 'manifest-chrome'], function() {
  return gulp.src(assets, {base: '.'})
    .pipe(gulp.dest('dist/chrome'))
});

gulp.task('firefox-data', function() {
   return gulp.src(assets)
    .pipe(dest('.'))
    .pipe(gulp.dest('dist/firefox/data'))
});

gulp.task('firefox-lib', function() {
  return gulp.src('assets/firefox/main.js')
    .pipe(dest('.'))
    .pipe(gulp.dest('dist/firefox/lib'))
});

gulp.task('assets-firefox', ['template', 'firefox-data', 'firefox-lib'], function() {
  return gulp.src('assets/firefox/package.json')
    .pipe(dest('.'))
    .pipe(replace('%VERSION%', version))
    .pipe(gulp.dest('dist/firefox'))
});

gulp.task('package-chrome-zip', ['assets-chrome'], function() {
  return gulp.src('dist/chrome/**/*')
      .pipe(zip('signr-chrome.zip'))
      .pipe(gulp.dest('.'))
});

gulp.task('package-chrome', ['package-chrome-zip'], shell.task([
  'crxmake --pack-extension=./dist/chrome --extension-output="./signr-chrome.crx"'
]));

gulp.task('package-firefox', ['assets-firefox'], shell.task([
  'cfx xpi --pkgdir=./dist/firefox'
]));

gulp.task('package', ['package-chrome', 'package-firefox'])

gulp.task('opbeat-release', shell.task([
  'curl https://intake.opbeat.com/api/v1/organizations/9fab231fcf4d4dcd9cd6d8e5ab4a4841/apps/badf3dcff7/releases/ \
    -H "Authorization: Bearer ' + process.env.OPBEAT_BEARER + '" \
    -d rev=`git log -n 1 --pretty=format:%H` \
    -d branch=`git rev-parse --abbrev-ref HEAD` \
    -d status=completed'
]));

gulp.task('release', ['package', 'opbeat-release'], shell.task([
  'hub release create -a signr-chrome.crx -a signr-chrome.zip -a signr-firefox.xpi -m "signr plugin" v' + version
]));

gulp.task('ci-release', ['package-chrome', 'opbeat-release'], shell.task([
  'hub release create -a signr-chrome.crx -a signr-chrome.zip -m "signr plugin" v' + version
]));
