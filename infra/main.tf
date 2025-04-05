resource "aws_s3_bucket" "meu_bucket" {
  bucket = "meu-bucket-local"
}

resource "aws_sqs_queue" "minha_fila" {
  name = "fila-local"
}