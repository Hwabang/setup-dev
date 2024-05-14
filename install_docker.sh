#!/bin/bash

# 스크립트가 root로 실행되었는지 확인
if [ "$(id -u)" != "0" ]; then
   echo "이 스크립트는 root 권한으로 실행해야 합니다."
   exit 1
fi

# 필수 패키지 업데이트 및 설치
apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Docker의 공식 GPG 키 추가
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# Docker 저장소를 소스 리스트에 추가
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Docker Engine 설치
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

# 현재 사용자를 docker 그룹에 추가
usermod -aG docker $USER

# Docker Compose 설치
COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "Docker와 Docker Compose가 설치되었습니다."
