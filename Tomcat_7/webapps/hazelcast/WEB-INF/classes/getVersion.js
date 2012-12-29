importPackage(java.lang);
importPackage(java.util);
importPackage(com.hazelcast.config);

function getVersion() {
    var result = hazelcast.node.initializer.version;
    return result
}

getVersion();