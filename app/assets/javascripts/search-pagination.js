$('[data-uk-pagination]').on('select.uk.pagination', function(e, pageIndex){
    $("#pagination-page").val(pageIndex+1);
    $("form[action*=search]").last().submit();
});