var multiMapMemoryTableDataView;
var multiMapMemoryTableGrid;
var multiMapThroughputTableDataView;
var multiMapThroughputTableGrid;


function initMultiMapTab() {
    multiMapMemoryTableGrid = null
    multiMapThroughputTableGrid = null
}



function chartmultimap1(datalist) {

    var checkedOpt = $("[name='chartMultiMap1radiogroup']:checked");
    var label = checkedOpt.next().text();
    if (checkedOpt.val().charAt(0) == "i") {
        label += " (X1000)"
        chartOpts.yaxis.autoscaleMargin = 4
    }
    else {
        chartOpts.yaxis.autoscaleMargin = 0.3
    }
    $.plot($("#chartMultiMap1"), [
        {label:label, data:datalist}
    ], chartOpts);
}

function chartmultimap2(datalist) {
    var checkedOpt = $("[name='chartMultiMap2radiogroup']:checked");
    var label = $("[name='chartMultiMap2radiogroup']:checked").next().text();
    if (checkedOpt.val().charAt(0) == "i") {
        label += " (X1000)"
        chartOpts.yaxis.autoscaleMargin = 4
    }
    else {
        chartOpts.yaxis.autoscaleMargin = 2
    }
    $.plot($("#chartMultiMap2"), [
        {label:label, data:datalist}
    ], chartOpts);
}



function multiMapMemoryTable(olist) {
    var columns = [
        {id:"num", name:"#", field:"num", width:40, sortable:true},
        {id:"members", name:"Members", field:"members", width:140, sortable:true, formatter: memberFormatter},
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
        enableCellNavigation: true,
        enableColumnReorder: false
    };

    $("#datatableMultiMap1").css("height", Math.min(olist.length+1, 10) * 30)

    if(multiMapMemoryTableGrid == null) {
        $("#datatableMultiMap1").empty()
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
        multiMapMemoryTableDataView = new Slick.Data.DataView({ inlineFilters:true });
        multiMapMemoryTableDataView.beginUpdate();
        multiMapMemoryTableDataView.setItems(data);
        multiMapMemoryTableDataView.endUpdate();
        multiMapMemoryTableDataView.refresh();
        multiMapMemoryTableGrid = new Slick.Grid("#datatableMultiMap1", multiMapMemoryTableDataView, columns, options);


        multiMapMemoryTableGrid.onSort.subscribe(function (e, args) {
            sortdir = args.sortAsc ? 1 : -1;
            sortcol = args.sortCol.field;
            // using native sort with comparer
            // preferred method but can be very slow in IE with huge datasets
            multiMapMemoryTableDataView.sort(comparerMap, args.sortAsc);
        });

        multiMapMemoryTableDataView.onRowCountChanged.subscribe(function (e, args) {
            multiMapMemoryTableGrid.updateRowCount();
            multiMapMemoryTableGrid.render();
        });

        multiMapMemoryTableDataView.onRowsChanged.subscribe(function (e, args) {
            multiMapMemoryTableGrid.invalidateRows(args.rows);
            multiMapMemoryTableGrid.render();
        });
    }

    else {
        var data = [];
        for (var i = 0; i < olist.length; i++) {
            var ss = olist[i]
            data[i] = {
                id:"mid"+ss[0],
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
        multiMapMemoryTableDataView.beginUpdate();
        multiMapMemoryTableDataView.setItems(data);
        multiMapMemoryTableDataView.endUpdate();
        multiMapMemoryTableDataView.refresh();
        for (var i = 0; i < olist.length; i++) {
            multiMapMemoryTableGrid.updateRow(i)
        }
    }

}



function multiMapThroughputTable(olist) {
    var columns = [
        {id:"num", name:"#", field:"num", width:40, sortable:true},
        {id:"members", name:"Members", field:"members", width:140, sortable:true, formatter: memberFormatter},
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
        enableCellNavigation: true,
        enableColumnReorder: false
    };

    $("#datatableMultiMap2").css("height", Math.min(olist.length+1, 10) * 30)

    if(multiMapThroughputTableGrid == null) {
        $("#datatableMultiMap2").empty()
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
        multiMapThroughputTableDataView = new Slick.Data.DataView({ inlineFilters:true });
        multiMapThroughputTableDataView.beginUpdate();
        multiMapThroughputTableDataView.setItems(data);
        multiMapThroughputTableDataView.endUpdate();
        multiMapThroughputTableDataView.refresh();
        multiMapThroughputTableGrid = new Slick.Grid("#datatableMultiMap2", multiMapThroughputTableDataView, columns, options);


        multiMapThroughputTableGrid.onSort.subscribe(function (e, args) {
            sortdir = args.sortAsc ? 1 : -1;
            sortcol = args.sortCol.field;
            // using native sort with comparer
            // preferred method but can be very slow in IE with huge datasets
            multiMapThroughputTableDataView.sort(comparerMap, args.sortAsc);
        });

        multiMapThroughputTableDataView.onRowCountChanged.subscribe(function (e, args) {
            multiMapThroughputTableGrid.updateRowCount();
            multiMapThroughputTableGrid.render();
        });

        multiMapThroughputTableDataView.onRowsChanged.subscribe(function (e, args) {
            multiMapThroughputTableGrid.invalidateRows(args.rows);
            multiMapThroughputTableGrid.render();
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
        multiMapThroughputTableDataView.beginUpdate();
        multiMapThroughputTableDataView.setItems(data);
        multiMapThroughputTableDataView.endUpdate();
        multiMapThroughputTableDataView.refresh();
        for (var i = 0; i < olist.length; i++) {
            multiMapThroughputTableGrid.updateRow(i)
        }
    }

}




function multimaplist(olist) {
    $('#multimaps').empty()
    var str = "<table><tbody>"
    for (var i = 0; i < olist.length; i++) {
        str += "<tr><td><span class='ui-icon ui-icon-carat-1-e'></span></td><td><a href='#' class='itemLink' onclick='addViewShort(\"" + olist[i].label + "\", \"multimap\" )'>" + olist[i].label + "</a></td></tr>"
    }
    str += "</tbody></table>"
    $('#multimaps').append(str)
    multimapListCache = olist;
}

