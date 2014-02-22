Gogo = angular.module('Gogo', [])

@GogoCtrl =  ['$scope', '$http', '$location', ($scope, $http, $location) ->

#  console.log $location.url()
#  console.log $route.current.templateUrl

  convertDate = (timestamp) ->
    console.log timestamp
    date = new Date(timestamp * 1000)
    day = date.getDay()
    month = date.getMonth()
    year = date.getFullYear()
    formattedDate = "#{month}/#{day}/#{year}"
    return formattedDate

#  console.log convertDate(1296540000)

  searchFlight = (airlineNumber) ->
    url = "http://gogo-test.apigee.net/v1/aircraft/flightno/#{airlineNumber}?apikey=0XOAphNPi8w4nY1LAqVnhlUIPsBDV69Q"
    $http.get(url).success((data, status, headers, config)->
      $scope.flight = data.FlightInfo
    ).error( (data, status, headers, config) ->
      console.log data
      console.log status
      console.log headers
      console.log config
      console.log 'error'
    )

  $scope.todos = [
    {text: 'learn angular', done: true},
    {text: 'build an angular app', done: false}
  ]

  $scope.viewFlight = () ->
    console.log "Flight"
    $location.url("/flight")

  $scope.viewNews = () ->
    $location.url("/news")
    console.log $location.url()

  $scope.viewLeisure = () ->
    $location.url("/leisure")
    console.log $location.url()

  $scope.searchFlight = () ->
    searchFlight($scope.airlineNumberText)

]