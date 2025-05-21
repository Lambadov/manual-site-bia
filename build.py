from jinja2 import Environment, FileSystemLoader
from pathlib import Path
import shutil
from data import site_links

# Создание папки output
output_dir = Path("output")
output_dir.mkdir(exist_ok=True)

# Настройка Jinja2
env = Environment(loader=FileSystemLoader("."))
template = env.get_template("template.html")

# Генерация index.html
output_html = template.render(sections=site_links)  # Обрати внимание: ключ в шаблон передаётся как sections
(output_dir / "index.html").write_text(output_html, encoding="utf-8")

# Копирование файлов из pages/
pages_dir = Path("pages")
for page_file in pages_dir.glob("*.html"):
    shutil.copy(page_file, output_dir / page_file.name)

# Копирование папки images/
images_dir = Path("images")
if images_dir.exists():
    shutil.copytree(images_dir, output_dir / "images", dirs_exist_ok=True)


print("Сайт успешно собран.")
