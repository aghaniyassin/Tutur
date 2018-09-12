$(document).on('turbolinks:load', function() {
  $("#new_rental input").change(function() {
    var price = $("#new_rental").data("price");
    var start_at = Date.parse($("#rental_start_at").val());
    var end_at = Date.parse($("#rental_end_at").val());
    var price_input = $("#rental_price");

    if(end_at - start_at > 0) {
      var days = Math.round(Math.abs((end_at - start_at)/(24*60*60*1000)));
      price_input.text(price * days);
   } else {
      price_input.text('--')
   }
  });
});

$(document).on('turbolinks:load', function() {
  var start_at_input = $("input[id*='rental_start_at']")
  var end_at_input = $("input[id*='rental_end_at']")

  start_at_input.change(function() {
     end_at_input.attr("min", start_at_input.val());
  });
});
