<div id="mapContentTemplate" class="contentDiv" style="display: none;">

    <table>
        <tr>
            <td style="padding-top:10px; padding-bottom:10px; ">
                <div id="chartMap1" onclick='openChartOpts(event, "#chartMap1-opts")' class="chartDivSmall">
                    <img src="images/loader.gif" class="loaderImage"/>
                </div>
            </td>
            <td style="padding-top:10px; padding-bottom:10px; ">
                <div id="chartMap2" onclick='openChartOpts(event, "#chartMap2-opts")' class="chartDivSmall">
                    <img src="images/loader.gif" class="loaderImage"/>
                </div>
            </td>
            <td style="vertical-align: top; padding-top: 15px;">
                <table align="right">
                    <tr>
                        <td>
                            <button id="browseButton" style="width: 90px">Browse</button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <button id="configButton" style="width: 90px" class="writeModeButton">Config</button>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <h3>Map Memory Data Table</h3>

                <div id="datatableMap1" style="width:1000px; height: 120px; " class="datatable"><img
                        src="images/loader.gif" class="loaderImage"/></div>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <h3>Map Throughput Data Table</h3>

                <div id="datatableMap2" style="width:1000px; height: 120px; " class="datatable"><img
                        src="images/loader.gif" class="loaderImage"/></div>
            </td>
        </tr>
    </table>
</div>
