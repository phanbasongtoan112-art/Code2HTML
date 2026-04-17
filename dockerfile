FROM python:3.11-slim

# Cài đặt Pandoc và LibreOffice (cần cho .doc)
RUN apt-get update && apt-get install -y \
    pandoc \
    libreoffice \
    libreoffice-writer \
    && rm -rf /var/lib/apt/lists/*

# Cài thư viện Python
RUN pip install mammoth pypandoc

WORKDIR /app
COPY pandoc_converter.py .

VOLUME ["/data"]
ENTRYPOINT ["python", "pandoc_converter.py"]
CMD ["--help"]