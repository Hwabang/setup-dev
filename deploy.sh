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

# 필요한 디렉토리 생성
mkdir -p nginx certbot/conf certbot/www

# Docker Compose 시작 (Nginx 제외)
docker-compose up -d certbot wordpress db

# 최초의 Let's Encrypt 인증서 취득
docker-compose run --rm certbot certbot certonly --webroot --webroot-path=/var/www/certbot -d hwabang.jeonghi.com --email jpark0902@kookmin.ac.kr --agree-tos --no-eff-email

# Nginx 컨테이너 시작 및 기타 서비스 재시작
docker-compose up -d nginx
docker-compose restart
echo "Deployment completed successfully."

