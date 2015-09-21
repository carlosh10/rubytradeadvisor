$(document).ready(function(){
	$.ajaxSetup({
		  headers: {
		    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
		  }
	});
	$(".ncm-hovertip").each(function(){
		var $this = $(this);
		$.get("/ncm?ncm=" + $this.text(), function(data){
			$this.attr({
				"data-uk-tooltip": "{pos:'top-left'}",
				"title": JSON.parse(data)["key"]
			})
		});
	});
});