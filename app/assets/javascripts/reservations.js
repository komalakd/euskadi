
function load_reservation_form(){
  load_selects();
  load_rooms();
  add_events();
  calculate_total_amount();
  show_rooms();
  show_page();
}

function load_selects(){

  $("#passenger_select").select2({
    placeholder: "Seleccione un pasajero",
    allowClear: true,
    width: '300px',
    minimumInputLength: 2,
    data: passengers
  }).on('change', function(e){
   $('#reservation_passenger_id').val( e.val );
  });

  var selected_text = '';
  if( reservation.passenger ){
    $("#passenger_select").select2("val", reservation.passenger.id);
  }

  $("#enterprise_select").select2({
    placeholder: "Seleccione una empresa",
    allowClear: true,
    width: '300px',
    minimumInputLength: 2,
    data: enterprises
  }).on('change', function(e){
   $('#reservation_enterprise_id').val( e.val );
  });

  var selected_text = '';
  if( reservation.enterprise ){
    $("#enterprise_select").select2("val", reservation.passenger.id);
  }


  // AJAX PASAJERO

  $('#new_passenger').on('submit', function() { // FIXME - HACK ASQUEROSO
    $('#new_passenger').trigger('submit.rails');
    return false;
  });

  $('#new_passenger').on('ajax:success', function(e, data, status, xhr) { 

    $('#reservation_passenger_id').val(data.id);

    var text = data.name + ' ' + data.lastname + ' (' + data.dni + ')';
    passengers.push( { id: data.id, text: text} );

    $("#passenger_select").select2({ 
      placeholder: "Seleccione un pasajero",
      allowClear: true,
      width: '300px',
      minimumInputLength: 2,
      data: passengers
    });

    $("#passenger_select").select2("val", data.id );

    $('#passenger_modal').modal('toggle');

  }).on('ajax:error', function(e, data, status, xhr) { 

    var messages = '';

    $.each( data.responseJSON, function( field, description ){
      messages += '<li>El ' + passenger_field_names(field) + ' ' + description + '</li>';
    });
    
    var div_errors =
    '<button data-dismiss="alert" class="close" type="button">×</button>'+
      '<p><b>Se encontraron los siguientes errores:</b></p>'+
      '<ul>'+ messages + '</ul>'+
    '</div>';

    $('#passenger_errors').empty().append( div_errors ).show();

  });


  // AJAX EMPRESA

  $('#new_enterprise').on('submit', function() { // FIXME - HACK ASQUEROSO
    $('#new_enterprise').trigger('submit.rails');
    return false;
  });

  $('#new_enterprise').on('ajax:success', function(e, data, status, xhr) { 
console.log( data );
    $('#reservation_enterprise_id').val(data.id);

    var text = data.name + ' (' + data.cuit + ')';
    enterprises.push( { id: data.id, text: text} );

    $("#enterprise_select").select2({ 
      placeholder: "Seleccione una empresa",
      allowClear: true,
      width: '300px',
      minimumInputLength: 2,
      data: enterprises
    });

    $("#enterprise_select").select2("val", data.id );

    $('#enterprise_modal').modal('toggle');

  }).on('ajax:error', function(e, data, status, xhr) { 

    var messages = '';

    $.each( data.responseJSON, function( field, description ){
      messages += '<li>El ' + enterprise_field_names(field) + ' ' + description + '</li>';
    });
    
    var div_errors =
    '<button data-dismiss="alert" class="close" type="button">×</button>'+
      '<p><b>Se encontraron los siguientes errores:</b></p>'+
      '<ul>'+ messages + '</ul>'+
    '</div>';

    $('#enterprise_errors').empty().append( div_errors ).show();

  });



}


function load_rooms(){

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

  });

}


function show_rooms(){
    
  $('.room_check, .group_check').each(function(){
    var datepicker1 = $( '#'+this.id+'_since' );
    var datepicker2 = $( '#'+this.id+'_until' );
    var amount = $( '#'+this.id+'_amount' );
    var total = $( '#'+this.id+'_total' );

    if ( $(this).is(':checked') ){

      datepicker1.datepicker( {format: "dd/mm/yyyy", language: "es"} ).on('changeDate', function(ev){ calculate_total_amount(); });;
      datepicker2.datepicker( {format: "dd/mm/yyyy", language: "es"} ).on('changeDate', function(ev){ calculate_total_amount(); });;

      datepicker1.show();
      datepicker2.show();

      amount.show();
      total.show();
    }

  });

    
}

