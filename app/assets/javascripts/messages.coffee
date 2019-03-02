# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#--- Count Input Text ---
# Need "@" top of function.
@ShowTextLength = (str) ->
 document.getElementById("inputlength").innerHTML = str.length;
