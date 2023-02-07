#!/bin/bash

#####################################
#                                   #
#       By Anderson Ribeiro         #
#  https://github.com/tumilander/   #
#                                   #
#####################################


if [ $UID -ne 0 ]; then
	echo -e "\e[1;31m\nVocê precisa ser root para executar este script!\e[0m"
    echo -e "\n"
	exit 1
fi
                                             
echo "                                                               ";
echo "   (               )                  (                        ";
echo "   )\    (      ( /(     (    (       )\          (            ";
echo " (((_)   )\ )   )\())   ))\   )(    (((_)    (    )(    \  )   ";
echo " )\___  (()/(  ((_)\   /((_) (()\   )\___    )\  (()\   /(/(   ";
echo "((/ __|  )(_)) | |(_) (_))    ((_) ((/ __|  ((_)  ((_) ((_)_\  ";
echo " | (__  | || | | '_ \ / -_)  | '_|  | (__  / _ \ | '_| | '_ \) ";
echo "  \___|  \_, | |_.__/ \___|  |_|     \___| \___/ |_|   | .__/  ";
echo "         |__/                                          |_|     ";
echo "                                                        | v.1.4"

echo -e "\033[05;31mBy Anderson\033[00;37m"
while true
do
    echo -e "\n"
    echo "Escolha uma opção:"
    echo -e "\n"
    echo "1" " - Escanear portas abertas                       " "|" "11 - Comando para Limpar pacotes desnecessários"
    echo "2" " - Instalar aplicativo/programa                  " "|" "12 - Consultar comandos Linux"
    echo "3" " - Desinstalar aplicativo/programa               " 
    echo "4" " - Realizar conexao SSH                          "
    echo "5" " - Verifica o status ativo/inativo do programa   "
    echo "6" " - Atualizar programas/pacotes                   "
    echo "7" " - Verificar sua rota a partir do destino        "
    echo "8" " - Verificar suas rotas internas                 "
    echo "9" " - Procurar aplicativo/programa                  "
    echo "10 - Help para verificar comandos Linux              " 
    echo -e "\n0" " - Sair                                     "
    echo -e "00 - Instalar e atualizar script                  "
    echo -e "\n"
    read opcao
   
    case $opcao in
        1)
            echo "Verificando sistema para port scan"
            sleep 2
            verificarnmap="$(whereis nmap | grep nmap | cut -d ":" -f 1)" 
            echo -e "Digite o endereço IP que deseja escanear:\n"
            read ip
                if [ $verificarnmap == nmap ];then
                    nmap -sS -F $ip | tail -n +5 | head -n -2
                else
                    apt-get install nmap -y
                    nmap -sS -F $ip | tail -n +5 | head -n -2
                fi
            ;;
        2)
            echo "Digite o aplicativo/programa que deseja instalar:"
            read programa
            apt-get install $programa
            echo -e "\e[1;32m\n\nAplicativo/programa Instalado!\e[0m"
            ;;
        3)
            echo "Digite o aplicativo/programa que deseja desinstalar:"
            read unistall
            apt remove $unistall
            apt autoremove
            echo -e "\e[1;32m\n\nAplicativo/Programa desinstalado!\e[0m"
            ;;
        4)
        echo "digite 1 para conexao com chave e 2 para sem"
        read ssh    
            if [ $ssh == 1 ]; then          
                echo "digite o usuario:"
                read usuario
                echo "digite o destino:"
                read destino
                echo "digite o caminho da chave:"
                read caminho
                ssh $usuario@$destino -i $caminho
            elif [ $ssh == 2 ]; then      
                echo "digite o usuario:"
                read usuario
                echo "digite o destino:"
                read destino
                echo "digite a senha:"
                read semchave
                ssh $usuario@$destino $semchave
            else
                echo "parametro nao encontrao"
            fi
            ;;
        5)
            echo "Digite o nome do programa"
            read sistema
            status="$(systemctl status $sistema | grep Active | cut -d ":" -f 2 | cut -d " " -f 2)"
            if [ $status == inactive ]; then
                echo -e "\e[1;31m\nO programa está $status\e[0m"
            else
                echo -e "\e[1;32m\nO programa está $status\e[0m"
            fi
            ;;
        6)
            echo "Atualizando pacotes e programas..."
            sleep 2
            com1="$(apt-get update -y && apt-get upgrade -y)"
            sleep 2
            echo  "Finalizando..."
            sleep 2
            echo -e "\e[1;32m\n\n\nPacotes e programas atualizados!!\e[0m"
            sleep 5
            ;;
        7)
            echo "Digite seu destino: ex. google.com"
            read route
            traceroute -I $route
            ;;
        8) 
            echo "Verifica suas rotas internas"
            route -n
            ;;
        9)
            echo "Procurar aplicativo/programa:"
            read procurar
            apt search $procurar
            ;;
        10)
            
            echo ""
            echo "ls - Comando para listar"
            echo "mv - comando para mover ou renomear arquivos"
            echo "cp - comando para copiar arquivos/pastas"
            echo "mkdir - comando usado para criar diretorio"
            echo "rm - deleta arquivos ou diretorios"
            echo "less - comando para visualizar arquivos e mover usando setas no teclado. Ex. less arquivo.txt"
            echo "whoami - mostra o username ativo"
            echo "diff - encontra a diferenca entre dois arquivos. Ex. diff arquivo1 arquivo2"
            echo "ps - comando para visualizar os processos ativos"
            echo "ifconfig - comando usado para visualizar as interfaces de rede"
            echo "useradd - comando usado para adicionar um novo usuario"
            echo "usermod - comand usado para modificar usuario existente"
            echo "pwd - comando usado para visualizar caminho da pasta atual"
            echo "mv - comando usado para mover e/ou renomear arquivos/diretorios"
            echo "touch - comando usado para criar arquivos em branco"
            echo "cp - comando usado para copiar arquivos/diretorios"
            echo "cd ..	Sobe um nível na árvore de diretórios."
            echo "ls -lh	Lista arquivos e diretórios com mais detalhes."
            echo "ls -a	Lista arquivos e diretórios, inclusive ocultos."
            echo "ls -d */	Lista apenas diretórios."
            echo "mkdir	Cria um diretório."
            echo "mkdir -p	Cria vários diretórios simultâneos."
            echo "rm	Remove um arquivo."
            echo "rm -r	Remove um diretório."
            echo "cp -r	Copia um diretório recursivamente."
            echo "mv	Move um arquivo/diretório ou renomeia. Se o caminho-destino for o mesmo local, irá renomear, se for diferente, irá mover."
            echo "pwd	Exibe o caminho completo até o diretório atual."
            echo "free -m	Mostra o uso (livre/usado) das memórias."
            echo "df -h	Mostra o espaço utilizado pelos dispositivos."
            echo "du -h	Mostra o espaço utilizado pelos arquivos."
            echo "cat /proc/cpuinfo	Informações do processador do computador."
            echo "cat /proc/meminfo	Informações da memória do computador."
            echo "cat /proc/partitions	Informações sobre discos e partições."
            echo "pstree -p	Mostra cada processo em execução, em forma de árvore, contendo o PID de cada processo."
            echo "lspci	Exibe informações dos dispositivos da máquina."
            echo "lsusb	Exibe informações dos dispositivos USB da máquina."
            echo "sensors	Exibe informações de temperatura da máquina, CPU, cooler, placa mãe…"
            echo "hddtemp /dev/[sh]d[a-z]	Exibe informações sobre temperatura dos dispositivos de armazenamento."
            echo "inxi -v7	Informações completas sobre o hardware da máquina."
            echo "who	Exibe os usuários logados, com sessão aberta no sistema."
            echo "iotop -Pak	Analisa a leitura e gravação dos discos."
            echo "cut -d: -f1 /etc/group	Exibe todos os grupos disponíveis no sistema."
            echo "date	Exibe e altera a data e a hora do sistema."
            echo "date -s	Altera a data e a hora do sistema por extenso."
            echo "date -r	Exibe a última data e hora de modificação de um arquivo."
            echo "touch	Modifica a data e hora de um arquivo."
            echo "touch -m arquivo	Altera a data e hora de modificação do arquivo."
            echo "free -m	Mostra o uso (livre/usado) das memórias."
            echo "df -h	Mostra o espaço utilizado pelos dispositivos."
            echo "du -h	Mostra o espaço utilizado pelos arquivos."
            echo "cat /proc/cpuinfo	Informações do processador do computador."
            echo "cat /proc/meminfo	Informações da memória do computador."
            echo "cat /proc/partitions	Informações sobre discos e partições."
            echo "pstree -p	Mostra cada processo em execução, em forma de árvore, contendo o PID de cada processo."
            echo "lspci	Exibe informações dos dispositivos da máquina."
            echo "lsusb	Exibe informações dos dispositivos USB da máquina."
            echo "sensors	Exibe informações de temperatura da máquina, CPU, cooler, placa mãe…"
            echo "hddtemp /dev/[sh]d[a-z]	Exibe informações sobre temperatura dos dispositivos de armazenamento."
            echo "inxi -v7	Informações completas sobre o hardware da máquina."
            echo "who	Exibe os usuários logados, com sessão aberta no sistema."
            echo "iotop -Pak	Analisa a leitura e gravação dos discos."
            echo "cut -d: -f1 /etc/group	Exibe todos os grupos disponíveis no sistema."
            echo "shutdown	Desliga a máquina."
            echo "shutdown -r	Reinicia a máquina. Use a palavra “now” para reiniciar imediatamente. Exemplo: shutdown -r now"
            echo "shutdown -h	Desliga a máquina. Use a palavra “now” para desligar imediatamente. Exemplo: shutdown -h now"
            echo "shutdown -c	Cancela a execução do shutdown. Apenas se não for usado a palavra “now”."
            echo "shutdown -h +30	Desliga o sistema em 30 minutos."
            echo "shutdown -r 04:37 "Prezados, o servidor será reiniciado em 1:30h min"	Reinicia o sistema na hora informada."
            echo "reboot	Reinicia o sistema."
            echo "adduser anderson	Cria o usuário "anderson"."
            echo "adduser anderson lp	Adiciona o usuário "anderson" ao grupo “lp”."
            echo "deluser –-remove-home bruno	Remove o usuário "anderson" e o seu diretório $\HOME."
            echo "chmod	Altera a permissão de um arquivo."
            echo "chmod -R	Altera a permissão de um arquivo ou diretório de forma recursiva."
            echo "chmod +x arquivo	Torna o “arquivo” executável."
            echo "mount	Monta um dispositivo."
            echo "umount	Desmonta um dispositivo."
            echo "umount -l	Desmonta um dispositivo mesmo que o mesmo esteja em uso;"
            echo "mount -o loop,ro arquivo.iso /mnt/	Monta uma imagem “.iso”."
            echo "mount -o remount,rw /	Remonta o diretório raiz em modo de leitura e gravação."
            echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
            echo "++++++++++++++++++++++++++++++++++++COMANDO POR ORDEM ALFABETICA++++++++++++++++++++++++++++++++++++++++++"
            echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
            echo ""
            echo -e "\e[1;32m\nComandos do Terminal Linux com a letra A\e[0m"
            echo ""
            echo "alias: cria um alias;"
            echo "apropos: busca ajuda na página do manual (man -k);"
            echo "apt-get: busca e instala pacotes de software (Debian/Ubuntu);"
            echo "aptitude: busca e instala pacotes de software (Debian/Ubuntu);"
            echo "aspell: verifica a ortografía;"
            echo "awk: encontra e substitui texto, ordena/valida/indexa bases de dados."
            echo ""
            echo -e "\e[1;32m\nComandos do Terminal Linux com a letra B\e[0m"
            echo ""
            echo "basename:  Exibe diretórios e base de arquivos;"
            echo "bash: GNU Bourne-Again SHell;"
            echo "bc: linguagem de cálculo de precisão arbitrária;"
            echo "bg: Enviar trabalho ou processo para o segundo plano;"
            echo "break: sair de um loop;"
            echo "builtin: Executar um shell integrado;"
            echo "bzip2: Comprimir ou descomprimir arquivo(s)."
            echo ""
            echo -e "\e[1;32m\nComandos do Terminal Linux com a letra C\e[0m"
            echo ""
            echo "cal: Mostrar um calendário;"
            echo "case: Executar um comando de forma condicionada;"
            echo "cat: Concatenar e exibir (na tela) o conteúdo de um ou mais arquivos;"
            echo "cd: Trocar de diretório;"
            echo "cfdisk: Gestor de Tabelas de Partição para Linux;"
            echo "chgrp: Alterar a associação de um grupo;"
            echo "chmod: Alterar permissões de acesso;"
            echo "chown: Alterar o dono e o grupo de um arquivo;"
            echo "chroot: Executar um comando com um diretório raiz diferente;"
            echo "chkconfig: Serviços do sistema (nível de execução);"
            echo "cksum: Imprimir o conteúdo da soma de verificação e do byte;"
            echo "clear: Limpar a tela do terminal;"
            echo "cmp: Comparar dois arquivos;"
            echo "comm: Comparar dois arquivos ordenados linha por linha;"
            echo "command: Execute um comando – ignorando as funções do shell;"
            echo "continue: Continue com a próxima interação de um ciclo ou loop;"
            echo "cp: Copia um ou mais arquivos para outro local ou rota;"
            echo "cron: daemon para executar comandos programados ou programados;"
            echo "crontab: Horário ou agendar a execução de um comando para um tempo específico;"
            echo "csplit: dividir um arquivo em partes determinadas pelo contexto;"
            echo "cut: dividir um arquivo em várias partes."
            echo ""
            echo -e "\e[1;32m\nComandos do Terminal Linux com a letra D\e[0m"
            echo ""
            echo "data: mostrar ou alterar a data e hora;"
            echo "dc: calculadora;"
            echo "dd: converter e copiar um arquivo, gravar em um dispositivo;"
            echo "ddrescue: Ferramenta de recuperação de dados;"
            echo "declare: declarar variáveis e atribuir atributos;"
            echo "df: Mostrar o espaço livre em disco;"
            echo "diff: Mostrar diferenças entre dois arquivos;"
            echo "diff3: Mostrar a diferença entre três arquivos;"
            echo "dig: DNS lookup;"
            echo "dir: lista de diretórios brevemente conteúdo;"
            echo "dircolors: Definir cores para 'ls';"
            echo "dirname: Converte um nome de caminho completo em apenas uma rota;"
            echo "dirs: mostra uma lista de diretórios acessados;"
            echo "dmesg: Imprime mensagens do kernel e drivers;"
            echo "du: Estima o espaço ocupado pelo arquivo."
            echo ""
            echo -e "\e[1;32m\nComandos do Terminal Linux com a letra E\e[0m"
            echo ""
            echo "echo: Exibe uma mensagem na tela;"
            echo "egrep: Pesquisa em arquivo(s) para as linhas que correspondem a uma expressão estendida;"
            echo "eject: Ejeta mídia removível;"
            echo "enable: Ativa e desativa comandos internos do shell;"
            echo "env: Variáveis de ambiente;"
            echo "ethtool: Configuração de interface Ethernet;"
            echo "eval: Avalia vários comandos/argumentos;"
            echo "exec: Executa um comando;"
            echo "exit: Sai do shell;"
            echo "expect: Automatiza aplicações arbitrárias acessadas através de um terminal;"
            echo "expand: Converter tabulações de caracteres para exportar espaços;"
            echo "export: Definir uma variável de ambiente;"
            echo "expr: Avaliar expressões."
            echo ""
            echo -e "\e[1;32m\nComandos do Terminal Linux com a letra F\e[0m"
            echo ""
            echo "false: sem sucesso, falsa;"
            echo "fdformat: formatação de baixo-nível para disquetes;"
            echo "fdisk: manipula partição de tabelas para Linux;"
            echo "fg: enviar trabalho ou processo para o primeiro plano;"
            echo "fgrep: pesquisa por linhas correspondem a uma seqüência de arquivo(s);"
            echo "file: determina o(s) tipo(s) de arquivo;"
            echo "find: encontra arquivos que correspondem a um critério desejado;"
            echo "fmt: reformatar um parágrafo de texto"
            echo "fold: cortar texto para ter uma largura específica."
            echo "for: expandir palavras e executar comandos"
            echo "format: formatar discos ou fitas"
            echo "free: mostra o uso da memória"
            echo "fsck: verifica e repara a consistência do sistema de arquivos"
            echo "FTP: protocolo de transferência de arquivos FTP"
            echo "function: define funções macros"
            echo "fuser: Identificar/Matar o processo que está acessando ou modificando um arquivo."
            echo ""
            echo -e "\e[1;32m\nComandos do Terminal Linux com a letra G\e[0m"
            echo ""
            echo "gawk: pesquisar e substituir texto em arquivo (s);"
            echo "getopts: analisa parâmetros de posições"
            echo "grep: pesquisa arquivos para linhas que correspondem ao padrão pesquisado"
            echo "groupadd: Adiciona um grupo de usuários"
            echo "groupdel: exclui um grupo"
            echo "groupmod: modificar um grupo"
            echo "groups: imprimir nome dos grupos que pertence a um usuário"
            echo "gzip: comprime ou descompacta os arquivos nomeados."
            echo ""
            echo -e "\e[1;32m\nComandos do Terminal Linux com a letra H\e[0m"
            echo ""
            echo "hash: recupera o caminho completo de um argumento"
            echo "head: exibe a primeira parte de um ou mais arquivos"
            echo "help: exibe a ajuda de um comando integrado ao sistema."
            echo "history: exibe o histórico dos comandos executados"
            echo "hostname: Imprime ou define o nome do sistema."
            echo ""
            echo -e "\e[1;32m\nComandos do Terminal Linux com a letra I\e[0m"
            echo ""
            echo "Iconv: converter caracteres de um arquivo"
            echo "id: imprimeos IDs de usuário e grupo"
            echo "if: executa um comando como condição"
            echo "ifconfig: configurar uma interface de rede"
            echo "ifdown: parar uma interface de rede"
            echo "ifup: iniciar uma interface de rede"
            echo "info: ler a informação documentos do sistema ou comandos"
            echo "import: capturar uma tela do servidor X e salvar a imagem em um arquivo"
            echo "install: copiar arquivos e definir atributos."
            echo ""
            echo -e "\e[1;32m\nComandos do Terminal Linux com a letra J\e[0m"
            echo ""
            echo "jobs: lista trabalhos ou processos ativos."
            echo "join: une linhas em um campo comum."
            echo ""
            echo -e "\e[1;32m\nComandos do Terminal Linux com a letra K\e[0m"
            echo ""
            echo "kill: interrompe um processo em execução"
            echo "killall: para processos por nome."
            echo ""
            echo -e "\e[1;32m\nComandos do Terminal Linux com a letra L\e[0m"
            echo ""
            echo "less: mostra parte de um arquivo na tela de forma interativa"
            echo "let: realiza contas em variáveis do shell."
            echo "ln: criar links simbólicos ou físicos entre arquivos"
            echo "local: crie variáveis."
            echo "locate:  buscar arquivos"
            echo "logname:  Imprime o nome da atribuição atual"
            echo "logout: sai de uma sessão do shell."
            echo "look: exibe as linhas que começam com uma determinada string"
            echo "lpc: programa de controle da linha de impressão"
            echo "lpr: impressão off-line"
            echo "lprint: imprime um arquivo"
            echo "lprintd: aborta um trabalho de impressão"
            echo "lprintq: listar a fila de impressão"
            echo "lprm: remover trabalhos da fila de impressão"
            echo "ls: listar informações sobre os arquivos"
            echo "lsof: listar os arquivos abertos."
            echo ""
            echo -e "\e[1;32m\nComandos do Terminal Linux com a letra M\e[0m"
            echo ""
            echo "make: recompilar um grupo de programas"
            echo "man: manual ou a ajuda de um comando"
            echo "mkdir: criar um diretório"
            echo "mkisofs: criar um sistema de arquivos híbridos ISO9660/Joliet/HFS"
            echo "mknod: criar um bloco ou um arquivo especial de caracteres"
            echo "more: exibe a saída em uma tela com pausas"
            echo "mount: montar um arquivo de sistema"
            echo "mtools:  manipular arquivos MS-DOS"
            echo "mtr: diagnosticar redes (traceroute/ping)"
            echo "mv: mover ou renomear arquivos, ou diretórios"
            echo "mmv: mover ou renomear arquivos, ou diretórios massivamente"
            echo ""
            echo -e "\e[1;32m\nComandos do Terminal Linux com a letra N\e[0m"
            echo ""
            echo "netstat: dar informações da rede"
            echo "nice: prioriza um comando ou processo"
            echo "nl: enumera as linhas (no início) de um arquivo"
            echo "nohup: executar um comando imune a bloqueios"
            echo "notify-send: enviar notificações de desktop"
            echo "nslookup: consulta de servidores, de nomes de domínio de forma interativa."
            echo ""
            echo -e "\e[1;32m\nComandos do Terminal Linux com a letra O\e[0m"
            echo ""
            echo "open: abre um arquivo com seu aplicativo padrão"
            echo "op: operador de acesso."
            echo ""
            echo -e "\e[1;32m\nComandos do Terminal Linux com a letra P\e[0m"
            echo ""
            echo "passwd: alterar a senha de um usuário"
            echo "paste: mesclar linhas de arquivo"
            echo "pathchk: ver disponibilidade de um nome de arquivo"
            echo "ping: teste a conexão de rede"
            echo "pkill: parar a execução de um processo"
            echo "popd: restaurar o valor anterior do diretório atual"
            echo "pr: preparar arquivos para impressão"
            echo "printcap: base de Dados da capacidade das impressoras"
            echo "printenv: imprimir variáveis de ambiente"
            echo "printf: formatar dados e imprimir."
            echo "ps: estado de processos no sistema"
            echo "pushd: grave e altere o diretório atual"
            echo "pwd: imprime o diretório atual."
            echo ""
            echo -e "\e[1;32m\nComandos do Terminal Linux com a letra Q\e[0m"
            echo ""
            echo "quota: mostrar limites e uso de disco"
            echo "quotacheck: verificar um sistema de arquivos para uso de disco"
            echo "quotactl: definir cotas de disco."
            echo ""
            echo -e "\e[1;32m\nComandos do Terminal Linux com a letra R\e[0m"
            echo ""
            echo "ram: criar um dispositivo de disco na memória"
            echo "rcp: copiar arquivos entre duas máquinas"
            echo "read: ler uma linha da entrada padrão."
            echo "readarray: Lê caminho padrão para um arranjo de tipo variável."
            echo "readonly: Marcar variáveis e funções como somente leitura"
            echo "reboot: reinicie o sistema"
            echo "rename: renomear arquivos"
            echo "renice: alterar a prioridade de execução de processos"
            echo "remsync: sincronizar arquivos remotos via e-mail"
            echo "return: sair de uma função shell"
            echo "rev: reverter as linhas de um arquivo"
            echo "rm: remove arquivo(s)"
            echo "rmdir: remover diretório(s)"
            echo "rsync: copiar arquivos local ou remotamente para sincronizar diretórios"
            echo ""
            echo -e "\e[1;32m\nComandos do Terminal Linux com a letra S\e[0m"
            echo ""
            echo "scp: copiar arquivos remotamente de forma segura (usando ssh)"
            echo "sdiff: mescla arquivos interativamente"
            echo "sed: editor de fluxo de caracteres para filtrar e formatar texto"
            echo "seq: imprime sequências numéricas"
            echo "set: manipular variáveis e funções Shell"
            echo "SFTP: protocolo  seguro de compartilhamento de arquivos (SFTP)"
            echo "shift: alterar os parâmetros de posição"
            echo "shopt: opções do Shell"
            echo "shutdown: desligar ou reiniciar o Linux"
            echo "sleep: delay por um tempo determinado"
            echo "slocate: localizar arquivos"
            echo "sort: escolher arquivos de texto"
            echo "source: executa um comando de um arquivo."
            echo "split: dividir um arquivo em partes de um determinado tamanho"
            echo "ssh: cliente SSH (Secure Client Shell) para chamar programas remotamente"
            echo "strace: rastrear chamadas de sistema ou sinalizados"
            echo "su: alterar o ID do usuário ou tornar-se superusuário (root)"
            echo "sudo: executa um comando como outro usuário"
            echo "sum: imprime a soma de verificação de um arquivo"
            echo "suspend:  suspende a execução do shell atual."
            echo "symlink: cria um novo nome para um arquivo"
            echo "sync: sincronizar dados em disco com memória."
            echo ""
            echo -e "\e[1;32m\nComandos do Terminal Linux com a letra T\e[0m"
            echo ""
            echo "tail: Mostra a última parte de um arquivo"
            echo "tar: Tape ARchiver – compacta e descompacta arquivos"
            echo "tee: redirecionar a saída a vários arquivos"
            echo "test: verifica tipos de arquivos e compara valores"
            echo "time: executa programas e resume o tempo e recursos ocupados"
            echo "times: obter hora do sistema (tempo) e do usuário"
            echo "touch: alterar a hora do registro de uso de um arquivo"
            echo "top: listar os processos em execução no sistema e os recursos utilizados"
            echo "traceroute: rastreia uma rota para um host"
            echo "tr: traduzir ou excluir caracteres"
            echo "true: nenhum efeito, valor verdadeiro, sucesso"
            echo "tsort: executa uma ordem topológica"
            echo "tty: imprime o nome do arquivo de entrada padrão de final stdin"
            echo "type: descreve um comando."
            echo ""
            echo -e "\e[1;32m\nComandos do Terminal Linux com a letra U\e[0m"
            echo ""
            echo "ulimit: limitar recursos do usuário."
            echo "umask: arquivos do usuário máscara de criação de"
            echo "umount: desmontar um dispositivo"
            echo "unalias: remove um alias."
            echo "uname: Imprimir informações do sistema"
            echo "unexpand: converte espaços personagens tablatura"
            echo "uniq: remove linhas duplicadas nos arquivos listados"
            echo "units: converte unidades de uma escala para outra"
            echo "unset: renova variáveis ou nomes de função"
            echo "unshar: descompacta arquivos de shell script"
            echo "until: executa comandos (para encontrar erro)"
            echo "uptime: mostra quanto tempo o sistema tem funcionado"
            echo "useradd: criar uma nova conta de usuário"
            echo "userdel: exclui uma conta de usuário"
            echo "usermod:  modifica uma conta de usuário"
            echo "users: lista usuários atualmente conectados ao sistema"
            echo "uuencode: codifica um arquivo binário"
            echo "uudecode: decodifica um arquivo binário."
            echo ""
            echo -e "\e[1;32m\nComandos do Terminal Linux com a letra V\e[0m"
            echo ""
            echo "vdir: lista estendida de conteúdo(s) do diretório ('ls -l -b ')"
            echo "vi: editor de texto"
            echo "vmstat: reportar estatísticas de memória virtual"
            echo ""
            echo -e "\e[1;32m\nComandos do Terminal Linux com a letra W\e[0m"
            echo ""
            echo "wait: esperar que um processo se complete"
            echo "watch: executar/exibir um programa periodicamente"
            echo "wc: imprime a contagem de bytes, palavras e linhas"
            echo "whatis: imprime descrições de página demanual."
            echo "whereis:  pesquisa no $/PATH nos manuais de comando e nos arquivos fontes de um programa"
            echo "which:  busca $/path do usuário por um arquivo de programa"
            echo "while: executar comandos"
            echo "who:  mostra todos os usuários conectados ao sistema"
            echo "whoami: mostra ID e nome de usuário  ('id -un')"
            echo "wget: baixar páginas da Web ou arquivos via HTTP, HTTPS ou FTP"
            echo "write: enviar uma mensagem para outro usuário."
            echo ""
            echo -e "\e[1;32m\nComandos do Terminal Linux com a letra X\e[0m"
            echo ""
            echo "xargs: utilidade de execução, passando lista (s) de argumentos"
            echo "xdg-open: abre um arquivo ou URL com o aplicativo preferido pelo usuário."
            echo ""
            echo -e "\e[1;32m\nComandos do Terminal Linux com a letra Y\e[0m"
            echo ""
            echo "yes: Imprima uma string “yes” até que seja interrompida."
            echo ""
            echo "Comando restirados da internet em sites como: https://sempreupdate.com.br/ | https://www.linuxpro.com.br/ | https://livrosdelinux.com.br/ | https://www.devmedia.com.br/ "

            ;;    
        11)
            echo "Realizando a limpeza..."
            com1="$(apt-get autoremove)"
            sleep 2
            echo "Removendo pacotes desnecessários..."
            com2="$(apt-get autoclean)"
            sleep 2
            echo "Removendo pacotes inutilizados..."
            sleep 2 
            echo "Finalizando..."
            com3="$(apt-get clean)"
            sleep 5
            ;;
        12)
            echo "Digite o comando que deseja saber informações: "
            read comando
            response="$(curl https://www.mankier.com/api/v2/mans/?q=$comando 2>/dev/null | cut -d ":" -f 7 | cut -d '"' -f 2)"
            echo -e "\n"
            echo "==================================================================="
            echo $response
            echo "==================================================================="
            echo -e "\n"
            ;;
        00)
            echo ""
            echo "********************************************************************************************************************"
            echo "Para Instalar pela primeira vez"
            echo "baixe o arquivo pelo comando git clone https://github.com/tumilander/cyberbasic.git"
            echo "entre na pasta criado: cd cyberbasic"
            echo "De permissões para executar: chmod +x cybercorp.sh"
            echo "execute o script: ./cybercorp"
            echo "********************************************************************************************************************"
            echo ""
            sleep 5
            echo -e "\e[1;31mLembre-se que apos rodar pela primeira vez, pode-se atualizar a partir de qualquer diretorio\n 
            digitando apenas cybercorp e opção 00\e[0m"
            sleep 5
            echo "Instalar e atualizar script"
            sleep 2
            echo "Baixando novas atualizações..."
            com0="$(whereis git | cut -d " " -f 2)"
            if [ com0 == /usr/bin/git ]; then
                com1="$(git clone https://github.com/tumilander/cyberbasic.git)"
                sleep 2
                #com2="$(cd ./cyberbasic/)"
                com3="$(chmod +x ./cyberbasic/cybercorp.sh)"
            else
                background="$(apt-get install git -y)"
                com1="$(git clone https://github.com/tumilander/cyberbasic.git)"
                sleep 5
                com2="$(chmod +x ./cyberbasic/cybercorp.sh)"
                sleep 1
                #com3="$(chmod +x ./cybercorp.sh)"
            fi
            echo "instalando..."
            sleep 2
            echo "copiando arquivos..."
            com4="$(cp ./cyberbasic/cybercorp.sh ./cyberbasic/cybercorp)"         
            com10="$(ls /usr/local/bin/ | grep cybercorp)"
            if [ com10 == cybercorp ]; then
                echo "Movendo arquivos"
                com5="$(mv ./cyberbasic/cybercorp /usr/local/bin/)"
            else 
                com9="$(rm -rf /usr/local/bin/cybercorp)"
                echo "Movendo arquivos"
                com5="$(mv ./cyberbasic/cybercorp /usr/local/bin/)"
            fi
            sleep 2
            echo "Arquivos movidos"
            com6="$(chmod +x /usr/local/bin/cybercorp)"
            #com7="$(cd ../)"
            com8="$(rm -rf ./cyberbasic/)"

            echo "Finalizado!!!"
            sleep 5
            echo "======================================================="
            echo "==Modo de uso: digite cybercorp independente do local=="
            echo "======================================================="
            echo -e "\e[1;31mPara que as atualizações tenham efeito\n
            digite 0 para sair e cybercorp para abrir novamente\e[0m"
            sleep 5
            ;;
        0)

            com0="$(whereis cowsay | cut -d " " -f 2)"
            com3="$(apt-get install apt-utils -y)"
            #com2="$(locate apt-utils | grep -A1 "apt-utils" | head -1)"
            if [ com0 == /usr/games/cowsay ]; then
                cowsay -f tux "Ja vai?! Desculpa te decepcionar, estou melhorando a cada dia!"
            else
                com1="$(apt-get install cowsay -y)"
                cowsay -f tux "Ja vai?! Desculpa te decepcionar, estou melhorando a cada dia!"
            fi
            echo -e "\n\n\nSaindo...Beep! Beep!"
            echo -e "\n"
            break
            ;;
        *)
            echo "Opção inválida!"
            ;;
    esac
done