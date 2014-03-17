app.controller "MainCtrl", ($scope, $http, $analytics) ->
  $scope.start = (restart) ->
    $scope.hasChosen = false
    $scope.chosen = null
    $scope.numberOptions = shuffle(range(0, 9))
    $analytics.eventTrack('restart', { category: 'science' }) if restart

  $scope.gotIt = ->
    $scope.ready = true
    $analytics.eventTrack('got_it', { category: 'science' })

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
    $analytics.eventTrack('choose_number', { category: 'science' })
