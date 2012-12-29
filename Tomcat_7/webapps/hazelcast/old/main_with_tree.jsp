<html>

<head>
<style type="text/css">

    .tabsDiv {
        height: 100%;
        vertical-align: top;
        border: 10px solid red;
    }

    .datatable td {
        font-size: 11px;
    }

    .flexigrid {
        margin-top: 10px;
    }

    .hDiv div {
        font-size: 11px;
    }

    .bannerTd {
        background-image: url("images/banner_bg.png");
        padding-left: 150px;
    }


</style>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js">
</script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.17/jquery-ui.min.js">
</script>
<script type="text/javascript" src="js/jquery.flot.js">
</script>
<!--[if lte IE 8]>
<script language="javascript" type="text/javascript" src="js/excanvas.min.js"></script><![endif]-->

<link rel="stylesheet" type="text/css" href="css/custom-theme/jquery-ui-1.8.17.custom-old.css"/>
<link rel="stylesheet" type="text/css" href="js/flexigrid/css/flexigrid.css"/>

<script type="text/javascript" src="js/jstree/jquery.jstree.js">
</script>
<script type="text/javascript" src="js/flexigrid/js/flexigrid.js">
</script>

<script type="text/javascript">

var activeView = "";
var activeObject = "";
var tabCounter = 0;
var tabmap = {};
var revtabmap = {};


$(document).ready(function() {
    $("#instances").jstree({
        "themes" : {
            "theme" : "classic",
            "dots" : false,
            "icons" : true
        },
        "plugins" : [ "themes", "html_data" ]
    });
    var tabs = $("#tabs").tabs({
        tabTemplate: "<li><a href='#{href}' >#{label}</a> <span class='ui-icon ui-icon-close'>Remove Tab</span></li>",
        add: function(event, ui) {
            tabs.tabs('select', '#' + ui.panel.id);
            refreshpage(0)
        },
        select: function(event, ui) {
            if (revtabmap[ui.panel.id]) {
                var str = revtabmap[ui.panel.id].split("_")
                activeView = str[0]
                activeObject = str[1]
                refreshpage(0)
            }
        },
        show: function(event, ui) {
            $(".ui-tabs-panel").empty();
            var content = getInitialContent()
            $(ui.panel).append(content);
        }
    });

    $("#tabs span.ui-icon-close").live("click", function() {
        var index = $("li", tabs).index($(this).parent());
        tabs.tabs("remove", index);
    });

    $("#topmenu").buttonset();
    $("#radio1").button({ icons: {primary:'ui-icon-home'} });
    $("#radio2").button({ icons: {primary:'ui-icon-check'} });
    $("#radio3").button({ icons: {primary:'ui-icon-pencil'} });
    $("#radio4").button({ icons: {primary:'ui-icon-gear'} });
    $("#radio5").button({ icons: {primary:'ui-icon-help'} });

    $(".accordion").accordion({
        collapsible: true,
        autoHeight: false,
        navigation: true
    });

    refreshpage(5);

});

function getInitialContent() {
    return $("#" + activeView + "ContentTemplate").html()
}

function refreshpage(repeatSeconds) {
    var default_op = "memberlist_instancelist"
    var data = {operation : default_op}

    if (activeView == 'map' || activeView == 'topic') {
        var chart1type = $("#chart1type option:selected").val()
        var chart2type = $("#chart2type option:selected").val()
        data = {operation : default_op + "_charts_datatables", type:activeView, instance:activeObject, chart1type:chart1type, chart2type:chart2type }
    }
    else if (activeView == 'queue') {
        var chart1type = $("#chart1type option:selected").val()
        var chart2type = $("#chart2type option:selected").val()
        data = {operation : default_op + "_charts", type:activeView, instance:activeObject, chart1type:chart1type, chart2type:chart2type }
    }
    else if (activeView == 'member') {
        data = {operation : default_op + "_memberdata", member:activeObject}
    }

    var request = $.ajax({
        url: "main.do",
        data: data,
        cache: false,
        dataType: "json"
    });

    request.done(function(resp) {
        for (var oper in resp) {
            eval(oper + "(resp[oper])")
        }

        if (repeatSeconds > 0)
            setTimeout("refreshpage(" + repeatSeconds + ")", repeatSeconds * 1000);
    });
}


function memberlist(olist) {
    $('#members').empty()
    for (var i = 0; i < olist.length; i++) {
        $('#members').append("<li><a href='#' onclick='addView(\"" + olist[i].label + "\", \"member\" )'>" + olist[i].label + "</a></li>")
    }
}


