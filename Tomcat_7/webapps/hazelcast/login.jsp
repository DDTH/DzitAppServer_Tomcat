<div id="login_dialog" title="Login to Cluster">
    <div id="loginDiv" style="margin: 10px;">
        <table>
            <tr>
                <td>Username:</td>
                <td><input type="text" id="login_username"/></td>
            </tr>
            <tr>
                <td>Password:</td>
                <td><input type="password" id="login_password" class="onEnterSubmit"/></td>
            </tr>
            <tr>
                <td colspan="2" style="padding: 5px; vertical-align: middle;"><input type="checkbox"
                                                                                     class="onEnterSubmit"
                                                                                     id="login_remember"/><label
                        for="login_remember" style="font-size: 10pt;">Remember me?</label></td>
            </tr>
            <tr>
                <td colspan="2" style="color: red;" id="loginFailTd"></td>
            </tr>
            <tr>
                <td colspan="2">Management Center Version <a class="versionText"></a></td>
            </tr>
        </table>


    </div>
    <div id="clusterConnectDiv" class="loginDivs">
        <p class="validateTips">Select cluster to connect.</p>

        <form>
            <fieldset id="clusterList">
                <img src="images/loader.gif" class="loaderImage"/>
            </fieldset>
        </form>
        <div style="padding-top: 10px;" id="licenseInfo"></div>

        <div style="padding-top: 10px;" id="applyWarnDiv">For unlimited nodes, <a href="#"
                                                                                  onclick="applyLicenseAction()">apply
            for trial</a></div>
        <br>
        <div>
            <a>Management Center Version <a class="versionText"></a></a>
        </div>
    </div>

    <div id="licenseKeyDiv" class="loginDivs">
        <p class="validateTips">Please enter your license key:</p>

        <form>
            <label for="licenseKeyInput">License Key:</label><br/><input style="width: 220px;" type="text"
                                                                         id="licenseKeyInput"></input>
        </form>
        <div style="color: red; padding-top: 10px;" id="licenseSaveInfo"></div>
        <p class="validateTips"><a href="#" onclick="applyLicenseAction()">or apply for trial</a></p>
    </div>

    <div id="applyLicenseDiv" class="loginDivs">
        <form name="contactform" action="http://www.hazelcast.com/sendemail.jsp" method="post">
            <input type="hidden" name="subject" id="subject" value="TRIAL LICENSE">
            <table cellpadding="5" cellspacing="5">
                <tbody>
                <tr>
                    <td>Your Name (required):</td>
                    <td>
                        <input type="text" name="name" id="name"/>
                    </td>
                </tr>
                <tr>
                    <td>Your Email (required):</td>
                    <td><input type="text" name="email" id="email" value=""> <br/>(the license will be emailed)</td>
                </tr>
                <tr>
                    <td>Company Name (required):</td>
                    <td><input type="text" name="website" id="website" value=""></td>
                </tr>
                <tr>
                    <td valign="top">Message:</td>
                    <td>
                        <textarea name="message" id="message" rows="10" cols="30"></textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center;">
                        <button class="button">Submit</button>
                    </td>
                </tr>
                </tbody>
            </table>
            <input type="hidden" value="mancenter" name="product"/>

        </form>
    </div>

</div>



<div id="noDataDialog" title="No Cluster Data?">
    <div id="noDataDiv" >
        <p class="validateTips">No cluster data. Have you configured your Hazelcast cluster for web management
            center?</p>

        <p class="validateTips">You should add the following to your Hazelcast configuration.</p>

        <pre style='font-size: 8pt;'><code class='xml'>&lt;management-center enabled="true"&gt;<span class="yourUrlText">YOUR_MANCENTER_WEB_URL</span>&lt;/management-center&gt;</code></pre>

        <br/>
        or <a href="#" onclick="showChangeUrlScreen()">click here</a> to assign web url dynamically.
    </div>

</div>


<div id="connectClusterDialog" title="Connecting To Cluster">
    <div id="connectClusterDiv" >
        <p class="validateTips">Please wait</p>
        <img src="images/loader.gif" />
    </div>
</div>


<div id="changeUrlDialog" title="Change Server Url">
    <div id="changeUrlDiv" >
        <form>
            <label for="clusterNameInput">Cluster Name:</label><br/><input style="width: 220px;" type="text" id="clusterNameInput" value="dev" /><br/>
            <label for="clusterPasswordInput">Password:</label><br/><input style="width: 220px;" type="password" id="clusterPasswordInput" value="dev-pass" /><br/>
            <label for="memberIPInput">Member IP:</label><br/><input style="width: 220px;" type="text" id="memberIPInput" value="127.0.0.1" /><br/>
            <label for="memberPortInput">Member Port:</label><br/><input style="width: 100px;" type="text" id="memberPortInput" value="5701" /><br/>
            <label for="serverUrlInput">Server Url:</label><br/><input style="width: 220px;" type="text" id="serverUrlInput" class="yourUrlInput" /><br/>
        </form>
        <div id="changeUrlMessage" style="padding-top: 5px; color: red;"></div>
    </div>
</div>


<div id="licenseErrorDialog" title="Nodes Limit Exceeded">
    <div id="licenseErrorDiv">
        <p class="validateTips">In the developer mode, you can monitor maximum 2 nodes.</p>

        <p class="validateTips">Either shutdown your exceeding nodes or enter your license key.</p>
    </div>
</div>
