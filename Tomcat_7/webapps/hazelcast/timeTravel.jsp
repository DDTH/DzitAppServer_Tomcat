<div id="timeTravelDiv"
     style="z-index:10; position: absolute; top:0px; left: 240px;
     padding-left: 10px; padding-top: 10px; width: 100%; height:54px; background-color: #e6e6fa;">

    <table cellpadding="0" cellspacing="0" align="left">

        <tr>
            <td colspan="1" style="padding-bottom: 5px;">
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <button id="backbutton" style="height: 25px; width: 30px;" onclick="backTime()">Back
                            </button>
                        </td>
                        <td>
                            <div id="slider" style="width: 500px;"></div>
                        </td>
                        <td>
                            <button id="forwardbutton" style="height: 25px; width: 30px;" onclick="forwardTime()">
                                Forward
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="text-align: center;">
                            <img src="images/timeruler.png"/>
                        </td>
                    </tr>
                </table>

            </td>
            <td style="padding-left: 10px;">
                <table cellpadding="0" cellspacing="0" align="center">
                    <tr>
                        <td>
                            <div id="timeLabel"
                                 style="width: 100%; text-align: center; font-weight: bold; font-size: 12pt; float: left;"></div>
                        </td>
                        <td style="padding-left: 10px; vertical-align: middle; cursor: pointer;">
                            <input type="hidden" id="datepicker"/>
                        </td>
                        <td style="padding-left: 10px; vertical-align: middle;">
                            <img src="images/cancel.png" onclick="disableTimeTravelConfirm()" style=" width: 18px; height: 18px; cursor: pointer;" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>
