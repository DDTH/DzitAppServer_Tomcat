function loginAction() {
    username = $("#login_username").val()
    password = $("#login_password").val()
    loginActionWithParams(username, password)
}

function loginActionWithParams(username, password) {
    opcall({operation:"login", username:username, password:password })
}


function login(data) {
    if (data == null) {
        $("#loginFailTd").html("Wrong username or password. (First time pass: admin/admin)")
    }
    else if (data == "VERSION_MISMATCH") {
        $("#loginFailTd").html("Version mismatch. Hazelcast node versions should be: " + version + ".X")
    }
    else {
        clusternames(data)
    }
}


function clusternames(user) {
    if ($("#login_remember").attr("checked") == "checked") {
        $.cookie('c_username', user.username, { expires:7 });
        $.cookie('c_password', user.password, { expires:7 });
    }


    admin = user.admin

    $('#clusterList').empty()
    clusterList = new Array()
    var slist = user.roles.split("###")
    var nocluster = true
    for (var i = 0; i < slist.length; i++) {
        var ss = slist[i]
        if (ss.length > 0) {
            var role = ss.split("___")[0]
            var cluster = ss.split("___")[1]
            if (cluster.length > 0 && (role != "0" || user.admin == "1")) {
                $('#clusterList').append("<div class='clusterRadioDiv' ><input id='clusterradiolist" + i + "' type='radio' name='clusterradiolist' value='" + ss + "'  /><label for='clusterradiolist" + i + "' class='itemLink'>" + cluster + "</label></div>")
                clusterList.push(cluster)
                nocluster = false
            }
        }
    }

    $("[name='clusterradiolist']:first").attr("checked", true)

    var buttons = [];
    buttons = [
        {id:"connectButton", text:"Connect", click:function () {
            init();
            $(this).dialog("close");
        }}
    ]

    if (user.licenseInfo == null || user.licenseInfo == 'EXPIRED') {
        $("#applyWarnDiv").show()
        if (user.licenseInfo == null)
            $("#licenseInfo").html("Developer Mode: Max 2 node limit.")
        else if (user.licenseInfo == 'EXPIRED'){
            $("#licenseInfo").html("Your license has been expired. You can continue in developer Mode (Max 2 node limit) or renew your license.")
        }
        buttons.push(
            {id:"enterLicenseButton", text:"Enter License", click:function () {
                showEnterLicense()
            }}
        )
    }
    else {
        $("#licenseInfo").html(user.licenseInfo)
    }


    $("#login_dialog").dialog("option", "buttons", buttons)
    $("#connectButton").focus()
    $("#loginDiv").hide()
    $(".loginDivs").hide()
    $("#clusterConnectDiv").show("slide")

}


function changeUrlAction() {
    var data = {operation:"changeurl", clusterName:$("#clusterNameInput").val(), password:$("#clusterPasswordInput").val(),
        memberIP:$("#memberIPInput").val(), memberPort:$("#memberPortInput").val(), serverUrl:$("#serverUrlInput").val()}
    opcall(data)
}

function changeurl(data) {
    if (data == "wrongpass") {
        $("#changeUrlMessage").html("Wrong cluster name/password.")
    }
    else if (data == "success") {
        $("#changeUrlMessage").html("Successfully assigned new url.")
        setTimeout('location.href = "main.do"', 1000);
    }
    else if (data == "notallowed") {
        $("#changeUrlMessage").html("Url change is disabled. To enable set system property 'hazelcast.mc.url.change.enabled' to true")
    }
    else {
        $("#changeUrlMessage").html("Problem occured. Check member IP/Port and be sure the member is running.")
    }

}


function saveLicenseAction() {
    var key = $("#licenseKeyInput").val()
    var data = {operation:"savelicense", key:key}
    opcall(data)
}


function savelicense(data) {
    if (data == 0)
        $("#licenseSaveInfo").html("Invalid license key.")
    else if (data == 1)
        $("#licenseSaveInfo").html("The license key entered has been expired.")
    else if (data > 1) {
        $("#licenseSaveInfo").html("Your license has been activated. License end date:" + $.format.date(new Date(data), "MMMM,dd yyyy"))
        $("#applyWarnDiv").hide()
        setTimeout('loginActionWithParams(username, password)', 1500);
    }
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


function logout() {
    $.cookie('c_username', null);
    $.cookie('c_password', null);
    reloadPage()
}
