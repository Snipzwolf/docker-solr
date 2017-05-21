# solr
solr docker image of 3.6.2 as it's not provided by the [official image](https://hub.docker.com/_/solr/)

## Example usage
```
docker run -d --restart=always \
  -e REPLICATION_MASTER="true"
  -e REPLICATION_SLAVE="false"
  -e REPLICATION_HOST="127.0.0.1:8986"
  -e JAVA_STACKSIZE="4m"
  -e JAVA_HEAPSIZE="512m"
  -e JAVA_PERMSIZE="24m"
  -v /var/solr \
	--name solr snipzwolf/solr

```
