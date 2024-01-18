echo "Creating Image"
docker create --name surge-build --interactive --tty \
	--volume=/home/paul/dev/surge:/home/build/surge \
	sst-dockerimages-x64-linux:2

echo "Starting Image"
docker start surge-build



