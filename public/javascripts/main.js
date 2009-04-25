$(document).ready(function(){
  $('.calendar').each(function(){
    var self = $(this);
    var date = Date.parse(self.attr('title'));
    self.datepicker({
      defaultDate: date
    });
  });
});