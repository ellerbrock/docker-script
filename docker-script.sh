#!/usr/bin/env bash

# Docker Shell Scripts
# ====================
# Version: 	0.0.1
#
# Author: 	Maik Ellerbrock
# GitHub: 	https://github.com/ellerbrock/docker-scripts
# Twitter:      https://twitter.com/frapsoft

# update all containers
container_update() {
  echo updating containers ...
  docker images | grep -v "REPOSITORY" | awk '{print $1}' | xargs -L1 docker pull
}

# remove all unnamed container
container_del_unnamed() {
  echo removing unnamed containers ...
  docker rmi $(docker images | grep "^<none>" | awk '{print $3}') --force
}

# remove all dangling volumes
volumes_del_dangling() {
  echo removing dangling volumes ...
  docker volume rm $(docker volume ls -f dangling=true | grep -v "DRIVER" | awk '{print $2}')
}

echo "Docker Shell Script"
echo "==================="
echo "[1] update container"
echo "[2] delete unnamed container"
echo "[3] delete dangling volumes"

read -p " " -n 1 action
echo

if [[ $action == 1 ]]; then
  container_update
elif [[ $action == 2 ]]; then
  container_del_unnamed
elif [[ $action == 3 ]]; then
  volumes_del_dangling
else
  echo "wrong parameter"
fi
