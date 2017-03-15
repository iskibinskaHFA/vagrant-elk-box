# install Java
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
echo debconf shared/accepted-oracle-license-v1-1 select true | \
  sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | \
  sudo debconf-set-selections
sudo apt-get -y install oracle-java8-installer

# install ElasticSearch
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list
sudo apt-get update && sudo apt-get install elasticsearch

sudo echo "network.host: 0.0.0.0" >> /etc/elasticsearch/elasticsearch.yml

sudo iptables -I INPUT -p tcp --dport 9200 -j ACCEPT
sudo iptables-save

update-rc.d elasticsearch defaults 95 10
/etc/init.d/elasticsearch start

# install Kibana
wget https://download.elastic.co/kibana/kibana/kibana-4.3.1-linux-x64.tar.gz
gunzip kibana-4.3.1-linux-x64.tar.gz
tar -xvf kibana-4.3.1-linux-x64.tar
mkdir /opt/kibana
cp -Rrvf kibana-4.3.1-linux-x64/* /opt/kibana/
cd /etc/init.d/
wget https://gist.githubusercontent.com/thisismitch/8b15ac909aed214ad04a/raw/bce61d85643c2dcdfbc2728c55a41dab444dca20/kibana4
chmod +x /etc/init.d/kibana4

sudo iptables -I INPUT -p tcp --dport 5601 -j ACCEPT
sudo iptables-save

update-rc.d kibana4 defaults 96 9
/etc/init.d/kibana4 restart


# install logstash

echo 'deb http://packages.elasticsearch.org/logstash/2.0/debian stable main' | sudo tee /etc/apt/sources.list.d/logstash.list
sudo apt-get update
sudo apt-get install logstash



#install php 7
# remove php5 modules
sudo apt-get autoremove --purge php5-*
# add php-7.0 source list by [Ondřej Surý](https://github.com/oerdnj)
sudo add-apt-repository ppa:ondrej/php
# Update index
sudo apt-get update
# Install php7.0-fpm with needed extensions
sudo apt-get install php7.0-fpm php7.0-cli php7.0-common php7.0-json php7.0-opcache php7.0-mysql php7.0-phpdbg php7.0-mbstring php7.0-gd php7.0-imap php7.0-ldap php7.0-pgsql php7.0-pspell php7.0-recode php7.0-snmp php7.0-tidy php7.0-dev php7.0-intl php7.0-gd php7.0-curl php7.0-zip php7.0-xml