# Adds/removes a search condition.
# Reference: http://railscasts.com/episodes/370-ransack

jQuery ->
  # Search button is initially hidden.
  if $(".field").length == 0
    $("#user_search_button").hide()

  $('form').on 'click', '.remove_fields', (event) ->
    $(this).closest('.field').remove()
    event.preventDefault()

    if $(".field").length == 0
      $("#user_search_button").hide()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

    button = $("#user_search_button")
    if !button.is(":visible")
      button.show()
