$(function() {
 
    $('.room_selection').change(function(){
        
        var datepicker1 = $( '#'+this.id+'[since]' );
        var datepicker2 = $( '#'+this.id+'[until]' );
        
        // $.datepicker.setDefaults($.datepicker.regional["es"]);

        datepicker1.datepicker({
            // onSelect: function () {
            //     console.log('onSelect');
            // }
        });
        datepicker2.datepicker();

        if ( $(this).is(':checked') ){
            console.log('show!');
            console.log( datepicker1 );
            datepicker1.show();
            datepicker2.show();
        }else{
            console.log('hide!');
            datepicker1.hide();
            datepicker2.hide();
        }

    });

});