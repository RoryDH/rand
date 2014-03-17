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
app = angular.module('rand', ['angulartics', 'angulartics.google.analytics'])