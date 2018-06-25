Selenium OpenShift Templates
===

> OpenShift Templates used for a Scalable Selenium infrastructure

Usage
===

```bash
$ oc create -f selenium-hub.yaml
$ oc create -f selenium-node-chrome.yaml
```

In case you want to have VNC access to your chrome node, you need to add node chrome debug
```
$ oc create -f selenium-node-chrome-debug.yaml
```
and then to view the node via VNC, you use port forwarding to localhost.

First you get the pod of chrome debug
```
$ oc get pods
NAME                                 READY     STATUS      RESTARTS   AGE
selenium-hub-1-b8w96                 1/1       Running     5          4d
selenium-node-chrome-debug-1-2gcqn   1/1       Running     4          3d

```
Run port forwarding
```
$ oc port-forward -p selenium-node-chrome-debug-1-2gcqn 5900:5900
Forwarding from 127.0.0.1:5900 -> 5900
Forwarding from [::1]:5900 -> 5900
Handling connection for 5900
```

```
$ vncviewer 127.0.0.1:5900
```
NB: The default password to access to VNC is `secret`. You can change it by editing the chrome debug Dockerfile following [this](https://github.com/SeleniumHQ/docker-selenium/tree/master/NodeChromeDebug#how-to-use-this-image).


Example
===

![openshift 1 hub 1 node](http://i.imgur.com/Ux3VcE3.png)
![hub 1 node](http://i.imgur.com/FBIDvta.png)
![openshift 1 hub 1 nodes](http://i.imgur.com/JpMkwTP.png)
![hub 2 nodes](http://i.imgur.com/LBqQ0KS.png)
