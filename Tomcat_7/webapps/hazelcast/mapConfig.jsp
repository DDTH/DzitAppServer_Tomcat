<div id="mapConfigDiv" title="Map Configuration">

    <table>
        <tr>
            <td class="infoLabel">
                Name:
            </td>
            <td>
                <input title="name" style="background-color: #d3d3d3;" name="mapconfiginput" class="mapconfiginfo"
                       readonly="readonly"/>
            </td>
          <td class="infoLabel">
              Max Size:
          </td>
          <td>
              <input class="mapconfiginfo" name="mapconfiginput" type="text" title="maxSize"/>
           </td>
        </tr>
        <tr>
            <td class="infoLabel">
                Backup Count:
            </td>
            <td>
                <select title="backupCount" name="mapconfiginput" class="mapconfiginfo">
                    <option value="0">0</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                </select>
            </td>

            <td class="infoLabel">
                Async Backup Count:
            </td>
            <td>
                <select title="asyncBackupCount" name="mapconfiginput" class="mapconfiginfo">
                    <option value="0">0</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="infoLabel">
                Max Idle(seconds):
            </td>
            <td>
                <input class="mapconfiginfo" name="mapconfiginput" type="text" title="maxIdleSeconds"/>
            </td>
            <td class="infoLabel">
                TTL (seconds):
            </td>
            <td>
                <input class="mapconfiginfo" name="mapconfiginput" type="text" title="timeToLiveSeconds"/>
            </td>
        </tr>
        <tr>
            <td class="infoLabel">
                Eviction Policy:
            </td>
            <td>
                <select title="evictionPolicy" class="mapconfiginfo" name="mapconfiginput">
                    <option value="NONE">NONE</option>
                    <option value="LRU">LRU</option>
                    <option value="LFU">LFU</option>
                </select>
            </td>

            <td class="infoLabel">
                Eviction Percentage (%):
            </td>
            <td>
                <select title="evictionPercentage" class="mapconfiginfo" name="mapconfiginput">
                    <%
                        for (int i = 0; i <= 100; i += 5) {
                    %>
                    <option value="<%=i%>"><%=i%>
                    </option>
                    <%}%>
                </select>
            </td>
        </tr>
        <tr>
            <td class="infoLabel">
                Cache Value:
            </td>
            <td>
                <select title="cacheValue" class="mapconfiginfo" name="mapconfiginput">
                    <option value="true">true</option>
                    <option value="false">false</option>
                </select>
            </td>

            <td class="infoLabel">
                Read Backup Data:
            </td>
            <td>
                <select title="readBackupData" class="mapconfiginfo" name="mapconfiginput">
                    <option value="true">true</option>
                    <option value="false">false</option>
                </select>
            </td>
        </tr>
        <tr>
            <td colspan="4" style="text-align: center; padding-top: 5px; color: red;" id="updateConfigMessageTd">
            </td>
        </tr>
        <tr>
            <td colspan="4" style="text-align: center; padding-top: 10px;">
                <button class="button" onclick="updateMapConfigAction()">Update</button>
            </td>
        </tr>
    </table>
</div>
