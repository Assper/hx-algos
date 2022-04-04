dev:
	haxe --main Main --interp

build:
	haxe --main Main --neko dist/algo.n

start:
	make -f run.mk build && neko ./dist/algo.n
