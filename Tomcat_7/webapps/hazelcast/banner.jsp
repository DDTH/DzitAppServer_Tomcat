<table cellpadding="0" cellspacing="0" style="width:100%;">
    <tr>
        <td style="width: 237px;">
            <img src="images/logo.png" alt="hazelcast logo"/>
        </td>
        <td style="vertical-align: bottom; padding-left: 0px;">
            <div class="buttonset" id="topButtonDiv">
                <input type="radio" id="radio1" name="radiomenu" onclick="changeSection('sectionHome')"
                       checked="checked"/><label for="radio1">Home</label>
                <input type="radio" id="radio2" name="radiomenu"
                onclick="changeSection('sectionHealth')"/><label for="radio2">Health
                Check</label>
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
                         <a id="mainVersion" style="color:white" ></a>
                    </td>
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
                        <button onclick="enterLicenseButton()" id="enterLicenseButton">enter license</button>
                    </td>
                    <td>
                        <button onclick="showChangeUrlScreen(true)" id="changeUrlButton">change url</button>
                    </td>
                    <td>
                        <button onclick="logout()" id="logoutButton">logout</button>
                    </td>
                </tr>
            </table>
        </td>
    </tr>

</table>
