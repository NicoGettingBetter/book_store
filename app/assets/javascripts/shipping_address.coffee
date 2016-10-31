$(document).on 'turbolinks:load', ->
  toggle_shipping_address();
  $(".checkbox").change ->
    toggle_shipping_address(500);

toggle_shipping_address = (num = 0) ->
  if $('#use_billing_address_check').is(':checked')
    $("#shipping_address").hide(num);
  else
    $("#shipping_address").show(num);
