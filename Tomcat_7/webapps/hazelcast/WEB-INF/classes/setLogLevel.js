importPackage(java.lang);
importPackage(java.util);

function setLogLevel() {
    hazelcast.node.systemLogService.setCurrentLevel(logLevel);
    return "success"
}

setLogLevel();