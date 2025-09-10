#!/bin/bash
# Script para a Atividade Prática 7: Configurando Firewall com IPTABLES
# ATENÇÃO: Executar como root. CUIDADO, regras incorretas podem bloquear seu acesso SSH.

echo "Iniciando configuração do firewall IPTABLES..."

# Limpa todas as regras existentes (flush)
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X

#Define a política padrão como DROP (bloquear tudo) para tráfego que entra e passa pelo firewall 
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT # Permite todo o tráfego de saída

# Permite tráfego da interface de loopback (essencial para o sistema)
iptables -A INPUT -i lo -j ACCEPT

# Permite conexões já estabelecidas e relacionadas
# (Ex: respostas a requisições que o próprio servidor fez)
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# --- LIBERAÇÃO DE SERVIÇOS ---
# Adicione aqui as regras para os serviços que você configurou

# Libera SSH na porta 2244 (conforme atividade 4)
echo "--> Liberando porta 2244/TCP para SSH"
iptables -A INPUT -p tcp --dport 2244 -j ACCEPT

# [cite_start]Libera Servidor Web (HTTP porta 80) [cite: 70]
echo "--> Liberando porta 80/TCP para HTTP (Apache)"
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# Libera DNS (porta 53 TCP e UDP)
echo "--> Liberando porta 53/TCP e 53/UDP para DNS (BIND)"
iptables -A INPUT -p udp --dport 53 -j ACCEPT
iptables -A INPUT -p tcp --dport 53 -j ACCEPT

# Libera SAMBA (portas comuns para redes locais - use com cautela)
# echo "--> Liberando portas para o SAMBA"
# iptables -A INPUT -p tcp --dport 139 -j ACCEPT
# iptables -A INPUT -p tcp --dport 445 -j ACCEPT
# iptables -A INPUT -p udp --dport 137 -j ACCEPT
# iptables -A INPUT -p udp --dport 138 -j ACCEPT

echo "Regras do firewall aplicadas."
echo "Listando regras atuais:"
iptables -L -v -n

# Para tornar as regras persistentes (não sumirem ao reiniciar),
# instale o pacote iptables-persistent:
# apt-get install -y iptables-persistent
# (Ele perguntará se deseja salvar as regras atuais)
