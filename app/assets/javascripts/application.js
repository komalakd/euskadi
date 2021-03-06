// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require bootstrap.min
//= require select2

$(function() {

  load_select2_locale();



$('.datepicker').keydown(function() {
  //code to not allow any changes to be made to input field
  return false;
});


  

});

function load_select2_locale(){
  "use strict";
  $.extend($.fn.select2.defaults, {
    formatNoMatches: function () { return "No se encontraron resultados"; },
    formatInputTooShort: function (input, min) { var n = min - input.length; return "Por favor, introduzca " + n + " car" + (n == 1? "ácter" : "acteres"); },
    formatInputTooLong: function (input, max) { var n = input.length - max; return "Por favor, elimine " + n + " car" + (n == 1? "ácter" : "acteres"); },
    formatSelectionTooBig: function (limit) { return "Sólo puede seleccionar " + limit + " elemento" + (limit == 1 ? "" : "s"); },
    formatLoadMore: function (pageNumber) { return "Cargando más resultados…"; },
    formatSearching: function () { return "Buscando…"; }
  });
}
