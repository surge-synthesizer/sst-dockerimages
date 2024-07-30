echo "Creating Image"
docker create --name surge-build --interactive --tty \
	--volume=/home/paul/dev/surge:/home/build/surge \
        arm-surge:4 

echo "Starting Image"
docker start surge-build

echo "Running build"
docker exec -it surge-build /bin/bash -c "(cd /home/build/surge && cmake -B ignore/arm-cross -DCMAKE_BUILD_TYPE=DEBUG -DCMAKE_C_COMPILER=/home/build/x-tools/aarch64-rpi4-linux-gnu/bin/aarch64-rpi4-linux-gnu-gcc -DCMAKE_CXX_COMPILER=/home/build/x-tools/aarch64-rpi4-linux-gnu/bin/aarch64-rpi4-linux-gnu-g++)"
docker exec -it surge-build /bin/bash -c "(cd /home/build/surge && cmake --build ignore/arm-cross --parallel 4 --target surge-xt-distribution)"

echo "Stopping Image"
docker stop surge-build
docker rm surge-build


