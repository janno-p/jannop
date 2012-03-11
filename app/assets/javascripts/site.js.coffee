# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

collectedItemsCount = 0

myCarouselItemLoadCallback = (carousel, state) ->
  return unless state == 'init'
  $.getJSON("coins", { first: carousel.first, last: carousel.last }, (data) ->
    carousel.add(i + 1, myCarouselGetItemHTML(item)) for item, i in data
    carousel.size(data.length)
  )

myCarouselGetItemHTML = (item) ->
  #"<img src=\"#{url}\" width=\"75\" height=\"75\" alt=\"\" />"
  "<p>#{item.nominal_value}</p>"

$(document).ready ->
  $("#account-link").click ->
    $("#account-panel").slideToggle(200)
    return
  $("#mycarousel").jcarousel {
    itemLoadCallback: myCarouselItemLoadCallback
  }
  return

$(document).keydown (e) ->
  $("#account-panel").hide(0) if e.keyCode == 27
