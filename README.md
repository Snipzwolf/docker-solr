# solr
solr docker image of 3.6.2 as it's not provided by the [official image](https://hub.docker.com/_/solr/)

## files you may want to replace
if you replace the files below using volumes ensure the host files have at least read access for everyone (chmod 0444 somefile)
* /etc/solr/solr.xml
* /etc/solr/logging.properties

## Example usage
```
docker run -d -p 8005:8005 --restart=always \
  -e REPLICATION_MASTER="true" \
  -e REPLICATION_SLAVE="false" \
  -e REPLICATION_HOST="127.0.0.1:8006" \
  -e JAVA_STACKSIZE="4m" \
  -e JAVA_HEAPSIZE="512m" \
  -e JAVA_PERMSIZE="24m" \
  -v /var/solr \
	--name solr snipzwolf/solr

```
