$(function() {
 
    $('.room_selection').change(function(){
        
        var datepicker1 = $( '#'+this.id+'_since' );
        var datepicker2 = $( '#'+this.id+'_until' );
        
        datepicker1.datepicker();
        datepicker2.datepicker();

        if ( $(this).is(':checked') ){
            datepicker1.show();
            datepicker2.show();
        }else{
            datepicker1.hide();
            datepicker2.hide();
        }

    });

});