<div id="executorContentTemplate" class="contentDiv" style="display: none;">

    <table>
        <tr>
            <td style="padding-top:10px; padding-bottom:10px; ">
                <h4>Executed By Nodes</h4>
                <div id="chartExecutor1" onclick='openChartOpts(event, "#chartExecutor1-opts")' class="chartDivSmall">
                    <img src="images/loader.gif" class="loaderImage"/>
                </div>
            </td>
            <td style="padding-top:10px; padding-bottom:10px; ">
                <h4>Submitted By Nodes</h4>
                <div id="chartExecutor2" onclick='openChartOpts(event, "#chartExecutor2-opts")' class="chartDivSmall">
                    <img src="images/loader.gif" class="loaderImage"/>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <h3>Executed By Node (last 60 seconds)</h3>
                <div id="datatableExecutor1" style="width:1000px; height: 120px; " class="datatable"><img
                        src="images/loader.gif" class="loaderImage"/></div>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <h3>Submitted By Node (last 60 seconds)</h3>
                <div id="datatableExecutor2" style="width:1000px; height: 120px; " class="datatable"><img
                        src="images/loader.gif" class="loaderImage"/></div>
            </td>
        </tr>
    </table>
</div>
