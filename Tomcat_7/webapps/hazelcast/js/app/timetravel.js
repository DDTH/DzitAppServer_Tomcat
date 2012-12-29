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

function openTimeTravel() {
    if (writeMode == 0) {
        $("#readOnlyError").dialog("open")
        $("#timeTravelButton").attr("checked", false)
        $("#timeTravelButton").button("refresh")
    }
    else if (writeMode == 1) {
        $("#timeTravelButton").attr("checked", false)
        $("#timeTravelButton").button("refresh")

        $("#enableTimeTravelDialog").dialog("option", "width", 500);
        $("#enableTimeTravelDialog").dialog("option", "height", 180);
        $("#enableTimeTravelDialog").dialog("open")

        $("#enableTimeTravelDialog").dialog("option", "buttons",
            [
                {id:"enableTTButton", text:"Enable", click:function () {
                    enableTimeTravelAction()
                    $(this).dialog("close")
                }},
                {id:"cancelTTButton", text:"Cancel", click:function () {
                    $(this).dialog("close")
                }}
            ])
    }

    else if (writeMode == 2) {
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

}

function enableTimeTravelAction() {
    opcall({operation:"enabletimetravel"})
}

function enabletimetravel(data) {
    if (data == "SUCCESS") {
        writeMode = 2
        $("#timeTravelButton").attr("checked", true)
        $("#timeTravelButton").button("refresh")
        openTimeTravel()
        fillAlertList()
        getAlertHistoryAction()
    }
    else {
        reloadPage()
    }
}


function disableTimeTravelConfirm() {
    $("#disableTimeTravelDialog").dialog("option", "width", 500);
         $("#disableTimeTravelDialog").dialog("option", "height", 150);
         $("#disableTimeTravelDialog").dialog("open")

         $("#disableTimeTravelDialog").dialog("option", "buttons",
             [
                 {id:"disableTTButton", text:"Disable", click:function () {
                     disableTimeTravelAction()
                     $(this).dialog("close")
                 }},
                 {id:"cancelDisTTButton", text:"Cancel", click:function () {
                     $(this).dialog("close")
                 }}
             ])

}

function disableTimeTravelAction() {
    opcall({operation:"disabletimetravel"})
}

function disabletimetravel(data) {
    if (data == "SUCCESS") {
        $("#timeTravelButton").attr("checked", false)
        $("#timeTravelButton").button("refresh")
        openTimeTravel()
        writeMode = 1
        fillAlertList()
        getAlertHistoryAction()
    }
    else {
        reloadPage()
    }
}


