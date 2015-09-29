$('[data-uk-pagination]').on('select.uk.pagination', function(e, pageIndex){
    
    $("#pagination-page").val(pageIndex+1);
    console.log($("#pagination-page").val());
    //alert($("[name*=page]").val());
    $("form[action*=search]").last().submit();
});