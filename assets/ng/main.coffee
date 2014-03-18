# Random stuff
# document.addEventListener("touchstart", (-> ), false)

range = (s, e) ->
  [s..e]

shuffle = (array) ->
  counter = array.length
  temp = undefined
  index = undefined

  while (counter > 0)
    index = Math.floor(Math.random() * counter)
    counter--
    temp = array[counter]
    array[counter] = array[index]
    array[index] = temp
  array

# NG
app = angular.module('rand', ['ngRoute', 'angulartics', 'angulartics.google.analytics'])

app.config(($routeProvider) ->
  $routeProvider.when('/', {
    templateUrl: 'home',
    controller: 'MainCtrl'
  }).when('/results', {
    templateUrl: 'results',
    controller: 'ResultsCtrl'
  }).otherwise({
    controller: 'NotFoundCtrl',
    templateUrl: 'notFound'
  })
)