var chartOpts = {
    series: {
        lines: { show: true },
        points: { show: true }
    },
    xaxis: {
        mode: "time"
    },
    yaxis: {
//                ticks: 10,
//                min: 0,
//                max: 1000
    },
    grid: {
        backgroundColor: { colors: ["#fff", "#eee"] }
    }
}

function chart1(datalist) {
    var label = $("#chart1type option:selected").text();
    $.plot($("#chart1"), [
        {label:label, data: datalist}
    ], chartOpts);
}
function chart2(datalist) {
    var label = $("#chart2type option:selected").text();
    $.plot($("#chart2"), [
        {label:label, data: datalist}
    ], chartOpts);
}

function mapMemoryTable(datalist) {
    var tbl = $("#datatable1")
    tbl.flexigrid({
        dataType: 'json',
        colModel : [
            {display: 'Members', name : 'members', width : 100, sortable : true, align: 'left'},
            {display: 'Entries', name : 'entries', width : 60, sortable : true, align: 'left'},
            {display: 'Entry Memory', name : 'entry_memory', width : 60, sortable : true, align: 'left'},
            {display: 'Backups', name : 'entry_memory', width : 60, sortable : true, align: 'left'},
            {display: 'Backup Memory', name : 'backup_memory', width : 60, sortable : true, align: 'left'},
            {display: 'Dirty Entries', name : 'dirty_entries', width : 60, sortable : true, align: 'left'},
            {display: 'Marked As Remove', name : 'marked_as_remove', width : 60, sortable : true, align: 'left'},
            {display: 'Marked Rem. Mem.', name : 'marked_as_remove_memory', width : 60, sortable : true, align: 'left'},
            {display: 'Locks', name : 'locks', width : 60, sortable : true, align: 'left'}
        ],
        sortname: "members",
        sortorder: "asc",
        usepager: true,
        title: "Map Memory Data Table",
        useRp: true,
        rp: 10,
        showTableToggleBtn: true,
        resizable: false,
        height: 100,
        width: 1000,
        singleSelect: true
    });
    tbl.flexAddData(datalist)
    tbl.flexReload()

}

function mapThroughputTable(datalist) {
    var tbl = $("#datatable2")
    tbl.flexigrid({
        dataType: 'json',
        colModel : [
            {display: 'Members', name : 'members', width : 100, sortable : true, align: 'left'},
            {display: 'Total', name : 'id1', width : 60, sortable : true, align: 'left'},
            {display: 'Gets', name : 'id2', width : 60, sortable : true, align: 'left'},
            {display: 'Avg Get Lat.', name : 'id3', width : 60, sortable : true, align: 'left'},
            {display: 'Puts', name : 'id4', width : 60, sortable : true, align: 'left'},
            {display: 'Avg Put Lat.', name : 'id5', width : 60, sortable : true, align: 'left'},
            {display: 'Removes', name : 'id6', width : 60, sortable : true, align: 'left'},
            {display: 'Avg Remove Lat.', name : 'id7', width : 60, sortable : true, align: 'left'},
            {display: 'Other Ops.', name : 'id8', width : 60, sortable : true, align: 'left'},
            {display: 'Events', name : 'id9', width : 60, sortable : true, align: 'left'}
        ],
        sortname: "members",
        sortorder: "asc",
        usepager: true,
        title: "Map Throughput Data Table",
        useRp: true,
        rp: 10,
        showTableToggleBtn: true,
        resizable: false,
        height: 100,
        width: 1000,
        singleSelect: true
    });
    tbl.flexAddData(datalist)
    tbl.flexReload()

}


function memberdata(datalist) {
    var tbl = $("#memberInfo")
    tbl.empty()
    var str = "<tbody>"
    for (var i = 0; i < datalist.length; i++) {
        str += "<tr><td style='infoLabel'>" + datalist[i][0] + "</td><td>" + datalist[i][1] + "</td></tr>"
    }
    tbl.append(str + "</tbody>")
}


function datatableold2(tid, datalist) {
    var tbl = $("#" + tid)
    tbl.flexigrid({
        dataType: 'json',
        colModel : [
            {display: 'Members', name : 'id', width : 60, sortable : true, align: 'left'},
            {display: 'Entries', name : 'first_name', width : 60, sortable : true, align: 'left'},
            {display: 'Entry Memory', name : 'surname', width : 60, sortable : true, align: 'left'}
        ],
        sortname: "id",
        sortorder: "asc",
        usepager: true,
        title: "Staff",
        useRp: true,
        rp: 10,
        showTableToggleBtn: false,
        resizable: false,
        width: 700,
        height: 370,
        singleSelect: true
    });
    tbl.flexAddData(datalist)
    tbl.flexReload()

}

