$(document).ready(function(){
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