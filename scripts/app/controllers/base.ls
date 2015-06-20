app_controllers.controller \BaseController [\$scope \$state \$sce \TranslationsService !($scope, $state, $sce, TranslationsService)->
	$scope._		= TranslationsService.get
	$scope.$state	= $state
	$scope.$sce		= $sce
]