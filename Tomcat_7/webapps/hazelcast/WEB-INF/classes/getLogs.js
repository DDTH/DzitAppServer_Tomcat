importPackage(java.lang);
importPackage(java.util);
importPackage(com.hazelcast.config);

function getLogs() {
    var result = hazelcast.node.systemLogService.logBundle;
//	result.add(hazelcast.node.thisAddress);
//	result.add(new ConfigXmlGenerator(true).generate(hazelcast.node.config));
    return result
}

getLogs();