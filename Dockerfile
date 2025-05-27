# Estágio final otimizado
FROM python:3.10-slim-bookworm

# Instalação mínima de dependências
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    tesseract-ocr-eng \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender1 \
    libgl1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# Diretório de trabalho
WORKDIR /app

# Copia e instala o pacote .whl da API
COPY sigplac_ocr-*.whl .
RUN pip install --no-cache-dir --timeout 300 sigplac_ocr-*.whl

# Expõe a porta usada pelo FastAPI
EXPOSE 8000

# Comando padrão para rodar a API
CMD ["uvicorn", "sigplac_ocr.main:app", "--host", "0.0.0.0", "--port", "8000"]