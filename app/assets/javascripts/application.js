// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require uikit
//= require_tree .
//= require jquery-ui
//= require jquery-ui/core
//= require jquery-ui/widget

$.urlParam = function(name){
    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
    if (results==null){
       return null;
    }
    else{
       return results[1] || 0;
    }
}

function toggleChevron(e) {
    $(e.target)
        .prev('.panel-heading')
        .find("i.indicator")
        .toggleClass('glyphicon-chevron-down glyphicon-chevron-up');
}


$('div[role=tablist]').on('hidden.bs.collapse', toggleChevron);
$('div[role=tablist]').on('shown.bs.collapse', toggleChevron);

$(document).ready(function(){

    $(".notify").each(function(){

        var message = $(this).text()

        UIkit.notify({
            message : message,
            status  : 'alert',
            timeout : 5000,
            pos     : 'top-center'
        });

    });

});