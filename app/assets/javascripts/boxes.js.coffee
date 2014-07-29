# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  # Update departments when company selected in box form
  $(".company_select").on "change", ->
    $.ajax
      url: "/boxes/update_departments"
      cache: false
      type: "GET"
      data:
        company_id: $('.company_select option:selected').val()
      success: (options) ->
          $('.department_select').html(options)

# requires page to load fully before starting jquery
$(document).ready(ready)
$(document).on('page:load', ready)          

# select all checkbox in box index
$ ->
  $(".checkall").on "click", ->
    $(this).closest("fieldset").find(":checkbox").prop "checked", @checked
