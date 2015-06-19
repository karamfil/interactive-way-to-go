app = angular.module \iwtg, [
	\ui.router
	
	\iwtg.controllers
]

app.config [
	\$interpolateProvider \$locationProvider \$urlMatcherFactoryProvider \$stateProvider 
	($interpolateProvider, $locationProvider, $urlMatcherFactoryProvider, $stateProvider, $http)->
		$interpolateProvider
			.startSymbol	'[['
			.endSymbol		']]'
		
		$locationProvider
			# .html5Mode		true
			.hashPrefix		'!'
		
		$urlMatcherFactoryProvider.strictMode(false)
		
		$stateProvider
			.state \home,
				url			: '/:lang/'
				templateUrl	: \tpl/home/index/
				# resolve		: data: [\$stateParams \$http ($stateParams, $http)-> $http.get "api/home/index/"]
			.state \url,
				url			: \/:lang/:page/
				templateUrl	: -> "pages/#{it.lang}/#{it.page}.html"
				# controller	: [\$scope \response ($scope, response)-> $scope.response = response.data ]
				# resolve		: response: [\$stateParams \$http ($stateParams, $http)-> $http.get "api/#{$stateParams.model}/#{$stateParams.method}/"]
		
		# TODO LOADER
]

app_controllers = angular.module('iwtg.controllers', []);
