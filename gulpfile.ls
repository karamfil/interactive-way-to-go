require! [ \gulp \gulp-load-plugins \merge2 ]

# server = tinyLr()
$ = gulpLoadPlugins(/*lazy: false*/)

paths =
	SCSS_SRC		: \scss/*.scss,
	SCSS_DST		: \styles/
	
	VENDOR_SRC		: [ \scripts/vendor/*.js \scripts/vendor/**/*.js ]
	LIVESCRIPT_SRC	: [ \scripts/app/*.ls \scripts/app/**/*.ls ]
	SCRIPT_DST		: \javascripts/
	
	HTML_SRC			: [ \*.html \**/*.html ]

gulp.task \livescript, ->
	merge2(
		gulp.src paths.VENDOR_SRC
		gulp.src paths.LIVESCRIPT_SRC
			.pipe $.plumber!
			.pipe $.sourcemaps.init!
			.pipe $.livescript(bare: true)
			.pipe $.sourcemaps.write!
	)
		# .pipe $.cached \scripts
		.pipe $.concat \app.js
		.pipe $.chmod owner: { +read, +write }, group: { +read }, others: { +read }
		.pipe gulp.dest paths.SCRIPT_DST
		.pipe $.livereload!

gulp.task \html, ->
	gulp.src paths.HTML_SRC
		.pipe $.cached!
		.pipe $.livereload!

gulp.task \scss, ->
	gulp.src paths.SCSS_SRC
		.pipe $.cached!
		.pipe $.sourcemaps.init!
		.pipe $.sass!
		.pipe $.sourcemaps.write!
		.pipe $.livereload!
		.pipe gulp.dest paths.SCSS_DST
		

gulp.task \watch, ->
	$.livereload.listen!
	
	gulp.watch paths.VENDOR_SRC ++ paths.LIVESCRIPT_SRC, [ \livescript ]
	gulp.watch paths.SCSS_SRC, [ \scss ]
	gulp.watch paths.HTML_SRC, [ \html ]

gulp.task \default, [ \watch \livescript \scss ]