function datatableold(tid, datalist) {
    var tbl = $("#" + tid)
    tbl.empty()


    var str = "<thead>"
    var row = datalist[0]
    str += "<tr>"
    for (var j = 0; j < row.length; j++) {
        str += "<th>" + row[j] + "</th>"
    }
    str += "</tr>"
    str = str + "</thead>"


    str = str + "<tbody>"

    for (var i = 1; i < datalist.length; i++) {
        var row = datalist[i]
        str += "<tr>"
        for (var j = 0; j < row.length; j++) {
            str += "<td>" + row[j] + "</td>"
        }
        str += "</tr>"
    }

    tbl.append(str + "</tbody>")

}


function maplist(olist) {
    $('#maps').empty()
    for (var i = 0; i < olist.length; i++) {
        $('#maps').append("<li><a href='#' onclick='addView(\"" + olist[i].label + "\", \"map\" )'>" + olist[i].label + "</a></li>")
    }
}

function queuelist(olist) {
    $('#queues').empty()
    for (var i = 0; i < olist.length; i++) {
        $('#queues').append("<li><a href='#' onclick='addView(\"" + olist[i].label + "\", \"queue\" )'>" + olist[i].label + "</a></li>")
    }
}

function topiclist(olist) {
    $('#topics').empty()
    for (var i = 0; i < olist.length; i++) {
        $('#topics').append("<li><a href='#' onclick='addView(\"" + olist[i].label + "\", \"topic\" )'>" + olist[i].label + "</a></li>")
    }
}

function addTabView() {
    var str = activeView + "_" + activeObject
    var idstr = "#tab_" + tabmap[str]
    if ($(idstr).length == 0) {
        tabCounter ++;
        $('#tabs').tabs("add", "#tab_" + tabCounter, activeObject);
        tabmap[str] = tabCounter
        revtabmap["tab_" + tabCounter] = str
    }
    else {
        $('#tabs').tabs('select', idstr);
    }
    return tabCounter
}

function addView(label, view) {
    activeObject = label;
    activeView = view
    addTabView()
}


</script>

</head>

<body style="padding: 0px; margin: 0px;">

<table style="padding: 0px; margin: 0px; width:100%; height: 100%;" cellpadding="0" cellspacing="0" border=0>

    <tr>
        <td colspan="2" class="bannerTd">
            <table cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <img src="images/logo.png" alt="hazelcast logo"/>
                    </td>
                    <td style="vertical-align: bottom; padding-left: 35px;">
                        <div id="topmenu">
                            <input type="radio" id="radio1" name="radio"/><label for="radio1">Home</label>
                            <input type="radio" id="radio2" name="radio" checked="checked"/><label for="radio2">Health
                            Check</label>
                            <input type="radio" id="radio3" name="radio"/><label for="radio3">Scripting</label>
                            <input type="radio" id="radio4" name="radio"/><label for="radio4">Settings</label>
                            <input type="radio" id="radio5" name="radio"/><label for="radio5">Support</label>
                        </div>
                    </td>
                </tr>

            </table>

        </td>
    </tr>

    <tr>
        <td colspan="2" style="background-color: #e6e6fa; height: 2px;">
        </td>
    </tr>

    <tr>
        <td style="width:300px; height: 100%; vertical-align: top; background-color: #e6e6fa;">


            <div class="accordion">
                <h3><a href="#">Instances</a></h3>

                <div>
                    <div id="instances">
                        <ul>
                            <li>
                                <a href="#">Maps</a>
                                <ul id="maps">
                                    <li><a href="#">&nbsp;</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#">Queues</a>
                                <ul id="queues">
                                    <li><a href="#">&nbsp;</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#">Topics</a>
                                <ul id="topics">
                                    <li><a href="#">&nbsp;</a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="accordion">
                <h3><a href="#">Members</a></h3>

                <div>
                    <div>
                        <ul id="members">
                        </ul>
                    </div>
                </div>
            </div>

        </td>
        <td>
            <div id="tabs" class="tabsDiv">
                <ul id="tabheaders">
                    <li><a href="#tabs-1">Nunc tincidunt</a> <span class="ui-icon ui-icon-close">Remove Tab</span></li>

                </ul>
                <div id="tabs-1">
                    <p>Proin elit arcu, rutrum commodo, vehicula tempus, commodo a, risus. Curabitur nec arcu.
                        Donec </p>
                </div>

            </div>

        </td>
    </tr>

</table>

