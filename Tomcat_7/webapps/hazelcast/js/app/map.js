var mapMemoryTableDataView;
var mapMemoryTableGrid;
var mapThroughputTableDataView;
var mapThroughputTableGrid;


function initMapTab() {
    mapMemoryTableGrid = null
    mapThroughputTableGrid = null
    enableMapButtons()
}

function enableMapButtons() {
    $("#browseButton")
        .button({
            text:true,
            icons:{
                primary:"ui-icon-search"
            }
        })
        .click(function () {
            $("#mapBrowserDiv").dialog("open")
            $("#updateConfigMessageTd").empty()
        })

    $("#configButton")
        .button({
            text:true,
            icons:{
                primary:"ui-icon-gear"
            }
        })
        .click(function () {
            showMapConfig();
            $("#mapConfigDiv").dialog("open")
            $("#updateConfigMessageTd").empty()
        })
    disableWriteModeButtons()

}


function browseMapValue() {
    var type = $("#selectMapBrowserType").val()
    var data = {cluster:activeCluster, operation:"browsemap", mapName:activeObject, key:$("#mapkey").val(), type:type}
    opcall(data)
}



function openChartOpts(e, did) {
    $(did).dialog("open").dialog("option", "position", [e.pageX, e.pageY]);
}

function updateMapConfigAction() {
    var data = {cluster:activeCluster, operation:"updatemapconfig", mapName:activeObject}
    $('[name="mapconfiginput"]').each(
        function () {
            data[$(this).attr("title")] = $(this).val()
        });
    opcall(data)
}

function showMapConfig() {
    var data = {cluster:activeCluster, operation:"loadmapconfig", mapName:activeObject}
    opcall(data)
}

function chartmap1(datalist) {

    var checkedOpt = $("[name='chartMap1radiogroup']:checked");
    var label = checkedOpt.next().text();
    if (checkedOpt.val().charAt(0) == "i") {
        label += " (X1000)"
        chartOpts.yaxis.autoscaleMargin = 4
    }
    else {
        chartOpts.yaxis.autoscaleMargin = 0.3
    }
    $.plot($("#chartMap1"), [
        {label:label, data:datalist}
    ], chartOpts);
}

function chartmap2(datalist) {
    var checkedOpt = $("[name='chartMap2radiogroup']:checked");
    var label = $("[name='chartMap2radiogroup']:checked").next().text();
    if (checkedOpt.val().charAt(0) == "i") {
        label += " (X1000)"
        chartOpts.yaxis.autoscaleMargin = 4
    }
    else {
        chartOpts.yaxis.autoscaleMargin = 2
    }
    $.plot($("#chartMap2"), [
        {label:label, data:datalist}
    ], chartOpts);
}


function memberFormatter(row, cell, value, columnDef, dataContext) {
    return "<a href='#' onclick='addViewShort(\"" + value + "\", \"member\")'>" + value + "</a>";
}


