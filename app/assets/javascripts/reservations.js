$(function() {
 
});

function load_form(){


    // $reservation = {
    //     id: 9,
    //     items: [{
    //         id: 
    //         type:
    //         since:
    //         until:
    //         },
    //     ]
    // };


    console.log( reservation );

    jQuery.each(reservation.items, function(){
    console.log( this );
        var checkbox_id;
        var since_id;
        var until_id;
        if ( this.type == 'Room' ){
            checkbox_id = 'reservation_room_'+this.id;
        }else{
            checkbox_id = 'reservation_group_'+this.id;
        }
        since_id = checkbox_id+'_since';
        until_id = checkbox_id+'_until';

        console.log( checkbox_id );
        
        $('#'+checkbox_id).attr('checked',true);
        $('#'+since_id).val(this.since);
        $('#'+until_id).val(this.until);

    });

    load_datepickers();

}

function load_datepickers(){
    
    $('.room_selection').each(function(){
        var datepicker1 = $( '#'+this.id+'_since' );
        var datepicker2 = $( '#'+this.id+'_until' );

        if ( $(this).is(':checked') ){
            datepicker1.show();
            datepicker2.show();
        }

    });

    $('.room_selection').change(function(){
        
        var datepicker1 = $( '#'+this.id+'_since' );
        var datepicker2 = $( '#'+this.id+'_until' );
        
        datepicker1.datepicker( {format: "dd/mm/yyyy", language: "fr"} );
        datepicker2.datepicker( {format: "dd/mm/yyyy", language: "fr"} );

        if ( $(this).is(':checked') ){
            datepicker1.show();
            datepicker2.show();
        }else{
            datepicker1.hide();
            datepicker2.hide();
        }

    });
}