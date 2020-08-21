all: conda install

conda:
	./setup.sh -c

install: clean conda
	./setup.sh -b

clean:
	rm -f awesome_package_dev/awesome_package/*so