function mapMemoryTable(olist) {
    var columns = [
        {id:"num", name:"#", field:"num", width:40, sortable:true},
        {id:"members", name:"Members", field:"members", width:140, sortable:true, formatter:memberFormatter},
        {id:"entries", name:"Entries", field:"entries", width:90, sortable:true},
        {id:"entry_memory", name:"Entry Memory", field:"entry_memory", width:110, sortable:true},
        {id:"backups", name:"Backups", field:"backups", width:90, sortable:true},
        {id:"backup_memory", name:"Backup Memory", field:"backup_memory", width:110, sortable:true},
        {id:"dirty_entries", name:"Dirty Entries", field:"dirty_entries", width:90, sortable:true},
        {id:"marked_as_remove", name:"Marked As Remove", field:"marked_as_remove", width:110, sortable:true},
        {id:"marked_as_remove_memory", name:"Marked As Remove Memory", field:"marked_as_remove_memory", width:130, sortable:true},
        {id:"locks", name:"Locks", field:"locks", width:90, sortable:true}
    ];

    var options = {
        enableCellNavigation:true,
        enableColumnReorder:false
    };

    $("#datatableMap1").css("height", Math.min(olist.length + 1, 10) * 30)

    if (mapMemoryTableGrid == null) {
        $("#datatableMap1").empty()
        var data = [];
        for (var i = 0; i < olist.length; i++) {
            var ss = olist[i]
            data[i] = {
                id:"mid" + ss[0],
                num:ss[0],
                members:ss[1],
                entries:ss[2],
                entry_memory:ss[3],
                backups:ss[4],
                backup_memory:ss[5],
                dirty_entries:ss[6],
                marked_as_remove:ss[7],
                marked_as_remove_memory:ss[8],
                locks:ss[9]
            };
        }
        mapMemoryTableDataView = new Slick.Data.DataView({ inlineFilters:true });
        mapMemoryTableDataView.beginUpdate();
        mapMemoryTableDataView.setItems(data);
        mapMemoryTableDataView.endUpdate();
        mapMemoryTableDataView.refresh();
        mapMemoryTableGrid = new Slick.Grid("#datatableMap1", mapMemoryTableDataView, columns, options);


        mapMemoryTableGrid.onSort.subscribe(function (e, args) {
            sortdir = args.sortAsc ? 1 : -1;
            sortcol = args.sortCol.field;
            // using native sort with comparer
            // preferred method but can be very slow in IE with huge datasets
            mapMemoryTableDataView.sort(comparerMap, args.sortAsc);
        });

        mapMemoryTableDataView.onRowCountChanged.subscribe(function (e, args) {
            mapMemoryTableGrid.updateRowCount();
            mapMemoryTableGrid.render();
        });

        mapMemoryTableDataView.onRowsChanged.subscribe(function (e, args) {
            mapMemoryTableGrid.invalidateRows(args.rows);
            mapMemoryTableGrid.render();
        });
    }

    else {
        var data = [];
        for (var i = 0; i < olist.length; i++) {
            var ss = olist[i]
            data[i] = {
                id:"mid" + ss[0],
                num:ss[0],
                members:ss[1],
                entries:ss[2],
                entry_memory:ss[3],
                backups:ss[4],
                backup_memory:ss[5],
                dirty_entries:ss[6],
                marked_as_remove:ss[7],
                marked_as_remove_memory:ss[8],
                locks:ss[9]
            };
        }
        mapMemoryTableDataView.beginUpdate();
        mapMemoryTableDataView.setItems(data);
        mapMemoryTableDataView.endUpdate();
        mapMemoryTableDataView.refresh();
        for (var i = 0; i < olist.length; i++) {
            mapMemoryTableGrid.updateRow(i)
        }
    }

}


function comparerMap(a, b) {
    var x = a[sortcol], y = b[sortcol];
    return (x == y ? 0 : (x > y ? 1 : -1));
}

