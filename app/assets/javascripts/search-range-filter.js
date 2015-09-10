  $(function() {

    // <div class="slider-range" data-max="300" data-max-field="input[name='total_value[max]'']" data-min-field="input[name='total_value[min]']" data-display="#amount">

    $(".slider-range").each(function(){

        var setMin =  $(this).attr('data-min-field');
        var setMax =  $(this).attr('data-max-field');
        var display = $(this).attr('data-display');

        var max = parseInt($(this).attr('data-max'));
        var min = parseInt($(this).attr('data-min'));

        var maxRange = parseInt($(this).attr('data-max-range'));
        var minRange = parseInt($(this).attr('data-min-range'));
    

        $(this).slider({
          range: true,
          min: minRange,
          max:  maxRange,
          values: [ min , max ],
          slide: function( event, ui ) {
            $(display).val( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
            $(setMin).val(ui.values[0]);
            $(setMax).val(ui.values[1]);
          }
        });

        $(display).val( "$" + $(this).slider( "values", 0 ) +
          " - $" + $(this).slider( "values", 1 ) );
        })

  });