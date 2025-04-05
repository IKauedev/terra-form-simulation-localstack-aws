# 🌩️ Projeto de Infraestrutura Local com LocalStack + Terraform

Este projeto simula um ambiente AWS completo **localmente** usando [LocalStack](https://localstack.cloud) e [Terraform](https://www.terraform.io/). Ideal para testar sua aplicação com S3, SQS, Lambda, DynamoDB, etc., **sem custos** e **sem depender da nuvem** real.

---

## 📦 Estrutura do Projeto

```
projeto-infra-local/
├── docker-compose.yml     # LocalStack rodando como container
├── infra/                 # Código Terraform da infraestrutura
│   ├── main.tf
│   ├── provider.tf
│   └── variables.tf       # (opcional)
├── app/                   # Sua aplicação (Python, Node.js, Java etc)
│   └── src/...
└── README.md
```

---

## 🚀 O que é provisionado?

Neste exemplo inicial:

- 🪣 **S3 Bucket**: `meu-bucket-local`
- 📬 **SQS Queue**: `fila-local`
- (Você pode adicionar Lambda, DynamoDB, API Gateway, etc.)

---

## 🛠️ Pré-requisitos

Você precisa ter instalado:

- [Docker](https://www.docker.com/)
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- (Opcional) [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

---

## 🐳 Subindo o LocalStack com Docker

```bash
docker-compose up -d
```

Isso vai rodar o LocalStack na porta `4566` com os serviços AWS simulados.

---

## ⚙️ Criando a Infra com Terraform

1. Entre na pasta de infraestrutura:

```bash
cd infra/
```

2. Inicialize o Terraform:

```bash
terraform init
```

3. Aplique a infraestrutura:

```bash
terraform apply
```

Confirme com `yes`. Isso criará os recursos (S3, SQS, etc.) no LocalStack.

---

## 🧪 Testando os recursos com AWS CLI

### Listar buckets S3:

```bash
aws --endpoint-url=http://localhost:4566 s3 ls
```

### Ver filas SQS:

```bash
aws --endpoint-url=http://localhost:4566 sqs list-queues
```

---

## 🧩 Conectando sua aplicação

### Python (`boto3`)

```python
import boto3

s3 = boto3.client(
    "s3",
    region_name="us-east-1",
    endpoint_url="http://localhost:4566",
    aws_access_key_id="test",
    aws_secret_access_key="test"
)

print(s3.list_buckets())
```

---

### Node.js (AWS SDK v3)

```js
import { S3Client } from "@aws-sdk/client-s3";

const s3 = new S3Client({
  region: "us-east-1",
  endpoint: "http://localhost:4566",
  credentials: {
    accessKeyId: "test",
    secretAccessKey: "test",
  },
  forcePathStyle: true,
});
```

---

### Java (AWS SDK v2)

```java
S3Client s3 = S3Client.builder()
    .endpointOverride(URI.create("http://localhost:4566"))
    .region(Region.US_EAST_1)
    .credentialsProvider(
        StaticCredentialsProvider.create(
            AwsBasicCredentials.create("test", "test")
        )
    )
    .build();
```

---

## 🎯 Usando variáveis de ambiente

Para facilitar a alternância entre produção e local, use variáveis:

```bash
export AWS_ENDPOINT=http://localhost:4566
```

E no código, use `AWS_ENDPOINT` se estiver definido, ou padrão da AWS se não estiver.

---

## ☁️ Indo para produção

Quando quiser aplicar na AWS real:

1. Remova os `endpoints` do `provider.tf`
2. Configure suas credenciais reais (IAM)
3. Rode `terraform apply` novamente

---

## 🧼 Limpando tudo

```bash
terraform destroy
docker-compose down -v
```

---

## 📌 Dica final

Você pode adicionar qualquer serviço da AWS no `SERVICES=` do `docker-compose.yml`, como:

```yaml
environment:
  - SERVICES=s3,sqs,dynamodb,lambda,apigateway,iam,cloudwatch
```