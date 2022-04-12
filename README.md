# Desafio 2 - Terraform & Linux = Construção de um infra com Servidor e Load Balancer com 3 servidores Apache

## Objetivos
1.  :white_check_mark: Criar uma VPC.
2.  :white_check_mark: Criar 3 subnets publicas em zonas de disponibilidades diferentes na VPC.
3.  :white_check_mark: Criar 3 subnets privadas, em zonas de disponibilidades diferentes na VPC.
4.  :white_check_mark: Criar 1 Internet Gateway para acesso da instância NGINX à internet.
5.  :white_check_mark: Criar 1 Nat Gateway para acesso da instância NGINX à internet (Lembrando que esse **não** é um recurso free-tier).
6.  :white_check_mark: Criar 2 Security Groups, sendo um para a instância nginx e outro para a instância apache.
7.  :white_check_mark: Instancias EC2 utilizando a AMI da amazon Linux, instalar o apache e liberar o acesso da seguinte forma:
    - :white_check_mark: Alterar o arquivo /var/www/html/index.html adicionando o texto  "Servidor Apache 1", e subir o serviço na porta 3001
    - :white_check_mark: Alterar o arquivo /var/www/html/index.html adicionando o texto  "Servidor Apache 2", e subir o serviço na porta 3002
    - :white_check_mark: Alterar o arquivo /var/www/html/index.html adicionando o texto  "Servidor Apache 3, e subir o serviço na porta 3003
    - :white_check_mark: Observações: As 3 instâncias devem ser deployadas uma em cada subrede privada com acesso a internet somente para instalação de pacotes. O apache não deve mostrar sua versão aos clientes através do nmap ou inspect via browser. Desabilitar a versão 1.0 http e Configurar no S.O. o tcp reuse e tcp port recycle (Que serve para reutilizar as portas TCP do kernel)
8. :white_check_mark: Uma Instância com Nginx em uma subrede pública, que será utilizada como LoadBalancer, conforme abaixo:
    - :white_check_mark: Acesso Full a internet e acesso as portas de serviço das EC2 com apache via Security Group.
    - :white_check_mark: Configurar o LoadBalancer no modo Random e acessivel via porta 8080.
    - :white_check_mark: Durante a apresentação, o acesso deve ser feito no ip público desta EC2 para validar o funcionamento do Balancer
9.  :white_check_mark: Criar um Bucket S3 sem acesso a internet para ser repositório do terraform.tfstate

## <b> Obrigatório! </b> <br>
    - :white_check_mark: As EC2 devem ser deployadas utilizando "count" através do módulo criado no último desafio
    - :white_check_mark: As subnets devem ser criadas utilizando "count" ou "for_each". 
    - :white_check_mark: Necessário ter outputs dos ips privados das 3 EC2 com apache e do ip público da EC2 com nginx
    - :white_check_mark: Utilizar dynamic block de um item de sua escolha da infraestrutura
    - :white_check_mark: Rodar tudo no computador pessoal, subir no GIT pessoal e montar uma apresentação final do seu código em funcionamento
<br>

## <b> Modo de apresentação: </b> <br>
- Mostrar o GIT, e rodar o terraform apply e mostrar a infra sendo provisionada na AWS e acessar o ip do balancer, demostrando o funcionamento.

## :newspaper: <span style="color:black"><b> Pré-Requisito: </b> </span>  
- :white_check_mark: Ter uma conta na AWS;
- :white_check_mark: Configurar terraform no PC;
- :white_check_mark: Ter/Criar uma Chave publica;

## <b> Estruturação dos arquivos </b> <br>   

- **Infra** - Criação dos recursos de EC2, configurações iniciais, Internet Gateway, Nat Gateway, outputs, security group, subnets, varíaveis e a criação da VPC.

- **bucket** - Nessa pasta há a criação do bucket s3 que servirá para armanezar o tfstate do projeto.

- **ec2_module** - Criação do módulo para provisionamento tanto do NGINX quanto do Apache

- **scripts** - Scripts shell de criação de servers com apache e proxy reverso com nginx

## <b> Como reproduzir o código: </b> <br>   

1. **Faça fork do [repositório](https://github.com/juliocesarleite/desafio-terraform2.git)**

2. **Baixe o código para o seu "vscode", conforme exemplo abaixo:**
   
   *Utilize o repositório do seu GIT*
    ```sh
    git clone https://github.com/juliocesarleite/desafio-terraform2.git
    ```
    
3.  **Crie seu Bucket S3 que servirá de respositório para o tfstate.**
    - 3.1 *Entre na pasta 'bucket'*
    ```sh
    cd ...Desafio-2/infra/bucket
    ```
    - 3.2 *Inicializando o ambiente*
    ```sh
    terraform init
    ```
    - 3.3  Montando o plano de criação do Bucket S3
    ```sh
    terraform plan
    ```
    - 3.4 Aplicando a criação do Bucket S3 com auto-aprove
    ```sh
    terraform apply -auto-approve
    ```
    
4.  **Após a criação do bucket S3, pegue na AWS o nome gerado para utilizar de parametro na alteração do arquivo remote_state.tf. Exemplo:**
    ```sh
    terraform {
        backend "s3" {
        bucket = "tfstate-97993711039x"
        key    = "state/terraform.tfstate"
        region = "us-east-1"
  }
}
    ```
5. **Altere o caminho da sua chave pública  que servirá de modelo para criação do key_pair das EC2.** 
   - *No arquivo /infra/ec2.tf*
    ```sh
    #Chave AWS
    resource "aws_key_pair" "my_key" {
        key_name = "aws_key"
        public_key = file(pathexpand("~/.ssh/id_rsa.pub"))
    }
    ```

## :memo: <span style="color:black"><b> Subindo a Infra na AWS </b> </span>    


1.  **Execute a criação dos recursos na pasta '/infra'**
    - 1.1 Inicializando o ambiente

    ```sh
    terraform init
    ```
    - 1.2  Montando o plano de criação dos recursos
    ```sh
    terraform plan
    ```
    - 1.3 Aplicando a criação dos recursos com auto-aprove
    ```sh
    terraform apply -auto-approve
    ```
2. **Por fim, não esquecer de destruir o ambiente, primeiro na pasta 'infra/' e depois na pasta 'infra/bucket'**
    ```sh
    terraform destroy
    ```