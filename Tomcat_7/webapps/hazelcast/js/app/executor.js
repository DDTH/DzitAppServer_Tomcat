var executorInternalTableDataView;
var executorInternalTableGrid;

var executorExternalTableDataView;
var executorExeternalTableGrid;



function initExecutorTab() {
    executorInternalTableGrid = null
    executorExternalTableGrid = null
}


function executorlist(olist) {
    $('#executors').empty()
    if(olist == null) return
    executorListCache = olist;
    var str = "<table><tbody>"
    var hzlist = new Array();
    for (var i = 0; i < olist.length; i++) {
        var label = olist[i].split("x:")[1]
        if(label.indexOf("hz.") == 0)
            hzlist.push(olist[i])
        else
            str += "<tr><td><span class='ui-icon ui-icon-carat-1-e'></span></td><td><a href='#' class='itemLink' onclick='addView(\"" + label + "\", \"" + olist[i] + "\", \"executor\" )'>" + label + "</a></td></tr>"
    }
    if (hzlist.length > 0) {
        str += "<tr><td colspan='2' class='itemlink' style='padding-top: 10px; border-bottom: 1px groove #a9a9a9; '>Internal Executors</td></tr>"
        for (var j = 0; j < hzlist.length; j++) {
        var label = hzlist[j].split("x:hz.")[1]
        str += "<tr><td><span class='ui-icon ui-icon-carat-1-e'></span></td><td><a href='#' class='itemLink' onclick='addView(\"" + label + "\", \"" + hzlist[j] + "\", \"executor\" )'>" + label + "</a></td></tr>"
        }
    }


    str += "</tbody></table>"
    $('#executors').append(str)
}



function datatableinternalexecutor(olist) {
    if(olist == null )
    return

    var columns = [
        {id:"num", name:"#", field:"num", width:40, sortable:true},
        {id:"members", name:"Members", field:"members", width:140, sortable:true, formatter: memberFormatter},
        {id:"pending", name:"Pending", field:"pending", width:80, sortable:true},
        {id:"started", name:"Started", field:"started", width:80, sortable:true},
        {id:"startLatency", name:"Avg Latency", field:"startLatency", width:80, sortable:true},
        {id:"completed", name:"Completed", field:"completed", width:80, sortable:true},
        {id:"completionTime", name:"Avg Completion", field:"completionTime", width:100, sortable:true},
        {id:"minCompletionTime", name:"Min Completion", field:"minCompletionTime", width:100, sortable:true},
        {id:"maxCompletionTime", name:"Max Completion", field:"maxCompletionTime", width:100, sortable:true},
    ];

    var options = {
        enableCellNavigation: true,
        enableColumnReorder: false
    };

    $("#datatableExecutor1").css("height", Math.min(olist.length+1, 10) * 30)

    if(executorInternalTableGrid == null) {
        $("#datatableExecutor1").empty()
        var data = [];
        for (var i = 0; i < olist.length; i++) {
            var ss = olist[i]
            data[i] = {
                id:"e1id" + ss[0],
                num:ss[0],
                members:ss[1],
                pending:ss[2],
                started:ss[3],
                startLatency:ss[4],
                completed:ss[5],
                completionTime:ss[6],
                minCompletionTime:ss[7],
                maxCompletionTime:ss[8]
            };
        }
        executorInternalTableDataView = new Slick.Data.DataView({ inlineFilters:true });
        executorInternalTableDataView.beginUpdate();
        executorInternalTableDataView.setItems(data);
        executorInternalTableDataView.endUpdate();
        executorInternalTableDataView.refresh();
        executorInternalTableGrid = new Slick.Grid("#datatableExecutor1", executorInternalTableDataView, columns, options);


        executorInternalTableGrid.onSort.subscribe(function (e, args) {
            sortdir = args.sortAsc ? 1 : -1;
            sortcol = args.sortCol.field;
            // using native sort with comparer
            // preferred method but can be very slow in IE with huge datasets
            executorInternalTableDataView.sort(comparerMap, args.sortAsc);
        });

        executorInternalTableDataView.onRowCountChanged.subscribe(function (e, args) {
            executorInternalTableGrid.updateRowCount();
            executorInternalTableGrid.render();
        });

        executorInternalTableDataView.onRowsChanged.subscribe(function (e, args) {
            executorInternalTableGrid.invalidateRows(args.rows);
            executorInternalTableGrid.render();
        });
    }

    else {
            var data = [];
            for (var i = 0; i < olist.length; i++) {
                var ss = olist[i]
                data[i] = {
                    id:"e1id" + ss[0],
                        num:ss[0],
                        members:ss[1],
                        pending:ss[2],
                        started:ss[3],
                        startLatency:ss[4],
                        completed:ss[5],
                        completionTime:ss[6],
                        minCompletionTime:ss[7],
                        maxCompletionTime:ss[8]
                };
            }
            executorInternalTableDataView.beginUpdate();
            executorInternalTableDataView.setItems(data);
            executorInternalTableDataView.endUpdate();
            executorInternalTableDataView.refresh();
        for (var i = 0; i < olist.length; i++) {
            executorInternalTableGrid.updateRow(i)
        }
    }

}


