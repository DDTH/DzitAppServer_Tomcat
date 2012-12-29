function getAlertHistoryAction() {
    $('div[name=histGrid]').html('<img src="images/loader.gif" />');
    var data = {cluster:activeCluster, operation:"getAlertHistory"}
    opcall(data)
}

function getAlertHistory(olist) {
    var filter_names = olist.filterNames.split(",")

    for(var i = 0 ; i < filter_names.length ; i++){
        if(filter_names[i] != ""){
            if($('#alertHistory_' + filter_names[i]).length == 0 ){
                var strHist = " <div id='alertHistory_"+ filter_names[i] +"' name='histGrid' style='display:none;height:450px;width:800px;' ><h2>There is no data for this filter !</h2></div>" ;
                $("#alertHistoryGrid").append(strHist)
            }
        }
    }

    var hist = olist.alertHistory;

    var data = {}
    for (var i = 0; i < hist.length; i++) {
        var ss = hist[i]
        var entry = [];
        entry = data[ss[1]] //filterName ss[1]
        if(entry == null){
            entry = [];
        }
        entry.push({date: ss[0] , message : ss[2]})
        data[ss[1]] = entry;
    }

     for(var i = 0 ; i < filter_names.length ; i++){
        if(filter_names[i] != ""){
            loadHistory(filter_names[i] , data[filter_names[i]]);
        }
    }
}

function loadHistory(filterName , olist){
    var dataView;
    var grid;

    if(olist == null || olist.length == 0){
        $("#alertHistory_"+filterName).html("<h2>There is no persisted data for this filter !</h2>")
        return
    }
    $("#alertHistory_"+filterName).empty()

    var columns = [
        {id:"date", name:"Date", field:"date", width:160, sortable:true},
        {id:"message", name:"Message(Click on the cell for the full message)", field:"message", width:610, formatter: htmlFormatter}
    ];

    var options = {
        enableCellNavigation:true,
        enableTextSelectionOnCells:true,
        editable:true,
        enableColumnReorder:true
    };
    var data = [];
    for (var i = 0; i < olist.length; i++) {
        data[i] = {id:"id"+ i , date: olist[i].date, message : olist[i].message}
    }
    dataView = new Slick.Data.DataView({ inlineFilters:true });

    dataView.beginUpdate();
    dataView.setItems(data);
    dataView.endUpdate();
    dataView.refresh();

    grid = new Slick.Grid("#alertHistory_"+filterName, dataView, columns, options);
    grid.setSelectionModel(new Slick.RowSelectionModel());

    grid.onActiveCellChanged.subscribe(function (e, cell) {
        if(cell.cell == 1){
            var cc = grid.getCellNode(cell.row, 1)
            $("#alertMessage").html(cc.innerHTML);
            $("#alertMessage").dialog("option", "width", 700);
            $("#alertMessage").dialog("option", "height", 180);
            $("#alertMessage").dialog("open")

        }
    });

    grid.onSort.subscribe(function (e, args) {
        sortdir = args.sortAsc ? 1 : -1;
        sortcol = args.sortCol.field;
        dataView.sort(comparer, args.sortAsc);
    });

     dataView.onRowsChanged.subscribe(function (e, args) {
        grid.invalidateRows(args.rows);
        grid.render();
     });
}

function clearFilterHistoryAction(filterName) {
    $('div[name=histGrid]').html('<img src="images/loader.gif" />');
    var data = {operation:"clearFilterHistory" , cluster:activeCluster,  filterName : filterName}
    opcall(data)
}

function clearFilterHistory(olist){
    getAlertHistoryAction()
}

