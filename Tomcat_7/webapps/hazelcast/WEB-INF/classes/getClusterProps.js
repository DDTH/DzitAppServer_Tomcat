importPackage(java.lang);
importPackage(java.util);
importPackage(java.lang.management);

var runtime = Runtime.getRuntime();
var runtimeMxBean = ManagementFactory.getRuntimeMXBean();

function getClusterProps() {
	var props = new Properties();
	var hzProps = hazelcast.getClass().getClassLoader().getResourceAsStream('hazelcast-runtime.properties');
    var pmanager = hazelcast.node.concurrentMapManager.partitionManager;
	if(hzProps != null) {
		props.load(hzProps);
		hzProps.close();
	}
	else {
		props.put('hazelcast.cl_version', '---');
		props.put('hazelcast.cl_build', '---');
	}
	
	props.put('date.cl_startTime', runtimeMxBean.getStartTime());
	props.put('seconds.cl_upTime', runtimeMxBean.getUptime());
	props.put('memory.cl_freeMemory', runtime.freeMemory());
	props.put('memory.cl_totalMemory', runtime.totalMemory());
    props.put('memory.cl_maxMemory', runtime.maxMemory());
    props.put('data.cl_immediateTasksCount', pmanager.immediateTasksCount);
    props.put('data.cl_scheduledTasksCount', pmanager.scheduledTasksCount);

	return props;
}

getClusterProps();
