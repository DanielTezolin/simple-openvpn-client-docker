# simple-openvpn-client-docker
A simple openvpn client inside a docker container

# Motivation
Eu estava buscando uma maneira de conectar uma nuvem à outra via VPN, mas não queria instalar nada na máquina host. Acho mais fácil gerenciar todos os softwares instalados via Docker. 

Estava procurando um projeto que proporcionasse uma experiência semelhante ao webui do OpenVPN para inicializar uma conexão VPN, onde eu só precisasse fazer o upload de um arquivo ovpn e inserir a senha. 
No entanto, tudo que eu encontrava tinha várias configurações e flags verbosas. Então, decidi criar um contêiner Docker que simplesmente receba um arquivo ovpn e estabeleça a conexão.

I was looking for a way to connect one cloud to another via VPN, but I didn't want to install anything on the host machine. I find it easier to manage all installed software via Docker.

I was looking for a project that would provide a similar experience to the webui of OpenVPN to initiate a VPN connection, where I would only need to upload an ovpn file and enter the password.
However, everything I found had various configurations and verbose flags. So, I decided to create a Docker container that simply takes an ovpn file and establishes the connection.

# How to use

Utilize o modelo docker-compose para simplificar as tarefas

Use the docker-compose model to simplify tasks.
```yml
version: '2'
services:
  openvpn:
    cap_add:
     - NET_ADMIN
    image: danieltezolin/simple-openvpn-client
    container_name: simple-openvpn
    environment:
     - PROFILE=your_profile
    devices:
      - /dev/net/tun
    volumes:
     - ./openvpn-data:/etc/openvpn

```
Para instalar o seu primeiro perfil, é necessário executar um comando separado antes.

To install your first profile, it is necessary to run a command beforehand.
```shell
$ docker-compose run openvpn create_ovpn_profile --user user --pass pass --profile-name user-profile < /path/to/config.ovpn
```
Agora você pode iniciar o servidor para conectar seu VPN, mas lembre-se de especificar a variável `PROFILE` com um perfil que você criou anteriormente para que funcione corretamente.

Now you can start the server to connect your VPN, but remember to specify the `PROFILE` variable with a profile that you created earlier for it to work properly.
```shell
$ docker-compose up -d
```