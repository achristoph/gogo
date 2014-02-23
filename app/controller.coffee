Gogo = angular.module('Gogo', ['ngRoute'])

#Gogo.config( ['$compileProvider', ( $compileProvider ) ->
#  $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|ftp|mailto|chrome-extension):/);
#])


@GogoCtrl =  ['$scope', '$http', '$location', ($scope, $http, $location) ->
  $scope.templatePage = chrome.extension.getURL('/app/login.html')

  convertDate = (timestamp) ->
    console.log timestamp
    date = new Date(timestamp * 1000)
    day = date.getDay()
    month = date.getMonth()
    year = date.getFullYear()
    formattedDate = "#{month}/#{day}/#{year}"
    return formattedDate

  searchFlight = (airlineNumber) ->
    url = "http://gogo-test.apigee.net/v1/aircraft/flightno/#{airlineNumber}?apikey=0XOAphNPi8w4nY1LAqVnhlUIPsBDV69Q"
    $http.get(url).success((data, status, headers, config)->
      $scope.flight = data.FlightInfo
      if (data.FlightInfo.ErrorCode)
        $scope.flightSearchSucceed = false
      else
        $scope.flightSearchSucceed = true

    ).error( (data, status, headers, config) ->
      alert('Search failed')
    )

  $scope.todos = [
    {text: 'learn angular', done: true},
    {text: 'build an angular app', done: false}
  ]
  $scope.login = () ->
    $scope.loggedIn = true
    $scope.templatePage = chrome.extension.getURL('/app/flight.html')

  $scope.viewLogin = () ->
    $scope.templatePage = chrome.extension.getURL('/app/login.html')

  $scope.viewFlight = () ->
    $scope.templatePage = chrome.extension.getURL('/app/flight.html')

  $scope.viewNews = () ->
    $scope.templatePage = chrome.extension.getURL('/app/news.html')
    url = "http://news.google.com/?output=rss"
    $http.get(url).success((data, status, headers, config)->
      xmlDoc = $.parseXML(data)
      xml = $(xmlDoc)
      items = xml.find("item")
      newsItems = []
      items.each(() ->
        n = {'title': $(this).children().first('title').text(), 'link': $(this).children().first('link').text() }
        newsItems.push(n)
      )
      $scope.items = newsItems
    ).error( (data, status, headers, config) ->
      console.log 'Search Failed'
    )

  $scope.viewLeisure = () ->
    $scope.templatePage = chrome.extension.getURL('/app/leisure.html')

  $scope.searchFlight = () ->
    searchFlight($scope.airlineNumberText)


  $scope.open = () ->
    chrome.tabs.create({url: "http://www.google.com"})

  $scope.flightNotExist = () ->
    return angular.isUndefined($scope.flight)

#  $scope.showFlightSearchError = () ->
#    !$scope.flightNotExist && !flightSearchSucceed
]
