
function getLogsFromFile() {
    getLogsAction($("#logFilePath").val());
}

function setLogLevelAction() {
    var loglevel = $("#logLevelSelect").val()
    if (loglevel == "")
        return;
    var data = {cluster:activeCluster, operation:"setloglevel", loglevel:loglevel}
    opcall(data)
}


function getLogLevelAction() {
    var data = {cluster:activeCluster, operation:"getloglevel"}
    opcall(data)

}

function getLogsAction(filepath) {

    $("#logsGrid").html('<img src="images/loader.gif" class="loaderImage"/>')
    var data = {cluster:activeCluster, operation:"getlogs", curtime:0, filepath:filepath}
    opcall(data)
}

function logFilter(item, args) {
//    if (args.messageParam != "" && item["message"].indexOf(args.messageParam) == -1) {
    if (args.messageParam != "" && !item["message"].match(new RegExp(args.messageParam, "i"))) {
        return false;
    }

    if (args.callIdParam != "" && !String(item["callId"]).match(new RegExp(args.callIdParam, "i"))) {
        return false;
    }

    if (args.memberParam != "" && args.memberParam.indexOf(item["member"]) == -1) {
        return false;
    }

    if (args.memberParam2 != "" && !String(item["member"]).match(new RegExp(args.memberParam2, "i"))) {
        return false;
    }

    if (args.typeParam != "" && args.typeParam.indexOf(item["type"]) == -1) {
        return false;
    }

    return true;
}


function getlogs(olist) {
    var dataView;
    var grid;
    var columns = [
        {id:"date", name:"Date", field:"date", width:160, sortable:true},
        {id:"callId", name:"Call Id", field:"callId", width:90, sortable:true},
        {id:"member", name:"Member", field:"member", width:130, sortable:true},
        {id:"type", name:"Type", field:"type", sortable:true},
        {id:"message", name:"Message", field:"message", width:480}
    ];

    var options = {
        enableCellNavigation:true,
        enableTextSelectionOnCells:true,
        editable:true,
        enableColumnReorder:true
    };

    var data = [];
    for (var i = 0; i < olist.length; i++) {
        var ss = olist[i]
        var date = new Date(ss.date)
        data[i] = {
            id:"id" + i,
            date:$.format.date(date, "dd/MM/yyyy HH:mm:ss") + ":" + date.getMilliseconds(),
            callId:ss.callId,
            member:ss.node,
            type:ss.type,
            message:ss.message
        };
    }
    dataView = new Slick.Data.DataView({ inlineFilters:true });

    dataView.beginUpdate();
    dataView.setItems(data);
    dataView.setFilterArgs({
        messageParam:"",
        memberParam:"",
        memberParam2:"",
        typeParam:"",
        callIdParam:""
    });
    dataView.setFilter(logFilter);
    dataView.endUpdate();
    dataView.refresh();

    grid = new Slick.Grid("#logsGrid", dataView, columns, options);
    grid.setSelectionModel(new Slick.RowSelectionModel());

    grid.onSort.subscribe(function (e, args) {
        sortdir = args.sortAsc ? 1 : -1;
        sortcol = args.sortCol.field;
        // using native sort with comparer
        // preferred method but can be very slow in IE with huge datasets
        dataView.sort(comparer, args.sortAsc);
    });

     grid.onDblClick.subscribe(function (e, cell) {
         var ss = grid.getColumns()[cell.cell]
         var cc = grid.getCellNode(cell.row, 4)
         $( "#logDetailDialog").html(cc.innerHTML);
         $( "#logDetailDialog" ).dialog("open");
     });

    grid.onActiveCellChanged.subscribe(function (e, cell) {
        var ss = grid.getColumns()[cell.cell]
        var cc = grid.getCellNode(cell.row, 4)
        $("#fullLogMessageText").val(cc.innerHTML)
    });

    dataView.onRowCountChanged.subscribe(function (e, args) {
        grid.updateRowCount();
        grid.render();
    });

    dataView.onRowsChanged.subscribe(function (e, args) {
        grid.invalidateRows(args.rows);
        grid.render();
    });

    $("[name='memberchecklistForLogs'],[name='typechecklistForLogs']").click(function () {
        filterLogs(dataView)
    })

    // wire up the search textbox to apply the filter to the model
    $("#logFilterMessage,#logFilterCallId,#logFilterMembers").keyup(function (e) {
        // clear on Esc
        if (e.which == 27) {
            this.value = "";
        }
        filterLogs(dataView)
    });
    filterLogs(dataView)
}

function filterLogs(dataView) {
    $("#fullLogMessageText").val("")

    var memberParam = ""
    var memberParam2 = ""
    var typeParam = ""

    if ($("[name='typechecklistForLogs']").not(":checked").size() > 0) {
        $("[name='typechecklistForLogs']:checked").each(
            function () {
                typeParam = typeParam + "#" + $(this).val()
            }
        )
        if (typeParam == "")
            typeParam = "none"
    }

    if ($("[name='memberchecklistForLogs']").not(":checked").size() > 0) {
        $("[name='memberchecklistForLogs']:checked").each(
            function () {
                memberParam = memberParam + "#" + $(this).val()
            }
        )
        if (memberParam == "")
            memberParam = "none"
    }

    if($("#logFilterMembers").val().length > 0) {
            memberParam2 = $("#logFilterMembers").val();
    }

    dataView.setFilterArgs({
        messageParam:$("#logFilterMessage").val(),
        memberParam:memberParam,
        memberParam2:memberParam2,
        typeParam:typeParam,
        callIdParam:$("#logFilterCallId").val()
    });
    dataView.refresh();
}

function comparer(a, b) {
    var x = a[sortcol], y = b[sortcol];
    return (x == y ? 0 : (x > y ? 1 : -1));
}

function setloglevel(data) {
    $("#logLevelResultDialog").dialog("open");
}


function getloglevel(data) {
    if(data == 'none')
        $("#logLevelWarningDialog").dialog("open");

    $("#logLevelSelect").val(data)
}
