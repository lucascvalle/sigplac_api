# SIGPLAC-API - Versão 0.2.0

Sistema de Microserviços Sigplac compostos por bibliotecas wheel com contêinerização docker para implementação em produção. 


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
   docker run -d --name sigplac-api -p 8000:8000 -p 5000:5000 -e SIGPLAC_API4AI_KEY="sua_chave_aqui" sigplac-api
    ```
   * Nota: Caso não possua uma chave e queira iniciar o contêiner, passe um valor genérico e utilize apenas o serviço do tesseract

## SIGPLAC-OCR

API de OCR com suporte para dois métodos de processamento: **API4AI** (Serviço de OCR Alto Detalhe) e **Tesseract** (OCR de Documentos).  
*Desenvolvido em FastAPI e empacotado para implantação via Docker.*

---

### 📦 Recursos
- **API4AI OCR**: Integração com serviço premium para OCR avançado.
- **Tesseract OCR**: Extração básica de texto em inglês.
- Configuração simplificada via variáveis de ambiente.
- Implantação via Docker com todas as dependências inclusas.

---


### Endpoints

#### API4AI

* Parâmetro: image_url (URL pública da imagem)

* Exemplo:
   ```bash
  curl -X POST "http://localhost:8000/api4ai/ocr?image_url=https://exemplo.com/imagem.png"
  ```

###### 🔍 Estrutura de Resposta (API4AI)

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

##### Extraindo apenas o texto formatado:
```python
texto = response['results'][0]['entities'][0]['objects'][0]['entities'][0]['text']
```


#### Tesseract

* Parâmetro: image_url (URL pública da imagem)

* Exemplo:
   ```bash
  curl -X POST "http://localhost:8000/tesseract/ocr?image_url=https://exemplo.com/imagem.png"
  ```
##### 🔍 Estrutura de Resposta (TESSERACT)

A resposta inclui metadados completos e texto estruturado:
```json
{
  "text": "Hello World"
}
```
## SIGPLAC-VALIDATE

API de validação para análise de texto obtído através de OCR de placas veículares prontas para descarte.

---

### Atualizações: 

⚡ Processamento 3x mais rápido - Apenas 1 chamada OCR por validação

📦 Menor tamanho de imagem - Remoção de dependências desnecessárias

🎯 Precisão melhorada - Lógica validada com casos reais

📝 Respostas simplificadas - Apenas informações essenciais

🔧 Manutenção facilitada - Código 60% menor e centralizado

---


### Endpoints

#### Validador de Placa Cortada

* Parâmetro:
  
* Exemplo:
```bash
  curl -X POST "http://localhost:5000/validate/placa_descartada" \
  -H "Content-Type: application/json" \
  -d '{
    "token": "CBA0K41",
    "image_url": "https://exemplo.com/placa_mercosul.jpg"
  }'
```
###### 🔍 Estrutura de Resposta 

* Placa Cortada:
```json
{
  "placa_descartada": true,
  "motivo": "Placa descartada (cortada)",
  "ocr_global": "BR MERCOSUL BRASIL ABC 1C34",
  "tipo_placa": "MERCOSUL"
}
```
* Placa Não Cortada:
```json
{
  "placa_descartada": true,
  "motivo": "Placa não descartada (intacta)",
  "ocr_global": "BR MERCOSUL BRASIL ABC1C34",
  "tipo_placa": "MERCOSUL"
}
```

## Suporte
Para problemas ou dúvidas, abra uma issue no GitHub.


