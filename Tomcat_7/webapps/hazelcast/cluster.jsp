<div id="clusterContentTemplate" style="display: none;">
    <table id="clusterProps">
        <tr>
            <td class="infoLabel clusterPropsLabelTd">Version:</td>
            <td id="cl_version" class="clusterValueLabelTd valueTd"></td>
            <td class="infoLabel clusterPropsLabelTd">Build:</td>
            <td id="cl_build" class="clusterValueLabelTd valueTd"></td>
        </tr>
        <tr>
            <td class="infoLabel clusterPropsLabelTd">Max Memory:</td>
            <td id="cl_maxMemory" class="clusterValueLabelTd valueTd"></td>
            <td class="infoLabel clusterPropsLabelTd">Free Memory:</td>
            <td id="cl_freeMemory" class="clusterValueLabelTd valueTd"></td>
        </tr>
        <tr>
            <td class="infoLabel clusterPropsLabelTd">Start Time:</td>
            <td id="cl_startTime" class="clusterValueLabelTd valueTd"></td>
            <td class="infoLabel clusterPropsLabelTd">Up Time:</td>
            <td id="cl_upTime" class="clusterValueLabelTd valueTd"></td>
        </tr>

        <tr >
            <td colspan="4">
                <div class="alert" style="margin-top: 10px; display: none;" id="migrationWarningRow">
                    <span style="color:red; font-weight: bold;">Ongoing Migration On Cluster</span><br/>
                    There are <span id="cl_scheduledTasksCount"></span> scheduled, <strong><span
                        id="cl_immediateTasksCount"></span> immediate</strong> migration tasks.
                </div>
            </td>
        </tr>
    </table>

    <div style="padding: 20px;  font-weight: bold;">Members &amp; Partitions</div>

    <div id="partitionspiechart" class="chartDiv" align="center"><img src="images/loader.gif" class="loaderImage"/>
    </div>

    <table style="visibility: hidden;">
        <tr>
            <td>bulk bulk</td>
            <td>bulk bulk</td>
            <td>bulk bulkbulk bulkbulk bulkbulk bulk</td>
            <td>bulk bulkbulk bulkbulk bulkbulk bulk</td>
            <td>bulk bulkbulk bulkbulk bulkbulk bulk</td>
        </tr>
    </table>
</div>