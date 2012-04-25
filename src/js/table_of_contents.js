$(function() {
    var headers = $("h2,h3,h4,h5,h6")

    var text = ""

    headers.map(function(y,x) {
	text += "<a href=\"#" + x.innerHTML.toLowerCase().replace(/\s/g, "-") + "\">"  + x.innerHTML + "</a></br>"
    });

    $('#contents').html(text);
    $('body').css('font-family','Arial');
    $('code').css('font-family', 'Menlo, Consolas, Monospace');
    $('p, ul, ol').css('text-align','justify')
    $('code').addClass('prettyprint lang-hs');
    $('body').css('margin', '0 0');
    $('pre').css('margin', '0 0 23px 0');

    prettyPrint()

});