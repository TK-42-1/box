# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->

  $(".company_select").on "change", ->
    $.ajax
      url: "/boxes/update_departments"
      cache: false
      type: "GET"
      data:
        company_id: $('.company_select option:selected').val()
      success: (options) ->
          $('.department_select').html(options)

$(document).ready(ready)
$(document).on('page:load', ready)          