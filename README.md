### Grupo
Carlos Andrade
Henrique Martins
Joao Costa

### Requisitos

- Docker
- Jenkins
- Nexus
- SonarQube
- Plugins de integracao do Nexus e SonarQube configurados no Jenkins.
- Configuracao do Maven e Java JDK no Jenkins.

### Como usar

- Fazer clone do repositorio para uma diretoria local.
- Criar os repositorios necessarios no nexus.
- Criar uma docker network e adicionar a essa rede os containers Jenkins, Nexus e SonarQube.
- Criar repositorio Raw e Docker no Nexus.
- Adicionar o projeto no SonarQube e gerar o respetivo token de acesso.
- Configurar no Jenkins as credenciais de acesso ao Nexus e SonarQube.
- Configurar o SonarQube scanner no Jenkins.
- Configurar o Jenkinsfile de acordo com as variaveis definidas no sistema:
	- nome e URL do Nexus e SonarQube servers.
	- Ports usados.
	- nome do SonarQube scanner.
	- Token de acesso ao SonarQube.
	- Diretorias dos repositorios.
- Criar o job pipeline e configurar o Pipeline Script from SCM de modo a buscar o Jenkinsfile presente no repositorio do GitHub.
- (Opcional) Configurar notification webhooks para o Teams se desejar receber notificacoes das builds.
- Fazer build do projeto com os parametros pretendidos.

###### No final devera ter um relatorio da analise do codigo no SonarQube, o ficheiro .jar do projeto no repositorio Docker e a imagem criada no repositorio Raw do Nexus.