function fillAlertList()
{
    var filterListDiv = $("#filterListDiv")

    filterListDiv.empty();

    if(admin){
        var str = "<tr><td colspan='3' ><button class='button' id='createFilterButton' onclick='createFilter()' >Create New Filter</button></td><tr>";

        $('#filterListDiv').append($(str));

        $("#createFilterButton").button();
        if(filterCreateOrEdit == "create"){
            closeEverythingBut(["alertTypes"]);
        }
    }
    var data = {operation : "getAlertFilterNames" , cluster : activeCluster}
    opcall(data);
}
function loadAlertFilterNames(olist){
    var filter_names = olist.filterNames.split(",")
    for(var i = 0 ; i < filter_names.length ; i++){
        if(filter_names[i] != "")
            addFilter(filter_names[i]);
    }
}
function addFilter(filterName){
    var str = "<tr id = 'filterName_"+filterName+"'>";
    str += "<td><a href='#' onclick='showPersistedData(\""+filterName+"\")'>"+filterName+"</a></td>";
    if(admin){
        str += "<td><button id='"+filterName+"_editFilter' onclick='editFilter(\""+filterName+"\")' ></button></td>";
        str += "<td><button id=\""+filterName+"_deleteFilter\" onclick='deleteFilter(\""+filterName+"\")' ></button></td>";
        str += "</tr>";
        $('#filterListDiv').append($(str));
        $("#"+filterName+"_editFilter").button({ icons:{ primary:"ui-icon-wrench" } })
        $("#"+filterName+"_editFilter").css("width","30px")
        $("#"+filterName+"_editFilter").css("height","20px")
        $("#"+filterName+"_deleteFilter").button({ icons:{ primary:"ui-icon-closethick" } })
        $("#"+filterName+"_deleteFilter").css("width","30px")
        $("#"+filterName+"_deleteFilter").css("height","20px")
    }else{
        str += "</tr>";
        $('#filterListDiv').append($(str));
    }
}

function saveFilterCheckName(){
    if($('#filterName').val() == "" ){
            $("#saveFilterNoNameDialog").dialog("option", "width", 400);
            $("#saveFilterNoNameDialog").dialog("option", "height", 210);

            $("#saveFilterNoNameDialog").dialog("option", "buttons",
                [
                    {id:"saveFilterNoNameCancel", text:"OK", click:function () {
                        $(this).dialog("close")
                    }}
                ])
            $("#saveFilterNoNameDialog").dialog("open")
            return;

    }
    saveFilterCheckExist();
}

function saveFilterCheckExist(){

    var filterName = $('#filterName').val();
    var filterType = $('input[name=alertTypesRadio]:checked').attr('id');
    if( $("#filterListDiv > tbody > #filterName_"+filterName).length){
        $("#saveFilterDialog").dialog("option", "width", 500);
        $("#saveFilterDialog").dialog("option", "height", 210);

        $("#saveFilterDialog").dialog("option", "buttons",
            [
                {id:"saveFilterOverwrite", text:"Overwrite", click:function () {
                    saveFilterAction(filterType);
                    $(this).dialog("close")

                }},
                {id:"saveFilterCancel", text:"Cancel", click:function () {
                    $(this).dialog("close")
                }}
            ])
        $("#saveFilterDialog").dialog("open")
        return;
    }
    saveFilterAction(filterType);
}

