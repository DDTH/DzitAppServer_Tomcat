<!DOCTYPE html>
<html>
<head>
    <title>Hazelcast Management Center (BETA)</title>

    <%@ include file="head.jsp" %>
</head>

<body style="padding: 0px; margin: 0px; overflow-x: hidden; overflow-y: scroll; height: 100%; ">

<div id="loadingDiv"
     style="background-color: #d3d3d3; position: absolute; top: 0px; left: 50%; padding: 5px; font-family: Arial, sans-serif; font-weight: bold;">
    Loading...
</div>

<%@ include file="timeTravel.jsp" %>


<table style="padding: 0px; margin: 0px; width:100%; height:100%; " cellpadding="0" cellspacing="0">

    <tr>
        <td colspan="2" class="bannerTd">
            <%@ include file="banner.jsp" %>
        </td>
    </tr>
    <tr class="sectionTable sectionDocs">
        <td colspan="2" id="docsTd" style="vertical-align: top;">
            &nbsp;
        </td>
    </tr>


    <%@ include file="scripting.jsp" %>

    <%@ include file="logs.jsp" %>

    <%@ include file="health.jsp" %>

    <%@ include file="alert.jsp" %>

    <%@ include file="admin.jsp" %>

    <%@ include file="home.jsp" %>

</table>

<%@ include file="map.jsp" %>

<%@ include file="multimap.jsp" %>

<%@ include file="queue.jsp" %>

<%@ include file="topic.jsp" %>

<%@ include file="cluster.jsp" %>

<%@ include file="member.jsp" %>

<%@ include file="chartOpts.jsp" %>

<%@ include file="threadDump.jsp" %>

<%@ include file="mapConfig.jsp" %>

<%@ include file="console.jsp" %>

<%@ include file="mapBrowser.jsp" %>

<%@ include file="login.jsp" %>

<%@ include file="confirm.jsp" %>

<%@ include file="executor.jsp" %>


</body>
</html>