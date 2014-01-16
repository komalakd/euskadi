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
    amount_id = checkbox_id+'_amount';
    total_id = checkbox_id+'_total';

    console.log( checkbox_id );
    
    // Carga de los valores de cada hab
    $('#'+checkbox_id).attr('checked',true);
    $('#'+since_id).val(this.since);
    $('#'+until_id).val(this.until);
    $('#'+amount_id).val(this.amount);
    // $('#'+total_id).val(this.total);

  });

  load_datepickers();
  add_events();

}

function load_datepickers(){
    
  $('.room_selection').each(function(){
    var datepicker1 = $( '#'+this.id+'_since' );
    var datepicker2 = $( '#'+this.id+'_until' );
    var amount = $( '#'+this.id+'_amount' );
    var total = $( '#'+this.id+'_total' );

    if ( $(this).is(':checked') ){

      datepicker1.datepicker( {format: "dd/mm/yyyy", language: "es"} );
      datepicker2.datepicker( {format: "dd/mm/yyyy", language: "es"} );

      datepicker1.show();
      datepicker2.show();

      amount.show();
      total.show();
    }

  });

    
}

function add_events(){

  $('.room_selection').change(function(){
      
    var datepicker1 = $( '#'+this.id+'_since' );
    var datepicker2 = $( '#'+this.id+'_until' );
    var amount = $( '#'+this.id+'_amount' );
    var total = $( '#'+this.id+'_total' );
    
    datepicker1.datepicker( {format: "dd/mm/yyyy", language: "es"} );
    datepicker2.datepicker( {format: "dd/mm/yyyy", language: "es"} );

    if ( $(this).is(':checked') ){
      datepicker1.show();
      datepicker2.show();
      amount.show();
      total.show();
    }else{
      datepicker1.hide();
      datepicker2.hide();
      amount.hide();
      total.hide();
    }

  });
}

function load_pages(){
  $('#myTab a:first').tab('show');

  $('#myTab a').click(function (e) {
    e.preventDefault();
    $(this).tab('show');
  });
}