function mapThroughputTable(olist) {
    var columns = [
        {id:"num", name:"#", field:"num", width:40, sortable:true},
        {id:"members", name:"Members", field:"members", width:140, sortable:true, formatter:memberFormatter},
        {id:"total", name:"Total", field:"total", width:80, sortable:true},
        {id:"gets", name:"Gets", field:"gets", width:80, sortable:true},
        {id:"avggetlat", name:"Avg Get Lat.", field:"avggetlat", width:110, sortable:true},
        {id:"puts", name:"Puts", field:"puts", width:80, sortable:true},
        {id:"avgputlat", name:"Avg Put Lat.", field:"avgputlat", width:100, sortable:true},
        {id:"removes", name:"Removes", field:"removes", width:90, sortable:true},
        {id:"avgremovelat", name:"Avg Remove Lat.", field:"avgremovelat", width:120, sortable:true},
        {id:"otherops", name:"Other Ops.", field:"otherops", width:90, sortable:true},
        {id:"events", name:"Events", field:"events", width:70, sortable:true}
    ];

    var options = {
        enableCellNavigation:true,
        enableColumnReorder:false
    };

    $("#datatableMap2").css("height", Math.min(olist.length + 1, 10) * 30)

    if (mapThroughputTableGrid == null) {
        $("#datatableMap2").empty()
        var data = [];
        for (var i = 0; i < olist.length; i++) {
            var ss = olist[i]
            data[i] = {
                id:"tid" + ss[0],
                num:ss[0],
                members:ss[1],
                total:ss[2],
                gets:ss[3],
                avggetlat:ss[4],
                puts:ss[5],
                avgputlat:ss[6],
                removes:ss[7],
                avgremovelat:ss[8],
                otherops:ss[9],
                events:ss[10]
            };
        }
        mapThroughputTableDataView = new Slick.Data.DataView({ inlineFilters:true });
        mapThroughputTableDataView.beginUpdate();
        mapThroughputTableDataView.setItems(data);
        mapThroughputTableDataView.endUpdate();
        mapThroughputTableDataView.refresh();
        mapThroughputTableGrid = new Slick.Grid("#datatableMap2", mapThroughputTableDataView, columns, options);


        mapThroughputTableGrid.onSort.subscribe(function (e, args) {
            sortdir = args.sortAsc ? 1 : -1;
            sortcol = args.sortCol.field;
            // using native sort with comparer
            // preferred method but can be very slow in IE with huge datasets
            mapThroughputTableDataView.sort(comparerMap, args.sortAsc);
        });

        mapThroughputTableDataView.onRowCountChanged.subscribe(function (e, args) {
            mapThroughputTableGrid.updateRowCount();
            mapThroughputTableGrid.render();
        });

        mapThroughputTableDataView.onRowsChanged.subscribe(function (e, args) {
            mapThroughputTableGrid.invalidateRows(args.rows);
            mapThroughputTableGrid.render();
        });
    }

    else {
        var data = [];
        for (var i = 0; i < olist.length; i++) {
            var ss = olist[i]
            data[i] = {
                id:"tid" + ss[0],
                num:ss[0],
                members:ss[1],
                total:ss[2],
                gets:ss[3],
                avggetlat:ss[4],
                puts:ss[5],
                avgputlat:ss[6],
                removes:ss[7],
                avgremovelat:ss[8],
                otherops:ss[9],
                events:ss[10]
            };
        }
        mapThroughputTableDataView.beginUpdate();
        mapThroughputTableDataView.setItems(data);
        mapThroughputTableDataView.endUpdate();
        mapThroughputTableDataView.refresh();
        for (var i = 0; i < olist.length; i++) {
            mapThroughputTableGrid.updateRow(i)
        }
    }

}




function browsemap(datalist) {
    $("#mapBrowserInfo").html("")
    for (data in datalist) {
        if (data == "No Value Found!") {
            $(".browseValueTd").html("")
            $("#mapBrowserInfo").html("No value found.")
            break;
        }
        $("#" + data).html(datalist[data])
    }
}

function updatemapconfig(dlist) {
    if (dlist == 'success')
        $("#updateConfigMessageTd").html("Configuration has been successfully updated.")
}

function loadmapconfig(dlist) {

    $(".mapconfiginfo").each(function () {
        var t = $(this).attr("title")

        if ($(this).is('input')) {
            $(this).val("" + dlist[t])
        }
        else if ($(this).is('select')) {
            $(this).val("" + dlist[t])
        }
        else
            $(this).html("" + dlist[t])
    });
}

function maplist(olist) {
    $('#maps').empty()
    var str = "<table><tbody>"
    for (var i = 0; i < olist.length; i++) {
        str += "<tr><td><span class='ui-icon ui-icon-carat-1-e'></span></td><td><a href='#' class='itemLink' onclick='addViewShort(\"" + olist[i].label + "\", \"map\" )'>" + olist[i].label + "</a></td></tr>"
    }
    str += "</tbody></table>"
    $('#maps').append(str)
    mapListCache = olist;
}

