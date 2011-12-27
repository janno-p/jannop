# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $("#account-link").click ->
    $("#account-panel").slideToggle(200)
    false

$(document).keydown (e) ->
  $("#account-panel").hide(0) if e.keyCode == 27
