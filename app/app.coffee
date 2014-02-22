Gogo = angular.module('Gogo', ['ngRoute'])

Gogo.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.when('/flight', { templateUrl: 'app/flight.html', controller: 'GogoCtrl'})
  .when('/news', {templateUrl: 'app/news.html', controller: 'GogoCtrl'})
  .when('/leisure', {templateUrl: 'app/leisure.html', controller: 'GogoCtrl'})
  .when("", {
        templateUrl: '/app/news.html',
        controller: 'GogoCtrl'
      })
  .otherwise({ templateUrl: 'app/flight.html', controller: 'GogoCtrl'})
])