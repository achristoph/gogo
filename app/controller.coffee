@TodoCtrl = ['$scope','$http', ($scope,$http) ->
#  url = 'http://www.google.com'
  url = 'http://localhost:63343/gogo/videoCatalog.json'
#  $.JSON()
  $http.get(url).success( (data,status,headers,config)->
    console.log data
    console.log status
    console.log headers
    console.log config
    console.log "success"
  ).error( ()->
    console.log 'error'
  )



  $scope.todos = [
    {text:'learn angular', done:true},
    {text:'build an angular app', done:false}]
]