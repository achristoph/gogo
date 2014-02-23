Gogo = angular.module('Gogo', ['ngRoute'])

#Gogo.config( ['$compileProvider', ( $compileProvider ) ->
#  $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|ftp|mailto|chrome-extension):/);
#])

@GogoCtrl = ['$scope', '$http', '$location', ($scope, $http, $location) ->
  searchNews = () ->
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
    ).error((data, status, headers, config) ->
      console.log 'Search Failed'
    )
  searchFlight = (airlineNumber) ->
    url = "http://gogo-test.apigee.net/v1/aircraft/flightno/#{airlineNumber}?apikey=0XOAphNPi8w4nY1LAqVnhlUIPsBDV69Q"
    $http.get(url).success((data, status, headers, config)->
      $scope.flight = data.FlightInfo

      if (data.FlightInfo.ErrorCode)
        console.log data
        $scope.flightSearchSucceed = false
      else
        departureTime = data.FlightInfo.Departure.DepartureTime
        arrivalTime = data.FlightInfo.Destination.ArrivalTime
        data.FlightInfo.Departure.DepartureTime = moment(departureTime).format("dddd, MMMM Do YYYY, h:mm:ss a")
        data.FlightInfo.Destination.ArrivalTime = moment(arrivalTime).format("dddd, MMMM Do YYYY, h:mm:ss a")

        $scope.flightFound = true
        $scope.flightSearchSucceed = true

    ).error((data, status, headers, config) ->
      console.log 'Search failed'
    )

  checkLogin = () ->
    url = '/app/login.html'
    if localStorage.getItem('loggedIn')
      $scope.loggedIn = true
      url = '/app/flight.html'
      if localStorage.getItem('url')
        url = localStorage.getItem('url')
        if url == '/app/news.html'
          searchNews()
    #        else if url == '/app/flight.html'
    #          airlineNumber = localStorage.getItem('airlineNumber')
    #          if airlineNumber
    #            searchFlight(airlineNumber)

    $scope.templatePage = chrome.extension.getURL(url)

  checkLogin()

  $scope.login = () ->
    $scope.loggedIn = true
    localStorage.setItem('loggedIn', true)
    $scope.templatePage = chrome.extension.getURL('/app/flight.html')

  $scope.logout = () ->
    $scope.loggedIn = false
    localStorage.setItem('loggedIn', false)
    $scope.templatePage = chrome.extension.getURL('/app/login.html')

  $scope.viewLogin = () ->
    $scope.templatePage = chrome.extension.getURL('/app/login.html')

  $scope.viewFlight = () ->
    $scope.templatePage = chrome.extension.getURL('/app/flight.html')
    localStorage.setItem('url', '/app/flight.html')

  $scope.viewNews = () ->
    $scope.templatePage = chrome.extension.getURL('/app/news.html')
    localStorage.setItem('url', '/app/news.html')
    searchNews()

  searchTopMovies = () ->
    topMovies = []

    $.getJSON('../videoCatalog.json').done((data)->
      _.each(data.Entries, (element, index, list) ->
        x = _.find(element["@categories"].split(","), (n) ->
          n == "2"
        )
        if x == "2"
          element["@duration"] = parseInt(element["@duration"]) / 60
          topMovies.push(element)
      )
#      console.log topMovies
      $scope.$apply () ->
        $scope.movies = topMovies
    )

  $scope.viewLeisure = () ->
    $scope.templatePage = chrome.extension.getURL('/app/leisure.html')
    localStorage.setItem('url', '/app/leisure.html')
    searchTopMovies()

  $scope.searchFlight = () ->
    searchFlight(this.airlineNumber)
    localStorage.setItem('airlineNumber', this.airlineNumber)

  $scope.changeFlight = () ->
    $scope.flightFound = false
    $scope.flight = undefined

  $scope.openNewsLink = (n) ->
    chrome.tabs.create({url: n.link})

  $scope.flightNotExist = () ->
    return angular.isUndefined($scope.flight)



]
