#!/bin/bash

# Nexus API credentials
USER="user"
PASS='pass'
NEXUS_URL="https://"

# Путь к blob storage
BLOBS_DIR="/var/nexus/blobs/default/content"

echo "Собираем список репозиториев с Nexus API..."
repos=$(curl -s -u "$USER:$PASS" "$NEXUS_URL/service/rest/v1/repositories" | jq -r '.[].name')

declare -A repo_sizes

echo "Поиск всех .properties файлов..."
files=$(find "$BLOBS_DIR" -type f -name "*.properties")

echo "Обработка файлов..."
for file in $files; do
    repo=$(grep '^@Bucket.repo-name=' "$file" | cut -d= -f2)
    size=$(grep '^size=' "$file" | cut -d= -f2)

    if [[ -n "$repo" && -n "$size" && "$size" =~ ^[0-9]+$ ]]; then
        repo_sizes["$repo"]=$(( ${repo_sizes["$repo"]} + size ))
    fi
done

echo -e "\n📦 Размеры репозиториев (в байтах):"
printf "%-30s %20s\n" "Repository" "Bytes"
printf "%-30s %20s\n" "---------" "------"

total_bytes=0

for repo in "${!repo_sizes[@]}"; do
    size_bytes=${repo_sizes[$repo]}
    printf "%-30s %20s\n" "$repo" "$size_bytes"
    total_bytes=$((total_bytes + size_bytes))
done

echo
echo "📦 Общий размер всех репозиториев:"
echo "Total bytes: $total_bytes"