function datatableexternalexecutor(olist) {
    if(olist == null )
    return

    var columns = [
        {id:"num", name:"#", field:"num", width:40, sortable:true},
        {id:"members", name:"Members", field:"members", width:140, sortable:true, formatter: memberFormatter},
        {id:"started", name:"Started", field:"started", width:80, sortable:true},
        {id:"completed", name:"Completed", field:"completed", width:80, sortable:true},
        {id:"completionTime", name:"Avg Completion", field:"completionTime", width:100, sortable:true},
        {id:"minCompletionTime", name:"Min Completion", field:"minCompletionTime", width:100, sortable:true},
        {id:"maxCompletionTime", name:"Max Completion", field:"maxCompletionTime", width:100, sortable:true},
    ];

    var options = {
        enableCellNavigation: true,
        enableColumnReorder: false
    };

    $("#datatableExecutor2").css("height", Math.min(olist.length+1, 10) * 30)

    if(executorExternalTableGrid == null) {
        $("#datatableExecutor2").empty()
        var data = [];
        for (var i = 0; i < olist.length; i++) {
            var ss = olist[i]
            data[i] = {
                id:"e1id" + ss[0],
                num:ss[0],
                members:ss[1],
                started:ss[2],
                completed:ss[3],
                completionTime:ss[4],
                minCompletionTime:ss[5],
                maxCompletionTime:ss[6]
            };
        }
        executorExternalTableDataView = new Slick.Data.DataView({ inlineFilters:true });
        executorExternalTableDataView.beginUpdate();
        executorExternalTableDataView.setItems(data);
        executorExternalTableDataView.endUpdate();
        executorExternalTableDataView.refresh();
        executorExternalTableGrid = new Slick.Grid("#datatableExecutor2", executorExternalTableDataView, columns, options);


        executorExternalTableGrid.onSort.subscribe(function (e, args) {
            sortdir = args.sortAsc ? 1 : -1;
            sortcol = args.sortCol.field;
            // using native sort with comparer
            // preferred method but can be very slow in IE with huge datasets
            executorExternalTableDataView.sort(comparerMap, args.sortAsc);
        });

        executorExternalTableDataView.onRowCountChanged.subscribe(function (e, args) {
            executorExternalTableGrid.updateRowCount();
            executorExternalTableGrid.render();
        });

        executorExternalTableDataView.onRowsChanged.subscribe(function (e, args) {
            executorExternalTableGrid.invalidateRows(args.rows);
            executorExternalTableGrid.render();
        });
    }

    else {
            var data = [];
            for (var i = 0; i < olist.length; i++) {
                var ss = olist[i]
                data[i] = {
                    id:"e1id" + ss[0],
                        num:ss[0],
                        members:ss[1],
                        started:ss[2],
                        completed:ss[3],
                        completionTime:ss[4],
                        minCompletionTime:ss[5],
                        maxCompletionTime:ss[6]
                };
            }
            executorExternalTableDataView.beginUpdate();
            executorExternalTableDataView.setItems(data);
            executorExternalTableDataView.endUpdate();
            executorExternalTableDataView.refresh();
        for (var i = 0; i < olist.length; i++) {
            executorExternalTableGrid.updateRow(i)
        }
    }
}

function chartexecutor1(datalist) {
    var label = $("[name='chartExecutor1radiogroup']:checked").next().text();
    $.plot($("#chartExecutor1"), [
        {label:label, data:datalist}
    ], chartOpts);
}

function chartexecutor2(datalist) {
    var label = $("[name='chartExecutor2radiogroup']:checked").next().text();
    $.plot($("#chartExecutor2"), [
        {label:label, data:datalist}
    ], chartOpts);
}