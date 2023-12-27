docker create --name surge-build --interactive --tty \
	--volume=/Users/paul/dev/music/arm-cross:/home/build/source-dir \
	--volume=/Users/paul/dev/music/surge:/home/build/surge \
        arm-surge:4 

docker start surge-build

docker exec -it surge-build /bin/bash -c "(cd /home/build/surge && cmake --build ignore/arm-cross --parallel 4 --target surge-xt-distribution)"

docker stop surge-build
docker rm surge-build


