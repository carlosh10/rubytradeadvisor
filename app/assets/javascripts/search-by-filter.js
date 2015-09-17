$(document).ready(function(){
	//get actual url e verify if is at /search
	var isAtSearchPage = window.location.href.indexOf("search") > -1;
	if(isAtSearchPage){
		//if is click on select box of filters. Do request again!
		$("input[type=checkbox],input[type=button]").click(function(){
			//set page 1, to restart pagination
			$("#pagination-page").val(1);
			//submit form
			$("form[action*=search]").last().submit();
		});

		$( "select" ).change(function() {
			//set page 1, to restart pagination
			$("#pagination-page").val(1);
			//submit form
			$("form[action*=search]").last().submit();
		});


	}
})