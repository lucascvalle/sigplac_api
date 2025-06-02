FROM python:3.10-slim-bookworm

RUN apt-get update && apt-get install -y --no-install-recommends \
    tesseract-ocr \
    tesseract-ocr-eng \
    tesseract-ocr-por \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender1 \
    libgl1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copiar ambas as wheels
COPY sigplac_ocr-*.whl .
COPY sigplac_validate-*.whl .

# Instalar as bibliotecas
RUN pip install --no-cache-dir --timeout 300 sigplac_ocr-*.whl sigplac_validate-*.whl

EXPOSE 8000 5000

# Variáveis de ambiente
ENV OCR_SERVICE_URL=http://localhost:8000
ENV APP_PORT=5000
ENV APP_HOST=0.0.0.0
ENV PYTHONUNBUFFERED=1

# Iniciar ambos os serviços
CMD ["sh", "-c", "uvicorn sigplac_ocr.main:app --host 0.0.0.0 --port 8000 & uvicorn sigplac_validate.composed:app --host 0.0.0.0 --port 5000"]
