#!/bin/bash

# 현재 실행 중인 모든 Docker 컨테이너를 종료하고 제거
echo "Stopping all running containers..."
docker stop $(docker ps -aq)

echo "Removing all containers..."
docker rm $(docker ps -aq)

# 모든 Docker 이미지 제거 (선택적: 주의해서 사용하세요)
# echo "Removing all docker images..."
# docker rmi $(docker images -q)

# 모든 Docker 네트워크 제거
echo "Removing all docker networks..."
docker network prune -f

# Docker 볼륨 정리 (사용하지 않는 볼륨 삭제)
echo "Pruning volumes..."
docker volume prune -f

# Docker 시스템 정리 (불필요한 데이터 모두 삭제)
echo "Pruning Docker system..."
docker system prune -af

# 새로운 Docker Compose 프로젝트 실행
echo "Starting new Docker Compose project..."
docker-compose up -d

echo "Deployment completed successfully."
