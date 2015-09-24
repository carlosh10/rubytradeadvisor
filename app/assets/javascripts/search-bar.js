// if find hidden field of serch query on page, set it value on search bar 


$(document).ready(function(){
	var query = $("input[name*=query][type=hidden]").first().val();
	if(query != null && query != "") {
		//set value on query field at top
		$(".input_busca").val(query);
		//dísplay query form at navbar
		$(".td-hidden").removeClass("td-hidden");
	}
})
