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
                    <tr>
                        <td class="infoLabel">Email:</td>
                        <td><input type="text" id="a_email"/></td>
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