function saveFilterAction(filterType){

   var filterName = $('#filterName').val()
   var isPersisted = $('#persist:checked').length ? true : false
   var emailConfig = $('input[name=email]:checked').attr('id').substring(0,1)
   var periodInMinutes = $('#periodMin option:selected').val() * 1 + $('#periodHour option:selected').val() * 60

    var strHist = " <div id='alertHistory_"+ filterName +"' name='histGrid' style='display:none;height:450px;width:800px;' ><h2>There is no persisted data for this filter !</h2></div>" ;
    $("#alertHistoryGrid").append(strHist)

   if(filterType == "clusterFilterButton"){
        var clusterFilter = $('input[name=clusterFilter]:checked');
        var checkList = new Array();
        for( i = 0; i < clusterFilter.length ; i++){
            checkList[i] = $(clusterFilter[i]).attr('id').substring(7)
        }
        var data = {operation:"saveClusterAlertFilter", filterName: filterName, clusterName:activeCluster, emailConfig : emailConfig , period : periodInMinutes, isPersisted : isPersisted, checkList: checkList.toString() }
        opcall(data)
   }else if(filterType == "memberFilterButton"){
        var memberFilter = $('input[name=memberFilter]:checked')

        var memberList;
        if($('#mall').is(':checked') ){
            memberList = "all";
        }else{
            var member_list = new Array();

            for(var i = 0; i < memberFilter.length ; i++){
                member_list[i] = $(memberFilter[i]).attr('id').substring(1)//1 because starts with m
            }
            memberList = member_list.toString();
        }


        var memberDetails = $('input[name=memberDetails]:checked');
        var checkList = "";
        for(var i= 0; i < memberDetails.length ; i++){
            var prop = $(memberDetails[i]).attr('id').substring(9)
            var value = $('#member_'+prop).val()
            checkList += "##" +prop +":"+value
        }
        checkList = checkList.substring(2)


        var data = {operation:"saveMemberAlertFilter", filterName: filterName, clusterName:activeCluster, emailConfig : emailConfig , period : periodInMinutes, isPersisted : isPersisted, memberList : memberList ,checkList: checkList }
        opcall(data)
   }else if(filterType == "dataTypeFilterButton"){
        var dataType = $('input[name=dataTypeFilterRadio]:checked').attr('id').substring('9')
        var dataFilter = $('input[name=nameFilterList]:checked')

        var dataList ;
        if($('#checkbox_nameFilter_all').is(':checked') ){
            dataList = 'all';
        }else{
            var data_list = new Array();
            for(var i = 0; i < dataFilter.length ; i++){
                data_list[i] =  $(dataFilter[i]).attr('id').substring(20)
            }
            dataList = data_list.toString();
        }

        var memberFilter = $('input[name=memberFilterForDataType]:checked')
        var memberList;
        if($('#mdall').is(':checked') ){
            memberList = "all";
        }else{
            var member_list = new Array();

            for(var i = 0; i < memberFilter.length ; i++){
                member_list[i] = $(memberFilter[i]).attr('id').substring(2)//1 because starts with md
            }
            memberList = member_list.toString();
        }

        var dataTypeDetails = $('tr[name=dataTypeDetails]');
        if(dataType == "executor"){
            dataTypeDetails = $('tr[name=executorDetails]');
        }
        var checkList = "";
        for(var i= 0; i < dataTypeDetails.length ; i++){
            var currentId = $(dataTypeDetails[i]).attr('id')
            var key =  currentId.split("_")[0]
            var op = currentId.split("_")[1]
            var value = currentId.split("_")[2]

            checkList += "##" +key +":"+op + ":" + value
        }
        checkList = checkList.substring(2)

        var data = {operation:"saveDataTypeAlertFilter", filterName: filterName, clusterName:activeCluster, emailConfig : emailConfig , period : periodInMinutes, isPersisted : isPersisted, dataType: dataType, dataList : dataList ,memberList : memberList ,checkList: checkList }
        opcall(data)
   }

}

function saveAlertFilter(olist){
    fillAlertList()
    createFilter()
}

function editFilter(filterName){
    $('#filterName').val(filterName);
    filterCreateOrEdit = "edit";
    var data = {operation : "getAlertFilter" , filterName : filterName , cluster : activeCluster}
    opcall(data)

}

function loadClusterAlertFilter(olist){
    $('#clusterFilterButton').attr("checked","checked");

    $('input[name=clusterFilter]').attr("checked",false)
    var check_list = olist.checkList.split(",");
    for(var i = 0; i < check_list.length ; i++){
        if(check_list[i] != ""){
            $('#cluster' + check_list[i]).attr("checked",true)
        }
    }
    closeEverythingBut(['alertFilters','clusterFilterAccordion','alertActions']);
    loadAlertActions(olist)
    fillAlertList()

}