function add_events(){


  $('.room_check, .group_check').change(function(check){

    var index = this.id.lastIndexOf("_");
    var item_id = this.id.substr(index+1);

    if( $('#'+check.target.id).hasClass('room_check') ){ // FIXME: rooms is undefined
      var group_id = rooms[item_id].group_id;
      if( group_id && $('#reservation_group_'+group_id).is(':checked') ){
        alert('No puedes seleccionar esta habitacion, ya has seleccionado la combinada.');
        $('#'+check.target.id).attr('checked',false);
        return;
      }
    }else{ // groupcheck
      $.each( groups[item_id].rooms, function( index, room_id ){
        if( room_id && $('#reservation_room_'+room_id).is(':checked') ){
          alert('No puedes seleccionar esta combinada, ya has seleccionado una de las habitaciones.');
          $('#'+check.target.id).attr('checked',false);
          return false;
        }
      });

    }

    calculate_total_amount();

    var datepicker1 = $( '#'+this.id+'_since' );
    var datepicker2 = $( '#'+this.id+'_until' );
    var amount = $( '#'+this.id+'_amount' );
    var total = $( '#'+this.id+'_total' );
    
    datepicker1.datepicker( {format: "dd/mm/yyyy", language: "es"} ).on('changeDate', function(ev){ calculate_total_amount(); });
    datepicker2.datepicker( {format: "dd/mm/yyyy", language: "es"} ).on('changeDate', function(ev){ calculate_total_amount(); });

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


  $('.amount').bind('keyup', function(e) {
    if (this.value.match(/^[0-9]{1,14}(\.[0-9]{0,2})?$/) === null) {
      $(this).addClass('invalid_amount');
    } else {
      $(this).removeClass('invalid_amount');
      calculate_total_amount();
    }
  });


}

function show_page(){
  $('#myTab a:first').tab('show');

  $('#myTab a').click(function (e) {
    e.preventDefault();
    $(this).tab('show');
  });
}

function load_map(){
  console.log( reservation_rooms );

  $.each( reservation_rooms, function( rr_id, rr ){ //each rr
    // reservation_id = rr.reservation;
    
    // double loop
    $.each( rr.rooms, function( room ){ //each room
      
      cell_ids = new Array();

      $.each( rr.dates, function( date ){ //each date

        cell_id = rr.dates[date] + '_' + rr.rooms[room];
        // console.log( cell_id );

        cell_ids.push( cell_id );

        $('#'+cell_id).addClass( "map_reservation reserved" ); // FIXME - pasar estado de la reserva
        $('#'+cell_id).click(function(){
          window.location.href = "/reservations/" + rr.reservation;
        });
      });

      // console.log( cell_ids );
      $( '#' + cell_ids[0] ).addClass( "circle_left" );
      $( '#' + cell_ids[cell_ids.length-1] ).addClass( "circle_rigth" );
      

    });
  });

}

function calculate_total_amount(){
  console.log("calculate_total_amount");
  var total = 0;
  $( "input[type=checkbox]" ).each(function() { // FIXME
      if( $(this).is(':checked')) {
          var start = $( '#'+this.id+'_since' ).val();
          var end   = $( '#'+this.id+'_until' ).val();
          var amount = $( '#'+this.id+'_amount' ).val();

          if( !start || !end || !amount ){
            return;
          }

          start = new Date( start.replace( /(\d{2})\/(\d{2})\/(\d{4})/, "$2/$1/$3") );
          end = new Date( end.replace( /(\d{2})\/(\d{2})\/(\d{4})/, "$2/$1/$3") );

          // end - start returns difference in milliseconds 
          var day_difference = new Date(end - start);
          day_difference = day_difference / 24 / 60 / 60 / 1000 ;

          console.log( this.id );
          console.log(amount);
          var subtotal = amount * day_difference;
          if( subtotal < 0 ){
            $( '#'+this.id+'_total' ).val(0);
          }else{
            $( '#'+this.id+'_total' ).val(subtotal);
            total += subtotal;
          }
      }
  });

  $('#reservation_amount').val(total);

}

function passenger_field_names(field){
  if( field == 'dni' )
    return 'DNI'
  else if( field == 'name' )
    return 'Nombre'
  else if( field == 'lastname' )
    return 'Apellido'
  else if( field == 'phone_number' )
    return 'Teléfono'
}

function enterprise_field_names(field){
  if( field == 'cuit' )
    return 'CUIT'
  else if( field == 'name' )
    return 'Razon social'
  else if( field == 'address' )
    return 'Direccion fiscal'
}