<tr class="sectionTable sectionLogs">
    <td class="leftPanel resizable">

        <div class="accordion" id="memberLogsCheckListAccordion">
            <h3><a href="#">Filter Logs</a></h3>

            <div class="logFilters">

                <div>
                    <label>Message:</label>
                    <br/>
                    <input type="text" id="logFilterMessage"/>
                </div>

                <br/>

                <div>
                    <label>Call Id:</label>
                    <br/>
                    <input type="text" id="logFilterCallId"/>
                </div>
                <br/>

                <label>Members:</label>
                <br/>
                <input type="text" id="logFilterMembers" class="hidden" />
                <div id="memberCheckListForLogs">
                </div>
                <br/>

                <label>Log Type:</label>
                <br/>
                <br/>

                <div id="typeCheckDivForLogs">
                    <div class='typeCheckDiv'>
                        <input id='typechecklistForLogs1' checked='checked' type='checkbox' name='typechecklistForLogs'
                               value='NODE'/>
                        <label for='typechecklistForLogs1' class='itemLink'>NODE</label>
                    </div>
                    <div class='typeCheckDiv'>
                        <input id='typechecklistForLogs2' checked='checked' type='checkbox' name='typechecklistForLogs'
                               value='JOIN'/>
                        <label for='typechecklistForLogs2' class='itemLink'>JOIN</label>
                    </div>
                    <div class='typeCheckDiv'>
                        <input id='typechecklistForLogs3' checked='checked' type='checkbox' name='typechecklistForLogs'
                               value='CONNECTION'/>
                        <label for='typechecklistForLogs3' class='itemLink'>CONNECTION</label>
                    </div>
                    <div class='typeCheckDiv'>
                        <input id='typechecklistForLogs4' checked='checked' type='checkbox' name='typechecklistForLogs'
                               value='PARTITION'/>
                        <label for='typechecklistForLogs4' class='itemLink'>PARTITION</label>
                    </div>
                    <div class='typeCheckDiv'>
                        <input id='typechecklistForLogs5' checked='checked' type='checkbox' name='typechecklistForLogs'
                               value='CALL'/>
                        <label for='typechecklistForLogs5' class='itemLink'>CALL</label>
                    </div>
                </div>
                <br/>
                <br/>
                <a href="main.do?operation=getlogs&export=true" id="exportLogsLink" class="button">Export Logs</a>
                <button class="button" onclick="getLogsAction('none')">Refresh</button>
                <br/>
                <br/>
                <select id="logLevelSelect">
                    <option value="" disabled="true">Select</option>
                    <option value="trace">Trace</option>
                    <option value="info">Info</option>
                    <option value="default">Default</option>
                    <option value="none">None</option>
                </select>
                <button class="button" onclick="setLogLevelAction()">Set Level</button>

            </div>
        </div>


    </td>
    <td style="vertical-align: top; padding: 1px;">
        <div id="logsGrid" style="width:1000px;height:500px; border: 1px solid #aaa;"></div>
        <input type="text" id="fullLogMessageText"
               style="width:1000px; font-weight: bold; background-color: #F5F5DC "></input>
        <% if ("true".equals(request.getParameter("import"))) { %>
        <input type="text" id="logFilePath" style="width: 300px;"></input>
        <button onclick="getLogsFromFile()">Import</button>
        <% } %>
    </td>
</tr>
