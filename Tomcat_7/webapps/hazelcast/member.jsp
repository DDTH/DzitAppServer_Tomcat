
<div id="memberContentTemplate" style="display: none; ">

    <div align="right">
        <button id="threadDumpButton" class="writeModeButton">Thread Dump</button>
        <button id="runGCButton" class="writeModeButton">Run GC</button>
    </div>

    <div id="memberTabs">
        <ul>
            <li><a href="#mtabs-1">Runtime</a></li>
            <li><a href="#mtabs-2">Properties</a></li>
            <li><a href="#mtabs-3">Configuration</a></li>
            <li><a href="#mtabs-4">Partitions</a></li>
        </ul>
        <div id="mtabs-1">
            <table id="memberRuntime">
                <tr>
                    <td class="infoLabel">Number of Processors:</td>
                    <td id="availableProcessors" class="valueTd"><img src="images/loader.gif"/></td>
                </tr>
                <tr>
                    <td class="infoLabel">Start Time:</td>
                    <td id="startTime" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Up Time:</td>
                    <td id="upTime" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Maximum Memory:</td>
                    <td id="maxMemory" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Total Memory:</td>
                    <td id="totalMemory" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Free Memory:</td>
                    <td id="freeMemory" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Used Heap Memory:</td>
                    <td id="heapMemoryUsed" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Max Heap Memory:</td>
                    <td id="heapMemoryMax" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Used Non-Heap Memory:</td>
                    <td id="nonHeapMemoryUsed" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Max Non-Heap Memory:</td>
                    <td id="nonHeapMemoryMax" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Total Loaded Classes:</td>
                    <td id="totalLoadedClassCount" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Current Loaded Classes:</td>
                    <td id="loadedClassCount" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Total Unloaded Classes:</td>
                    <td id="unloadedClassCount" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Total Thread Count:</td>
                    <td id="totalStartedThreadCount" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Active Thread Count:</td>
                    <td id="threadCount" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Peak Thread Count:</td>
                    <td id="peakThreadCount" class="valueTd"></td>
                </tr>
                <tr>
                    <td class="infoLabel">Daemon Thread Count:</td>
                    <td id="daemonThreadCount" class="valueTd"></td>
                </tr>
            </table>
        </div>
        <div id="mtabs-2">
            <table id="memberProps" style="width: 400px;">

            </table>

        </div>
        <div id="mtabs-3">
            <div id="memberConfig">

            </div>
        </div>
        <div id="mtabs-4">
            <div id="memberPartitions" style="height: 600px;">
            </div>
        </div>
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
