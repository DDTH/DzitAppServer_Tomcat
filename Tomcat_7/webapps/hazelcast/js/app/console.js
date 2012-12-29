


function openConsole() {
    $("#consoleDiv").dialog("open")
    $("#commandInput").focus()
}


function sendCommand() {

    var command = $("#commandInput").val()
    $("#commandInput").val("")
    $("#commandInput").focus()

    if(command == "") {
        $("#commandOutput").val($("#commandOutput").val() + namespace + "> " + command + "\n")
        $("#commandOutput").scrollTop(99999)
        return
    }


    $("#commandOutput").val($("#commandOutput").val() + namespace + "> " + command + "\n")

    if (command.indexOf("ns") == 0) {
        namespace = command.split(" ")[1]
        $("#commandOutput").val($("#commandOutput").val() + "> Current Namespace:" + namespace + "\n")
        var textArea = document.getElementById('commandOutput');
        textArea.scrollTop = textArea.scrollHeight;
        return;
    }


    var data = {cluster:activeCluster, operation:"executecommand", namespace:namespace, command:command }
    opcall(data)
}


function executecommand(data) {
    $("#commandOutput").val($("#commandOutput").val() + namespace + "> " + data)
    $("#commandOutput").scrollTop(99999)
}
