echo "Creating Image"
docker create --name surge-build --interactive --tty \
	--volume=/home/paul/dev/surge:/home/build/surge \
        arm-surge:4 

echo "Starting Image"
docker start surge-build



