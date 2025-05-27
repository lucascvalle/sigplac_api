# SIGPLAC-OCR API

API de OCR com suporte para dois métodos de processamento: **API4AI** (Serviço de OCR Alto Detalhe) e **Tesseract** (OCR de Documentos).  
*Desenvolvido em FastAPI e empacotado para implantação via Docker.*

---

## 📦 Recursos
- **API4AI OCR**: Integração com serviço premium para OCR avançado.
- **Tesseract OCR**: Extração básica de texto em inglês.
- Configuração simplificada via variáveis de ambiente.
- Implantação via Docker com todas as dependências inclusas.

---

## 🚀 Instalação

### Pré-requisitos
- Docker instalado
- Chave da API4AI (para o endpoint `/api4ai/ocr`)

### Passo a Passo
1. Construa a imagem Docker:
   ```bash
   docker build -t sigplac-api .
    ```

2. Execute o contêiner Docker passando a sua chave da API:
   ```bash
   docker run -d --name sigplac-api -p 8000:8000 -e SIGPLAC_API4AI_KEY="sua_chave_aqui" sigplac-api
    ```
   * Nota: Caso não possua uma chave e queira iniciar o contêiner, passe um valor genérico e utilize apenas o serviço do tesseract
### Endpoints

## API4AI

* Parâmetro: image_url (URL pública da imagem)

* Exemplo:
   ```bash
  curl -X POST "http://localhost:8000/api4ai/ocr?image_url=https://exemplo.com/imagem.png"
  ```

# 🔍 Estrutura de Resposta (API4AI)

A resposta inclui metadados completos e texto estruturado:
```json
{
  "results": [
    {
      "status": {"code": "ok", "message": "Success"},
      "width": 1475,
      "height": 1106,
      "entities": [
        {
          "objects": [
            {
              "entities": [
                {
                  "text": "TEXTO EXTRAÍDO..."
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}
```

# Extraindo apenas o texto formatado:
```python
texto = response['results'][0]['entities'][0]['objects'][0]['entities'][0]['text']
```


## Tesseract

* Parâmetro: image_url (URL pública da imagem)

* Exemplo:
   ```bash
  curl -X POST "http://localhost:8000/tesseract/ocr?image_url=https://exemplo.com/imagem.png"
  ```
# 🔍 Estrutura de Resposta (TESSERACT)

A resposta inclui metadados completos e texto estruturado:
```json
{
  "text": "Hello World"
}
```

