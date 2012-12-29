importPackage(java.lang);
importPackage(java.util);
importPackage(com.hazelcast.config);

function getMemberConfig() {
    var result = new ArrayList(1);
    result.add(new ConfigXmlGenerator(true).generate(hazelcast.node.config));
    return result;
}

getMemberConfig();