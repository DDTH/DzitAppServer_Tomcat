
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
    opcall(data)
}



function executescript(olist) {
    $("#scriptResult").html(olist)
}
