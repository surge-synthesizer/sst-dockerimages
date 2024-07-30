echo "Creating Image"
docker create --name surge-build-u18 --interactive --tty \
	--volume=/home/paul/dev/surge:/home/build/surge \
	sst-dockerimages-ubuntu18:1 

echo "Starting Image"
docker start surge-build-u18



