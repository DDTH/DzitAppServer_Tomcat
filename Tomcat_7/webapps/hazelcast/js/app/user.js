
function saveUserAction() {
    var password = $("#a_password").val()
    if (password != $("#a_password_retype").val()) {
        alert("Passwords mismatch.")
        return;
    }
    var username = $("#a_username").val()
    var email = $("#a_email").val();
    var admin = $("#a_admin").attr("checked") == 'checked' ? 1 : 0;
    var roles = ""
    $(".roleRadio:checked").each(
        function (index) {
            roles = roles + "###" + $(this).val();
        });

    var data = {operation:"saveuser", username:username, email:email, password:password, admin:admin, roles:roles}
    opcall(data)
}


function showDeleteUserConfirm() {
    $('#deleteUserConfirm').dialog('open')
}


function deleteUserAction() {
    var username = $("#a_username").val()

    var data = {operation:"deleteuser", username:username}
    opcall(data)
}



function fillRoles() {
    $("#a_roles").empty()

    var str = "<table cellspacing=5 ><tr><td style='border-bottom: 1px solid gray; font-weight: bold; text-align: center;'>Cluster Name</td><td style='border-bottom: 1px solid gray; font-weight: bold; text-align: center;'>Permissions</td></tr>"
    for (var i = 0; i < clusterList.length; i++) {
        var cluster = clusterList[i]
        str += "<tr><td>" + cluster + "</td><td>  <input type='radio' class='roleRadio roleChecked' checked='checked'  name='" + cluster + "Role' value='0___" + cluster + "' id='0___" + cluster + "' /> <label for='0___" + cluster + "'> None </label> &nbsp;&nbsp;  <input type='radio' class='roleRadio' name='" + cluster + "Role' value='1___" + cluster + "' id='1___" + cluster + "' /> <label for='1___" + cluster + "'> Read Only </label> &nbsp;&nbsp; <input class='roleRadio' type='radio' name='" + cluster + "Role' value='2___" + cluster + "' id='2___" + cluster + "' /> <label for='2___" + cluster + "'> Read/Write </label></td></tr>";
    }
    str += "</table>"
    $("#a_roles").append(str)

}

function fillUsersAction() {
    var data = {operation:"userlist"}
    opcall(data)
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


function editUser(usr) {
    var data = {user:usr, operation:"loaduser"}
    opcall(data)
}



function loadNewUserAction() {
    $("#a_username").val("")
    $("#a_username").attr("readonly", false)
    $("#a_email").val("")
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
    $("#a_email").val(data.email)
    $("#a_password").val(data.password)
    $("#a_password_retype").val(data.password)

    $("#userAccordionHeader").html("Update User")
    $("#deleteUserButton").show()
//    $("#resetPasswordButton").show()
    var ss = data.roles.split("###")
    for (var i = 0; i < ss.length; i++) {
        $("#" + ss[i]).attr("checked", false)
        if (ss[i].length > 0)
            $("#" + ss[i]).attr("checked", "checked")
    }
    if (data.admin == 1)
        $("#a_admin").attr("checked", "checked")
    else
        $("#a_admin").attr("checked", false)

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