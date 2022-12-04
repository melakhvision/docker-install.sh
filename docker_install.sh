
#!/bin/bash
read -p " Do you want to install Docker ? : yes | no  :" dockerreply
read -p " Do you want to install Nginx ? : yes | no  :" Nginxreply


function dockerInstall() {
    #Update system & reboot
    sudo apt update && sudo apt -y upgrade

    # Install dependencies
    sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    # Install docker
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
    sudo apt update && sudo apt upgrade -y && sudo apt install docker-ce -y

    # Install Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo systemctl enable docker
}

function nginxInstall() {
    sudo apt update && sudo apt -y upgrade
    sudo apt install nginx -y
    systemctl enable nginx
    systemctl start nginx
    sudo apt-add-repository -r ppa:certbot/certbot
    sudo apt-get update
    sudo apt install certbot python3-certbot-nginx -y
}

if [ $dockerreply = "yes" ] || [ $dockerreply = "y" ]; then
    dockerInstall
elif [ $dockerreply = "no" ] || [ $dockerreply = "n" ]; then
    echo cancelling docker installation ....
fi

if [ $Nginxreply = "yes" ] || [ $Nginxreply = "y" ]; then
    nginxInstall
elif [ $Nginxreply = "no" ] || [ $Nginxreply = "n" ]; then
    echo cancelling Nginx installation ....
fi
