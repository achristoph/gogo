Gogo = angular.module('Gogo', [])

@GogoCtrl =  ['$scope', '$http', '$location', ($scope, $http, $location) ->
  $("#flight").hide()
  $("#news").hide()
  $("#leisure").hide()

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
      console.log data.FlightInfo
      if (data.FlightInfo.ErrorCode)
        $scope.flightSearchSucceed = false
      else
        $scope.flightSearchSucceed = true

    ).error( (data, status, headers, config) ->
      alert('Search failed')
    )

  searchNews = () ->
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

  searchNews()

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

  $scope.searchNews = () ->
    console.log $scope.news

  $scope.open = () ->
    chrome.tabs.create({url: "http://www.google.com"})

  $scope.flightNotExist = () ->
    return angular.isUndefined($scope.flight)
#
#  $scope.showFlightSearchError = () ->
#    !$scope.flightNotExist && !flightSearchSucceed
]