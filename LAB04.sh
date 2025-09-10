# [cite_start]Roteiro de Comandos para a Atividade Prática 4: Protegendo o SSH [cite: 35]

# 1. Instalação do OpenSSH Server
apt-get update && apt-get install -y openssh-server

# 2. Backup do arquivo de configuração original (BOA PRÁTICA!)
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bkp

# 3. Edição do arquivo de configuração
echo "--> Edite o arquivo /etc/ssh/sshd_config com um editor (nano, vim, etc.)"
echo "--> Altere as seguintes linhas:"
echo "De: #Port 22"
echo "Para: Port 2244"
echo ""
echo "De: #PermitRootLogin prohibit-password"
echo "Para: PermitRootLogin no"

# Após salvar as alterações no arquivo, reinicie o serviço.

# 4. Reiniciar o serviço para aplicar as mudanças
systemctl restart sshd

# 5. Verificar o status do serviço e se ele está ouvindo na nova porta
echo "--> Verifique o status com: systemctl status sshd"
echo "--> Verifique a nova porta com: ss -tlpn | grep sshd"
