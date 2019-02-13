.PHONY: all build test push delete deploy
CHROME=qgervacio/selenium-node-chrome
FIREFO=qgervacio/selenium-node-firefox

LATEST=latest
CANDID=1.0.0

# tested in:
# minishift v1.30.0+186b034
# oc v3.11.0+0cbc58b
# kubernetes v1.11.0+d4cacc0
OCPNAM=selenium
OCPURL=https://192.168.99.100:8443
OCPTKN=Wzd7HQk9vub4GMgVVfHeGiSxTp9XSYcbzyH3ZStMsQY

TEMPLATES=selenium-hub.yaml,selenium-node-chrome.yaml,selenium-node-chrome-debug.yaml,selenium-node-firefox.yaml,selenium-node-firefox-debug.yaml

# leave empty to let OCP decide
SELURL=

all:
	@echo 'Targets:'
	@echo 'build -- Build all images tagged as "${LATEST}"'
	@echo 'test --- Build all images tagged as "${CANDID}" then run test'
	@echo 'push --- Push all images'
	@echo 'delete - Delete OCP template'
	@echo 'deploy - Create OCP template then deploy'

build:
	@echo 'Building...'
	@TAG="${LATEST}" CHROME="${CHROME}" FIREFO="${FIREFO}" docker-compose build

test:
	@echo 'Building...'
	@TAG="${CANDID}" CHROME="${CHROME}" FIREFO="${FIREFO}" docker-compose build

	@echo 'Testing selenium-node-chrome...'
	@TAG="${CANDID}" CHROME="${CHROME}" FIREFO="${FIREFO}" docker-compose run selenium-node-chrome id
	@TAG="${CANDID}" CHROME="${CHROME}" FIREFO="${FIREFO}" docker-compose run selenium-node-chrome pwd

	@echo 'Testing selenium-node-chrome-debug...'
	@TAG="${CANDID}" CHROME="${CHROME}" FIREFO="${FIREFO}" docker-compose run selenium-node-chrome-debug id
	@TAG="${CANDID}" CHROME="${CHROME}" FIREFO="${FIREFO}" docker-compose run selenium-node-chrome-debug pwd

	@echo 'Testing selenium-node-firefox...'
	@TAG="${CANDID}" CHROME="${CHROME}" FIREFO="${FIREFO}" docker-compose run selenium-node-firefox id
	@TAG="${CANDID}" CHROME="${CHROME}" FIREFO="${FIREFO}" docker-compose run selenium-node-firefox pwd

	@echo 'Testing selenium-node-firefox-debug...'
	@TAG="${CANDID}" CHROME="${CHROME}" FIREFO="${FIREFO}" docker-compose run selenium-node-firefox-debug id
	@TAG="${CANDID}" CHROME="${CHROME}" FIREFO="${FIREFO}" docker-compose run selenium-node-firefox-debug pwd

push:
	@echo 'Pushing...'
	@TAG="${LATEST}" CHROME="${CHROME}" FIREFO="${FIREFO}" docker-compose push
	@TAG="${CANDID}" CHROME="${CHROME}" FIREFO="${FIREFO}" docker-compose push


delete:
	@echo 'Deleting...'
	-oc delete all --selector app=selenium -n "${OCPNAM}" --server="${OCPURL}" --token="${OCPTKN}" --insecure-skip-tls-verify="true"
	-oc delete --filename=${TEMPLATES} -n "${OCPNAM}" --server="${OCPURL}" --token="${OCPTKN}" --insecure-skip-tls-verify="true"

deploy:
	@echo 'Deploying...'
	@oc create --filename=${TEMPLATES} -n "${OCPNAM}" --server="${OCPURL}" --token="${OCPTKN}" --insecure-skip-tls-verify="true"
	
	@oc new-app -f selenium-hub.yaml -p HUB_ROUTE=${SELURL} -n "${OCPNAM}" --server="${OCPURL}" --token="${OCPTKN}" --insecure-skip-tls-verify="true"
	@oc new-app -f selenium-node-chrome.yaml -p IMAGE=${CHROME}:${CANDID} -n "${OCPNAM}" --server="${OCPURL}" --token="${OCPTKN}" --insecure-skip-tls-verify="true"
	@oc new-app -f selenium-node-chrome-debug.yaml -p IMAGE=${CHROME}-debug:${CANDID} -n "${OCPNAM}" --server="${OCPURL}" --token="${OCPTKN}" --insecure-skip-tls-verify="true"
	@oc new-app -f selenium-node-firefox.yaml -p IMAGE=${FIREFO}:${CANDID} -n "${OCPNAM}" --server="${OCPURL}" --token="${OCPTKN}" --insecure-skip-tls-verify="true"
	@oc new-app -f selenium-node-firefox-debug.yaml -p IMAGE=${FIREFO}-debug:${CANDID} -n "${OCPNAM}" --server="${OCPURL}" --token="${OCPTKN}" --insecure-skip-tls-verify="true"