<div id="mapContentTemplate" class="contentDiv" style="display: none;">
    <table>
        <tr>
            <td>
                <select id="chart1type" onchange="refreshpage(0)">
                    <option value="i_Map_OwnedEntryCount" selected="true">Size</option>
                    <option value="i_Map_OwnedEntryMemoryCost">Memory</option>
                    <option value="i_Map_BackupEntryCount">Backup Size</option>
                    <option value="i_Map_BackupEntryMemoryCost">Backup Mem.</option>
                    <option value="i_Map_Hits">Hits</option>
                    <option value="i_Map_LockedEntryCount">Locked Entr.</option>
                    <option value="o_Map_NumberOfPuts">Puts</option>
                    <option value="o_Map_NumberOfGets">Gets</option>
                    <option value="o_Map_NumberOfRemoves">Removes</option>
                </select>
                <select id="chart1period" onchange="refreshpage(0)">
                    <option value="i_Map_OwnedEntryCount" selected="true">Last 1 Minute</option>
                </select>
            </td>
            <td>
                <select id="chart2type" onchange="refreshpage(0)">
                    <option value="i_Map_OwnedEntryCount">Size</option>
                    <option value="i_Map_OwnedEntryMemoryCost" selected="true">Memory</option>
                    <option value="i_Map_BackupEntryCount">Backup Size</option>
                    <option value="i_Map_BackupEntryMemoryCost">Backup Memory</option>
                    <option value="i_Map_Hits">Hits</option>
                    <option value="i_Map_LockedEntryCount">Locked Entries</option>
                    <option value="o_Map_NumberOfPuts">Puts</option>
                    <option value="o_Map_NumberOfGets">Gets</option>
                    <option value="o_Map_NumberOfRemoves">Removes</option>
                </select>
                <select id="chart2period" onchange="refreshpage(0)">
                    <option value="i_Map_OwnedEntryCount" selected="true">Last 1 Minute</option>
                </select>
            </td>
        </tr>
        <tr>
            <td style="padding-top:10px; padding-bottom:10px; ">
                <div id="chart1" style="width:370px;height:200px; ">loading</div>
            </td>
            <td style="padding-top:10px; padding-bottom:10px; ">
                <div id="chart2" style="width:370px;height:200px; ">loading</div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <table id="datatable1" class="datatable"></table>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <table id="datatable2" class="datatable"></table>
            </td>
        </tr>
    </table>
</div>


<div id="queueContentTemplate" class="contentDiv" style="display: none;">
    <table>
        <tr>
            <td>
                <select id="chart1type" onchange="refreshpage(0)">
                    <option value="i_Queue_OwnedItemCount" selected="true">Size</option>
                    <option value="o_Queue_NumberOfOffers">Offers</option>
                    <option value="o_Queue_NumberOfPolls">Polls</option>
                </select>
            </td>
            <td>
                <select id="chart2type" onchange="refreshpage(0)">
                    <option value="i_Queue_OwnedItemCount">Size</option>
                    <option value="o_Queue_NumberOfOffers" selected="true">Offers</option>
                    <option value="o_Queue_NumberOfPolls">Polls</option>
                </select>
            </td>
        </tr>
        <tr>
            <td style="padding:20px; ">
                <div id="chart1" style="width:400px;height:300px; ">loading</div>
            </td>
            <td style="padding:20px; ">
                <div id="chart2" style="width:400px;height:300px; ">loading</div>
            </td>
        </tr>

    </table>
</div>


<div id="topicContentTemplate" class="contentDiv" style="display: none;">
    <table>
        <tr>
            <td>
                <select id="chart1type" onchange="refreshpage(0)">
                    <option value="o_Topic_NumberOfPublishes" selected="true">Publishes</option>
                    <option value="o_Topic_NumberOfReceivedMessages">Receives</option>
                </select>
            </td>
            <td>
                <select id="chart2type" onchange="refreshpage(0)">
                    <option value="o_Topic_NumberOfPublishes">Publishes</option>
                    <option value="o_Topic_NumberOfReceivedMessages" selected="true">Receives</option>
                </select>
            </td>
        </tr>
        <tr>
            <td style="padding:20px; ">
                <div id="chart1" style="width:400px;height:300px; ">loading</div>
            </td>
            <td style="padding:20px; ">
                <div id="chart2" style="width:400px;height:300px; ">loading</div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <table id="datatable1" class="datatable"></table>
            </td>
        </tr>

    </table>
</div>


<div id="memberContentTemplate" style="display: none;">
    <table id="memberInfo">
    </table>
</div>


</body>
</html>