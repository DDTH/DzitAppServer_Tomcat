<div id="mapBrowserDiv" title="Map Browser">

    <div>
        <label for="mapkey">Key:</label>
        <input id="mapkey" type="text"/>
        <select id="selectMapBrowserType">
            <option value="string">string</option>
            <option value="integer">integer</option>
            <option value="long">long</option>
        </select>
        <button id="browseSubmitButton" style="height: 20px; " onclick="browseMapValue()">Browse</button>
        <span id="mapBrowserInfo" style="color: red; margin-left: 10px;" ></span>
    </div>

    <table id="browserResult" style="margin-top: 10px;">
        <tr>
            <td class="infoLabel">Value:</td>
            <td id="browse_value" class="valueTd browseValueTd"></td>
            <td class="infoLabel">Class:</td>
            <td id="browse_class" class="valueTd browseValueTd"></td>
        </tr>
        <tr>
            <td class="infoLabel">Cost:</td>
            <td id="memory_cost" class="valueTd browseValueTd"></td>
            <td class="infoLabel">Creation Time:</td>
            <td id="date_creation_time" class="valueTd browseValueTd"></td>
        </tr>
        <tr>
            <td class="infoLabel">Expiration Time:</td>
            <td id="date_expiration_time" class="valueTd browseValueTd"></td>
            <td class="infoLabel">Hits:</td>
            <td id="browse_hits" class="valueTd browseValueTd"></td>
        </tr>
        <tr>
            <td class="infoLabel">Access Time:</td>
            <td id="date_access_time" class="valueTd browseValueTd"></td>
            <td class="infoLabel">Update Time:</td>
            <td id="date_update_time" class="valueTd browseValueTd"></td>
        </tr>
        <tr>
            <td class="infoLabel">Version:</td>
            <td id="browse_version" class="valueTd browseValueTd"></td>
            <td class="infoLabel">Valid:</td>
            <td id="boolean_valid" class="valueTd browseValueTd"></td>
        </tr>

    </table>
</div>

