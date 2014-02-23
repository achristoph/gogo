// Generated by CoffeeScript 1.7.1
(function() {
  var Gogo;

  Gogo = angular.module('Gogo', ['ngRoute']);

  this.GogoCtrl = [
    '$scope', '$http', '$location', function($scope, $http, $location) {
      var convertDate, searchFlight;
      $scope.templatePage = chrome.extension.getURL('/app/login.html');
      convertDate = function(timestamp) {
        var date, day, formattedDate, month, year;
        console.log(timestamp);
        date = new Date(timestamp * 1000);
        day = date.getDay();
        month = date.getMonth();
        year = date.getFullYear();
        formattedDate = "" + month + "/" + day + "/" + year;
        return formattedDate;
      };
      searchFlight = function(airlineNumber) {
        var url;
        url = "http://gogo-test.apigee.net/v1/aircraft/flightno/" + airlineNumber + "?apikey=0XOAphNPi8w4nY1LAqVnhlUIPsBDV69Q";
        return $http.get(url).success(function(data, status, headers, config) {
          $scope.flight = data.FlightInfo;
          if (data.FlightInfo.ErrorCode) {
            return $scope.flightSearchSucceed = false;
          } else {
            return $scope.flightSearchSucceed = true;
          }
        }).error(function(data, status, headers, config) {
          return alert('Search failed');
        });
      };
      $scope.todos = [
        {
          text: 'learn angular',
          done: true
        }, {
          text: 'build an angular app',
          done: false
        }
      ];
      $scope.login = function() {
        $scope.loggedIn = true;
        return $scope.templatePage = chrome.extension.getURL('/app/flight.html');
      };
      $scope.viewLogin = function() {
        return $scope.templatePage = chrome.extension.getURL('/app/login.html');
      };
      $scope.viewFlight = function() {
        return $scope.templatePage = chrome.extension.getURL('/app/flight.html');
      };
      $scope.viewNews = function() {
        var url;
        $scope.templatePage = chrome.extension.getURL('/app/news.html');
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
              'title': $(this).children().first('title').text(),
              'link': $(this).children().first('link').text()
            };
            return newsItems.push(n);
          });
          return $scope.items = newsItems;
        }).error(function(data, status, headers, config) {
          return console.log('Search Failed');
        });
      };
      $scope.viewLeisure = function() {
        return $scope.templatePage = chrome.extension.getURL('/app/leisure.html');
      };
      $scope.searchFlight = function() {
        return searchFlight($scope.airlineNumberText);
      };
      $scope.open = function() {
        return chrome.tabs.create({
          url: "http://www.google.com"
        });
      };
      return $scope.flightNotExist = function() {
        return angular.isUndefined($scope.flight);
      };
    }
  ];

}).call(this);

//# sourceMappingURL=controller.map
