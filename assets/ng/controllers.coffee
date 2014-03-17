app.controller "MainCtrl", ($scope, $http) ->
  $scope.start = ->
    $scope.hasChosen = false
    $scope.chosen = null
    $scope.numberOptions = shuffle(range(0, 9))

  $scope.start()

  $http.post('/u', null)
  .success((data, status, headers, config) ->
    $scope.ready = !data.new
    $scope.js = true
  ).error((data, status, headers, config) ->
  )

  $scope.choose = (n) ->
    $scope.chosen = n
    $scope.hasChosen = true
    $http.post('/rs',
      num: n
      j_time: Date()
    ).success((data, status, headers, config) ->
      $scope.ready = !data.new
      $scope.js = true
    ).error((data, status, headers, config) ->
    )
