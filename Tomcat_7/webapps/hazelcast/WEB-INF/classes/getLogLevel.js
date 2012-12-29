importPackage(java.lang);
importPackage(java.util);

function getLogLevel() {
    return hazelcast.node.systemLogService.getCurrentLevel();
}

getLogLevel();