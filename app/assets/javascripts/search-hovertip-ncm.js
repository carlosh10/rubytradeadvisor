$(document).ready(function(){
	$(".form-ncm").each(function(){
		var $this = $(this);	
			
			$.get($(this).attr('action'), $(this).serialize(), function(data){
				$("span[data-ncm=" + $this.find("[name=ncm]").first().val() + "]").attr({
						"data-uk-tooltip": "{pos:'top-left'}",
						"title": data["key"]
					});
			});
			
		});

});