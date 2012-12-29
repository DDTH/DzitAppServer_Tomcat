

function healthCheckInit() {
    $(".healthMessage").html('<img src="images/progress.gif" />')

}


function healthCheckAction() {
    var data = {cluster:activeCluster, operation:"healthcheck"}
    opcall(data)
}

function toggleImage(img) {
    if(img.attr("src") == "images/plus.png")
        img.attr("src","images/minus.png")
    else
        img.attr("src","images/plus.png")
}


function addMessages(coll, elem, id) {
    if (coll[0] == "OK") {
        elem.html('<img class="healthImage" align="middle" src="images/ok.png" />')
    }
    else if (coll[0] == "ERROR") {
        elem.html('<img class="healthImage" align="middle" src="images/error.png" /> ')
    }
    else if (coll[0] == "WARNING") {
        elem.html('<img class="healthImage" align="middle"  src="images/warning.png" /> ')
    }


    if (coll.length > 1)
        elem.append('&nbsp;' + coll[1] )

    if (coll.length > 2) {
        elem.append('<br/> <div onclick="$(this).next().toggle(); toggleImage($(this).children().first()) " class="healthSeeDetailsDiv" ><img src="images/plus.png" class="healthIcon" /> See Details</div>')
        var str = '<div style="display: none;">'
        for (var i = 2; i < coll.length; i++) {
            str = str + '<br/>' + coll[i]
        }
        elem.append(str + '</div>')
    }

}

function randNumber(num) {
    return Math.floor((Math.random()*num)+1);
}

function healthcheck(data) {
    var interval = 2000;
    setTimeout(function () {
        addMessages(data.member, $("#memberCheck"))
    }, randNumber(interval))

    setTimeout(function () {
        addMessages(data.connection, $("#connectionCheck"))
    }, randNumber(interval))

    setTimeout(function () {
        addMessages(data.locks, $("#locksCheck"))
    }, randNumber(interval))

    setTimeout(function () {
        addMessages(data.migration, $("#migrationCheck"))
    }, randNumber(interval))

    setTimeout(function () {
        addMessages(data.partition, $("#partitionCheck"))
    }, randNumber(interval))

}