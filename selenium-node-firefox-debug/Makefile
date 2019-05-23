build:
	docker build -t "jr00n/node-firefox-debug-os" -f Dockerfile .

.PHONY:test
test:
	docker build -t "jr00n/node-firefox-debug-os-candidate" -f Dockerfile .
	sh test/run
