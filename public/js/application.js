$(document).ready(function() {

  if ($("#user").text() === "") {
    $("a[href='/login']").show();
    $("a[href='/signout']").hide();
  }
  else {
    $("a[href='/login']").hide();
    $("a[href='/signout']").show();
  }

});
