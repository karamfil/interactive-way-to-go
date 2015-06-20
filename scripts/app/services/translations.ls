app.service \TranslationsService [ \$http !($http)->
	@lang_current = null;
	@translations = {};
	
	@lang = ~>
		if @lang_current != it
			@lang_current = it
			$http.get "/translations/#it.json" .success !~> @translations = it
		else
			@translations
	
	@get = ~> @translations[it] or it
]