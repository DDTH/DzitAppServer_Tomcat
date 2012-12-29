function refreshpage(repeatSeconds) {
    var default_op = "memberlist_instancelist_executorlist_alertPopup"
    var data = {cluster:activeCluster, operation:default_op}

    if (activeSection != 'sectionHome') {
        default_op = "alertPopup"
        data = {cluster:activeCluster, operation:default_op}

    }else{
        default_op = "memberlist_instancelist_executorlist_alertPopup"
        data = {cluster:activeCluster, operation:default_op}

        if (activeView == 'map') {
            var chart1type = $("[name='chartMap1radiogroup']:checked").val()
            var chart2type = $("[name='chartMap2radiogroup']:checked").val()
            data = {cluster:activeCluster, operation:default_op + "_charts_datatablesMap", type:activeView, instance:activeObject, chart1type:chart1type, chart2type:chart2type }
        }
        else if (activeView == 'multimap') {
            var chart1type = $("[name='chartMultiMap1radiogroup']:checked").val()
            var chart2type = $("[name='chartMultiMap2radiogroup']:checked").val()
            data = {cluster:activeCluster, operation:default_op + "_charts_datatablesMultiMap", type:activeView, instance:activeObject, chart1type:chart1type, chart2type:chart2type }
        }
        else if (activeView == 'topic') {
            var chart1type = $("[name='chartTopic1radiogroup']:checked").val()
            var chart2type = $("[name='chartTopic2radiogroup']:checked").val()
            data = {cluster:activeCluster, operation:default_op + "_charts_datatablesTopic", type:activeView, instance:activeObject, chart1type:chart1type, chart2type:chart2type }
        }
        else if (activeView == 'queue') {
            var chart1type = $("[name='chartQueue1radiogroup']:checked").val()
            var chart2type = $("[name='chartQueue2radiogroup']:checked").val()
            data = {cluster:activeCluster, operation:default_op + "_charts", type:activeView, instance:activeObject, chart1type:chart1type, chart2type:chart2type }
        }
        else if (activeView == 'executor') {
            var chart1type = $("[name='chartExecutor1radiogroup']:checked").val()
            var chart2type = $("[name='chartExecutor2radiogroup']:checked").val()
            data = {cluster:activeCluster, operation:default_op + "_executorstats", instance:activeObject, chart1type:chart1type, chart2type:chart2type }
        }
        else if (activeView == 'member') {
            $("#memberTabs").tabs();
            data = {cluster:activeCluster, operation:default_op + "_memberruntime_memberprops_memberconfig_memberpartitions", member:activeObject }
        }
        else if (activeView == 'cluster') {
            data = {cluster:activeCluster, operation:default_op + "_partitionspiechart_clusterprops"}
        }

        data.curtime = curtime;
    }
    var request = $.ajax({
        url:"main.do",
        data:data,
        cache:false,
        dataType:"json"
    });

    request.done(function (resp) {
        if (resp.error == "node_limit_error") {
            $("#licenseErrorDialog").dialog("open");
            return;
        }

        for (var oper in resp) {
            try {
                eval(oper + "(resp[oper])")
            }
            catch (err) {
                console.log(err)
            }
        }

        if (repeatSeconds > 0 && curtime == 0)
            setTimeout("refreshpage(" + repeatSeconds + ")", repeatSeconds * 1000);
    });
}

function addTabView() {
    var str = activeView + "_" + activeObject
    var idstr = "#tab_" + tabmap[str]
    if ($(idstr).length == 0) {
        tabCounter++;
        $('#tabs').tabs("add", "#tab_" + tabCounter, activeTitle);
        tabmap[str] = tabCounter
        revtabmap["tab_" + tabCounter] = str
    }
    else {
        $('#tabs').tabs('select', idstr);
    }
    return tabCounter
}

function addViewShort(obj, view) {
    addView(obj, obj, view)
}

function addView(title, obj, view) {
    activeTitle = title;
    activeObject = obj;
    activeView = view;
    addTabView()
}

function reloadPage() {
    location.href = "main.do"
}

function resetBannerButtons() {
    $("#radio1").attr("checked", "checked")
    $("#radio1").button("refresh")
}

function changeSection(sid) {
    activeSection = sid
    $(".sectionTable").hide();
    $("." + sid).show();
    if (activeSection == 'sectionHome')
        refreshpage(refreshSeconds)
    else if (activeSection == 'sectionAdministration') {
        if (writeMode == 0) {
            changeSection('sectionHome')
            resetBannerButtons()
            $("#readOnlyError").dialog("open")
        }
        else {
            fillUsersAction()
            fillRoles()
            loadNewUserAction()
        }
    }
    else if(activeSection == 'sectionAlert'){
       fillAlertList()
       getAlertHistoryAction()

    }
    else if (activeSection == 'sectionScripting')
        fillMemberListForScripting()
    else if (activeSection == 'sectionLogs') {
        fillMemberCheckListForLogs()
        getLogLevelAction()
        getLogsAction("none")
    }
    else if (activeSection == 'sectionHealth') {
//        healthCheckAction()
    }
    else if (activeSection == 'sectionDocs') {
        $("#docsTd").html('<iframe id="ifm" frameborder="0" height="100%" width="100%" src="http://www.hazelcast.com/docs/latest/manual/single_html/" />')
        resizeIframe()
    }
}

function pageY(elem) {
    return elem.offsetParent ? (elem.offsetTop + pageY(elem.offsetParent)) : elem.offsetTop;
}
var buffer = 20; //scroll bar buffer
function resizeIframe() {
    var height = document.documentElement.clientHeight;
    height -= pageY(document.getElementById('ifm')) + buffer;
    height = (height < 0) ? 0 : height;
    document.getElementById('ifm').style.height = height + 'px';
}

function disableWriteModeButtons() {
    if (activeRole != "2") {
        $(".writeModeButton").button("disable")
    }
}

function opcall(data) {
    var request = $.ajax({
        url:"main.do",
        data:data,
        cache:false,
        dataType:"json"
    });

    request.done(function (resp) {
        for (var oper in resp) {
            try {
                eval(oper + "(resp[oper])")
            }
            catch (err) {
                console.log(err + "|" + oper + "|" + resp)
            }
        }
    });
}

function htmlFormatter(row, cell, value, columnDef, dataContext){
    return value;
}