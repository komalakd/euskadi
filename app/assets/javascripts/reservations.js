
function load_reservation_form(){
  load_typeaheads();
  load_rooms();
  add_events();
  calculate_total_amount();
  show_rooms();
  show_page();
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
          $( '#'+this.id+'_total' ).val(subtotal);
          total += subtotal;
      }
  });

  $('#reservation_amount').val(total);

}

function load_typeaheads(){
  if( reservation.passenger ){
    $('#passenger_search').val( reservation.passenger.passenger_denomination );
  }

  if( reservation.enterprise ){ 
    $('#enterprise_search').val( reservation.enterprise.enterprise_denomination );
  }

  $('#passenger_search').typeahead({ // http://tatiyants.com/how-to-use-json-objects-with-twitter-bootstrap-typeahead/
    
    source: function (query, process) {
        // $.ajax({
        //   url: "",
        //   type: "get",
        //   data: this.value,
        //   success: function(response){
        //       // var json = $.parseJSON(response);
        //       alert("success");
        //       // $("#result").html('Submitted successfully');
        //   },
        //   error:function(){
        //       alert("failure");
        //       // $("#result").html('There is error while submit');
        //   }
        // });

      matches = [];
      map = {};
   
      // var data = [
      //   {"passenger_id": "CA", "dni": "California"},
      //   {"passenger_id": "AZ", "dni": "Arizona"},
      //   {"passenger_id": "NY", "dni": "New York"},
      //   {"passenger_id": "NV", "dni": "Nevada"},
      //   {"passenger_id": "OH", "dni": "Ohio"}
      // ];
   
      $.each(passengers, function (i, passenger) {
        // var passenger_denomination = passenger.dni + ' (' + passenger.name + ')';
        map[passenger.passenger_denomination] = passenger;
        matches.push(passenger.passenger_denomination);
      });
   
      process(matches);
    },
    
    updater: function (item) {
      selected = map[item].passenger_id;
      $('#reservation_passenger_id').val( selected );
      return item;
    },
    
    matcher: function (item) {
      if (item.toLowerCase().indexOf(this.query.trim().toLowerCase()) != -1) {
        return true;
      }
    },
    
    sorter: function (items) {
        return items.sort();
    },
    
    highlighter: function (item) {
      var regex = new RegExp( '(' + this.query + ')', 'gi' );
      return item.replace( regex, "<strong>$1</strong>" );
    },
  
  });


  $('#enterprise_search').typeahead({
    
    source: function (query, process) {

      matches = [];
      map = {};
   
      $.each(enterprises, function (i, enterprise) {
        map[enterprise.enterprise_denomination] = enterprise;
        matches.push(enterprise.enterprise_denomination);
      });
   
      process(matches);
    },
    
    updater: function (item) {
      selected = map[item].enterprise_id;
      $('#reservation_enterprise_id').val( selected );
      return item;
    },
    
    matcher: function (item) {
      if (item.toLowerCase().indexOf(this.query.trim().toLowerCase()) != -1) {
        return true;
      }
    },
    
    sorter: function (items) {
        return items.sort();
    },
    
    highlighter: function (item) {
      var regex = new RegExp( '(' + this.query + ')', 'gi' );
      return item.replace( regex, "<strong>$1</strong>" );
    },
  
  });

}