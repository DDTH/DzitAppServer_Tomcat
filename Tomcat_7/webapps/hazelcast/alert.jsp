<tr class="sectionTable sectionAlert">
    <td class="leftPanel resizable">

        <div class="accordion" id="alertListAccordion">
            <h3><a href="#">Filter List</a></h3>

            <div style="height: 300px;">
                <table id="filterListDiv">

                </table>
            </div>
        </div>

    </td>
    <td style=" vertical-align: top; ">

        <div >
            <div id="alertHistoryGridAccordion" class="accordion" style="display:none;">
                <h3 ><a href="#" id="filterNameHeader"></a></h3>
                <div id="alertHistoryGrid" >

                </div>
            </div>

            <div style="float:left" id="clearFilterHistoryButtonHolder"></div>
            <div style="float:left">
                <button onclick="getAlertHistoryAction()" id="refreshHistoryButton" style="display:none;" class="button">Reload</button>
            </div>
            <div class="accordion" id="alertTypes" style="display:none;">
                   <h3><a href="#">Create Filter </a></h3>
                   <div style="height: 300px;">
                       <h3>To create an automated alert , choose what you want to check. </h3>
                       <div>
                            <input type="radio" name="alertTypesRadio" class="button"  onclick="fillAlertFiltersAction('clusterFilter')"   id='clusterFilterButton' ><label style='width:130px;' for="clusterFilterButton">Cluster Alerts</label>

                            <a>General alerts on the health of your cluster.</a>
                       </div>
                       <br>
                       <div>
                            <input type="radio" name="alertTypesRadio" class="button" onclick="fillAlertFiltersAction('memberFilter')"    id='memberFilterButton' ><label style='width:130px;' for="memberFilterButton">Member Alerts</label>

                            <a>Alerts about memory and thread count of your members.</a>
                       </div>
                       <br>
                       <div>
                            <input type="radio" name="alertTypesRadio" class="button" onclick="fillAlertFiltersAction('dataTypeFilter')"  id='dataTypeFilterButton' ><label style='width:130px;' for="dataTypeFilterButton">Data Type Alerts</label>

                            <a>Alerts for data types (map, queue, multimap, executor).</a>
                       </div>
                    </div>
            </div>

            <div id="alertFilters" style="width:100%;display:none;">

                <div id="clusterFilterAccordion" class="accordion "style="display:none;">
                    <h3><a href="#">Cluster Filter</a></h3>
                    <div>
                        <h3>Choose alert items</h3>
                        <input type="checkbox" name="clusterFilter" id="clusterMembers"  /><label for="clusterMembers">Members</a><br>
                        <input type="checkbox" name="clusterFilter" id="clusterConnections" /><label for="clusterConnections">Connections</a><br>
                        <input type="checkbox" name="clusterFilter" id="clusterLocks"  /><label for="clusterLocks">Locks</a><br>
                        <input type="checkbox" name="clusterFilter" id="clusterMigration"  /><label for="clusterMigration">Migration</a><br>
                        <input type="checkbox" name="clusterFilter" id="clusterPartitions"  /><label for="clusterPartitions">Partitions</a><br>
                    </div>
                </div>

                <div id="memberFilterAccordion" class="accordion" style="display:none;">
                    <h3><a href="#">Member Filter</a></h3>
                    <div id="memberFilter">


                    </div>

                </div>
                <div id="memberSpecificAccordion" class="accordion" style="display:none;" >
                     <h3><a href="#">Alert Criteria</a></h3>
                     <div id="memberSpecific">
                         <table>
                             <tbody>
                                 <tr><td><input type="checkbox" name="memberDetails" id="checkbox_freeMemory" onclick="$('#member_freeMemory').attr('disabled' ,!$(this).is(':checked') )"/><a>Free Memory is less than </a></td><td><input type="text" id="member_freeMemory" disabled="disabled" /> MB</td></tr>
                                 <tr><td><input type="checkbox" name="memberDetails" id="checkbox_usedMemory" onclick="$('#member_usedMemory').attr('disabled' ,!$(this).is(':checked')  )"/><a>Used Heap Memory is larger than </a></td><td><input type="text" id="member_usedMemory" disabled="disabled" /> MB</td></tr>
                                 <tr><td><input type="checkbox" name="memberDetails" id="checkbox_activeThreads" onclick="$('#member_activeThreads').attr('disabled' ,!$(this).is(':checked') )"/><a># of Active Threads are less than </a></td><td><input type="text" id="member_activeThreads" disabled="disabled" /></td></tr>
                                 <tr><td><input type="checkbox" name="memberDetails" id="checkbox_daemonThreads" onclick="$('#member_daemonThreads').attr('disabled' ,!$(this).is(':checked') )"/><a># of Daemon Threads are larger than </a></td><td><input type="text" id="member_daemonThreads" disabled="disabled" /</td></tr>
                            </tbody>
                         </table>
                     </div>
                </div>
                <div id="dataTypeFilterAccordion" class="accordion" style="display:none;">

                    <h3><a href="#">Which data type dou you want to see on alert ?</a></h3>
                    <div id="dataTypeFilter">
                        <input type="radio" name="dataTypeFilterRadio" class="dataTypeFilterRadio" onclick="fillDataTypeAction('map')"  id="dataType_map"  ><label for="dataType_map">Maps</label>
                        <input type="radio" name="dataTypeFilterRadio" class="dataTypeFilterRadio" onclick="fillDataTypeAction('queue')" id="dataType_queue"  ><label for="dataType_queue">Queues</label>
                        <!--- <input type="radio" name="dataTypeFilterRadio" class="dataTypeFilterRadio" onclick="fillDataTypeAction('topic')" id="dataType_topic"  ><label for="dataType_topic">Topics</label>---->
                        <input type="radio" name="dataTypeFilterRadio" class="dataTypeFilterRadio" onclick="fillDataTypeAction('multimap')" id="dataType_multimap"  ><label for="dataType_multimap">Multimaps</label>
                        <input type="radio" name="dataTypeFilterRadio" class="dataTypeFilterRadio" onclick="fillDataTypeAction('executor')" id="dataType_executor"  ><label for="dataType_executor">Executors</label>
                    </div>
                </div>
                <div id="dataTypeSpecific" style="display:none;">

                    <div id = "nameFilterAccordion" class="accordion">
                        <h3><a href="#">Name Filter</a></h3>
                        <div id="nameFilter">
                            <h3>The names of the <a id="dataType" ></a>s that you want to check </h3>
                            <div id="nameFilterList">

                            </div>
                            <button onclick="createFilter()" class='button' id='cancelFilterButton' style='float:left;' >Cancel</button>
                            <button onclick="dataNameIsChosen()" id="dataNameChooseButton"  style='float:left;' class="button">Next</button>
                        </div>
                    </div>

                    <div id="memberFilterForDataTypeAccordion" class="accordion" style="display:none;">
                        <h3><a href="#">Members</a></h3>
                        <div id="memberFilterForDataType">

                        </div>
                    </div>
                    <div id="generalAlertFilterAccordion" class="accordion" style="display:none;">
                        <h3><a href="#">Data Type Settings</a></h3>
                        <div id="generalAlertFilter">
                            <h3>You will be alerted, when : </h3>
                            <table id="dataTypeFilterTable">
                                <tbody>
                                    <tr>
                                        <td>
                                             <select id="dataTypeKey" style="width:200px;">
                                               <option value="numEntries" selected="selected"># of Entries</option>
                                               <option value="entryMemory" >Entry Memory(MB)</option>
                                               <option value="numBackupEntries"># of Backup Entries</option>
                                               <option value="backupMemory">Backup Memory(MB)</option>
                                               <option value="dirtyEntries"># of Dirty Entries</option>
                                               <option value="markedAsRemove">Marked As Remove</option>
                                               <option value="markedAsRemoveMemory">Marked As Remove Memory(MB)</option>
                                               <option value="locks"># of Locks</option>
                                               <option value="numGets"># of Gets</option>
                                               <option value="avgGetLatency">Average Get Latency</option>
                                               <option value="numPuts"># of Puts</option>
                                               <option value="avgPutLatency">Average Put Latency</option>
                                               <option value="numRemoves"># of Removes</option>
                                               <option value="avgRemoveLatency">Average Remove Latency</option>
                                               <option value="numEvents"># of Events</option>
                                             </select>
                                        </td>
                                        <td>
                                             <select id="dataTypeOperation"  style="width:50px;">
                                                <option value="greater" selected="selected" >&gt;</option>
                                                <option value="equal">=</option>
                                                <option value="less">&lt;</option>
                                             </select>
                                        </td>
                                        <td>
                                             <input type id="dataTypeValue" style="width:50px;">
                                         </td>
                                         <td>
                                            <button onclick="addDataTypeFilter('dataType')" class="button">Add</button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div id="executorAlertFilterAccordion" class="accordion" style="display:none;">
                        <h3><a href="#">Data Type Settings</a></h3>
                        <div id="executorAlertFilter">
                            <h3>You will be alerted, when : </h3>
                            <table id="executorFilterTable">
                                <tbody>
                                    <tr>
                                        <td>
                                            <select id="executorKey" style="width:300px;">
                                                <option value="numPendingExecuted" selected="selected"># of Pending Tasks(Executed By Node)</option>
                                                <option value="numStartedExecuted" ># of Started Tasks(Executed By Node)</option>
                                                <option value="avgLatencyExecuted">Average Latency(Executed By Node)</option>
                                                <option value="numCompletedExecuted">Number of Completed(Executed By Node)</option>
                                                <option value="avgCompletionExecuted">Average Completion(Executed By Node)</option>
                                                <option value="minCompletionExecuted">Minimum Completion(Executed By Node)</option>
                                                <option value="maxCompletionExecuted">Maximum Completion(Executed By Node)</option>

                                                <option value="numStartedSubmitted" ># of Started Tasks(Submitted By Node)</option>
                                                <option value="numCompletedSubmitted">Number of Completed Tasks(Submitted By Node)</option>
                                                <option value="avgCompletionSubmitted">Average Completion(Submitted By Node)</option>
                                                <option value="minCompletionSubmitted">Minimum Completion(Submitted By Node)</option>
                                                <option value="maxCompletionSubmitted">Maximum Completion(Submitted By Node)</option>
                                            </select>
                                        </td>
                                        <td>
                                            <select id="executorOperation"  style="width:50px;">
                                                <option value="greater" selected="selected" >&gt;</option>
                                                <option value="equal">=</option>
                                                <option value="less">&lt;</option>
                                            </select>
                                        </td>
                                        <td>
                                             <input type id="executorValue" style="width:40px;">
                                        </td>
                                        <td>
                                            <button onclick="addDataTypeFilter('executor')" class="button">Add</button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <button onclick="createFilter()" class='button'  style="display:none;float:left;" id='cancelFilterButtonC' >Cancel</button>
                <button onclick="nextAction()"  id='nextButton' style="display:none;float:left;" class='button'>Next</button>

            </div>
            <div id="alertActions" style="width:100%; display:none;">
                <div class="accordion" id="alertPeriodAccordion">
                    <h3><a href="#">Alert Check Frequency</a></h3>

                    <div>
                        <br>
                        <select id="periodHour">
                           <option value="0" selected="selected">0</option>
                           <option value="1">1</option>
                           <option value="6">6</option>
                           <option value="12">12</option>
                           <option value="24">24</option>
                       </select>
                       <label for="periodHour">hour</label>
                        <select id="periodMin">
                           <option value="1">1</option>
                           <option value="5" selected="selected">5</option>
                           <option value="10">10</option>
                           <option value="30">30</option>
                       </select>
                       <label for="periodMin">min</label>
                       <br><br>
                    </div>
                </div>
                <div class="accordion" id="alertActionsAccordion">
                    <h3><a href="#">Alert Actions</a></h3>
                    <div>
                        <a>Filter Name: </a><input type="text" id="filterName"/>
                        <br> <br>
                        <a>Send Email To</a>
                        <br>
                        <input type='radio' class='groupRadio1 groupChecked' checked='checked'  name='email' value='1email' id='0email' /><label for='0email'> No One </label> &nbsp;&nbsp;
                            <input type='radio' class='groupRadio1' name='email' value='1email' id='1email' /> <label for='1email'> Admin Only </label> &nbsp;&nbsp;
                            <input type='radio' class='groupRadio1'  name='email' value='2email' id='2email' /> <label for='2email'> All </label>
                        <br> <br>
                        <a>Persist data on disk </a><input type="checkbox" id="persist"/>
                        <br> <br>
                        <button onclick="createFilter()" class='button' style="float:left;" >Cancel</button>
                        <button onclick="saveFilterCheckName()"  id='saveFilterButton' style='float:left;' class='button'>Save</button>
                    </div>
            </div>
         </div>
    </td>
</tr>
