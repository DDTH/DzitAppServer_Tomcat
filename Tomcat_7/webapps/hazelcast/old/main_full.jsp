<!DOCTYPE html>
<html>
<head>
<title>Hazelcast Management Center (BETA)</title>
<style type="text/css">

    html, body {
        margin: 0;
        padding: 0;
        height: 100%;
    }

    iframe {
        margin: 0;
        padding: 0;
        height: 100%;
        min-height: 100%;
    }

    button {
        font-size: 10pt;
    }

    select {
        width: 80px;
    }

    input[type="text"], input[type="password"] {
        width: 120px;
    }

    .leftPanel {
        width: 240px;
        height: 100%;
        vertical-align: top;
    }

    .itemLink {
        text-decoration: none;
        font-weight: bold;
        font-size: 8pt;
    }

    .loaderImage {
        margin: 10px;
    }

    .clusterPropsLabelTd {
    }

    .clusterPropsValueTd {
        width: 500px;
    }

    .memberCheckDiv {
        padding: 5px;
        width: 200px;
        vertical-align: middle;
    }

    .smallLabel {
        width: 150px;
        font-size: 9pt;
        font-weight: bold;
    }

    .sectionTable {
        display: none;
    }

    .chartDivSmall {
        width: 370px;
        height: 200px;
        cursor: pointer;
    }

    .chartDiv {
        width: 400px;
        height: 300px;
        cursor: pointer;
    }

    .chartoptsmenu {
        width: 450px;
    }

    .chartoptsmenu label {
        width: 140px;
    }

    .memberIcon {
        width: 32px;
        height: 32px;
    }

    .partitionDiv {
        float: left;
        text-align: center;
        padding: 10px;
        border: 1px solid black;
        width: 50px;
    }

    .valueTd {
        font-size: 9pt;
    }

    .valueTdSmall {
        font-size: 7pt;
    }

    .browseValueTd {
        width: 300px;
    }

    .infoLabel {
        font-weight: bold;
        font-size: 9pt;
        text-align: right;
        padding-right: 20px;
        white-space: nowrap;
    }

    .tabsDiv {
        width: 100%;
        height: 100%;
        vertical-align: top;
    }

    .instanceButtons {
        width: 225px;
    }

    .mapButtons {
        width: 170px;
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
        background-image: url("../images/banner_bg.png");
        padding-left: 10px;
        height: 60px;
    }

    .logFilters {
        font-weight: bold;
    }


</style>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js">
</script>
<script type="text/javascript" src="../js/jquery.event.drag-2.0.min.js">
</script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.18/jquery-ui.min.js">
</script>
<script type="text/javascript" src="../js/jquery.flot.js">
</script>
<script language="javascript" type="text/javascript" src="../js/jquery.flot.pie.js"></script>

<!--[if lte IE 8]>
<script language="javascript" type="text/javascript" src="js/excanvas.min.js"></script><![endif]-->

<link rel="stylesheet" type="text/css" href="css/custom-theme/jquery-ui-1.8.17.custom.css"/>
<link rel="stylesheet" type="text/css" href="js/flexigrid/css/flexigrid.css"/>

<script type="text/javascript" src="js/jstree/jquery.jstree.js">
</script>
<script type="text/javascript" src="js/flexigrid/js/flexigrid.js">
</script>

<link rel="stylesheet" href="http://yandex.st/highlightjs/6.1/styles/default.min.css">


<script src="http://yandex.st/highlightjs/6.1/highlight.min.js" type="text/javascript"></script>
<script src="js/jquery.dateFormat-1.0.js" type="text/javascript"></script>
<script src="js/jquery.cookie.js" type="text/javascript"></script>

<link rel="stylesheet" href="js/slickgrid/slick.grid.css" type="text/css"/>
<link rel="stylesheet" href="js/slickgrid/slick-default-theme.css" type="text/css"/>
<script src="js/slickgrid/slick.core.js" type="text/javascript"></script>
<script src="js/slickgrid/slick.grid.js" type="text/javascript"></script>
<script src="js/slickgrid/slick.editors.js" type="text/javascript"></script>
<script src="js/slickgrid/slick.formatters.js" type="text/javascript"></script>
<script src="js/slickgrid/slick.dataview.js" type="text/javascript"></script>
<script src="js/slickgrid/plugins/slick.cellrangeselector.js"></script>
<script src="js/slickgrid/plugins/slick.cellselectionmodel.js"></script>
<script src="js/slickgrid/plugins/slick.rowselectionmodel.js"></script>
<script type="text/javascript">

var namespace = ""
var clusterList = new Array();
var admin = "0";
var activeRole = "";
var activeCluster = "";
var activeSection = "sectionHome";
var activeView = "";
var activeObject = "";
var activeTitle = "";
var tabCounter = 0;
var tabmap = {};
var revtabmap = {};
var methodmap = {};
var curtime = 0;
var refreshSeconds = 5;
var memberlistcache;
var mapMemoryTableDataView;
var mapMemoryTableGrid;

/** init.js **/
$(document).ready(function () {
    $(".sectionHome").show();

    $("#licenseErrorDialog").dialog({
        autoOpen:false,
        height:200,
        width:500,
        modal:true,
        buttons:[
            {id:"retryButton", text:"Retry", click:function () {
                reloadPage()
            }}
        ],
        beforeClose:function (event, ui) {
            return false;
        }
    });

    $(".chartoptsdiv").dialog({
        autoOpen:false,
        height:200,
        width:500,
        modal:true
    });

    $("#consoleDiv").dialog({
        autoOpen:false,
        height:300,
        width:680,
        modal:true
    });

    $("#commandInput").keyup(function (event) {
        if (event.keyCode == 13) {
            sendCommand();
        }
    });

    $(".onEnterSubmit").keyup(function (event) {
        if (event.keyCode == 13) {
            loginAction();
        }
    });

    $("#threadDumpDiv").dialog({
        autoOpen:false,
        height:570,
        width:640,
        modal:true
    });

    $("#mapBrowserDiv").dialog({
        autoOpen:false,
        height:210,
        width:830,
        modal:true
    });

    $("#mapConfigDiv").dialog({
        autoOpen:false,
        height:260,
        width:770,
        modal:true
    });

    $("#gcResultDialog").dialog({
        autoOpen:false,
        height:100,
        modal:true
    });

    $("#logLevelResultDialog").dialog({
        autoOpen:false,
        height:100,
        modal:true
    });

    $("#deleteUserConfirm").dialog({
        autoOpen:false,
        height:240,
        modal:true,
        buttons:{
            "Delete User":function () {
                deleteUserAction()
                $(this).dialog("close");
            },
            Cancel:function () {
                $(this).dialog("close");
            }
        }
    });

    $("#timeTravelDiv").hide()
    $("#applyWarnDiv").hide()
    $("#loadingDiv").hide()
    $(".loginDivs").hide()
    $("#deleteUserButton").hide()
//    $("#resetPasswordButton").hide()


    var tabs = $("#tabs").tabs({
        tabTemplate:"<li><a href='#{href}' >#{label}</a> <span class='ui-icon ui-icon-close'>Remove Tab</span></li>",
        add:function (event, ui) {
            tabs.tabs('select', '#' + ui.panel.id);
        },
        select:function (event, ui) {
            if (revtabmap[ui.panel.id]) {
                var str = revtabmap[ui.panel.id].split("_")
                activeView = str[0]
                activeObject = str[1]
            }
        },
        show:function (event, ui) {
            $(".ui-tabs-panel").empty();
            var content = getInitialContent()
            $(ui.panel).append(content);
            if (methodmap[activeView]) {
                eval(methodmap[activeView])
            }
            refreshpage(0)
        }
    });


    $("#tabs span.ui-icon-close").live("click", function () {
        var index = $("li", tabs).index($(this).parent());
        tabs.tabs("remove", index);
    });


    $(".chartoptsdiv").buttonset();
    $(".chartoptsdiv input").click(function () {
        refreshpage(0)
    })


    $(".buttonset").buttonset();
    $(".button").button();

    $("#radio1").button({ icons:{primary:'ui-icon-home'} });
//    $("#radio2").button({ icons: {primary:'ui-icon-check'} });
    $("#radio3").button({ icons:{primary:'ui-icon-pencil'} });
//    $("#radio4").button({ icons: {primary:'ui-icon-gear'} });
    $("#radio5").button({ icons:{primary:'ui-icon-document'} });
//    $("#radio6").button({ icons: {primary:'ui-icon-help'} });
    $("#radio7").button({ icons:{primary:'ui-icon-clipboard'} });


    $("#consoleButton").button({
        text:false,
        icons:{
            primary:"ui-icon-script"
        }
    })

    $("#logoutButton").button({
        text:false,
        icons:{
            primary:"ui-icon-power"
        }
    })


    $("#enterLicenseButton").button({
        text:false,
        icons:{
            primary:"ui-icon-key"
        }
    })

    $("#clusterHomeButton").button({
        text:false,
        icons:{
            primary:"ui-icon-home"
        }
    })

    $("#timeTravelButton").button({
        text:false,
        icons:{
            primary:"ui-icon-clock"
        }
    })


    $("#backbutton").button({ text:false, icons:{primary:'ui-icon-seek-prev'} });
    $("#forwardbutton").button({ text:false, icons:{primary:'ui-icon-seek-next'} });


    $(".accordion").accordion({
        collapsible:true,
        autoHeight:false,
        active:false
    });

    $("#mapAccordion").accordion("activate", 0);
    $("#memberListAccordion").accordion("activate", 0);
    $("#memberCheckListAccordion").accordion("activate", 0);
    $("#scriptLanguageAccordion").accordion("activate", 0);
    $("#userListAccordion").accordion("activate", 0);
    $("#userEditAccordion").accordion("activate", 0);
    $("#memberLogsCheckListAccordion").accordion("activate", 0);


    $("#datepicker").datepicker({
        onSelect:function (dateText, inst) {
            prepareSlider()
        },
        showOn:"button",
        buttonImage:"images/calendar.png",
        buttonImageOnly:true
    });
    $("#datepicker").datepicker("setDate", new Date())

    prepareSlider()
    curtime = 0;


    methodmap["map"] = "initMapTab()";
    methodmap["member"] = "enableMemberButtons()";
//    clusterHome();
//    refreshpage(refreshSeconds);
//    $("#tabs").tabs("remove", 0)

    $(".resizable").resizable();

    var username = null;
    var password = null;
    var c_username = $.cookie('c_username')
    if (c_username != null && c_username != "") {
        username = c_username
        password = $.cookie('c_password')
    }

    $("#login_dialog").dialog({
        autoOpen:true,
        height:265,
        width:270,
        modal:true,
        buttons:{
            "Login":function () {
                loginAction();
            }
        }
    });

    if (password != null) {
        $("#loginDiv").hide()
        loginActionWithParams(username, password)
    }
});


