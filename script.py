#!/usr/bin/env python3
import os

# Set directories
base_dir = "docs"
output_file = os.path.join(base_dir, "downloads.md")
extensions = {"pdf": "PDFs", "epub": "EPUBs"}
icon_classes = {"pdf": "fas fa-file-pdf", "epub": "fas fa-book"}

# Collect files by extension
files_by_ext = {ext: [] for ext in extensions}

for root, dirs, files in os.walk(base_dir):
    for file in files:
        ext = file.split('.')[-1].lower()
        if ext in extensions:
            rel_path = os.path.relpath(os.path.join(root, file), ".")
            files_by_ext[ext].append(rel_path)

# Generate Markdown
with open(output_file, "w") as f:
    f.write("# Downloads\n\n")
    f.write("Welcome! Click a card to download the document you need.\n\n")

    for ext, files in files_by_ext.items():
        if not files:
            continue
        f.write(f"## {extensions[ext]}\n\n")
        for file_path in sorted(files):
            # Generate title automatically
            filename = os.path.basename(file_path)
            title = os.path.splitext(filename)[0].replace("-", " ").replace("_", " ")
            title = " ".join(word.capitalize() for word in title.split())
            
            # Default description same as title (can be updated manually later)
            description = f"Download {title}."

            f.write(f'<a href="{file_path}" class="download-card">\n')
            f.write(f'  <i class="{icon_classes[ext]}"></i>\n')
            f.write(f'  <span>{title}</span>\n')
            f.write(f'  <p>{description}</p>\n')
            f.write('</a>\n\n')

print(f"✅ Markdown file automatically generated at '{output_file}'!")

