importPackage(java.lang);
importPackage(java.util);

function getMapEntry() {
	var map = hazelcast.getMap(mapName);
	if(type == 'string') {
		//nop
	}
	else if(type == 'long') {
		key = Long.valueOf(key);
	}
	else if(type == 'integer') {
		key = Integer.valueOf(key);
	}
	
	var entry = map.getMapEntry(key);
    var result = new TreeMap();

	if(entry == null || entry.getValue() == null){
        result.put('No Value Found!', ' ');
        return result;
    }
    var value = entry.getValue();
    result.put('browse_value', value != null ? value.toString() : 'null');
    result.put('browse_class', value != null ? value.getClass().getName() : 'null');

	result.put('memory_cost', entry.getCost());
	result.put('date_creation_time', entry.getCreationTime());
	result.put('date_expiration_time', entry.getExpirationTime());
	result.put('browse_hits', entry.getHits());
	result.put('date_access_time', entry.getLastAccessTime());
	result.put('date_update_time', entry.getLastUpdateTime());
	result.put('browse_version', entry.getVersion());
	result.put('boolean_valid', entry.isValid());
	

	return result;
}

getMapEntry();