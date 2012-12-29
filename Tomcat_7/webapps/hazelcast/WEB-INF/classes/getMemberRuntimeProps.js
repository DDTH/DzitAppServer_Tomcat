importPackage(java.lang);
importPackage(java.util);
importPackage(java.lang.management);

var runtime = Runtime.getRuntime();
var threadMxBean = ManagementFactory.getThreadMXBean();
var runtimeMxBean = ManagementFactory.getRuntimeMXBean();
var clMxBean = ManagementFactory.getClassLoadingMXBean();
var memoryMxBean = ManagementFactory.getMemoryMXBean();
var heapMemory =  memoryMxBean.getHeapMemoryUsage();
var nonHeapMemory =  memoryMxBean.getNonHeapMemoryUsage();

function getRuntimeProperties() {
	var map = new HashMap();
	map.put('runtime.availableProcessors', runtime.availableProcessors());
	map.put('date.startTime', runtimeMxBean.getStartTime());
	map.put('seconds.upTime', runtimeMxBean.getUptime());

	map.put('memory.maxMemory', runtime.maxMemory());
	map.put('memory.freeMemory', runtime.freeMemory());
	map.put('memory.totalMemory', runtime.totalMemory());
	map.put('memory.heapMemoryMax', heapMemory.getMax());
	map.put('memory.heapMemoryUsed', heapMemory.getUsed());
	map.put('memory.nonHeapMemoryMax', nonHeapMemory.getMax());
	map.put('memory.nonHeapMemoryUsed', nonHeapMemory.getUsed());
	
	map.put('runtime.totalLoadedClassCount', clMxBean.getTotalLoadedClassCount());
	map.put('runtime.loadedClassCount', clMxBean.getLoadedClassCount());
	map.put('runtime.unloadedClassCount', clMxBean.getUnloadedClassCount());
	
	map.put('runtime.totalStartedThreadCount', threadMxBean.getTotalStartedThreadCount());
	map.put('runtime.threadCount', threadMxBean.getThreadCount());
	map.put('runtime.peakThreadCount', threadMxBean.getPeakThreadCount());
	map.put('runtime.daemonThreadCount', threadMxBean.getDaemonThreadCount());
	
	return map;
}

getRuntimeProperties();