function loadMemberAlertFilter(olist){
    $('#memberFilterButton').attr("checked","checked");

    $('input[name=memberFilter]').attr("checked",false)
    $('input[name=memberDetails]').attr("checked",false)
    $('#member_freeMemory').val("")
    $('#member_usedMemory').val("")
    $('#member_activeThreads').val("")
    $('#member_daemonThreads').val("")

    fillAlertFiltersAction('memberFilter')
    if(olist.memberList == "all"){
            $('input[name=memberFilter]').attr("checked",true)
    }else{
        var member_list = olist.memberList.split(",");
        for(var i = 0; i < member_list.length ; i++){
            if(member_list[i] != ""){
                $("#m" + member_list[i].replace(/([\.:])/g, '\\$1') ).attr("checked","checked")
            }
        }
    }
    var check_list = olist.checkList.split("##");
    for(var i = 0; i < check_list.length ; i++){
        if(check_list[i] != ""){
            var pair = check_list[i].split(":")
            var prop = pair[0]
            var value = pair[1]
            $('#checkbox_' + prop).attr("checked",true)
            $('#member_'+prop).val(value)
            $('#member_'+prop).attr("disabled",false)
        }
    }

    closeEverythingBut(['alertFilters','memberFilterAccordion','memberSpecificAccordion','alertActions'])
    loadAlertActions(olist)
    fillAlertList()
}

function loadDataTypeAlertFilter(olist){
    $('#dataTypeFilterButton').attr("checked","checked")
    $('#dataType_'+olist.dataType).attr("checked","checked")

    $('input[name=memberFilterForDataType]').attr("checked",false)
    $('input[name=nameFilterList]').attr("checked",false)

    $('tr[name=dataTypeDetails]').remove()
    $('tr[name=executorDetails]').remove()

    fillDataTypeAction(olist.dataType)
    if(olist.dataList == "all"){
        $('input[name=nameFilterList]').attr("checked",true)
    }else{
        var data_list = olist.dataList.split(",")
        for(var i = 0; i < data_list.length ; i++){
            if(data_list[i] != ""){
                $("#checkbox_nameFilter_" + data_list[i].replace(/([\.:])/g, '\\$1') ).attr("checked","checked")
            }
        }
    }
    dataNameIsChosen()
    if(olist.memberList == "all"){
        $('input[name=memberFilterForDataType]').attr("checked",true)
    }else{
        var member_list = olist.memberList.split(",");
        for(var i = 0; i < member_list.length ; i++){
            if(member_list[i] != ""){
                $("#md" + member_list[i].replace(/([\.:])/g, '\\$1') ).attr("checked","checked")
            }
        }

    }
    var check_list = olist.checkList.split("##");
    for(var i = 0; i < check_list.length ; i++){
        if(check_list[i] != ""){
            var key = check_list[i].split(":")[0]
            var op = check_list[i].split(":")[1]
            var value = check_list[i].split(":")[2]
            if(olist.dataType == "executor"){
                insertDataTypeFilterToTable(key,op,value,"executor");
            }else{
                insertDataTypeFilterToTable(key,op,value,"dataType");
            }
        }
    }

    closeEverythingBut(['alertFilters', 'nameFilterAccordion','memberFilterForDataTypeAccordion', 'dataTypeSpecific', 'alertActions'])
    if(olist.dataType == "map" || olist.dataType == "queue" || olist.dataType == "multimap"){
        $("#generalAlertFilterAccordion").show();
    }else if(olist.dataType == "executor") {
        $('#executorAlertFilterAccordion').show()
    }
    loadAlertActions(olist)
    fillAlertList()
}

function loadAlertActions(olist){

    $('#periodMin').val(olist.period%60)
    $('#periodHour').val((olist.period - olist.period%60)/60)
    $('#' + olist.emailConfig + 'email').attr("checked",true)
    $('#persist').attr("checked", olist.isPersisted == "true" ? true : false)

}

function showPersistedData(filterName){
    filterCreateOrEdit = "edit";
    if(admin){
        $('#clearFilterHistoryButtonHolder').html('<button onclick="clearFilterHistoryAction(\''+ filterName +'\')" id="clearFilterHistoryButton" class="button">Clear</button>');
        $('#clearFilterHistoryButton').button();
    }
    $('#filterNameHeader').html(filterName);
    closeEverythingBut(["refreshHistoryButton","alertHistory_"+ filterName, "filterNameHeader","clearFilterHistoryButton","alertHistoryGridAccordion"])

    getAlertHistoryAction();
}

