build:
	docker build -t "jr00n/node-chrome-debug-os" -f Dockerfile .

.PHONY:test
test:
	docker build -t "jr00n/node-chrome-debug-os-candidate" -f Dockerfile .
	sh test/run
