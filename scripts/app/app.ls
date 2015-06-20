app = angular.module \iwtg, [
	\ui.router
	
	\iwtg.controllers
]

app.config [
	\$interpolateProvider \$locationProvider \$urlMatcherFactoryProvider \$stateProvider
	($interpolateProvider, $locationProvider, $urlMatcherFactoryProvider, $stateProvider)->
		$interpolateProvider
			.startSymbol	'[['
			.endSymbol		']]'
		
		$locationProvider
			# .html5Mode		true
			.hashPrefix		'!'
		
		$urlMatcherFactoryProvider.strictMode(false)
		
		resolvers = 
			lang: [\$stateParams, \TranslationsService ($stateParams, TranslationsService)-> TranslationsService.lang $stateParams.lang ]
		
		$stateProvider
			.state \home,
				url			: ''
				templateUrl	: "/pages/welcome.html"
				# resolve		: data: [\$stateParams \$http ($stateParams, $http)-> $http.get "api/home/index/"]
			.state \url,
				url			: \/:lang/:page/
				templateUrl	: -> "/pages/#{it.page}.html"
				controller	: [ \$rootScope \TranslationsService \translations ($rootScope, TranslationsService, translations)->
					$rootScope.T		= translations.data
					$rootScope.LANG		= TranslationsService.lang_current
				]
				resolve		: translations: resolvers.lang
		
		# TODO LOADER
]

app_controllers = angular.module('iwtg.controllers', []);
