

function charttopic1(datalist) {
    var label = $("[name='chartTopic1radiogroup']:checked").next().text();
    $.plot($("#chartTopic1"), [
        {label:label, data:datalist}
    ], chartOpts);
}

function charttopic2(datalist) {
    var label = $("[name='chartTopic2radiogroup']:checked").next().text();
    $.plot($("#chartTopic2"), [
        {label:label, data:datalist}
    ], chartOpts);
}



function topicTable(datalist) {
    var tbl = $("#datatableTopic")
    tbl.flexigrid({
        dataType:'json',
        colModel:[
            {display:'Members', name:'members', width:100, sortable:true, align:'left'},
            {display:'Publishes', name:'publishes', width:60, sortable:true, align:'left'},
            {display:'Receives', name:'recieves', width:60, sortable:true, align:'left'}
        ],
        sortname:"members",
        sortorder:"asc",
        usepager:false,
        title:"Topic Stats Data Table",
        useRp:false,
        rp:10,
        showTableToggleBtn:true,
        resizable:false,
        height:100,
        width:1000,
        singleSelect:true
    });
    tbl.flexAddData(datalist)
    tbl.flexReload()

}


function topiclist(olist) {
    $('#topics').empty()
    var str = "<table><tbody>"
    for (var i = 0; i < olist.length; i++) {
        str += "<tr><td><span class='ui-icon ui-icon-carat-1-e'></span></td><td><a href='#' class='itemLink' onclick='addViewShort(\"" + olist[i].label + "\", \"topic\" )'>" + olist[i].label + "</a></td></tr>"
    }
    str += "</tbody></table>"
    $('#topics').append(str)
    topicListCache = olist;
}
