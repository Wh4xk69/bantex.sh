#!/usr/bin/bash
# bantex.sh - Gerenciador de Banco Textual
#
# Biblioteca de funcoes para gerenciar os dados do banco textual.
# Use o comando "source" para incluir-la em seu script.
#
# 2022-23-01 v1 Weverson Quaresma Furtado:Versao inicial
# 2022-23-01 v2 Weverson Quaresma Furtado
# 2022-26-01 v3 Weverson Quaresma Furtado
#
# -------------[ configuracao ]-------------
SEP=:									# defina aqui o separador, padrao e:
TEMP=temp.$$  								#Arquivo temporario
BANCO=usuarios.txt
# ----------------[ funcoes ]---------------


# O arquivo texto com o banco ja deve estar definido
[ -r "$BANCO" -a -w "$BANCO" ] || {
	echo "Base travada, confira as permissoes de leitura e escrita."
	return 1
}


# Verifica se a chave $1 esta no banco
tem_chave(){
	grep -i -q "^$1$SEP" "$BANCO"
}

# Apaga o registro da chave $1 do banco
apaga_registro(){
	tem_chave "$1" || return 					# se nao tem, nem tente
	grep -i -v "^$1$SEP" "$BANCO" > "$TEMP" 			# apaga a chave
	mv "$TEMP" "$BANCO"						# regrava o banco
	echo "O registro '$1' foi apagado"
}


# Insere o registro $* no banco
insere_registro(){
	local chave=$(echo "$1"|cut -d $SEP -f1) 			# pega primeiro campo
	if tem_chave "$chave"; then
		echo "A chave '$chave' ja esta cadastrada no banco."
		return 1
	else 								# chave nova
		echo "$*" >> "$BANCO"					# grava o registro
		echo "Registro de '$chave' cadastrado com sucesso."


	fi
	return 0
}


# Mostra os nomes dos campos do banco, um por linha
campos(){
	head -n 1 "$BANCO" | tr $SEP \\n
}


# Mostra os dados do registro da chave $1
mostra_registro(){
	local dados=$(grep -i "^$1$SEP" "$BANCO")
	local i=0
	[ "$dados" ] || return						# nao achei
	campos | while read campo; do					# para cada campo...
		i=$((i+1))						# indice do campo
		echo -n "$campo:" | tr a-z A-Z					# nome do campo
		echo -e "\033[31,1m$dados\033[m" | cut -d $SEP -f $i			# conteudo do campo
	done
}


# Mostra o valor do campo numero $1 do registro de chave $2 (opcional)
pega_campo(){
	local chave=${2:-.*}
	grep -i "^$chave$SEP" "$BANCO" | cut -d $SEP -f $1
}

