# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $(".company_select").on "change", ->
    $.ajax
      url: "/boxes/update_departments"
      type: "GET"
      data:
        company_id: $('.company_select option:selected').val()
      success: (options) ->
          $('.department_select').html(options)