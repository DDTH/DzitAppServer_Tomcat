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


function sendGC() {
    var data = {cluster:activeCluster, operation:"rungc", member:activeObject }
    opcall(data)
}

function threaddump(data) {
    $("#threadDumpDiv").dialog("open");
    $("#threadDumpTextarea").html(data.data)
}

function rungc(data) {
    $("#gcResultDialog").dialog("open");
}


function getThreadDump() {
    var data = {cluster:activeCluster, operation:"threaddump", member:activeObject }
    opcall(data)
}


function fillMemberListForScripting() {
    $('#memberCheckList').empty()
    for (var i = 0; i < memberlistcache.length; i++) {
        $('#memberCheckList').append("<div class='memberCheckDiv' ><input id='memberchecklist" + i + "' checked='checked' type='checkbox' name='memberchecklist' value='" + memberlistcache[i].label + "'  /><label for='memberchecklist" + i + "' class='itemLink'>" + memberlistcache[i].label + "</label></div>")
    }
}


function fillMemberCheckListForLogs() {
    $('#memberCheckListForLogs').empty()
    for (var i = 0; i < memberlistcache.length; i++) {
        $('#memberCheckListForLogs').append("<div class='memberCheckDiv' ><input id='memberchecklistForLogs" + i + "' checked='checked' type='checkbox' name='memberchecklistForLogs' value='" + memberlistcache[i].label + "'  /><label for='memberchecklistForLogs" + i + "' class='itemLink'>" + memberlistcache[i].label + "</label></div>")
    }
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


function memberruntime(datalist) {
    if (datalist != null)
        for (lbl in datalist) {
            var idm = lbl.split(".")[1]
            $("#" + idm).html(datalist[lbl])
        }
}


function memberlist(olist) {
    memberlistcache = olist
    $('#members').empty()
    $("#membersHeader").html("Members (" + olist.length + ")")
    var str = "<table ><tbody>"
    for (var i = 0; i < olist.length; i++) {
        var latencyPic = "images/"
        var info = "Latest Data: " + olist[i].latency + " seconds ago"
        if (olist[i].latency == -1) {
            latencyPic += "gray.png"
        }
        else if (olist[i].latency < 60) {
            latencyPic += "green.png"
        }
        else if (olist[i].latency < 300)
            latencyPic += "yellow.png"
        else
            latencyPic += "red.png"

        str += "<tr><td style='vertical-align: bottom;'><img class='latencyPics' src='" + latencyPic + "' alt='' title='" + info + "' /></td><td style='vertical-align: middle;'><a href='#' class='itemLink' onclick='addViewShort(\"" + olist[i].label + "\", \"member\" )'>" + (i + 1) + "- " + olist[i].label + "</a></td></tr>"
    }
    str += "</tbody></table>"
    $('#members').append(str)
}