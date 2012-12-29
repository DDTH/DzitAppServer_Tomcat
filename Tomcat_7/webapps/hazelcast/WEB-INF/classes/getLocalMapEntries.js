importPackage(java.lang);
importPackage(java.util);

function getLocalMapEntries() {
	var map = hazelcast.getMap(mapName);
	
	var keys = map.localKeySet().toArray();
	var entries = new HashMap(keys.length);
	
	for(var i = 0; i < keys.length; i++) {
		var value = map.get(keys[i]);
		value = value != null ? value.toString() : 'null';
		entries.put(keys[i].toString(), value);
	}
	return entries;
}

getLocalMapEntries();