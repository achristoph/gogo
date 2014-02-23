Gogo = angular.module('Gogo', ['ngRoute'])

#Gogo.config( ['$compileProvider', ( $compileProvider ) ->
#  $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|ftp|mailto|chrome-extension):/);
#])

@GogoCtrl =  ['$scope', '$http', '$location', ($scope, $http, $location) ->
  checkLogin = () ->
    url = '/app/login.html'
    if localStorage.getItem('loggedIn')
      url = '/app/flight.html'
      $scope.loggedIn = true
    $scope.templatePage = chrome.extension.getURL(url)

  checkLogin()

  convertDate = (timestamp) ->
    console.log timestamp
    date = new Date(timestamp * 1000)
    day = date.getDay()
    month = date.getMonth()
    year = date.getFullYear()
    formattedDate = "#{month}/#{day}/#{year}"
    return formattedDate

  $scope.login = () ->
    $scope.loggedIn = true
    localStorage.setItem('loggedIn',true)
    $scope.templatePage = chrome.extension.getURL('/app/flight.html')

  $scope.logout = () ->
    console.log 'logout'
    $scope.loggedIn = false
    localStorage.setItem('loggedIn',false)
    $scope.templatePage = chrome.extension.getURL('/app/login.html')

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
        n = {'title': $(this).find('title').text(), 'link': $(this).find('link').text() }
        newsItems.push(n)
      )
      $scope.items = newsItems
    ).error( (data, status, headers, config) ->
      console.log 'Search Failed'
    )

  $scope.viewLeisure = () ->
    $scope.templatePage = chrome.extension.getURL('/app/leisure.html')

  $scope.searchFlight = () ->
    console.log this.airlineNumber
    url = "http://gogo-test.apigee.net/v1/aircraft/flightno/#{this.airlineNumber}?apikey=0XOAphNPi8w4nY1LAqVnhlUIPsBDV69Q"
    $http.get(url).success((data, status, headers, config)->
      $scope.flight = data.FlightInfo
      if (data.FlightInfo.ErrorCode)
        $scope.flightSearchSucceed = false
      else
        $scope.flightSearchSucceed = true

    ).error( (data, status, headers, config) ->
      console.log 'Search failed'
    )

  $scope.openNewsLink = (n) ->
    chrome.tabs.create({url: n.link})

  $scope.flightNotExist = () ->
    return angular.isUndefined($scope.flight)

]
