#!/bin/bash

_setupDocker() {
	sudo systemctl enable docker.service
	sudo usermod -aG docker $USER
	newgrp docker
	sudo systemctl restart docker.service
}
