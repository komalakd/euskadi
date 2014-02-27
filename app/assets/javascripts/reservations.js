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

  // monto por cada combinada
  jQuery.each(groups, function(group_id, group){
    $('#reservation_group_'+group_id+'_amount').val(this.amount);
  });

  // monto por cada tipo_habitacion
  jQuery.each(room_types, function(room_type_id, room_type){
    jQuery.each(room_type.rooms, function(room_id){
      $('#reservation_room_'+room_id+'_amount').val(room_type.amount);
    });
  });

  jQuery.each(reservation.items, function(){

    var checkbox_id;
    var amount;
    if ( this.type == 'Room' ){
      checkbox_id = 'reservation_room_'+this.id;
    }else{
      checkbox_id = 'reservation_group_'+this.id;
    }
    var since_id = checkbox_id+'_since';
    var until_id = checkbox_id+'_until';
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

function load_map(){ // TODO
  console.log( reservation_rooms );

  $.each( reservation_rooms, function( rr_id, rr ){ //each rr
    reservation_id = rr.reservation;
    
    // double loop
    $.each( rr.rooms, function( room ){ //each room
      
      cell_ids = new Array();

      $.each( rr.dates, function( date ){ //each date

        cell_id = rr.dates[date] + '_' + rr.rooms[room];
        console.log( cell_id );

        cell_ids.push( cell_id );

        $('#'+cell_id).addClass( "reserved" ); // FIXME - pasar estado de la reserva
        $('#'+cell_id).click(function(){
          window.location.href = "/reservations/" + reservation_id;
        });
      });

      console.log( cell_ids );
      $( '#' + cell_ids[0] ).addClass( "circle_left" );
      $( '#' + cell_ids[cell_ids.length-1] ).addClass( "circle_rigth" );
      

    });
  });

}

function calculate_total_amount(){
  console.log("calculate_total_amount");
  var total = 0;
  $( "input[type=checkbox]" ).each(function() {
      if( $(this).is(':checked')) {
          console.log("checked");
          // var since = $( '#'+this.id+'_since' );
          // var until = $( '#'+this.id+'_until' );

          var start = $( '#'+this.id+'_since' ).val();
          var end   = $( '#'+this.id+'_until' ).val();

          start = new Date( start.replace( /(\d{2})\/(\d{2})\/(\d{4})/, "$2/$1/$3") );
          end = new Date( end.replace( /(\d{2})\/(\d{2})\/(\d{4})/, "$2/$1/$3") );

          // end - start returns difference in milliseconds 
          var day_difference = new Date(end - start);
          day_difference = day_difference / 24 / 60 / 60 / 1000 ;

          console.log( this.id );
          var amount = $( '#'+this.id+'_amount' ).val();
          console.log(amount);
          var subtotal = amount * day_difference;
          $( '#'+this.id+'_total' ).val(subtotal);
          total += subtotal;
      }
  });

  $('#reservation_amount').val(total);

}