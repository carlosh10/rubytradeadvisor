// if find search-query id on page, set it value on search bar 
$(document).ready(function(){
	var query = $("#search-query").text();
	if(query != null) {
		//set value on query field at top
		$(".input_busca").val(query);
		//dísplay query form at navbar
		$(".busca_topo").removeClass("uk-hidden");
	}
})
