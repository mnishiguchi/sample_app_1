# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#new_user_search").on 'ajax:success', (e, users) ->
    $(".users>li").hide()
    ids = (users.map (u) -> "#user_#{u.id}").join(",")
    $(ids).show()

    # For debugging
    # alert(ids)
    # console.log(ids)
