start:
	minikube start --driver docker --memory 4096 --cpus 4 --profile minikube
	devspace purge --kube-context=minikube --namespace=symfony-k8s-dev --no-warn # because you should run 'devspace dev' once
	devspace dev --kube-context=minikube --namespace=symfony-k8s-dev --no-warn --ui=false --skip-push=true --print-sync=false

stop:
	- devspace purge --kube-context=minikube --namespace=symfony-k8s-dev --no-warn
	minikube stop --profile minikube

delete:
	minikube delete --profile minikube

bash:
	devspace enter --kube-context=minikube --namespace=symfony-k8s-dev --container=symfony-k8s-php

sync:
	devspace purge --kube-context=minikube --namespace=symfony-k8s-dev --no-warn
	devspace dev --kube-context=minikube --namespace=symfony-k8s-dev --no-warn --ui=false --skip-pipeline=true --print-sync=false

install:
	composer install
	php bin/console doctrine:migrations:migrate --no-interactions

start_in_minikube:
	make start

start_in_docker_desktop:
	devspace dev --kube-context=docker-desktop --namespace=symfony-k8s-dev

view_config:
	kubectl config view

local_testing:
	chmod +x ./scripts/run_local_testing.sh
	/bin/bash ./scripts/run_local_testing.sh

clean_images:
	devspace cleanup images --kube-context=minikube

tests:
	php bin/console doctrine:database:drop --force --if-exists --env=test
	php bin/console doctrine:database:create --env=test
	php bin/console doctrine:schema:drop --force --env=test
	php bin/console doctrine:migrations:migrate -n --env=test
	php bin/phpunit

staging_post_deploy:
	php bin/console doctrine:migrations:migrate -n --env=prod

.PHONY: start stop delete bash sync install start_in_minikube start_in_docker_desktop view_config local_testing clean_images tests staging_post_deploy