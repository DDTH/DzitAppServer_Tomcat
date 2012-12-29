<!DOCTYPE html>
<html>
<head>

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js">
    </script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.17/jquery-ui.min.js">
    </script>

    <!--[if lte IE 8]>
    <script language="javascript" type="text/javascript" src="js/excanvas.min.js"></script><![endif]-->

    <link rel="stylesheet" type="text/css" href="css/custom-theme/jquery-ui-1.8.17.custom.css"/>

    <link rel="stylesheet" href="http://yandex.st/highlightjs/6.1/styles/default.min.css">

    <script src="http://yandex.st/highlightjs/6.1/highlight.min.js" type="text/javascript"></script>
    <script src="js/jquery.dateFormat-1.0.js" type="text/javascript"></script>
    <script src="js/jquery.cookie.js" type="text/javascript"></script>

    <style type="text/css">

        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            background-color: #F2F2F2;
            font-family: Arial, sans-serif;
            line-height: 30px;
        }

        .ui-widget-content {
            color: #444;
            font-size: 14px;
            font-family: Arial, sans-serif;
        }

        .title {
            color: #d52;
            font-weight: bold;
        }

        h3 {
            font-size: 24px;
        }

        h2 {
            font-size: 22px;
            color: #d52;
        }

        .bannerTd {
            background-image: url("images/banner_bg.png");
            padding-left: 10px;
            height: 40px;
        }

        .itemDiv {
            padding: 1px;
        }
        .innerItemDiv {
            padding: -1px;
            padding-left: 20px;
        }


    </style>

</head>

<body style="padding: 0px; margin: 0px; overflow-x: hidden; overflow-y: scroll; height: 100%; ">