function deleteFilter(filterName){
    $("#deleteFilterDialog").dialog("option", "width", 500);
    $("#deleteFilterDialog").dialog("option", "height", 180);
    $("#deleteFilterDialog").dialog("open")

    $("#deleteFilterDialog").dialog("option", "buttons",
    [
        {id:"deleteFilterDialog", text:"Delete", click:function () {
            $('#filterName_'+filterName).remove()
            $('#alertHistory_'+filterName).remove()
            var data = {operation : "deleteAlertFilter" , filterName : filterName , cluster: activeCluster}
            opcall(data)
            $(this).dialog("close")
        }},
        {id:"deleteFilterDialog", text:"Cancel", click:function () {
            $(this).dialog("close")
        }}
    ])
}

function deleteAlertFilter(olist){
    fillAlertList()
    createFilter()
}

function fillAlertActionsAction(){
    $('#alertFilters').hide()
    $('#clusterFilterAccordion').hide()
    $('#memberFilterAccordion').hide()
    $('#dataTypeFilterAccordion').hide()

    $('#alertActions').show()

}

function nextAction(){
    $('#nextButton').hide();
    $('#cancelFilterButtonC').hide();
    $('#dataTypeSpecific').hide()
    $('#memberSpecificAccordion').hide()

    var dataType = $('#dataType').html();
    if(dataType == "map" || dataType == "queue" || dataType == "multimap"){
        $("#generalAlertFilterAccordion").hide();
    }else if(dataType == "executor") {
        $('#executorAlertFilterAccordion').hide()
    }

    fillAlertActionsAction()
}

function fillAlertFiltersAction(filterName){

    if(filterName == "dataTypeFilter"){

    }
    if(filterName == "clusterFilter"){
        $('#nextButton').show();
        $('#cancelFilterButtonC').show();
    }
    if(filterName == "memberFilter"){
        $('#' + filterName).empty()
        var str = "<table ><tbody>"
        str += "<tr><td style='vertical-align: middle;'><input type='checkbox' name='memberFilter' id = 'mall' onclick=' $(\"input[name=memberFilter]\").attr(\"checked\", $(this).is(\":checked\") ) ' ><a>All</a></td></tr>"

        for (var i = 0; i < memberlistcache.length; i++) {
            str += "<tr><td style='vertical-align: middle;'><input type='checkbox' name='memberFilter' id='m"+memberlistcache[i].label+"' onclick='if( !$(this).is(\":checked\") ){ $(\"#mall\").attr(\"checked\", false ) } '><a>" + memberlistcache[i].label + "</a></td></tr>"
        }
        str += "</td></tr>";
        str += "</tbody></table>"


        if(filterCreateOrEdit == "edit"){
           str += "<button id='chooseMemberListButton' onclick='memberListIsChosen()'  style='display:none;' >Next</button>";
           str += "<button onclick='createFilter()' class='button' id='cancelFilterButtonA' style='float:right;display:none;' >Cancel</button>";

        }else{
           str += "<button onclick='createFilter()' class='button' id='cancelFilterButtonA' style='float:left;' >Cancel</button>";
           str += "<button id='chooseMemberListButton' onclick='memberListIsChosen()' style='float:left;'  >Next</button>";
        }


        $('#' + filterName).append(str)

        $('#cancelFilterButtonA').button();
        $('#chooseMemberListButton').button();
    }


    $('#alertTypes').hide()
    $('#alertFilters').show()
    $('#' + filterName + 'Accordion').show()
}

function memberListIsChosen(){
    $('#memberFilterAccordion').hide();

    $('#memberSpecificAccordion').show();
    $('#nextButton').show();
    $('#cancelFilterButtonC').show();

}

