# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $("#close").live "click", ->
    $("#js-do-comment, #js-comment-and-close, #js-task-rating").toggleClass "hide"

  $("#comment_message").live "keydown", (e)->
    if e.ctrlKey && e.keyCode is 13
      $(this).closest("form").submit()
