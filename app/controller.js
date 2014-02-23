// Generated by CoffeeScript 1.7.1
(function() {
  var Gogo;

  Gogo = angular.module('Gogo', ['ngRoute']);

  this.GogoCtrl = [
    '$scope', '$http', '$location', function($scope, $http, $location) {
      var checkLogin, searchFlight, searchNews, searchTopMovies;
      searchNews = function() {
        var url;
        url = "http://news.google.com/?output=rss";
        return $http.get(url).success(function(data, status, headers, config) {
          var items, newsItems, xml, xmlDoc;
          xmlDoc = $.parseXML(data);
          xml = $(xmlDoc);
          items = xml.find("item");
          newsItems = [];
          items.each(function() {
            var n;
            n = {
              'title': $(this).find('title').text(),
              'link': $(this).find('link').text()
            };
            return newsItems.push(n);
          });
          return $scope.items = newsItems;
        }).error(function(data, status, headers, config) {
          return console.log('Search Failed');
        });
      };
      searchFlight = function(airlineNumber) {
        var url;
        url = "http://gogo-test.apigee.net/v1/aircraft/flightno/" + airlineNumber + "?apikey=0XOAphNPi8w4nY1LAqVnhlUIPsBDV69Q";
        return $http.get(url).success(function(data, status, headers, config) {
          var arrivalTime, departureTime;
          $scope.flight = data.FlightInfo;
          if (data.FlightInfo.ErrorCode) {
            console.log(data);
            return $scope.flightSearchSucceed = false;
          } else {
            departureTime = data.FlightInfo.Departure.DepartureTime;
            arrivalTime = data.FlightInfo.Destination.ArrivalTime;
            data.FlightInfo.Departure.DepartureTime = moment(departureTime).format("dddd, MMMM Do YYYY, h:mm:ss a");
            data.FlightInfo.Destination.ArrivalTime = moment(arrivalTime).format("dddd, MMMM Do YYYY, h:mm:ss a");
            $scope.flightFound = true;
            return $scope.flightSearchSucceed = true;
          }
        }).error(function(data, status, headers, config) {
          return console.log('Search failed');
        });
      };
      checkLogin = function() {
        var url;
        url = '/app/login.html';
        if (localStorage.getItem('loggedIn')) {
          $scope.loggedIn = true;
          url = '/app/flight.html';
          if (localStorage.getItem('url')) {
            url = localStorage.getItem('url');
            if (url === '/app/news.html') {
              searchNews();
            }
          }
        }
        return $scope.templatePage = chrome.extension.getURL(url);
      };
      checkLogin();
      $scope.login = function() {
        $scope.loggedIn = true;
        localStorage.setItem('loggedIn', true);
        return $scope.templatePage = chrome.extension.getURL('/app/flight.html');
      };
      $scope.logout = function() {
        $scope.loggedIn = false;
        localStorage.setItem('loggedIn', false);
        return $scope.templatePage = chrome.extension.getURL('/app/login.html');
      };
      $scope.viewLogin = function() {
        return $scope.templatePage = chrome.extension.getURL('/app/login.html');
      };
      $scope.viewFlight = function() {
        $scope.templatePage = chrome.extension.getURL('/app/flight.html');
        return localStorage.setItem('url', '/app/flight.html');
      };
      $scope.viewNews = function() {
        $scope.templatePage = chrome.extension.getURL('/app/news.html');
        localStorage.setItem('url', '/app/news.html');
        return searchNews();
      };
      searchTopMovies = function() {
        var topMovies;
        topMovies = [];
        return $.getJSON('../videoCatalog.json').done(function(data) {
          _.each(data.Entries, function(element, index, list) {
            var x;
            x = _.find(element["@categories"].split(","), function(n) {
              return n === "2";
            });
            if (x === "2") {
              element["@duration"] = parseInt(element["@duration"]) / 60;
              return topMovies.push(element);
            }
          });
          return $scope.$apply(function() {
            return $scope.movies = topMovies;
          });
        });
      };
      $scope.viewLeisure = function() {
        $scope.templatePage = chrome.extension.getURL('/app/leisure.html');
        localStorage.setItem('url', '/app/leisure.html');
        return searchTopMovies();
      };
      $scope.searchFlight = function() {
        searchFlight(this.airlineNumber);
        return localStorage.setItem('airlineNumber', this.airlineNumber);
      };
      $scope.changeFlight = function() {
        $scope.flightFound = false;
        return $scope.flight = void 0;
      };
      $scope.openNewsLink = function(n) {
        return chrome.tabs.create({
          url: n.link
        });
      };
      return $scope.flightNotExist = function() {
        return angular.isUndefined($scope.flight);
      };
    }
  ];

}).call(this);

//# sourceMappingURL=controller.map
