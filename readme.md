# Requirements 

* minikube https://kubernetes.io/ru/docs/tasks/tools/install-minikube/
* devspace https://devspace.sh/cli/docs/getting-started/installation 
* kubectl https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/ 
* docker https://docs.docker.com/engine/install/ubuntu/ 


# Change k8s manifests

please, change `docker registry` configuration in k8s manifests in `./deployment` folder and in `./devspace.yml` file

default value is `registry-url`

# Commands

`make start` - run cluster

`make stop` - stop cluster

`make delete` - delete cluster

`make bash` - enter to php container

`make local_testing` - run tests in local cluster

local url http://127.0.0.1:8888

# Installation

```
make start
make install
```