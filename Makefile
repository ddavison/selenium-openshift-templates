.PHONY: all build test
CHROME=jr00n/node-chrome
FIREFO=jr00n/node-firefox

LATEST=latest
CANDID=candidate

all:
	@echo 'Targets:'
	@echo 'build - Build all images tagged as "${LATEST}"'
	@echo 'test -- Build all images tagged as "${CANDID}" then run test'

build:
	@echo 'Building...'
	@TAG="${LATEST}" CHROME="${CHROME}" FIREFO="${FIREFO}" docker-compose build

test:
	@echo 'Building...'
	@TAG="${CANDID}" CHROME="${CHROME}" FIREFO="${FIREFO}" docker-compose build

	@echo 'Testing selenium-node-chrome..'
	@TAG="${CANDID}" CHROME="${CHROME}" FIREFO="${FIREFO}" docker-compose run selenium-node-chrome id
	@TAG="${CANDID}" CHROME="${CHROME}" FIREFO="${FIREFO}" docker-compose run selenium-node-chrome pwd

	@echo 'Testing selenium-node-chrome-debug..'
	@TAG="${CANDID}" CHROME="${CHROME}" FIREFO="${FIREFO}" docker-compose run selenium-node-chrome-debug id
	@TAG="${CANDID}" CHROME="${CHROME}" FIREFO="${FIREFO}" docker-compose run selenium-node-chrome-debug pwd

	@echo 'Testing selenium-node-firefox..'
	@TAG="${CANDID}" CHROME="${CHROME}" FIREFO="${FIREFO}" docker-compose run selenium-node-firefox id
	@TAG="${CANDID}" CHROME="${CHROME}" FIREFO="${FIREFO}" docker-compose run selenium-node-firefox pwd

	@echo 'Testing selenium-node-firefox-debug..'
	@TAG="${CANDID}" CHROME="${CHROME}" FIREFO="${FIREFO}" docker-compose run selenium-node-firefox-debug id
	@TAG="${CANDID}" CHROME="${CHROME}" FIREFO="${FIREFO}" docker-compose run selenium-node-firefox-debug pwd