function fillDataTypeAction(dataType){
     $('#dataTypeFilterAccordion').hide();

     $('#dataType').html(dataType);
     $('#dataTypeSpecific').show();

     var olist;
     if(dataType == "map"){
        olist = mapListCache;
     }else if(dataType == "queue"){
        olist = queueListCache;
     }else if(dataType == "multimap"){
        olist = multimapListCache;
     }else if(dataType == "topic"){
        olist = topicListCache;
     }else if(dataType == "executor"){
        olist = executorListCache;
     }
     $('#nameFilterList').empty();
     var str = "<table><tbody>"
     str += "<tr><td><input type='checkbox' name='nameFilterList' id='checkbox_nameFilter_all' onclick='$(\"input[name=nameFilterList]\").attr(\"checked\", $(this).is(\":checked\") ) ' ></td><td><a>All</a></td></tr>"

     for (var i = 0; i < olist.length; i++) {
            if(dataType == "map")
                if(olist[i].label.indexOf("q:") == 0)
                    continue;
            if(dataType == "executor")
                str += "<tr><td><input type='checkbox' name='nameFilterList' id='checkbox_nameFilter_"+ olist[i]+"' onclick='if( !$(this).is(\":checked\") ){ $(\"#checkbox_nameFilter_all\").attr(\"checked\", false ) } ' ></td><td><a>" + olist[i] + "</a></td></tr>"
            else
                str += "<tr><td><input type='checkbox' name='nameFilterList' id='checkbox_nameFilter_"+ olist[i].label +"' onclick='if( !$(this).is(\":checked\") ){ $(\"#checkbox_nameFilter_all\").attr(\"checked\", false ) } ' ></td><td><a>" + olist[i].label + "</a></td></tr>"
     }
     str += "</tbody></table></br>"
     $('#nameFilterList').append($(str))

     $('#nameFilterAccordion').show();
     $('#dataNameChooseButton').show();
     $('#cancelFilterButton').show();
}

function dataNameIsChosen(){
    if(filterCreateOrEdit == "create")
        $('#nameFilterAccordion').hide();

    $('#dataNameChooseButton').hide()
    $('#cancelFilterButton').hide()

    var dataName = $('#dataName').val();
    var dataType = $('#dataType').html();
    if(dataName == ""){
        dataName = "all";
    }

    var  str = "<h3>Running on which members ?</h3>"
    str += "<table><tbody>"

    str += "<tr><td style='vertical-align: middle;'><input type='checkbox' id='mdall' name='memberFilterForDataType' onclick=' $(\"input[name=memberFilterForDataType]\").attr(\"checked\", $(this).is(\":checked\") ) ' ><a>All</a></td></tr>"

    for (var i = 0; i < memberlistcache.length; i++) {
        str += "<tr><td style='vertical-align: middle;'><input type='checkbox' name='memberFilterForDataType' id='md"+memberlistcache[i].label+"' onclick='if( !$(this).is(\":checked\") ){ $(\"#mdall\").attr(\"checked\", false ) } ' ><a>" + memberlistcache[i].label + "</a></td></tr>"
    }
    str += "</td></tr>";
    str += "</tbody></table></br>"

    if(filterCreateOrEdit == "edit"){
       str += "<button onclick='createFilter()' class='button' id='cancelFilterButtonB' style='float:left;display:none;' >Cancel</button>";
       str += "<button id='chooseMemberListForDataTypeButton'  onclick='memberFilterForDataTypeIsChosen(\""+ dataName +"\",\""+ dataType +"\")'";
       str += " style='display:none;float:left;' ";
       str += ">Next</button>";

    }else{
       str += "<button onclick='createFilter()' class='button' id='cancelFilterButtonB' style='float:left;' >Cancel</button>";
       str += "<button id='chooseMemberListForDataTypeButton' style='float:left;' onclick='memberFilterForDataTypeIsChosen(\""+ dataName +"\",\""+ dataType +"\")'";
       str += ">Next</button>";
    }

    $("#memberFilterForDataType").html(str);

    $('#cancelFilterButtonB').button();
    $('#chooseMemberListForDataTypeButton').button();

    if(filterCreateOrEdit == "create"){
        $('#chooseMemberListForDataTypeButton').show()
        $("#memberFilterForDataTypeAccordion").show();
    }



}

