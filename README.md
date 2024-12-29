# Projeto Terraform: VPC com Subnets e EC2 para Aplicação Web e MongoDB

Este projeto utiliza **Terraform** para provisionar recursos na AWS. O objetivo é criar uma infraestrutura básica com uma VPC, subnets pública e privada, e duas máquinas EC2. Uma das máquinas EC2 hospeda uma aplicação web acessível pela internet, enquanto a outra é utilizada como banco de dados MongoDB acessível apenas pela instância da aplicação web.

## Recursos Criados

1. **VPC**:
   - Provisão de uma Virtual Private Cloud (VPC) para isolar a infraestrutura.

2. **Subnets**:
   - Uma subnet pública para a aplicação web.
   - Uma subnet privada para o banco de dados MongoDB.

3. **Instâncias EC2**:
   - Uma instância EC2 na subnet pública com IP público para hospedar a aplicação web.
   - Uma instância EC2 na subnet privada para hospedar o MongoDB, acessível apenas pela instância da aplicação web.

4. **Regras de Segurança (Network Acls)**:
   - Permitir acessos mais abrangentes nas subnets que conterão as máquinas EC2.

5. **Regras de Segurança (Security Groups)**:
   - Permitir acesso HTTP/HTTPS e SSH na instância da aplicação web.
   - Permitir apenas comunicação entre as duas instâncias (web e MongoDB) na porta do MongoDB.

## Pré-requisitos

- **Conta AWS** com permissões para criar os recursos mencionados.
- Configuração da **AWS CLI** com as credenciais adequadas:
  ```bash
  aws configure
  ```
  Insira o `AWS Access Key ID` e o `AWS Secret Access Key` durante a configuração.

- Instale o **Terraform** em sua máquina local. Consulte [a documentação oficial](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) para instruções de instalação.

## Estrutura do Projeto

```
├── main.tf             # Configuração principal do Terraform
├── variables.tf        # Variáveis utilizadas no projeto
├── ec2.tf              # Definição das máquinas EC2
├── security.tf         # Definição das regras de segurança das máquinas EC2 e das Subnets
├── vpc.tf              # Definição da vpc e das subnets do projeto
├── README.md           # Documentação do projeto
```

## Como Usar

### Inicializar o Terraform

1. Clone este repositório em sua máquina local.
2. No diretório do projeto, inicialize o Terraform:
   ```bash
   terraform init
   ```

### Planejar o Ambiente

3. Revise as mudanças planejadas:
   ```bash
   terraform plan
   ```

### Aplicar o Projeto

4. Crie os recursos na AWS:
   ```bash
   terraform apply
   ```
   Confirme digitando `yes` quando solicitado.

Após a conclusão, o Terraform exibirá as informações sobre os recursos criados, como o endereço IP público da instância da aplicação web e o ip privado da máquina do mongodb.

### Destruir o Ambiente

5. Para remover todos os recursos criados pelo projeto:
   ```bash
   terraform destroy
   ```
   Confirme digitando `yes` quando solicitado.

## Notas Importantes

- A máquina EC2 da aplicação web possui um IP público, garantindo que a aplicação seja acessível pela internet.
- A máquina EC2 do MongoDB não é acessível diretamente pela internet. Ela é configurada para aceitar conexões apenas da máquina que hospeda a aplicação web.
- Certifique-se de proteger as credenciais da AWS e nunca as adicione ao controle de versão.

## Execução da Aplicação e do MongoDB

Tanto a aplicação web quanto o banco de dados MongoDB precisam ser executados dentro de containers Docker nas respectivas máquinas EC2. O Docker já foi instalado automaticamente nas máquinas EC2 durante sua criação, utilizando o script `instalacao-docker.sh` configurado no **user data**.

### Passos para execução

1. **Acesse as máquinas EC2 via SSH** utilizando o par de chaves criado (vale destacar que para acessar a máquina da aplicação web, podemos fazer pelo ip público da mesma, todavia, a máquina do banco de dados, só pode ser acessada via ssh de dentro da máquina da aplicação web):
   ```bash
   ssh -i "chave.pem" ubuntu@<ENDEREÇO_IP>
   ```

2. **Na máquina da aplicação web**, execute o seguinte comando para iniciar o container:
   ```bash
   sudo docker container run -p 80:5000 -e MONGODB_HOST=[IP_HOST_MONGODB] -e MONGODB_USERNAME=mongouser -e MONGODB_PASSWORD=mongopwd -d fabricioveronez/rotten-potatoes:v1
   ```

3. **Na máquina do banco de dados MongoDB**, execute o seguinte comando para iniciar o container:
   ```bash
   sudo docker container run -d -p 27017:27017 -e MONGO_INITDB_ROOT_USERNAME=mongouser -e MONGO_INITDB_ROOT_PASSWORD=mongopwd mongo
   ```

Certifique-se de que os containers estejam funcionando corretamente antes de acessar a aplicação web.  Para acessar a aplicação web, basta digitar o ip público em um browser de sua preferência.

## Melhorias Futuras

- Configurar balanceamento de carga para a aplicação web.
- Implementar alta disponibilidade para o banco de dados MongoDB.
- Adicionar automação de backups para o MongoDB.


