#!/bin/bash
# Script para a atividade prática 1: Configurando o Ambiente de Desenvolvimento
# ATENÇÃO: Este script deve ser executado com privilégios de root (sudo)

echo "Iniciando configuração do ambiente..."

# [cite_start]1. Criação de Grupos [cite: 295, 307]
echo "--> Criando grupos 'desenvolvedores' e 'testadores'..."
groupadd desenvolvedores
groupadd testadores
echo "Grupos criados com sucesso."

# [cite_start]2. Criação de Usuários [cite: 267, 289, 291]
echo "--> Criando usuários dev_senior, dev_junior e qa_analyst..."
useradd -m -g desenvolvedores dev_senior
useradd -m -g desenvolvedores dev_junior
useradd -m -g testadores qa_analyst
echo "--> Adicionando dev_senior ao grupo 'testadores'..."
usermod -aG testadores dev_senior
echo "Usuários criados com sucesso."

# [cite_start]3. Definição de Senhas [cite: 290]
echo "--> ATENÇÃO: Defina as senhas para os novos usuários a seguir."
passwd dev_senior
passwd dev_junior
passwd qa_analyst

# [cite_start]4. Estrutura de Diretórios [cite: 9, 191]
echo "--> Criando a estrutura de diretórios em /srv/projetos..."
mkdir -p /srv/projetos/backend
mkdir -p /srv/projetos/frontend
echo "Estrutura de diretórios criada com sucesso."

# [cite_start]5. Gerenciamento de Privilégios [cite: 30, 313, 325]
echo "--> Configurando propriedade e permissões dos diretórios..."
chown -R dev_senior:desenvolvedores /srv/projetos
chmod -R 750 /srv/projetos
echo "Permissões aplicadas. Verificando com 'ls -la /srv/':"
ls -la /srv/

# [cite_start]6. Controle de Processos [cite: 21, 222]
echo "--> A etapa de controle de processos é manual e deve ser feita em um terminal separado."
echo "--> Exemplo: 'sleep 500 &', 'ps aux | grep sleep', 'kill <PID>'."

# [cite_start]7. Shell Script de Boas-Vindas [cite: 31, 378, 381]
echo "--> Criando script de boas-vindas em /usr/local/bin/boasvindas.sh..."
cat << 'EOF' > /usr/local/bin/boasvindas.sh
#!/bin/bash
echo "=========================================="
echo "Bem-vindo(a) ao Servidor de Desenvolvimento!"
echo "Data e hora atual: $(date)"
echo "=========================================="
EOF

chmod +x /usr/local/bin/boasvindas.sh
echo "--> Adicionando script ao /etc/profile para execução no login..."
echo "" >> /etc/profile
echo "# Executa script de boas-vindas" >> /etc/profile
echo "if [ -f /usr/local/bin/boasvindas.sh ]; then" >> /etc/profile
echo "   /usr/local/bin/boasvindas.sh" >> /etc/profile
echo "fi" >> /etc/profile

echo "Configuração do ambiente concluída!"
