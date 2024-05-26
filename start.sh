#!/bin/bash

# Define o locale para evitar problemas com tr
export LC_ALL=C

# Função para gerar senhas aleatórias
generate_random_password() {
  length=$1
  tr -dc A-Za-z0-9 </dev/urandom | head -c $length
}

# Gere valores aleatórios
MYSQL_ROOT_PASSWORD=$(generate_random_password 16)
MYSQL_DATABASE=zabbix
MYSQL_USER=zabbix
MYSQL_PASSWORD=$(generate_random_password 16)
PHP_TZ=America/Sao_Paulo

# Crie o arquivo .env
cat <<EOF > .env
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
MYSQL_DATABASE=${MYSQL_DATABASE}
MYSQL_USER=${MYSQL_USER}
MYSQL_PASSWORD=${MYSQL_PASSWORD}
PHP_TZ=${PHP_TZ}
EOF

echo "Arquivo .env gerado com sucesso."

# Execute o docker-compose
docker-compose up -d