function init() {
    var str = $("[name='clusterradiolist']:checked").val()
    activeRole = str.split("-")[0]
    activeCluster = str.split("-")[1]
    $("#exportLogsLink").attr("href", $("#exportLogsLink").attr("href") + "&cluster=" + activeCluster)

    if (admin == 1) {
        $("#topButtonDiv").append('<input type="radio" id="radio100" name="radiomenu" /><label for="radio100">Administration</label>')
        $("#radio100").button({ icons:{primary:'ui-icon-person'} }).click(function () {
            changeSection("sectionAdministration")
        });
    }

    clusterHome();
    refreshpage(refreshSeconds);
    $("#tabs").tabs("remove", 0)
    disableWriteModeButtons()
}

/** init.js **/

function disableWriteModeButtons() {
    if (activeRole != "2") {
        $(".writeModeButton").button("disable")
    }
}


/** members.js **/
function enableMemberButtons() {
    $("#threadDumpButton")
            .button({
                text:true,
                icons:{
                    primary:"ui-icon-search"
                }
            })
            .click(function () {
                getThreadDump()
            })

    $("#runGCButton")
            .button({
                text:true,
                icons:{
                    primary:"ui-icon-gear"
                }
            })
            .click(function () {
                sendGC()
            })
    disableWriteModeButtons()
}

/** members.js **/


