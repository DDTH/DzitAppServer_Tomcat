var namespace = "default"
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
var version = "2.4"
var importLogs = false
var writeMode = 1
var username = ""
var password = ""
var filterCreateOrEdit = "create";

var mapListCache;
var queueListCache;
var multimapListCache;
var topicListCache;
var executorListCache;
$(document).ready(function () {

    importLogs = location.search.indexOf("import=true") > 0

    $("#mainVersion").html("Version " + version + "  ");
    $("title").html("v"+version+ " " + "Hazelcast Management Center")
    $(".sectionHome").show();

    $("#licenseErrorDialog").dialog({
        autoOpen:false,
        height:200,
        width:500,
        modal:true,
        buttons:[
            {id:"enterLicenseButton", text:"Enter License", click:function () {
                showEnterLicense()
            }},
            {id:"retryButton", text:"Retry", click:function () {
                reloadPage()
            }}
        ],
        beforeClose:function (event, ui) {
            return false;
        }
    });

    $("#changeUrlDialog").dialog({
        autoOpen:false,
        height:350,
        width:360,
        modal:true,
        buttons:[
            {id:"setUrlButton", text:"Set Url", click:function () {
                changeUrlAction()
            }}
        ]
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

    $("#connectClusterDialog").dialog({
        autoOpen:true,
        height:130,
        width:300,
        modal:true
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


    $("#noDataDialog").dialog({
        autoOpen:false,
        height:250,
        width:700,
        modal:true,
        buttons:[{id:"retryButton", text:"Retry", click:function () {
            reloadPage()
        }}]
    });

     $( "#alertPopup" ).resizable();

    $(".resultDialog").dialog({
        autoOpen:false,
        height:100,
        modal:true
    });
    $(".versionText").html(version)

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
    $(".hidden").hide()
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
    $("#radio2").button({ icons:{primary:'ui-icon-check'} });
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

    $("#changeUrlButton").button({
        text:false,
        icons:{
            primary:"ui-icon-link"
        }
    })

    $("#healthCheckButton").button({
        icons:{
            primary:"ui-icon-circle-check"
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
    $("#alertListAccordion").accordion("activate", 0);
    $("#alertTypes").accordion("activate", 0);
    $("#alertActionsAccordion").accordion("activate", 0);
    $("#alertPeriodAccordion").accordion("activate", 0);
    $("#clusterFilterAccordion").accordion("activate", 0);
    $("#memberFilterAccordion").accordion("activate", 0);
    $("#memberSpecificAccordion").accordion("activate",0);
    $("#dataTypeFilterAccordion").accordion("activate",0);
    $("#nameFilterAccordion").accordion("activate",0);
    $("#memberFilterForDataTypeAccordion").accordion("activate",0);
    $("#executorAlertFilterAccordion").accordion("activate",0);
    $("#generalAlertFilterAccordion").accordion("activate",0);
    $("#alertHistoryGridAccordion").accordion("activate",0);

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
    methodmap["multimap"] = "initMultiMapTab()";
    methodmap["executor"] = "initExecutorTab()";
    methodmap["member"] = "enableMemberButtons()";
//    clusterHome();
//    refreshpage(refreshSeconds);
//    $("#tabs").tabs("remove", 0)

    $(".resizable").resizable();


    if (importLogs) {
        $("#loginDiv").hide()
        activeSection = "sectionLogs"
        $(".sectionTable").hide();
        $(".sectionLogs").show();
        $("#logFilterMembers").show();
        return;
    }

    $( "#dataTypeFilter" ).buttonset();
    versionCheckAction();
});


function loginInit() {
    username = null
    password = null
    var c_username = $.cookie('c_username')
    if (c_username != null && c_username != "") {
        username = c_username
        password = $.cookie('c_password')
    }

    $("#login_dialog").dialog({
        autoOpen:true,
        height:305,
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
}


function init() {
    var str = $("[name='clusterradiolist']:checked").val()
    if (str.indexOf("___") > 0) {
        activeRole = str.split("___")[0]
        activeCluster = str.split("___")[1]
    }
    else {
        activeRole = str.split("-")[0]
        activeCluster = str.split("-")[1]
    }
    $("#exportLogsLink").attr("href", $("#exportLogsLink").attr("href") + "&cluster=" + activeCluster)

    $("#topButtonDiv").append('<input type="radio" id="radio101" name="radiomenu" /><label for="radio101">Alerts</label>')
    $("#radio101").button({ icons:{primary:'ui-icon-alert'} }).click(function () {
        changeSection("sectionAlert")
    });

    if (admin == 1) {


        $("#topButtonDiv").append('<input type="radio" id="radio100" name="radiomenu" /><label for="radio100">Administration</label>')
        $("#radio100").button({ icons:{primary:'ui-icon-person'} }).click(function () {
            changeSection("sectionAdministration")
        });


    }
   clusterHome();
//    refreshpage(refreshSeconds); this is commented because it is called when tab is changed and causes changeSection()
    $("#tabs").tabs("remove", 0)
    disableWriteModeButtons()
}

function versionCheckAction() {
    var data = {operation:"versioncheck", version:version}
    opcall(data)
}


function versioncheck(data) {
    $("#connectClusterDialog").dialog("close")

    if (data == "VERSION_MISMATCH") {
        $("#versionMismatchDialog").dialog("option", "width", 500);
        $("#versionMismatchDialog").dialog("option", "height", 180);
        $("#versionMismatchDialog").dialog("open")
        writeCheckAction()
    }
    else if (data == "TIMEOUT") {
        var host = location.href
        host = host.substring(0, host.indexOf("/main"))
        $(".yourUrlText").html(host)
        $("#noDataDialog").dialog("open")
    }
    else {
        writeCheckAction()
    }
}

function writeCheckAction() {
    opcall({operation:"writecheck"})
}


function writecheck(data) {
    if (data.indexOf("SUCCESS-") == 0) {
        writeMode = parseInt(data.split("-")[1])
        loginInit()
    }
    else {
        $("#writeErrorDialog").dialog("option", "width", 600);
        $("#writeErrorDialog").dialog("option", "height", 200);
        $("#dataDirectory").html(data)
        $("#writeErrorDialog").dialog("open")

        $("#writeErrorDialog").dialog("option", "buttons",
            [
                {id:"continueButton", text:"Continue Read-Only", click:function () {
                    $(this).dialog("close")
                    makeReadOnlyAction()
                }},
                {id:"retryButton", text:"Retry", click:function () {
                    reloadPage()
                }}
            ])
    }
}

function makeReadOnlyAction() {
    opcall({operation:"makereadonly"})
}

function makereadonly(data) {
    if (data == "SUCCESS") {
        writeMode = 0
        loginInit()
    }
    else {
        reloadPage()
    }
}


function getInitialContent() {
    return $("#" + activeView + "ContentTemplate").html()
}

function showChangeUrlScreen() {
    $("#changeUrlDialog").dialog("open")
    var host = location.href
    host = host.substring(0, host.indexOf("/main"))
    $(".yourUrlInput").val(host)
}
