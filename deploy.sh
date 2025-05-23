#!/bin/bash

# Настройки
OUTPUT_DIR="output"
TEMP_DIR="/tmp/manual_site_output"
BRANCH_MAIN="main"
BRANCH_DEPLOY="gh-pages"

# 1. Сохраняем текущее содержимое output
echo "📁 Копируем $OUTPUT_DIR во временную директорию..."
rm -rf "$TEMP_DIR"
mkdir -p "$TEMP_DIR"
cp -r $OUTPUT_DIR/* "$TEMP_DIR"

# 2. Переключаемся на ветку gh-pages
echo "🔁 Переключаемся на ветку $BRANCH_DEPLOY..."
git checkout $BRANCH_DEPLOY || exit 1

# 3. Удаляем старые файлы (HTML и изображения, если нужно)
echo "🧹 Удаляем старые HTML-файлы..."
rm -rf *.html images

# 4. Копируем новые файлы из временной папки
echo "📥 Копируем новые файлы..."
cp -r "$TEMP_DIR"/* .

# 5. Добавляем, коммитим, пушим
echo "📝 Коммитим изменения..."
git add .
git commit -m "Обновление сайта: $(date '+%d.%m.%Y %H:%M')" || echo "⚠️ Нечего коммитить"
git push origin $BRANCH_DEPLOY

# 6. Возвращаемся на main
echo "🔙 Возврат на ветку $BRANCH_MAIN..."
git checkout $BRANCH_MAIN

echo "✅ Готово!"
