$(document).ready(function(){
	//get actual url e verify if is at /search
	var isAtSearchPage = window.location.href.indexOf("search") > -1
	if(isAtSearchPage){
		//if is click on select box of filters. Do request again!
		$("input[type=checkbox]").click(function(){
			$("form[action*=search]").last().submit();
		});
	}
})