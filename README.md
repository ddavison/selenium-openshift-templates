Selenium OpenShift Templates
===

> OpenShift Templates used for a Scalable Selenium infrastructure and these templates tested on OpenShift 4.5.8.

Usage
===


```bash
$ oc create -f selenium-hub.yaml
$ oc create -f selenium-node-chrome.yaml
$ oc create -f selenium-node-firefox.yaml
$ oc process selenium-hub | oc create -f -
$ oc process selenium-node-chrome | oc create -f -
$ oc process selenium-node-firefox | oc create -f -
```

Once all pods up and running and check the grid status with the following endpoint and you should see following output.
Hub status url: https://OCP-ROUTE/wd/hub/status

**Note:** Please replace OCP-ROUTE based on your environment.

```
{
  "value": {
    "ready": true,
    "message": "Selenium Grid ready.",
    "nodes": [
      {
        "id": "72eaea16-1c0a-44b2-987f-c71cc36d6a77",
        "uri": "http:\u002f\u002f10.254.16.254:5555",
        "maxSessions": 1,
        "stereotypes": [
          {
            "capabilities": {
              "browserName": "chrome"
            },
            "count": 1
          }
        ],
        "sessions": [
        ]
      },
      {
        "id": "ee1d92e8-52cd-40a0-9516-cb4c424da8d8",
        "uri": "http:\u002f\u002f10.254.17.0:5555",
        "maxSessions": 1,
        "stereotypes": [
          {
            "capabilities": {
              "browserName": "firefox"
            },
            "count": 1
          }
        ],
        "sessions": [
        ]
      }
    ]
  }
}
```

In case you want to have VNC access to your chrome node, you need to add node chrome debug and you can follow same steps for firefox node as well.
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
