# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

myCarouselItemLoadCallback = (carousel, state) ->
  return unless state == 'init'
  $.getJSON("coins", { first: carousel.first, last: carousel.last }, (data) ->
    carousel.add(i + 1, myCarouselGetItemHTML(item)) for item, i in data
    carousel.size(data.length)
  )

myCarouselGetItemHTML = (item) ->
  "<article class=\"coin\">
    <header><img src=\"#{item.image_url}\" alt=\"\" /></header>
    <p>
      <a href=\"#{item.country[1]}\">#{item.country[0]}</a><br />
      <a href=\"#{item.value[1]}\">#{item.value[0]}</a>
    </p>
  </article>"

$(document).ready ->
  $("#account-link").click ->
    $("#account-panel").slideToggle(200)
    return
  $("#mycarousel").jcarousel {
    itemLoadCallback: myCarouselItemLoadCallback,
    scroll: 1
  }
  return

$(document).keydown (e) ->
  $("#account-panel").hide(0) if e.keyCode == 27
