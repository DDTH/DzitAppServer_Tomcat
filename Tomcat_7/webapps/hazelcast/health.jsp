<tr class="sectionTable sectionHealth">
    <td colspan="2" style="vertical-align: top; ">

        <table align="left" class="healthTable" cellpadding="0" cellspacing="0">
            <tr>
                <td colspan="2" style="padding-left: 20px; font-size: 14pt; font-weight: bold; vertical-align: middle; ">
                    <img src="images/doctor.png" align="middle" /> Health Check
                    <button style="margin-left: 100px;" onclick="healthCheckInit(); healthCheckAction()" id="healthCheckButton">
                        Check Cluster Health
                    </button>
                </td>
            </tr>
            <tr>
                <td class="healthLabel">Members:</td>
                <td id="memberCheck" class="healthMessage"> <em> Press 'Check Cluster Health' button to check/detect problems on your cluster.</em> </td>
            </tr>
            <tr>
                <td class="healthLabel bgGray">Connections:</td>
                <td id="connectionCheck" class="healthMessage bgGray"> </td>
            </tr>
            <tr>
                <td class="healthLabel">Locks: </td>
                <td id="locksCheck" class="healthMessage">  </td>
            </tr>
            <tr>
                <td class="healthLabel bgGray">Migration:</td>
                <td id="migrationCheck" class="healthMessage bgGray">  </td>
            </tr>
            <tr>
                <td class="healthLabel">Partitions: </td>
                <td id="partitionCheck" class="healthMessage">  </td>
            </tr>
        </table>

    </td>
</tr>
