$(document).ready(function(){
	//get actual url e verify if is at /search
	var isAtSearchPage = window.location.href.indexOf("search") > -1;
	if(isAtSearchPage){
		$("select").change(function() {
			//set page 1, to restart pagination
			$("#pagination-page").val(1);
			//submit form
			$("form[action*=search]").last().submit();
		});
	}
})