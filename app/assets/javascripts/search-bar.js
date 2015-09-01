// if query (q) param has a value, set it on search bar 
$(document).ready(function(){
	var query = $.urlParam('q');
	if(query != null) {
		//set value on query field at top
		$(".input_busca").val(query);
		//dísplay query form at navbar
		$(".busca_topo").removeClass("uk-hidden");
	}
})
