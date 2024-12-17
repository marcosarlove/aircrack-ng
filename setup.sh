#!/bin/bash

# Atualiza os pacotes do sistema
echo "Atualizando pacotes..."
apt update && apt upgrade -y

# Instala wget se não estiver instalado
command -v wget >/dev/null 2>&1 || { 
    echo "Instalando wget..."
    pkg install wget -y 
}

# Instala ferramentas adicionais
echo "Instalando ferramentas adicionais..."
apt install libc++ libnl libpcap libsqlite openssl pcre zlib -y

# Obtém o nome da plataforma
plataforma=$(uname -m)
if [[ $plataforma == arm* ]]; then
    plataforma="arm"
fi
echo "Plataforma detectada: $plataforma"

# Baixa o pacote aircrack-ng apropriado
echo "Baixando aircrack-ng..."
wget https://raw.githubusercontent.com/pitube08642/aircrack-ng-for-termux/main/dists/termux/aircrack-ng/binary-$plataforma/aircrack-ng_3_1.7_$plataforma.deb

# Instala o pacote baixado
echo "Instalando aircrack-ng..."
dpkg -i aircrack-ng_3_1.7_$plataforma.deb

# Verifica se a instalação foi bem-sucedida
if aircrack-ng -S > /dev/null 2>&1; then
    echo "Instalação do aircrack-ng concluída com sucesso!"
else
    echo "Houve um erro na instalação do aircrack-ng. Tentando reinstalar dependências..."
    apt install -f -y  # Tenta corrigir dependências quebradas
fi
