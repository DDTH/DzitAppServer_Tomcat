
function chartqueue1(datalist) {
    var label = $("[name='chartQueue1radiogroup']:checked").next().text();
    $.plot($("#chartQueue1"), [
        {label:label, data:datalist}
    ], chartOpts);
}

function chartqueue2(datalist) {
    var label = $("[name='chartQueue2radiogroup']:checked").next().text();
    $.plot($("#chartQueue2"), [
        {label:label, data:datalist}
    ], chartOpts);
}


function queuelist(olist) {
    $('#queues').empty()
    var str = "<table><tbody>"
    for (var i = 0; i < olist.length; i++) {
        str += "<tr><td><span class='ui-icon ui-icon-carat-1-e'></span></td><td><a href='#' class='itemLink' onclick='addViewShort(\"" + olist[i].label + "\", \"queue\" )'>" + olist[i].label + "</a></td></tr>"
    }
    str += "</tbody></table>"
    $('#queues').append(str)
    queueListCache = olist;
}
