var cache = {};
function googleSuggest(request, response) {
    var term = request.term;
    if (term in cache) { response(cache[term]); return; }
    $.ajax({
        url: '/posts/tags_ajax',
        dataType: 'JSON',
        data: { q: term },
        success: function(data) {
            cache[term] = data;
            response(data);
        }
    });
}
(function($){
    $('#post_tag_list').tagEditor({ autocomplete: { source: googleSuggest, minLength: 3 } });
})(jQuery)