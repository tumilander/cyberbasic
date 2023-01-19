#!/bin/bash

#####################################
#                                   #
#       By Anderson Ribeiro         #
#   https://github.com/tumilander/  #
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
echo "                                                        | v.1.2"

echo -e "\033[05;31mBy Anderson\033[00;37m"
while true
do
    echo -e "\n"
    echo "Escolha uma opção:"
    echo -e "\n"
    echo "1" " - Escanear portas abertas                       " "|" "11 - Comando para Limpar pacotes desnecessários"
    echo "2" " - Instalar aplicativo/programa                  " 
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
        00)
            echo -e "\e[1;31mLembre-se que para instalar e/ou atualizar, deve-se estar no mesmo diretorio do arquivo baixado\e[0m"
            sleep 5
            echo "Instalar e atualizar script"
            sleep 2
            echo "Baixando novas atualizações..."
            com0="$(whereis git | cut -d " " -f 2)"
            if [ com0 == /usr/bin/git ]; then
                com1="$(git clone https://github.com/tumilander/cyberbasic.git)"
                sleep 2
                com2="$(cd ./cyberbasic/)"
                com3="$(chmod +x ./cybercorp.sh)"
            else
                background="$(apt-get install git -y)"
                com1="$(git clone https://github.com/tumilander/cyberbasic.git)"
                sleep 5
                com2="$(cd ./cyberbasic/)"
                sleep 1
                com3="$(chmod +x ./cybercorp.sh)"
            fi
            echo "instalando..."
            sleep 2
            echo "copiando arquivos..."
            com4="$(cp ./cybercorp.sh ./cybercorp)"         
            com10="$(ls /usr/local/bin/ | grep cybercorp)"
            if [ com10 == cybercorp ]; then
                echo "Movendo arquivos"
                com5="$(mv ./cybercorp /usr/local/bin/)"
            else 
                com9="$(rm -rf /usr/local/bin/cybercorp)"
                echo "Movendo arquivos"
                com5="$(mv ./cybercorp /usr/local/bin/)"
            fi
            sleep 2
            echo "Arquivos movidos"
            com6="$(chmod +x /usr/local/bin/cybercorp)"
            com7="$(cd ..)"
            com8="$(rm -rf ./cyberbasic/)"

            echo "Finalizado!!!"
            sleep 5
            echo "======================================================="
            echo "==Modo de uso: digite cybercorp independente do local=="
            echo "======================================================="
            sleep 5
            ;;
        0)
            echo -e "\n\n\nSaindo...Beep! Beep!"
            break
            ;;
        *)
            echo "Opção inválida!"
            ;;
    esac
done