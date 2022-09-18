O programa bantex e um Gerenciador de Banco de Textual escrito 
em bash com intuito organização de formulário de usuarios:
 [Nome][cpf][telefone][endereço][outros]

O programa so funciona com um laço com 'source' do sistema e 
funciona o seguinte comandos:
	$> source Bantex.sh
Assim que que acionou o programa o sistema ja recomhece os seguinte
comandos
	$> insere_registro 1º_nome:nome_completo:cpf:telefone:endereço:outros
Quando for pesquisar por alguem no teu banco de dados é so digitar
o seguinte comando:
	$> mostra_registro 1º_nome
e para apagar qualquer registro do banco de dados e só digitar
o seguinte comando:
	$> apaga_registro 1º_nome

Algumas funções do programa são parte 
