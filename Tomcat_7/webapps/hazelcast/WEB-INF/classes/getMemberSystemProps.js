importPackage(java.lang);
importPackage(java.util);


 var names = [
             'java.runtime.name',
             'java.runtime.version',
             'java.vm.vendor',
             'java.vm.name',
             'java.home',
             
             'os.name',
             'os.version',
             
             'user.name',
             'user.home',
             'user.dir'
            ];

function getSystemProperties() {
	var map = new LinkedHashMap();
	var props = System.getProperties();
	for(var i=0; i<names.length; i++) {
		map.put(names[i], props.get(names[i]));
	}
	map.putAll(props);
	return map;
}

getSystemProperties();