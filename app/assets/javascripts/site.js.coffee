# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

collectedItemsCount = 0

$(document).ready ->
  $("#account-link").click ->
    $("#account-panel").slideToggle(200)
    false
  collectedItemsCount = $(".anyClass li").length
  $(".anyClass").jCarouselLite
    btnPrev: ".prev",
    btnNext: ".next",
    circular: false,
    mouseWheel: true,
    auto: 3000,
    visible: 5,
    afterEnd: (a) ->
      index = parseInt(a[0].getAttribute("data-index"))
      reserveCount = collectedItemsCount - (a.length + index)
      if (reserveCount < 3)
        $(".test").append "Info: #{index}, More: #{reserveCount}<br />"
      false
  false

$(document).keydown (e) ->
  $("#account-panel").hide(0) if e.keyCode == 27
