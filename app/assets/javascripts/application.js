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
//= require bootstrap


// FIXME - pasar a reservations.js
$(function() {

    $('.room_selection').change(function(){
        
        console.log( '#'+this.id+'_dp' );
        
        var datepicker1 = $( '#'+this.id+'_dp1' );
        var datepicker2 = $( '#'+this.id+'_dp2' );
        
        // $.datepicker.setDefaults($.datepicker.regional["es"]);

        datepicker1.datepicker({
            onSelect: function () {
                console.log('onSelect');
            }
        });
        datepicker2.datepicker();

        if ( $(this).is(':checked') ){
            console.log('show!');
            datepicker1.show();
            datepicker2.show();
        }else{
            console.log('hide!');
            datepicker1.hide();
            datepicker2.hide();
        }

    });

});