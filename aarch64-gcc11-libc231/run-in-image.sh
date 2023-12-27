docker run --rm --interactive --tty \
	--volume=/Users/paul/dev/music/arm-cross:/home/build/source-dir \
	--volume=/Users/paul/dev/music/surge:/home/build/surge \
        arm-surge:4 bash 