function memberFilterForDataTypeIsChosen(dataName,dataType){
    $("#memberFilterForDataTypeAccordion").hide();


    if(dataType == "map" ||dataType == "queue" ||dataType == "multimap"){
         $("#generalAlertFilterAccordion").show();
    }else if(dataType == "executor") {
         $('#executorAlertFilterAccordion').show()
    }
    $('#nextButton').show();
    $('#cancelFilterButtonC').show();
}

function addDataTypeFilter(type){
    var value = $('#'+type+'Value').val();
    var key = $('#'+type+'Key option:selected').val();
    var op = $('#'+type+'Operation option:selected').val();
    insertDataTypeFilterToTable(key,op,value,type);

}
function insertDataTypeFilterToTable(key,op,value,type){
    var keyText = $('#'+type+'Key option[value="'+key+'"]').html()
    var opText = $('#'+type+'Operation option[value="'+op+'"]').html()
    if(value == "" )
        value = "0";

    id = key+'_'+op+'_'+value;
    if($('#' + id).length != 0){
        $('#' + id).remove()
    }
    var str = "<tr id='"+ id +"' name='"+type+"Details' >";
    str += "<td style='text-align: center;'>"+keyText+"</td>";
    str += "<td style='text-align: center;'>"+opText+"</td>";
    str += "<td style='text-align: center;'>"+value+"</td>";
    str += "<td style='text-align: center;'><button style='width:33px;height:30px;'id='"+id+"Button' onclick='$(\"#"+ id +"\").remove()' ></button></td>";
    str += "</tr>";
    $('#'+type+'FilterTable').append(str);
    $('#' + id + 'Button').button({ icons:{ primary:"ui-icon-closethick" } });
}

function alertPopup(alert){
    if(alert == null || alert == "")
        return;
     var alertsButton = $('#radio101')
    if($('#alertPopupDialog').css("display") == "block"){
        $("#alertPopup").prepend(alert);
    }else{
        $("#alertPopup").html(alert);
        $("#alertPopupDialog").css(  "position", "fixed")
        $("#alertPopupDialog").css(  "left", alertsButton.offset().left - 238 )
        $("#alertPopupDialog").css(  "top", alertsButton.offset().top + 20 )
        $("#alertPopupDialog").show()
    }
}
function closeEverythingBut(ids){
    $('#alertActions').hide();
    $('#alertTypes').hide();
    $('#alertFilters').hide();
    $('#alertHistoryGridAccordion').hide();
    $('#cancelFilterButton').hide();
    $('#cancelFilterButtonA').hide();
    $('#cancelFilterButtonB').hide();
    $('#cancelFilterButtonC').hide();
    $('#chooseMemberListButton').hide();
    $('#chooseMemberListForDataTypeButton').hide();
    $('#clearFilterHistoryButton').hide();
    $('#clusterFilterAccordion').hide();
    $('#dataNameChooseButton').hide();
    $('#dataTypeFilterAccordion').hide();
    $('#dataTypeSpecific').hide();
    $('div[name=histGrid]').hide();
    $('#executorAlertFilterAccordion').hide();
    $('#filterNameHeader').hide();
    $('#generalAlertFilterAccordion').hide();
    $('#memberFilterAccordion').hide();
    $('#memberFilterForDataTypeAccordion').hide();
    $('#memberSpecificAccordion').hide();
    $('#nameFilterAccordion').hide();
    $('#nextButton').hide();
    $('#refreshHistoryButton').hide();

    for(var i = 0; i < ids.length ; i++){
        $('#'+ids[i]).show();
    }

}

function createFilter(){
    filterCreateOrEdit = "create";
    $('input[name=clusterFilter]').attr("checked",false)
    $('input:radio.dataTypeFilterRadio').removeAttr("checked");
    $('input:radio.dataTypeFilterRadio').button("refresh")
    $('input[name=alertTypesRadio]').removeAttr("checked");
    $('input[name=alertTypesRadio]').button("refresh")
    $('tr[name=dataTypeDetails]').remove()
    $('tr[name=executorDetails]').remove()
    $('#filterName').val("")
    closeEverythingBut(["alertTypes"])
}