<table style="padding: 0px; margin: 0px; width:100%; height:100%; " cellpadding="0" cellspacing="0">

    <tr>
        <td colspan="2" class="bannerTd">
            <img src="images/logo.png" alt="hazelcast logo"/>
        </td>
    </tr>
    <tr>
        <td style="height: 100%; padding: 20px; ">
            <div class="ui-widget-content ui-corner-all"
                 style="width: 100%; height: 100%; padding: 20px; background-color: white;">
                <h3>Hazelcast Management Center</h3>
                <span class="title">Version:</span> 2.0.0


                <h3>Table of Contents</h3>


                <div class="itemDiv"><span class="title">1.0</span>&nbsp; &nbsp; Introduction</div>
                <div class="innerItemDiv"><span class="title">1.1</span>&nbsp; &nbsp; Installation</div>
                <div class="innerItemDiv"><span class="title">1.2</span>&nbsp; &nbsp; User Administration</div>
                <div class="innerItemDiv"><span class="title">1.3</span>&nbsp; &nbsp; Tool Overview</div>
                <div class="itemDiv"><span class="title">2.0</span>&nbsp; &nbsp; Maps</div>
                <div class="innerItemDiv"><span class="title">2.1</span>&nbsp; &nbsp; Monitoring</div>
                <div class="innerItemDiv"><span class="title">2.2</span>&nbsp; &nbsp; Map Browser</div>
                <div class="innerItemDiv"><span class="title">2.3</span>&nbsp; &nbsp; Map Configuration</div>

                <div class="itemDiv"><span class="title">3.0</span>&nbsp; &nbsp; Queues</div>
                <div class="itemDiv"><span class="title">4.0</span>&nbsp; &nbsp; Topics</div>

                <div class="itemDiv"><span class="title">5.0</span>&nbsp; &nbsp; Members</div>
                <div class="innerItemDiv"><span class="title">5.1</span>&nbsp; &nbsp; Monitoring</div>
                <div class="innerItemDiv"><span class="title">5.2</span>&nbsp; &nbsp; Operations</div>

                <div class="itemDiv"><span class="title">6.0</span>&nbsp; &nbsp; Scripting</div>
                <div class="itemDiv"><span class="title">7.0</span>&nbsp; &nbsp; Time Travel</div>
                <div class="itemDiv"><span class="title">8.0</span>&nbsp; &nbsp; Console</div>
                <div class="itemDiv"><span class="title">9.0</span>&nbsp; &nbsp; Help & Support</div>

                <br/>
                <div>
                    <h2>1. Introduction</h2>
                    Hazelcast Management Center is the tool that enables you to monitor your servers running hazelcast.
                    With Management Center besides observing overall state of your clusters, you can also analyse and browse your data structures in details.
                    It has capabilities that you can configure your cluster on runtime, such as configuring your map properties, taking thread dump from nodes.
                    With its scripting module you can run actions on your servers with javascript.
                    Version 2.0 is a web based tool so you can deploy it into your internal server and serve your users.
                </div>

                <br/>
                <div>
                    <h2>1.1 Installation</h2>
                    <ul>
                        <li>Download latest hazelcast from <a href="http://www.hazelcast.com/downloads.jsp" >here.</a></li>
                        <li>Deploy the webmancenter.war file bundled in the to your webserver (Tomcat, Jetty etc.)</li>
                        <li>Start your web server.</li>
                        <li>Configure your hazelcast by adding following to your hazelcast.xml
                            <textarea rows="3" cols="90">&lt;management-center enabled="true" &gt;YOUR_URL&lt;/management-center&gt;</textarea>
                        </li>
                        <li>Start your hazelcast cluster</li>
                        <li>Browse your web servers url. <b>Initial login credentials are: username:admin password:admin </b></li>
                    </ul>
                </div>

                <br/>
                <div>
                    <h2>1.2 User Administration</h2>
                    Default credentials are for admin users.
                    Admin users can make user operations and has read/write access to all clusters.
                    In the "Administration" tab page you can add new users, update/remove existing ones..
                    If you want to restrict users to only read only operations then check the "Read Only" radio button for the clusters.

                    <br/><a href="images/help/admin.jpg" style="border: none;" >
                        <img src="images/help/admin.jpg" style="width: 800px;" alt="user administration" />
                    </a>
                </div>

                <br/>
                <div>
                    <h2>1.3 Tool Overview</h2>
                    The starter page of the tool is "Cluster Home". Here you can see cluster's main properties such as uptime, memory.
                    Also with pie chart you can see the distribution of partitions over cluster members.
                    You can come back to this page, by clicking the Home icon on the right top toolbar.
                    <br/>
                    On the left panel you see the instances Maps, Queues, Topics; stored in the cluster.
                    Below them, the members in the clusters are listed.
                    <br/>
                    On top menu bar, you can change the current page to Scripting, Docs, User Administration.
                    Note that User Administration page is viewable only for admin users.
                    Also Scripting page is disabled for users with read only credential for current cluster.
                    <br/><a href="images/help/clusterhome.jpg" style="border: none;" >
                        <img src="images/help/clusterhome.jpg" style="width: 800px;" alt="cluster home" />
                    </a>
                </div>

                <br/>
                <div>
                    <h2>2.0 Maps</h2>
                    In the left menu you can see the list of map instances.
                    Clicking on them, a new tab for monitoring this map instance is opened.
                    In this tab you can monitor metrics also re-configure the map.
                    <br/><a href="images/help/maphome.jpg" style="border: none;" >
                        <img src="images/help/maphome.jpg" style="width: 800px;" alt="map home" />
                    </a>
                </div>

                <div>
                    <h2>2.1 Monitoring Maps</h2>
                    In map page you can monitor instance metrics by 2 charts and 2 datatables.
                    First data table "Memory Data Table" gives the memory metrics distributed over members.
                    "Throughput Data Table" gives information about the operations performed on instance (get, put, remove)
                    <br/>
                    Each chart monitors a type data of the instance on cluster.
                    You can change the type by clicking on chart. The possible ones are: Size, Throughput, Memory, Backup Size, Backup Memory, Hits, Locked Entries, Puts, Gets, Removes.
                    <br/><a href="images/help/mapchart.jpg" style="border: none;" >
                    <img src="images/help/mapchart.jpg" style="width: 800px;" alt="map chart" />
                </a>
                </div>

                <div>
                    <h2>2.2 Map Browser</h2>
                    You can open "Map Browser" tool by clicking "Browse" button on map tab page.
                    Using map browser you can reach map's entries by keys. Besides its value, extra informations such as entry's cost, expiration time is provided.
                    <br/><a href="images/help/mapbrowse.jpg" style="border: none;" >
                    <img src="images/help/mapbrowse.jpg" style="width: 800px;" alt="map browser" />
                </a>
                </div>


                <div>
                    <h2>2.3 Map Configuration</h2>
                    You can open "Map Configuration" tool by clicking "Config" button on map tab page.
                    This button is disabled for users with Read Only permisson for current cluster.
                    Using map config tool you can adjust map's setting. You can change backup count, max size, max idle(seconds), eviction policy, cache value, read backup data, backup count of the current map instance.
                    For more information about these settings you may refer <a href="http://www.hazelcast.com/docs/2.0/manual/single_html/#Map" target="_blank">here.</a>
                    <br/><a href="images/help/mapbrowse.jpg" style="border: none;" >
                    <img src="images/help/mapbrowse.jpg" style="width: 800px;" alt="map browser" />
                </a>
                </div>


                <div>
                    <h2>3 Queues</h2>
                    Queues is the second data structure that you can monitor in management center.
                    You can activate the Queue Tab by clicking the instance name listed on the left panel under queues part.
                    The queue page consists of the charts monitoring data about the queue.
                    You can change the data to be monitored by clicking on the chart. Available options are Size, Polls, Offers.
                    <br/><a href="images/help/queue.jpg" style="border: none;" >
                    <img src="images/help/queue.jpg" style="width: 800px;" alt="queue" />
                </a>
                </div>


                <div>
                    <h2>4 Topics</h2>
                    You can monitor your topics' metrics by clicking the topic name listed on the left panel under topics part.
                    There are two charts which reflects live data, and a datatable lists the live data distributed among members.
                    <br/><a href="images/help/topic.jpg" style="border: none;" >
                    <img src="images/help/topic.jpg" style="width: 800px;" alt="topic" />
                </a>
                </div>


                <div>
                    <h2>5.0 Members</h2>
                    The current members in the cluster are listed on the bottom side of the left panel.
                    You can monitor each member on tab page displayed by clicking on member items.
                    <br/><a href="images/help/member.jpg" style="border: none;" >
                    <img src="images/help/member.jpg" style="width: 800px;" alt="member" />
                </a>
                </div>

                <div>
                    <h2>5.1 Monitoring</h2>
                    In members page there are 4 inner tab pages to monitor meber's state and properties.
                    <br/>
                    Runtime: Runtime properties about memory, threads are given. This data updates dynamically.
                    <br/>
                    Properties: System properties are displayed.
                    <br/>
                    Configuration: Configuration xml initially set can be viewed here.
                    <br/>
                    Partitions: The partitions belongs to this member are listed.
                    <br/>
                    <br/><a href="images/help/memberconf.jpg" style="border: none;" >
                    <img src="images/help/memberconf.jpg" style="width: 800px;" alt="member" />
                </a>
                </div>


                <div>
                    <h2>5.2 Operations</h2>
                    Besides monitoring you can perform certain actions on members.
                    You can
                    <br/>
                    <br/><a href="images/help/memberconf.jpg" style="border: none;" >
                    <img src="images/help/memberconf.jpg" style="width: 800px;" alt="member" />
                </a>
                </div>




            </div>
        </td>
        <td style="width: 350px;"></td>
    </tr>


</table>

</body>
</html>