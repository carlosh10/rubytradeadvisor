  $(function() {

    // <div class="slider-range" data-max="300" data-max-field="input[name='total_value[max]'']" data-min-field="input[name='total_value[min]']" data-display="#amount">

    $(".slider-range").each(function(){

        var setMin =  $(this).attr('data-min-field');
        var setMax =  $(this).attr('data-max-field');
        var display = $(this).attr('data-display');

        var max = parseInt($(this).attr('data-max')) || 0;
        var min = parseInt($(this).attr('data-min')) || 0;

        var maxRange = parseInt($(this).attr('data-max-range')) || 0;
        var minRange = parseInt($(this).attr('data-min-range')) || 0;
        var prefix = $(this).attr('data-display-prefix');

        $(this).slider({
          range: true,
          min: minRange,
          max:  maxRange,
          values: [ min , max ],
          slide: function( event, ui ) {
            $(display).val( prefix + ui.values[ 0 ] + " - " + prefix + ui.values[ 1 ] );
            $(setMin).val(ui.values[0]);
            $(setMax).val(ui.values[1]);
          }
        });

        $(display).val( prefix + $(this).slider( "values", 0 ) +
          " - " + prefix + $(this).slider( "values", 1 ) );
        })

  });