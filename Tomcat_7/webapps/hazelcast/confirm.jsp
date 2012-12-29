

<div id="deleteUserConfirm" title="Delete User?">
    <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>The user will be deleted and
        cannot be recovered. Are you sure?</p>
</div>

<div id="gcResultDialog" class="resultDialog" title="Garbage Collection">
    <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Garbage collection
        succesful.</p>
</div>

<div id="logLevelResultDialog" class="resultDialog"  title="Log Level Configured">
    <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Log level configured
        succesfully. Press "Refresh" to reload logs.</p>
</div>


<div id="logLevelWarningDialog" class="resultDialog"  title="Log Level is None">
    <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
    Your current log level is 'None'. For latest logs, set it to higher level.
    </p>
</div>

<div id="versionMismatchDialog" class="resultDialog"  title="Warning: Version Mismatch">
    <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        Version of the current management center is <span class="versionText"></span>.<br>
        Version of the hazelcast nodes should be: <span class="versionText"></span>.X
    </p>
</div>

<div id="readOnlyError" class="resultDialog"  title="Read Only Mode">
    <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        This module is not available in read-only mode.
    </p>
</div>

<div id="enableTimeTravelDialog" class="resultDialog"  title="Enable Time Travel">
    <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        By default, time travel module is not enabled. <br/> If you enable, the cluster states will be persisted to the disk while Management center is running.
    </p>
</div>

<div id="enableTimeTravelDialogForAlerts" style="margin:0px auto;" class="resultDialog"  title="Enable Time Travel">
    <p style="margin:50px 100px">
        <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        You should enable write mode to see the alert list.<br><br>
        <button onclick='enableTimeTravelForAlertsAction()' id='alertTimeTravelButton' >Enable Write Mode</button>
    </p>
</div>

<div id="disableTimeTravelDialog" class="resultDialog"  title="Disable Time Travel">
    <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        Time Travel module will be disabled. Cluster states will not be persisted to disk and you can not reach past data. Do you confirm?
    </p>
</div>

<div id="writeErrorDialog" class="resultDialog" title="Error: Directory Write Problem" >
    <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 60px 0;"></span>
        There is a problem on writing to the directory <span id="dataDirectory" style="font-weight: bold;"></span>.
        <br/>
        Either make it writable or change the data directory setting "hazelcast.mancenter.home" system property.
        <br/>
        Or you can continue in read-only mode in that case license and login credentials can not be saved/remembered and time-travel module will not be available.
    </p>
</div>

    <div id="logDetailDialog" style="width: 600px;" title="Log Detail" class="resultDialog"  >
        <p>Log Details</p>
    </div>


    <div id='alertMessage' class="resultDialog" title="Alert Message Details">

    </div>
    <div id="saveFilterDialog" class="resultDialog" title="Filter already exist"  >
         <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 60px 0;"></span>
           A filter with the given name already exist!
            <br/>
            Dou you want to overwrite existing filter with new settings ?
            <br/>
        </p>
    </div>

    <div id="deleteFilterDialog" class="resultDialog" title="Delete Filter"  >
         <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 60px 0;"></span>
           Are you sure you want to delete this filter permanently ?   <br>
           This will also delete old persisted alerts.
        </p>
    </div>

    <div id="saveFilterNoTaskDialog" class="resultDialog" title="No filter task!"  >
         <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 60px 0;"></span>
            Settings about what action should this filter take seems to be empty. <br>
            Do you want to save this filter anyway?
        </p>
    </div>

    <div id="saveFilterNoNameDialog" class="resultDialog" title="No filter task!"  >
         <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 60px 0;"></span>
            Please set a filter name <br>
        </p>
    </div>

    <div id="alertPopupDialog" title="New Alerts" style="z-index:2;display:none;height:100px;overflow-x:hidden;overflow-y:scroll;" class="triangle-right top" >
        <a style="float:left;font-size:16px;">NEW ALERT!</a><button style="float:right;height:20px;width:20px;" class="ui-icon ui-icon-close" onclick=" $('#alertPopupDialog').hide() "></button>
        <br>
        <a id="alertPopup" style="width:300px;height:100px;" > </a>
    </div>