/** maps.js **>


 /** maps.js **>

function initMapTab() {
    mapMemoryTableGrid = null
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
            })
    disableWriteModeButtons()

}

function openConsole() {
    $("#consoleDiv").dialog("open")
    $("#commandInput").focus()
}


function prepareSlider() {
    $("#slider").slider({
        slide:function (event, ui) {
            if (ui.value > new Date().getTime()) {
                $("#slider").slider("value", new Date().getTime());
                refreshTimeLabel()
                return false;
            }
            refreshTimeLabel()
        },
        change:function (event, ui) {
            curtime = ui.value
            refreshTimeLabel()
            refreshpage(0)
        },
        max:getEndDate().getTime(),
        min:getStartDate().getTime(),
        step:1000 * refreshSeconds
    });

    $("#slider").slider("value", Math.min($("#slider").slider("option", "max"), new Date().getTime()));
    refreshTimeLabel()

}

function refreshTimeLabel() {
    $("#timeLabel").html($.format.date(new Date($("#slider").slider("value")), "dd/MM/yyyy HH:mm:ss"))
}

function backTime() {
    $("#slider").slider("value", $("#slider").slider("option", "value") - $("#slider").slider("option", "step"))
}

function forwardTime() {
    $("#slider").slider("value", $("#slider").slider("option", "value") + $("#slider").slider("option", "step"))
}

function getStartDate() {
    var dt = $("#datepicker").datepicker("getDate")
    dt.setHours(0)
    dt.setMinutes(0)
    dt.setSeconds(0)
    return dt
}

function getEndDate() {
    var dt = $("#datepicker").datepicker("getDate")
    var now = new Date()
    dt.setHours(23)
    dt.setMinutes(59)
    dt.setSeconds(59)
    return dt
}

function getInitialContent() {
    return $("#" + activeView + "ContentTemplate").html()
}


function sendCommand() {

    var command = $("#commandInput").val()
    $("#commandInput").val("")
    $("#commandInput").focus()


    $("#commandOutput").val($("#commandOutput").val() + namespace + "> " + command + "\n")

    if (command.indexOf("ns") == 0) {
        namespace = command.split(" ")[1]
        $("#commandOutput").val($("#commandOutput").val() + "> Current Namespace:" + namespace + "\n")
        var textArea = document.getElementById('commandOutput');
        textArea.scrollTop = textArea.scrollHeight;
        return;
    }


    var data = {cluster:activeCluster, operation:"executecommand", namespace:namespace, command:command }
    var request = $.ajax({
        url:"main.do",
        data:data,
        cache:false,
        dataType:"json"
    });

    request.done(function (resp) {
        for (var oper in resp) {
            eval(oper + "(resp[oper])")
        }
    });
}


function sendScript() {
    var script = $("#scriptarea").val()
    var targetList = $("[name='memberchecklist']:checked")
    var targets = ""
    targetList.each(function () {
        if (targets.length > 0)
            targets += "," + $(this).val()
        else
            targets = $(this).val()
    })

    if (targets.length == 0) {
        alert("Please select at least one member to execute the script...")
        return
    }

    var data = {cluster:activeCluster, operation:"executescript", script:script, targets:targets, lang:$("[name='radioscriptlanguage']:checked").val()}
    var request = $.ajax({
        url:"main.do",
        data:data,
        cache:false,
        dataType:"json"
    });

    request.done(function (resp) {
        for (var oper in resp) {
            eval(oper + "(resp[oper])")
        }
    });
}


function browseMapValue() {
    var type = $("#selectMapBrowserType").val()
    var data = {cluster:activeCluster, operation:"browsemap", mapName:activeObject, key:$("#mapkey").val(), type:type}
    var request = $.ajax({
        url:"main.do",
        data:data,
        cache:false,
        dataType:"json"
    });

    request.done(function (resp) {
        for (var oper in resp) {
            eval(oper + "(resp[oper])")
        }
    });
}


function saveUserAction() {
    var password = $("#a_password").val()
    if (password != $("#a_password_retype").val()) {
        alert("Passwords mismatch.")
        return;
    }


    var username = $("#a_username").val()
    var admin = $("#a_admin").attr("checked") == 'checked' ? 1 : 0;
    var roles = ""
    $(".roleRadio:checked").each(
            function (index) {
                roles = roles + "###" + $(this).val();
            });

    var data = {operation:"saveuser", username:username, password:password, admin:admin, roles:roles}
    var request = $.ajax({
        url:"main.do",
        data:data,
        cache:false,
        dataType:"json"
    });

    request.done(function (resp) {
        for (var oper in resp) {
            eval(oper + "(resp[oper])")
        }
    });
}


function showDeleteUserConfirm() {
    $('#deleteUserConfirm').dialog('open')
}


function deleteUserAction() {
    var username = $("#a_username").val()

    var data = {operation:"deleteuser", username:username}
    var request = $.ajax({
        url:"main.do",
        data:data,
        cache:false,
        dataType:"json"
    });

    request.done(function (resp) {
        for (var oper in resp) {
            eval(oper + "(resp[oper])")
        }
    });
}


function getThreadDump() {
    var data = {cluster:activeCluster, operation:"threaddump", member:activeObject }
    var request = $.ajax({
        url:"main.do",
        data:data,
        cache:false,
        dataType:"json"
    });

    request.done(function (resp) {
        for (var oper in resp) {
            eval(oper + "(resp[oper])")
        }
    });
}


function loginAction() {
    var username = $("#login_username").val()
    var password = $("#login_password").val()
    loginActionWithParams(username, password)
}

function loginActionWithParams(username, password) {
    var data = {operation:"login", username:username, password:password}
    var request = $.ajax({
        url:"main.do",
        data:data,
        cache:false,
        dataType:"json"
    });

    request.done(function (resp) {
        for (var oper in resp) {
            eval(oper + "(resp[oper])")
        }
    });
}

function saveLicenseAction() {
    var key = $("#licenseKeyInput").val()
    var data = {operation:"savelicense", key:key}
    var request = $.ajax({
        url:"main.do",
        data:data,
        cache:false,
        dataType:"json"
    });

    request.done(function (resp) {
        for (var oper in resp) {
            eval(oper + "(resp[oper])")
        }
    });
}

function applyLicenseAction() {
    $("#login_dialog").dialog("show")
    $("#login_dialog").dialog("option", "position", 'top');
    $("#login_dialog").dialog("option", "width", 500);
    $("#login_dialog").dialog("option", "height", 520);
    $("#login_dialog").dialog("option", "buttons", [])
    $(".loginDivs").hide()
    $("#applyLicenseDiv").show("slide")
}


function fillRoles() {
    $("#a_roles").empty()

    var str = "<table cellspacing=5 ><tr><td style='border-bottom: 1px solid gray; font-weight: bold; text-align: center;'>Cluster Name</td><td style='border-bottom: 1px solid gray; font-weight: bold; text-align: center;'>Permissions</td></tr>"
    for (var i = 0; i < clusterList.length; i++) {
        var cluster = clusterList[i]
        str += "<tr><td>" + cluster + "</td><td>  <input type='radio' class='roleRadio roleChecked' checked='checked'  name='" + cluster + "'Role' value='0-" + cluster + "' id='0-" + cluster + "' /> <label for='0-" + cluster + "'> None </label> &nbsp;&nbsp;  <input type='radio' class='roleRadio' name='" + cluster + "'Role' value='1-" + cluster + "' id='1-" + cluster + "' /> <label for='1-" + cluster + "'> Read Only </label> &nbsp;&nbsp; <input class='roleRadio' type='radio' name='" + cluster + "'Role' value='2-" + cluster + "' id='2-" + cluster + "' /> <label for='2-" + cluster + "'> Read/Write </label></td></tr>";
    }
    str += "</table>"
    $("#a_roles").append(str)

}

function fillUsersAction() {
    var data = {operation:"userlist"}
    var request = $.ajax({
        url:"main.do",
        data:data,
        cache:false,
        dataType:"json"
    });

    request.done(function (resp) {
        for (var oper in resp) {
            eval(oper + "(resp[oper])")
        }
    });
}

function sendGC() {
    var data = {cluster:activeCluster, operation:"rungc", member:activeObject }
    var request = $.ajax({
        url:"main.do",
        data:data,
        cache:false,
        dataType:"json"
    });

    request.done(function (resp) {
        for (var oper in resp) {
            eval(oper + "(resp[oper])")
        }
    });
}

function threaddump(data) {
    $("#threadDumpDiv").dialog("open");
    $("#threadDumpTextarea").html(data.data)
}

function rungc(data) {
    $("#gcResultDialog").dialog("open");
}

function setloglevel(data) {
    $("#logLevelResultDialog").dialog("open");
}

function saveuser(data) {
    if (data.data == 'success')
        fillUsersAction()
}

function deleteuser(data) {
    if (data.data == 'success') {
        fillUsersAction()
        loadNewUserAction()
    }
}


function executecommand(data) {
    $("#commandOutput").val($("#commandOutput").val() + namespace + "> " + data)
    var textArea = document.getElementById('commandOutput');
    textArea.scrollTop = textArea.scrollHeight;
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

    var request = $.ajax({
        url:"main.do",
        data:data,
        cache:false,
        dataType:"json"
    });

    request.done(function (resp) {
        for (var oper in resp) {
            eval(oper + "(resp[oper])")
        }
    });

}
function showMapConfig() {
    var data = {cluster:activeCluster, operation:"loadmapconfig", mapName:activeObject}
    var request = $.ajax({
        url:"main.do",
        data:data,
        cache:false,
        dataType:"json"
    });

    request.done(function (resp) {
        for (var oper in resp) {
            eval(oper + "(resp[oper])")
        }

    });
}


function editUser(usr) {
    var data = {user:usr, operation:"loaduser"}

    var request = $.ajax({
        url:"main.do",
        data:data,
        cache:false,
        dataType:"json"
    });

    request.done(function (resp) {
        for (var oper in resp) {
            eval(oper + "(resp[oper])")
        }
    });
}


function fillMemberListForScripting() {
    $('#memberCheckList').empty()
    for (var i = 0; i < memberlistcache.length; i++) {
        $('#memberCheckList').append("<div class='memberCheckDiv' ><input id='memberchecklist" + i + "' checked='checked' type='checkbox' name='memberchecklist' value='" + memberlistcache[i].label + "'  /><label for='memberchecklist" + i + "' class='itemLink'>" + memberlistcache[i].label + "</label></div>")
    }
}

function getLogsFromFile() {
    getLogsAction($("#logFilePath").val());
//    getLogsAction("C:\\Users\\Enes\\hazel.json");
}

function setLogLevelAction() {
    var loglevel = $("#logLevelSelect").val()
    if (loglevel == "")
        return;
    var data = {cluster:activeCluster, operation:"setloglevel", curtime:0, loglevel:loglevel}

    var request = $.ajax({
        url:"main.do",
        data:data,
        cache:false,
        dataType:"json"
    });

    request.done(function (resp) {
        for (var oper in resp) {
            eval(oper + "(resp[oper])")
        }
    });

}

function getLogsAction(filepath) {

    $("#logsGrid").html('<img src="images/loader.gif" class="loaderImage"/>')
    var data = {cluster:activeCluster, operation:"getlogs", curtime:0, filepath:filepath}

    var request = $.ajax({
        url:"main.do",
        data:data,
        cache:false,
        dataType:"json"
    });

    request.done(function (resp) {
        for (var oper in resp) {
            eval(oper + "(resp[oper])")
        }
    });
}


function refreshpage(repeatSeconds) {

    if (activeSection != 'sectionHome')
        return;

    var default_op = "memberlist_instancelist"
    var data = {cluster:activeCluster, operation:default_op}

    if (activeView == 'map') {
        var chart1type = $("[name='chartMap1radiogroup']:checked").val()
        var chart2type = $("[name='chartMap2radiogroup']:checked").val()
        data = {cluster:activeCluster, operation:default_op + "_charts_datatablesMap", type:activeView, instance:activeObject, chart1type:chart1type, chart2type:chart2type }
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
    else if (activeView == 'member') {
        $("#memberTabs").tabs();
        data = {cluster:activeCluster, operation:default_op + "_memberruntime_memberprops_memberconfig_memberpartitions", member:activeObject }
    }
    else if (activeView == 'cluster') {
        data = {cluster:activeCluster, operation:default_op + "_partitionspiechart_clusterprops"}
    }

    data.curtime = curtime;

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
            eval(oper + "(resp[oper])")
        }

        if (repeatSeconds > 0 && curtime == 0)
            setTimeout("refreshpage(" + repeatSeconds + ")", repeatSeconds * 1000);
    });
}


function loadNewUserAction() {
    $("#a_username").val("")
    $("#a_username").attr("readonly", false)
    $("#a_password").val("")
    $("#a_password_retype").val("")
    $("#userAccordionHeader").html("Add New User")
    $("#deleteUserButton").hide()
//    $("#resetPasswordButton").hide()
    $(".roleChecked").attr("checked", "checked")
    $("#a_admin").attr("checked", false)

}


function loaduser(data) {
    $("#a_username").val(data.username)
    $("#a_username").attr("readonly", "readonly")
    $("#a_password").val(data.password)
    $("#a_password_retype").val(data.password)

    $("#userAccordionHeader").html("Update User")
    $("#deleteUserButton").show()
//    $("#resetPasswordButton").show()
    var ss = data.roles.split("###")
    for (var i = 0; i < ss.length; i++) {
        if (ss[i].length > 0)
            $("#" + ss[i]).attr("checked", "checked")
    }
    if (data.admin == 1)
        $("#a_admin").attr("checked", "checked")
    else
        $("#a_admin").attr("checked", false)

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
//            date:new Date(ss.date).getMilliseconds(),
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

    /*
     grid.onClick.subscribe(function (e) {
     var cell = grid.getCellFromEvent(e);
     var ss = grid.getColumns()[cell.cell]
     var cc = grid.getCellNode(cell.row, 4)
     $("#fullLogMessageText").val( cc.innerHTML )
     });
     */

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
    $("#logFilterMessage,#logFilterCallId").keyup(function (e) {
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

    dataView.setFilterArgs({
        messageParam:$("#logFilterMessage").val(),
        memberParam:memberParam,
        typeParam:typeParam,
        callIdParam:$("#logFilterCallId").val()
    });
    dataView.refresh();
}

function comparer(a, b) {
    var x = a[sortcol], y = b[sortcol];
    return (x == y ? 0 : (x > y ? 1 : -1));
}

function executescript(olist) {
    $("#scriptResult").html(olist)
}


function fillMemberCheckListForLogs() {
    $('#memberCheckListForLogs').empty()
    for (var i = 0; i < memberlistcache.length; i++) {
        $('#memberCheckListForLogs').append("<div class='memberCheckDiv' ><input id='memberchecklistForLogs" + i + "' checked='checked' type='checkbox' name='memberchecklistForLogs' value='" + memberlistcache[i].label + "'  /><label for='memberchecklistForLogs" + i + "' class='itemLink'>" + memberlistcache[i].label + "</label></div>")
    }
}


function login(data) {
    if (data == null) {
        $("#loginFailTd").html("Wrong username or password. (First time pass: admin/admin)")
    }
    else {
        clusternames(data)
    }
}

function savelicense(data) {
    if (data == 0)
        $("#licenseSaveInfo").html("Invalid license key.")
    else if (data == 1)
        $("#licenseSaveInfo").html("The license key entered has been expired.")
    else if (data == 2) {
        $("#licenseSaveInfo").html("Your license has been activated.")
        setTimeout('location.href = "main.do"', 1000);
    }


}


function clusternames(user) {
    if ($("#login_remember").attr("checked") == "checked") {
        $.cookie('c_username', user.username, { expires:7 });
        $.cookie('c_password', user.password, { expires:7 });
    }
    /*
     if (user.licenseInfo == null) {
     $("#login_dialog").dialog("option", "buttons",
     [
     {id:"applyButton",text:"Apply", click: function() {
     applyLicenseAction();
     }
     },
     {id:"licenseButton",text:"Enter", click: function() {
     saveLicenseAction();
     }
     }
     ])

     $("#loginDiv").hide()
     $("#licenseKeyDiv").show("slide")
     return;
     }
     */
    if (user.licenseInfo == null) {
        $("#applyWarnDiv").show()
        $("#licenseInfo").html("Developer Mode: Max 2 node limit.")
    }
    else {
        $("#licenseInfo").html(user.licenseInfo)
    }


    admin = user.admin

    $('#clusterList').empty()
    clusterList = new Array()
    var slist = user.roles.split("###")
    var nocluster = true
    for (var i = 0; i < slist.length; i++) {
        var ss = slist[i]
        if (ss.length > 0) {
            var role = ss.split("-")[0]
            var cluster = ss.split("-")[1]
            if (cluster.length > 0 && (role != "0" || user.admin == "1")) {
                $('#clusterList').append("<div class='clusterRadioDiv' ><input id='clusterradiolist" + i + "' type='radio' name='clusterradiolist' value='" + ss + "'  /><label for='clusterradiolist" + i + "' class='itemLink'>" + cluster + "</label></div>")
                clusterList.push(cluster)
                nocluster = false
            }
        }
    }
    if (nocluster) {
        $("#login_dialog").dialog("option", "width", 650);
        $("#loginDiv").hide()
        $("#noClusterDiv").show()
        var host = location.href
        host = host.substring(0, host.indexOf("/main"))
        $("#yourUrlText").html(host)

        $("#login_dialog").dialog("option", "buttons",
                [
                    {id:"retryButton", text:"Retry", click:function () {
                        reloadPage()
                    }}
                ])

        return
    }

    $("[name='clusterradiolist']:first").attr("checked", true)

    var buttons = [];
    buttons = [
        {id:"connectButton", text:"Connect", click:function () {
            init();
            $(this).dialog("close");
        }}
    ]

    if (user.licenseInfo == null) {
        $("#trialLicenseDiv").show()
        buttons.push(
                {id:"enterLicenseButton", text:"Enter License", click:function () {
                    showEnterLicense()
                }}
        )
    }

    $("#login_dialog").dialog("option", "buttons", buttons)
    $("#connectButton").focus()

    $("#loginDiv").hide()
    $("#clusterConnectDiv").show("slide")

}

function showEnterLicense() {
    $("#login_dialog").dialog("open")
    $("#login_dialog").dialog("option", "buttons",
            [
                {id:"licenseButton", text:"Enter", click:function () {
                    saveLicenseAction();
                }
                }
            ])
    $(".loginDivs").hide()
    $("#licenseKeyDiv").show("slide")
}

var pieChartOpts = {
    series:{
        pie:{
            show:true,
            radius:1,
            label:{
                show:true,
                radius:3 / 4,
                formatter:function (label, series) {
                    return '<div style="font-size:8pt;text-align:center;padding:2px;color:white;">' + label + '<br/>' + Math.round(series.percent) + '%</div>';
                },
                background:{ opacity:0.5 }
            }
        }
    },
    legend:{
        show:false
    }
}


var chartOpts = {
    series:{
        lines:{ show:true },
        points:{ show:true }
    },
    xaxis:{
        mode:"time", minTickSize:[15, "second"]
    },
    yaxis:{
        autoscaleMargin:4
//                ticks: 10,
//                min: 0,
//                max: 1000
    },
    grid:{
        backgroundColor:{ colors:["#fff", "#eee"] }
    }
}

function chartmap1(datalist) {

    var checkedOpt = $("[name='chartMap1radiogroup']:checked");
    var label = checkedOpt.next().text();
    if (checkedOpt.val().charAt(0) == "i") {
        label += " (X1000)"
        chartOpts.yaxis.autoscaleMargin = 4
    }
    else {
        chartOpts.yaxis.autoscaleMargin = 2
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


function partitionspiechart(datalist) {
    $.plot($("#partitionspiechart"), datalist, pieChartOpts);
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


function mapMemoryTable(olist) {
    var columns = [
        {id:"num", name:"#", field:"num", width:50},
        {id:"members", name:"Members", field:"members", width:90},
        {id:"entries", name:"Entries", field:"entries", width:90},
        {id:"entry_memory", name:"Entry Memory", field:"entry_memory", width:90},
        {id:"backups", name:"Backups", field:"backups", width:90},
        {id:"backup_memory", name:"Backup Memory", field:"backup_memory", width:90},
        {id:"dirty_entries", name:"Dirty Entries", field:"dirty_entries", width:90},
        {id:"marked_as_remove", name:"Marked As Remove", field:"marked_as_remove", width:90},
        {id:"marked_as_remove_memory", name:"Marked As Remove Memory", field:"marked_as_remove_memory", width:90},
        {id:"locks", name:"Locks", field:"locks", width:90}
    ];

    var options = {
        enableCellNavigation: true,
        enableColumnReorder: false
    };

    mapMemoryTableDataView = new Slick.Data.DataView({ inlineFilters:true });

    if(mapMemoryTableGrid == null) {
        var data = [];
        for (var i = 0; i < olist.length; i++) {
            var ss = olist[i]
            data[i] = {
                id:"id" + i,
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
        mapMemoryTableGrid = new Slick.Grid("#datatableMap1", mapMemoryTableDataView, columns, options);
    }

    else {
        for (var i = 0; i < olist.length; i++) {
            var ss = olist[i]
                mapMemoryTableGrid.getDataItem(i).id = "id" + i,
                mapMemoryTableGrid.getDataItem(i).num=ss[0]
                mapMemoryTableGrid.getDataItem(i).members=ss[1]
                mapMemoryTableGrid.getDataItem(i).entries=ss[2]
                mapMemoryTableGrid.getDataItem(i).entry_memory=ss[3]
                mapMemoryTableGrid.getDataItem(i).backups=ss[4]
                mapMemoryTableGrid.getDataItem(i).backup_memory=ss[5]
                mapMemoryTableGrid.getDataItem(i).dirty_entries=ss[6]
                mapMemoryTableGrid.getDataItem(i).marked_as_remove=ss[7]
                mapMemoryTableGrid.getDataItem(i).marked_as_remove_memory=ss[8]
                mapMemoryTableGrid.getDataItem(i).locks=ss[9]
                mapMemoryTableGrid.updateRow(i)
        }
    }

}

function mapMemoryTableOld(datalist) {
    var tbl = $("#datatableMap1")
    tbl.flexigrid({
        dataType:'json',
        colModel:[
            {display:'#', name:'num', width:30, sortable:true, align:'left'},
            {display:'Members', name:'members', width:100, sortable:true, align:'left'},
            {display:'Entries', name:'entries', width:60, sortable:true, align:'left'},
            {display:'Entry Memory', name:'entry_memory', width:60, sortable:true, align:'left'},
            {display:'Backups', name:'backups', width:60, sortable:true, align:'left'},
            {display:'Backup Memory', name:'backup_memory', width:60, sortable:true, align:'left'},
            {display:'Dirty Entries', name:'dirty_entries', width:60, sortable:true, align:'left'},
            {display:'Marked As Remove', name:'marked_as_remove', width:60, sortable:true, align:'left'},
            {display:'Marked Rem. Mem.', name:'marked_as_remove_memory', width:60, sortable:true, align:'left'},
            {display:'Locks', name:'locks', width:60, sortable:true, align:'left'}
        ],
        sortname:"num",
        sortorder:"asc",
        usepager:false,
        title:"Map Memory Data Table",
        useRp:false,
        rp:10,
        showTableToggleBtn:true,
        resizable:true,
        height:100,
        width:1000,
        singleSelect:true
    });
    tbl.flexAddData(datalist)
    tbl.flexReload()

}

function mapThroughputTable(datalist) {
    var tbl = $("#datatableMap2")
    tbl.flexigrid({
        dataType:'json',
        colModel:[
            {display:'#', name:'num', width:30, sortable:true, align:'left'},
            {display:'Members', name:'members', width:100, sortable:true, align:'left'},
            {display:'Total', name:'id1', width:60, sortable:true, align:'left'},
            {display:'Gets', name:'id2', width:60, sortable:true, align:'left'},
            {display:'Avg Get Lat.', name:'id3', width:60, sortable:true, align:'left'},
            {display:'Puts', name:'id4', width:60, sortable:true, align:'left'},
            {display:'Avg Put Lat.', name:'id5', width:60, sortable:true, align:'left'},
            {display:'Removes', name:'id6', width:60, sortable:true, align:'left'},
            {display:'Avg Remove Lat.', name:'id7', width:60, sortable:true, align:'left'},
            {display:'Other Ops.', name:'id8', width:60, sortable:true, align:'left'},
            {display:'Events', name:'id9', width:60, sortable:true, align:'left'}
        ],
        sortname:"num",
        sortorder:"asc",
        usepager:false,
        title:"Map Throughput Data Table",
        useRp:false,
        rp:10,
        showTableToggleBtn:true,
        resizable:true,
        height:100,
        width:1000,
        singleSelect:true
    });
    tbl.flexAddData(datalist)
    tbl.flexReload()

}


function memberpartitions(datalist) {
    $("#memberPartitions").empty()
    if (datalist != null)
        for (var i = 0; i < datalist.length; i++) {
            $("#memberPartitions").append("<div class='partitionDiv'>" + datalist[i] + "</div>")
        }
}


function memberprops(datalist) {
    $("#memberProps").empty()
    if (datalist != null)
        for (lbl in datalist) {
            $("#memberProps").append("<tr><td class='infoLabel'>" + lbl + ":</td><td class='valueTd valueTdSmall'>" + datalist[lbl] + "</td></tr>")
        }
}

function memberconfig(datalist) {
    $("#memberConfig").empty()
    if (datalist != null) {
        for (var i = 0; i < datalist.length; i++) {
            $("#memberConfig").append("<pre style='font-size: 10pt;'><code class='xml'>" + datalist[i].replace(/</gi, "&lt;").replace(/>/gi, "&gt;") + "</code></pre>")
        }

        $('pre code').each(function (i, e) {
            hljs.highlightBlock(e, '    ')
        });
    }
}

function clusterprops(datalist) {
    if (datalist != null)
        for (lbl in datalist) {
            var idm = lbl.split(".")[1]
            $("#" + idm).html(datalist[lbl])
        }
}


function memberruntime(datalist) {
    if (datalist != null)
        for (lbl in datalist) {
            var idm = lbl.split(".")[1]
            $("#" + idm).html(datalist[lbl])
        }
}

function browsemap(datalist) {
    for (data in datalist) {
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
}

function queuelist(olist) {
    $('#queues').empty()
    var str = "<table><tbody>"
    for (var i = 0; i < olist.length; i++) {
        str += "<tr><td><span class='ui-icon ui-icon-carat-1-e'></span></td><td><a href='#' class='itemLink' onclick='addViewShort(\"" + olist[i].label + "\", \"queue\" )'>" + olist[i].label + "</a></td></tr>"
    }
    str += "</tbody></table>"
    $('#queues').append(str)

}

function topiclist(olist) {
    $('#topics').empty()
    var str = "<table><tbody>"
    for (var i = 0; i < olist.length; i++) {
        str += "<tr><td><span class='ui-icon ui-icon-carat-1-e'></span></td><td><a href='#' class='itemLink' onclick='addViewShort(\"" + olist[i].label + "\", \"topic\" )'>" + olist[i].label + "</a></td></tr>"
    }
    str += "</tbody></table>"
    $('#topics').append(str)
}

function userlist(olist) {
    var userListDiv = $("#userListDiv")
    userListDiv.empty()
    var str = "<table><tbody>"
    for (var i = 0; i < olist.length; i++) {
        str += "<tr><td><span class='ui-icon ui-icon-person'></span></td><td><a href='#' class='itemLink' onclick='editUser(\"" + olist[i].label + "\" )'>" + olist[i].label + "</a></td></tr>"
    }
    str += "<tr><td><span class='ui-icon ui-icon-plusthick'></span></td><td><a href='#' class='itemLink' onclick='loadNewUserAction()'>ADD NEW USER</a></td></tr>"

    str += "</tbody></table>"
    userListDiv.append(str)
}


function memberlist(olist) {
    memberlistcache = olist
    $('#members').empty()
    $("#membersHeader").html("Members (" + olist.length + ")")
    var str = "<table><tbody>"
    for (var i = 0; i < olist.length; i++) {
        str += "<tr><td><span class='ui-icon ui-icon-carat-1-e'></span></td><td><a href='#' class='itemLink' onclick='addViewShort(\"" + olist[i].label + "\", \"member\" )'>" + (i + 1) + "- " + olist[i].label + "</a></td></tr>"
    }
    str += "</tbody></table>"
    $('#members').append(str)
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


function clusterHome() {
    $("#radio1").click();
    setTimeout('addView("Cluster Home", "cluster", "cluster")', 500);
}

function logout() {
    $.cookie('c_username', null);
    $.cookie('c_password', null);
    reloadPage()
}

function reloadPage() {
    location.href = "main.do"
}

function openTimeTravel() {
    var options = {};
    $("#timeTravelDiv").toggle("blind", options, "fast", function () {
        if ($("#timeTravelButton")[0].checked) {
            curtime = $("#slider").slider("value")
            refreshpage(0)
        }
        else {
            curtime = 0
            refreshpage(refreshSeconds)
        }
    });

}

function changeSection(sid) {
    activeSection = sid
    $(".sectionTable").hide();
    $("." + sid).show();
    if (activeSection == 'sectionHome')
        refreshpage(refreshSeconds)
    else if (activeSection == 'sectionAdministration') {
        fillUsersAction()
        fillRoles()
        loadNewUserAction()
    }
    else if (activeSection == 'sectionScripting')
        fillMemberListForScripting()
    else if (activeSection == 'sectionLogs') {
        fillMemberCheckListForLogs()
        getLogsAction("none")
    }
    else if (activeSection == 'sectionDocs') {
        $("#docsTd").html('<iframe id="ifm" frameborder="0" height="100%" width="100%" src="http://www.hazelcast.com/docs/2.0/manual/single_html/" />')
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


</script>


</head>

<body style="padding: 0px; margin: 0px; overflow-x: hidden; overflow-y: scroll; height: 100%; ">

<div id="loadingDiv"
     style="background-color: #d3d3d3; position: absolute; top: 0px; left: 50%; padding: 5px; font-family: Arial, sans-serif; font-weight: bold;">
    Loading...
</div>


<div id="timeTravelDiv"
     style="z-index:10; position: absolute; top:0px; left: 240px;
     padding-left: 10px; padding-top: 10px; width: 100%; height:54px; background-color: #e6e6fa;">

    <%--<p style="font-size: 10pt; font-weight: bold;">Select Day: <input type="hidden"--%>
    <%--style="width: 100px;"--%>
    <%--id="datepicker"/></p>--%>

    <table cellpadding="0" cellspacing="0" align="left">

        <tr>
            <td colspan="1" style="padding-bottom: 5px;">
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <button id="backbutton" style="height: 25px; width: 30px;" onclick="backTime()">Back
                            </button>
                        </td>
                        <td>
                            <div id="slider" style="width: 500px;"></div>
                        </td>
                        <td>
                            <button id="forwardbutton" style="height: 25px; width: 30px;" onclick="forwardTime()">
                                Forward
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="text-align: center;">
                            <img src="images/timeruler.png"/>
                        </td>
                    </tr>
                </table>

            </td>
            <td style="padding-left: 10px;">
                <table cellpadding="0" cellspacing="0" align="center">
                    <tr>
                        <td>
                            <div id="timeLabel"
                                 style="width: 100%; text-align: center; font-weight: bold; font-size: 12pt; float: left;"></div>
                        </td>
                        <td style="padding-left: 10px; vertical-align: middle;">
                            <input type="hidden" id="datepicker"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>


<table style="padding: 0px; margin: 0px; width:100%; height:100%; " cellpadding="0" cellspacing="0">

<tr>
    <td colspan="2" class="bannerTd">
        <table cellpadding="0" cellspacing="0" style="width:100%;">
            <tr>
                <td style="width: 237px;">
                    <img src="images/logo.png" alt="hazelcast logo"/>
                </td>
                <td style="vertical-align: bottom; padding-left: 0px;">
                    <div class="buttonset" id="topButtonDiv">
                        <input type="radio" id="radio1" name="radiomenu" onclick="changeSection('sectionHome')"
                               checked="checked"/><label for="radio1">Home</label>
                        <%--<input type="radio" id="radio2" name="radiomenu"--%>
                        <%--onclick="changeSection('sectionHealth')"/><label for="radio2">Health--%>
                        <%--Check</label>--%>
                        <input type="radio" id="radio7" name="radiomenu"
                               onclick="changeSection('sectionLogs')"/><label for="radio7">System Logs</label>
                        <input type="radio" id="radio3" name="radiomenu" class="writeModeButton"
                               onclick="changeSection('sectionScripting')"/><label for="radio3">Scripting</label>
                        <%--<input type="radio" id="radio4" name="radiomenu"--%>
                        <%--onclick="changeSection('sectionSettings')"/><label for="radio4">Settings</label>--%>
                        <input type="radio" id="radio5" name="radiomenu"
                               onclick="changeSection('sectionDocs')"/><label
                            for="radio5">Docs</label>
                        <%--<input type="radio" id="radio6" name="radiomenu"--%>
                        <%--onclick="changeSection('sectionSupport')"/><label--%>
                        <%--for="radio6">Support</label>--%>
                    </div>
                </td>
                <td style="text-align: right; ">
                    <table align="right">
                        <tr>
                            <td>
                                <input type="checkbox" id="timeTravelButton" onclick="openTimeTravel()"/><label
                                    for="timeTravelButton" style="z-index: 15;">Time Travel</label>
                            </td>
                            <td>
                                <button onclick="openConsole()" id="consoleButton" class="writeModeButton">console
                                </button>
                            </td>
                            <td>
                                <button onclick="clusterHome()" id="clusterHomeButton">cluster home</button>
                            </td>
                            <td>
                                <button onclick="showEnterLicense()" id="enterLicenseButton">enter license</button>
                            </td>
                            <td>
                                <button onclick="logout()" id="logoutButton">logout</button>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

        </table>

    </td>
</tr>


<tr class="sectionTable sectionDocs">
    <td colspan="2" id="docsTd" style="vertical-align: top;">
        &nbsp;
    </td>
</tr>

<tr class="sectionTable sectionScripting">
    <td class="leftPanel resizable">

        <div class="accordion" id="memberCheckListAccordion">
            <h3><a href="#">Select Members</a></h3>

            <div id="memberCheckList">
            </div>
        </div>
        <div class="accordion" id="scriptLanguageAccordion">
            <h3><a href="#">Script Language</a></h3>

            <div>
                <div id="scriptRadioList">
                    <input type="radio" id="radiojavascript" name="radioscriptlanguage" checked="checked"
                           value="javascript"/><label for="radiojavascript" class="itemLink">Javascript</label>
                    <br/><input type="radio" id="radiogroovy" name="radioscriptlanguage" value="groovy"/><label
                        for="radiogroovy" class="itemLink">Groovy</label>
                    <br/><input type="radio" id="radiojruby" name="radioscriptlanguage" value="jruby"/><label
                        for="radiojruby" class="itemLink">JRuby</label>
                    <br/><input type="radio" id="radiobeanshell" name="radioscriptlanguage"
                                value="beanshell"/><label
                        for="radiobeanshell" class="itemLink">BeanShell</label>
                </div>
            </div>
        </div>

    </td>
    <td style="vertical-align: top; padding: 10px;">
        <b>Script:</b><br/>
        <textarea id="scriptarea" rows="10" cols="100" style="padding: 15px; ">
            function echo() {
            var name = hazelcast.getName();
            var node = hazelcast.getCluster().getLocalMember();
            return name + ' => ' + node;
            }
            echo();
        </textarea>
        <br/>
        <br/>
        <button class="button" style="margin-left: 50px;" onclick="sendScript()">Execute</button>
        <br/>
        <br/>

        <b>Result:</b><br/>
        <textarea id="scriptResult" rows="10" cols="100"
                  style="padding: 15px; border: 3px solid #e6e6fa; background-color: #000000; color: #ffffff; font-weight:bold; "></textarea>

    </td>
</tr>


<tr class="sectionTable sectionLogs">
    <td class="leftPanel resizable">

        <div class="accordion" id="memberLogsCheckListAccordion">
            <h3><a href="#">Filter Logs</a></h3>

            <div class="logFilters">

                <div>
                    <label>Message:</label>
                    <br/>
                    <input type="text" id="logFilterMessage"/>
                </div>

                <br/>

                <div>
                    <label>Call Id:</label>
                    <br/>
                    <input type="text" id="logFilterCallId"/>
                </div>
                <br/>

                <label>Members:</label>
                <br/>

                <div id="memberCheckListForLogs">
                </div>
                <br/>

                <label>Log Type:</label>
                <br/>
                <br/>

                <div id="typeCheckDivForLogs">
                    <div class='typeCheckDiv'>
                        <input id='typechecklistForLogs1' checked='checked' type='checkbox' name='typechecklistForLogs'
                               value='NODE'/>
                        <label for='typechecklistForLogs1' class='itemLink'>NODE</label>
                    </div>
                    <div class='typeCheckDiv'>
                        <input id='typechecklistForLogs2' checked='checked' type='checkbox' name='typechecklistForLogs'
                               value='JOIN'/>
                        <label for='typechecklistForLogs2' class='itemLink'>JOIN</label>
                    </div>
                    <div class='typeCheckDiv'>
                        <input id='typechecklistForLogs3' checked='checked' type='checkbox' name='typechecklistForLogs'
                               value='CONNECTION'/>
                        <label for='typechecklistForLogs3' class='itemLink'>CONNECTION</label>
                    </div>
                    <div class='typeCheckDiv'>
                        <input id='typechecklistForLogs4' checked='checked' type='checkbox' name='typechecklistForLogs'
                               value='PARTITION'/>
                        <label for='typechecklistForLogs4' class='itemLink'>PARTITION</label>
                    </div>
                    <div class='typeCheckDiv'>
                        <input id='typechecklistForLogs5' checked='checked' type='checkbox' name='typechecklistForLogs'
                               value='CALL'/>
                        <label for='typechecklistForLogs5' class='itemLink'>CALL</label>
                    </div>
                </div>
                <br/>
                <br/>
                <a href="main.do?operation=getlogs&export=yes" id="exportLogsLink" class="button">Export Logs</a>
                <button class="button" onclick="getLogsAction('none')">Refresh</button>
                <br/>
                <br/>
                <select id="logLevelSelect">
                    <option value="" disabled="true">Select</option>
                    <option value="trace">Trace</option>
                    <option value="info">Info</option>
                    <option value="empty">Empty</option>
                    <option value="none">None</option>
                </select>
                <button class="button" onclick="setLogLevelAction()">Set Level</button>

            </div>
        </div>


    </td>
    <td style="vertical-align: top; padding: 1px;">
        <div id="logsGrid" style="width:1000px;height:500px; border: 1px solid #aaa;"></div>
        <input type="text" id="fullLogMessageText"
               style="width:1000px; font-weight: bold; background-color: #F5F5DC "></input>
        <% if ("true".equals(request.getParameter("import"))) { %>
        <input type="text" id="logFilePath" style="width: 300px;"></input>
        <button onclick="getLogsFromFile()">Import</button>
        <% } %>
    </td>
</tr>


<tr class="sectionTable sectionAdministration">
    <td class="leftPanel resizable">

        <div class="accordion" id="userListAccordion">
            <h3><a href="#">Users</a></h3>

            <div style="height: 300px;">
                <div id="userListDiv">
                </div>
            </div>
        </div>

    </td>
    <td style=" vertical-align: top; ">
        <div class="accordion" id="userEditAccordion">
            <h3><a href="#" id="userAccordionHeader">Add New User</a></h3>

            <div style="height: 300px; ">
                <table style="margin: 20px;" border=0>
                    <tr>
                        <td class="infoLabel">Username:</td>
                        <td><input type="text" id="a_username"/></td>
                    </tr>
                    <tr class="passwordRow">
                        <td class="infoLabel">Password:</td>
                        <td><input type="password" id="a_password"/></td>
                    </tr>
                    <tr class="passwordRow">
                        <td class="infoLabel">Password Retype:</td>
                        <td><input type="password" id="a_password_retype"/></td>
                    </tr>
                    <tr>
                        <td class="infoLabel">Is Admin:</td>
                        <td><input type="checkbox" id="a_admin"/></td>
                    </tr>
                    <tr>
                        <td class="infoLabel" style="vertical-align: top; padding-top: 8px">Permissions:</td>
                        <td id="a_roles" style="vertical-align: top;"></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center;" id="userButtonsTd">
                            <table align="center">
                                <tr>
                                    <td>
                                        <button onclick="saveUserAction()" class="button">Save</button>
                                    </td>
                                    <td>
                                        <button onclick="showDeleteUserConfirm()" class="button" id="deleteUserButton"
                                                >Delete
                                        </button>
                                    </td>
                                    <%--<td>--%>
                                    <%--<button onclick="resetPasswordAction()" class="button" id="resetPasswordButton"--%>
                                    <%-->Reset Password--%>
                                    <%--</button>--%>
                                    <%--</td>--%>
                                </tr>
                            </table>
                        </td>
                    </tr>

                </table>
            </div>
        </div>
    </td>
</tr>

<tr class="sectionTable sectionHome">
    <td class="leftPanel resizable">

        <div class="accordion" id="mapAccordion">
            <h3><a href="#">Maps</a></h3>

            <div id="maps">
            </div>
        </div>
        <div class="accordion">
            <h3><a href="#">Queues</a></h3>

            <div id="queues">
            </div>
        </div>
        <div class="accordion">
            <h3><a href="#">Topics</a></h3>

            <div id="topics">

            </div>
        </div>


        <div class="accordion" id="memberListAccordion">
            <h3><a href="#" id="membersHeader">Members</a></h3>

            <div>
                <div id="members">
                </div>
            </div>
        </div>

    </td>
    <td style=" vertical-align: top;">
        <div id="tabs" class="tabsDiv">
            <ul id="tabheaders">
                <li><a href="#tabs-news">Cluster Home</a> <span class="ui-icon ui-icon-close">Remove Tab</span></li>
            </ul>
            <div id="tabs-news">

            </div>

        </div>

    </td>
</tr>

</table>

<div id="mapContentTemplate" class="contentDiv" style="display: none;">

    <table>
        <tr>
            <td style="padding-top:10px; padding-bottom:10px; ">
                <div id="chartMap1" onclick='openChartOpts(event, "#chartMap1-opts")' class="chartDivSmall">
                    <img src="images/loader.gif" class="loaderImage"/>
                </div>
            </td>
            <td style="padding-top:10px; padding-bottom:10px; ">
                <div id="chartMap2" onclick='openChartOpts(event, "#chartMap2-opts")' class="chartDivSmall">
                    <img src="images/loader.gif" class="loaderImage"/>
                </div>
            </td>
            <td style="vertical-align: top; padding-top: 15px;">
                <table align="right">
                    <tr>
                        <td>
                            <button id="browseButton" style="width: 90px">Browse</button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <button id="configButton" style="width: 90px" class="writeModeButton">Config</button>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <div id="datatableMap1" style="width:1000px; height: 300px;" class="datatable"></div>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <table id="datatableMap2" class="datatable"></table>
            </td>
        </tr>
    </table>
</div>


<div id="queueContentTemplate" class="contentDiv" style="display: none;">
    <table>
        <tr>
            <td style="padding:20px; ">
                <div id="chartQueue1" onclick='openChartOpts(event, "#chartQueue1-opts")' class="chartDiv">
                    <img src="images/loader.gif" class="loaderImage"/>
                </div>
            </td>
            <td style="padding:20px; ">
                <div id="chartQueue2" onclick='openChartOpts(event, "#chartQueue2-opts")' class="chartDiv"><img
                        src="images/loader.gif" class="loaderImage"/></div>
            </td>
        </tr>

    </table>
</div>


<div id="topicContentTemplate" class="contentDiv" style="display: none;">
    <table>
        <tr>
            <td style="padding:20px; ">
                <div id="chartTopic1" onclick='openChartOpts(event, "#chartTopic1-opts")' class="chartDiv"><img
                        src="images/loader.gif" class="loaderImage"/></div>
            </td>
            <td style="padding:20px; ">
                <div id="chartTopic2" onclick='openChartOpts(event, "#chartTopic2-opts")' class="chartDiv"><img
                        src="images/loader.gif" class="loaderImage"/></div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <table id="datatableTopic" class="datatable"></table>
            </td>
        </tr>

    </table>
</div>


<div id="clusterContentTemplate" style="display: none;">
    <table id="clusterProps">
        <tr>
            <td class="infoLabel clusterPropsLabelTd">Version:</td>
            <td id="cl_version" class="clusterValueLabelTd valueTd"></td>
            <td class="infoLabel clusterPropsLabelTd">Build:</td>
            <td id="cl_build" class="clusterValueLabelTd valueTd"></td>
        </tr>
        <tr>
            <td class="infoLabel clusterPropsLabelTd">Max Memory:</td>
            <td id="cl_maxMemory" class="clusterValueLabelTd valueTd"></td>
            <td class="infoLabel clusterPropsLabelTd">Free Memory:</td>
            <td id="cl_freeMemory" class="clusterValueLabelTd valueTd"></td>
        </tr>
        <tr>
            <td class="infoLabel clusterPropsLabelTd">Start Time:</td>
            <td id="cl_startTime" class="clusterValueLabelTd valueTd"></td>
            <td class="infoLabel clusterPropsLabelTd">Up Time:</td>
            <td id="cl_upTime" class="clusterValueLabelTd valueTd"></td>
        </tr>
    </table>

    <div style="padding: 20px;  font-weight: bold;">Members &amp; Partitions</div>

    <div id="partitionspiechart" class="chartDiv" align="center"><img src="images/loader.gif" class="loaderImage"/>
    </div>

    <table style="visibility: hidden;">
        <tr>
            <td>bulk bulk</td>
            <td>bulk bulk</td>
            <td>bulk bulkbulk bulkbulk bulkbulk bulk</td>
            <td>bulk bulkbulk bulkbulk bulkbulk bulk</td>
            <td>bulk bulkbulk bulkbulk bulkbulk bulk</td>
        </tr>
    </table>
</div>


<div id="memberContentTemplate" style="display: none; ">

    <div align="right">
        <button id="threadDumpButton" class="writeModeButton">Thread Dump</button>
        <button id="runGCButton" class="writeModeButton">Run GC</button>
    </div>

    <div id="memberTabs">
        <ul>
            <li><a href="#mtabs-1">Runtime</a></li>
            <li><a href="#mtabs-2">Properties</a></li>
            <li><a href="#mtabs-3">Configuration</a></li>
            <li><a href="#mtabs-4">Partitions</a></li>
        </ul>
        <div id="mtabs-1">
            <table id="memberRuntime">
                <tr>
                    <td class="infoLabel">Number of Processors:</td>
                    <td id="availableProcessors" class="valueTd"><img src="images/loader.gif"/></td>
                </tr>
                <tr>
                    <td class="infoLabel">Start Time:</td>
                    <td id="startTime" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Up Time:</td>
                    <td id="upTime" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Maximum Memory:</td>
                    <td id="maxMemory" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Total Memory:</td>
                    <td id="totalMemory" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Free Memory:</td>
                    <td id="freeMemory" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Used Heap Memory:</td>
                    <td id="heapMemoryUsed" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Max Heap Memory:</td>
                    <td id="heapMemoryMax" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Used Non-Heap Memory:</td>
                    <td id="nonHeapMemoryUsed" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Max Non-Heap Memory:</td>
                    <td id="nonHeapMemoryMax" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Total Loaded Classes:</td>
                    <td id="totalLoadedClassCount" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Current Loaded Classes:</td>
                    <td id="loadedClassCount" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Total Unloaded Classes:</td>
                    <td id="unloadedClassCount" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Total Thread Count:</td>
                    <td id="totalStartedThreadCount" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Active Thread Count:</td>
                    <td id="threadCount" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Peak Thread Count:</td>
                    <td id="peakThreadCount" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Daemon Thread Count:</td>
                    <td id="daemonThreadCount" class="valueTd"></td>
                </tr>
            </table>
        </div>
        <div id="mtabs-2">
            <table id="memberProps" style="width: 400px;">

            </table>

        </div>
        <div id="mtabs-3">
            <div id="memberConfig">

            </div>
        </div>
        <div id="mtabs-4">
            <div id="memberPartitions" style="height: 600px;">
            </div>
        </div>
    </div>

    <table style="visibility: hidden;">
        <tr>
            <td>bulk bulk</td>
            <td>bulk bulk</td>
            <td>bulk bulkbulk bulkbulk bulkbulk bulk</td>
            <td>bulk bulkbulk bulkbulk bulkbulk bulk</td>
            <td>bulk bulkbulk bulkbulk bulkbulk bulk</td>
        </tr>
    </table>


</div>


<div id="chartMap1-opts" title="Chart 1 Options" class="chartoptsdiv">
    <div id="chartMap1optsmenu" class="chartoptsmenu">

        <input type="radio" id="c1r1" name="chartMap1radiogroup" value="i_Map_OwnedEntryCount" checked="true"/><label
            for="c1r1">Size</label>
        <input type="radio" id="c1r10" name="chartMap1radiogroup" value="o_Map_total"/><label
            for="c1r10">Throughput</label>
        <input type="radio" id="c1r2" name="chartMap1radiogroup" value="i_Map_OwnedEntryMemoryCost"/><label for="c1r2">Memory</label>
        <input type="radio" id="c1r3" name="chartMap1radiogroup" value="i_Map_BackupEntryCount"/><label for="c1r3">Backup
        Size</label>
        <input type="radio" id="c1r4" name="chartMap1radiogroup" value="i_Map_BackupEntryMemoryCost"/><label for="c1r4">Backup
        Mem.</label>
        <%--<input type="radio" id="c1r5" name="chartMap1radiogroup" value="i_Map_Hits"/><label for="c1r5">Hits</label>--%>
        <input type="radio" id="c1r6" name="chartMap1radiogroup" value="i_Map_LockedEntryCount"/><label for="c1r6">Locked
        Entr.</label>
        <input type="radio" id="c1r7" name="chartMap1radiogroup" value="o_Map_NumberOfPuts"/><label
            for="c1r7">Puts</label>
        <input type="radio" id="c1r8" name="chartMap1radiogroup" value="o_Map_NumberOfGets"/><label
            for="c1r8">Gets</label>
        <input type="radio" id="c1r9" name="chartMap1radiogroup" value="o_Map_NumberOfRemoves"/><label
            for="c1r9">Removes</label>
    </div>
</div>
<div id="chartMap2-opts" title="Chart 2 Options" class="chartoptsdiv">
    <div id="chartMap2optsmenu" class="chartoptsmenu">

        <input type="radio" id="c2r1" name="chartMap2radiogroup" value="i_Map_OwnedEntryCount"/><label
            for="c2r1">Size</label>
        <input type="radio" id="c2r10" name="chartMap2radiogroup" value="o_Map_total" checked="true"/><label
            for="c2r10">Throughput</label>
        <input type="radio" id="c2r2" name="chartMap2radiogroup" value="i_Map_OwnedEntryMemoryCost"
                /><label
            for="c2r2">Memory</label>
        <input type="radio" id="c2r3" name="chartMap2radiogroup" value="i_Map_BackupEntryCount"/><label for="c2r3">Backup
        Size</label>
        <input type="radio" id="c2r4" name="chartMap2radiogroup" value="i_Map_BackupEntryMemoryCost"/><label for="c2r4">Backup
        Mem.</label>
        <%--<input type="radio" id="c2r5" name="chartMap2radiogroup" value="i_Map_Hits"/><label for="c2r5">Hits</label>--%>
        <input type="radio" id="c2r6" name="chartMap2radiogroup" value="i_Map_LockedEntryCount"/><label for="c2r6">Locked
        Entr.</label>
        <input type="radio" id="c2r7" name="chartMap2radiogroup" value="o_Map_NumberOfPuts"/><label
            for="c2r7">Puts</label>
        <input type="radio" id="c2r8" name="chartMap2radiogroup" value="o_Map_NumberOfGets"/><label
            for="c2r8">Gets</label>
        <input type="radio" id="c2r9" name="chartMap2radiogroup" value="o_Map_NumberOfRemoves"/><label
            for="c2r9">Removes</label>
    </div>
</div>

<div id="chartQueue1-opts" title="Chart 1 Options" class="chartoptsdiv">
    <div id="chartQueue1optsmenu" class="chartoptsmenu">
        <input type="radio" id="c3r1" name="chartQueue1radiogroup" value="i_Queue_OwnedItemCount" checked="true"/><label
            for="c3r1">Size</label>
        <input type="radio" id="c3r2" name="chartQueue1radiogroup" value="o_Queue_NumberOfOffers"/><label
            for="c3r2">Offers</label>
        <input type="radio" id="c3r3" name="chartQueue1radiogroup" value="o_Queue_NumberOfPolls"/><label
            for="c3r3">Polls</label>
    </div>
</div>

<div id="chartQueue2-opts" title="Chart 2 Options" class="chartoptsdiv">
    <div id="chartQueue2optsmenu" class="chartoptsmenu">
        <input type="radio" id="c4r1" name="chartQueue2radiogroup" value="i_Queue_OwnedItemCount"/><label
            for="c4r1">Size</label>
        <input type="radio" id="c4r2" name="chartQueue2radiogroup" value="o_Queue_NumberOfOffers" checked="true"/><label
            for="c4r2">Offers</label>
        <input type="radio" id="c4r3" name="chartQueue2radiogroup" value="o_Queue_NumberOfPolls"/><label
            for="c4r3">Polls</label>
    </div>
</div>


<div id="chartTopic1-opts" title="Chart 1 Options" class="chartoptsdiv">
    <div id="chartTopic1optsmenu" class="chartoptsmenu">
        <input type="radio" id="c5r1" name="chartTopic1radiogroup" value="o_Topic_NumberOfPublishes"
               checked="true"/><label
            for="c5r1">Publishes</label>
        <input type="radio" id="c5r2" name="chartTopic1radiogroup" value="o_Topic_NumberOfReceivedMessages"/><label
            for="c5r2">Receives</label>
    </div>
</div>

<div id="chartTopic2-opts" title="Chart 2 Options" class="chartoptsdiv">
    <div id="chartTopic2optsmenu" class="chartoptsmenu">
        <input type="radio" id="c6r1" name="chartTopic2radiogroup" value="o_Topic_NumberOfPublishes"/><label
            for="c6r1">Publishes</label>
        <input type="radio" id="c6r2" name="chartTopic2radiogroup" value="o_Topic_NumberOfReceivedMessages"
               checked="true"/><label
            for="c6r2">Receives</label>
    </div>
</div>


<div id="threadDumpDiv" title="Thread Dump">
    <textarea id="threadDumpTextarea" style="height: 500px; width: 600px;"></textarea>
</div>


<div id="mapConfigDiv" title="Map Configuration">

    <table>
        <tr>
            <td class="infoLabel">
                Name:
            </td>
            <td>
                <input title="name" style="background-color: #d3d3d3;" name="mapconfiginput" class="mapconfiginfo"
                       readonly="readonly"/>
            </td>
            <td class="infoLabel">
                Backup Count:
            </td>
            <td>
                <select title="backupCount" name="mapconfiginput" class="mapconfiginfo">
                    <option value="0">0</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="infoLabel">
                Max Size:
            </td>
            <td>
                <input class="mapconfiginfo" name="mapconfiginput" type="text" title="maxSize"/>
            </td>
            <td class="infoLabel">
                TTL (seconds):
            </td>
            <td>
                <input class="mapconfiginfo" name="mapconfiginput" type="text" title="timeToLiveSeconds"/>
            </td>
        </tr>
        <tr>
            <td class="infoLabel">
                Max Idle(seconds):
            </td>
            <td>
                <input class="mapconfiginfo" name="mapconfiginput" type="text" title="maxIdleSeconds"/>
            </td>
            <td class="infoLabel">
                Eviction Percentage (%):
            </td>
            <td>
                <select title="evictionPercentage" class="mapconfiginfo" name="mapconfiginput">
                    <%
                        for (int i = 0; i <= 100; i += 5) {
                    %>
                    <option value="<%=i%>"><%=i%>
                    </option>
                    <%}%>
                </select>
            </td>
        </tr>
        <tr>
            <td class="infoLabel">
                Eviction Policy:
            </td>
            <td>
                <select title="evictionPolicy" class="mapconfiginfo" name="mapconfiginput">
                    <option value="NONE">NONE</option>
                    <option value="LRU">LRU</option>
                    <option value="LFU">LFU</option>
                </select>
            </td>

            <td class="infoLabel">
                Cache Value:
            </td>
            <td>
                <select title="cacheValue" class="mapconfiginfo" name="mapconfiginput">
                    <option value="true">true</option>
                    <option value="false">false</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="infoLabel">
                Read Backup Data:
            </td>
            <td>
                <select title="readBackupData" class="mapconfiginfo" name="mapconfiginput">
                    <option value="true">true</option>
                    <option value="false">false</option>
                </select>
            </td>
            <td class="infoLabel">
                Backup Count:
            </td>
            <td>
                <select title="backupCount" name="mapconfiginput" class="mapconfiginfo">
                    <option value="0">0</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                </select>
            </td>
        </tr>
        <tr>
            <td colspan="4" style="text-align: center; padding-top: 5px; color: red;" id="updateConfigMessageTd">
            </td>
        </tr>
        <tr>
            <td colspan="4" style="text-align: center; padding-top: 10px;">
                <button class="button" onclick="updateMapConfigAction()">Update</button>
            </td>
        </tr>
    </table>
</div>

<div id="consoleDiv" title="Console">
    <textarea id="commandOutput" readonly="true"
              style="width: 650px; background-color: #000000; color: #ffffff; font-weight: bold; " rows="14" cols="70"
            >&gt; Type help for command list</textarea>
    <br/>
    <input type="text" id="commandInput" style="width: 650px;"/>
    <%--<button onclick="sendCommand()">Send</button>--%>

</div>


<div id="mapBrowserDiv" title="Map Browser">

    <div>
        <label for="mapkey">Key:</label>
        <input id="mapkey" type="text"/>
        <select id="selectMapBrowserType">
            <option value="string">string</option>
            <option value="integer">integer</option>
            <option value="long">long</option>
        </select>
        <button id="browseSubmitButton" style="height: 20px; " onclick="browseMapValue()">Browse</button>
    </div>

    <table id="browserResult" style="margin-top: 10px;">
        <tr>
            <td class="infoLabel">Value:</td>
            <td id="browse_value" class="valueTd browseValueTd"></td>
            <td class="infoLabel">Class:</td>
            <td id="browse_class" class="valueTd browseValueTd"></td>
        </tr>
        <tr>
            <td class="infoLabel">Cost:</td>
            <td id="memory_cost" class="valueTd browseValueTd"></td>
            <td class="infoLabel">Creation Time:</td>
            <td id="date_creation_time" class="valueTd browseValueTd"></td>
        </tr>
        <tr>
            <td class="infoLabel">Expiration Time:</td>
            <td id="date_expiration_time" class="valueTd browseValueTd"></td>
            <td class="infoLabel">Hits:</td>
            <td id="browse_hits" class="valueTd browseValueTd"></td>
        </tr>
        <tr>
            <td class="infoLabel">Access Time:</td>
            <td id="date_access_time" class="valueTd browseValueTd"></td>
            <td class="infoLabel">Update Time:</td>
            <td id="date_update_time" class="valueTd browseValueTd"></td>
        </tr>
        <tr>
            <td class="infoLabel">Version:</td>
            <td id="browse_version" class="valueTd browseValueTd"></td>
            <td class="infoLabel">Valid:</td>
            <td id="boolean_valid" class="valueTd browseValueTd"></td>
        </tr>

    </table>
</div>


<div id="login_dialog" title="Login to Cluster">
    <div id="loginDiv" style="margin: 10px;">
        <table>
            <tr>
                <td>Username:</td>
                <td><input type="text" id="login_username"/></td>
            </tr>
            <tr>
                <td>Password:</td>
                <td><input type="password" id="login_password" class="onEnterSubmit"/></td>
            </tr>
            <tr>
                <td colspan="2" style="padding: 5px; vertical-align: middle;"><input type="checkbox"
                                                                                     class="onEnterSubmit"
                                                                                     id="login_remember"/><label
                        for="login_remember" style="font-size: 10pt;">Remember me?</label></td>
            </tr>
            <tr>
                <td colspan="2" style="color: red;" id="loginFailTd"></td>
            </tr>
        </table>


    </div>
    <div id="clusterConnectDiv" class="loginDivs">
        <p class="validateTips">Select cluster to connect.</p>

        <form>
            <fieldset id="clusterList">
                <img src="images/loader.gif" class="loaderImage"/>
            </fieldset>
        </form>
        <div style="padding-top: 10px;" id="licenseInfo"></div>

        <div style="padding-top: 10px;" id="applyWarnDiv">For unlimited nodes, <a href="#"
                                                                                  onclick="applyLicenseAction()">apply
            for trial</a></div>

    </div>

    <div id="licenseKeyDiv" class="loginDivs">
        <p class="validateTips">Please enter your license key:</p>

        <form>
            <label for="licenseKeyInput">License Key:</label><br/><input style="width: 220px;" type="text"
                                                                         id="licenseKeyInput"></input>
        </form>
        <div style="color: red; padding-top: 10px;" id="licenseSaveInfo"></div>
        <p class="validateTips"><a href="#" onclick="applyLicenseAction()">or apply for trial</a></p>
    </div>

    <div id="noClusterDiv" class="loginDivs">
        <p class="validateTips">No cluster data. Have you configured your Hazelcast cluster for web management
            center?</p>

        <p class="validateTips">You should add the following property to your Hazelcast configuration.</p>

        <div style="white-space: nowrap;">&lt;management-center enabled="true"&gt;<span id="yourUrlText">YOUR_MANCENTER_WEB_URL</span>&lt;/management-center&gt;
        </div>
    </div>


    <div id="applyLicenseDiv" class="loginDivs">
        <form name="contactform" action="http://www.hazelcast.com/sendemail.jsp" method="post">
            <input type="hidden" name="subject" id="subject" value="TRIAL LICENSE">
            <table cellpadding="5" cellspacing="5">
                <tbody>
                <tr>
                    <td>Your Name (required):</td>
                    <td>
                        <input type="text" name="name" id="name"/>
                    </td>
                </tr>
                <tr>
                    <td>Your Email (required):</td>
                    <td><input type="text" name="email" id="email" value=""> <br/>(the license will be emailed)</td>
                </tr>
                <tr>
                    <td>Company Name (required):</td>
                    <td><input type="text" name="website" id="website" value=""></td>
                </tr>
                <tr>
                    <td valign="top">Message:</td>
                    <td>
                        <textarea name="message" id="message" rows="10" cols="30"></textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center;">
                        <button class="button">Submit</button>
                    </td>
                </tr>
                </tbody>
            </table>
            <input type="hidden" value="mancenter" name="product"/>

        </form>
    </div>

</div>

<div id="licenseErrorDialog" title="Nodes Limit Exceeded">
    <div id="licenseErrorDiv">
        <p class="validateTips">In the developer mode, you can monitor maximum 2 nodes.</p>

        <p class="validateTips">Either shutdown your exceeding nodes or enter your license key.</p>
    </div>
</div>

<div id="deleteUserConfirm" title="Delete User?">
    <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>The user will be deleted and
        cannot be recovered. Are you sure?</p>
</div>

<div id="gcResultDialog" title="Garbage Collection">
    <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Garbage collected
        succesfully.</p>
</div>

<div id="logLevelResultDialog" title="Log Level Configured">
    <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Log level configured
        succesfully.</p>
</div>


</body>
</html>