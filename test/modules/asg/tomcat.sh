#!bin/bash

sudo apt-get update -y
sudo apt-get install default-jdk -y


##Installing tomcat
sudo groupadd tomcat
sudo useradd -g tomcat -d /opt/tomcat tomcat
cd /tmp
curl -O https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.59/bin/apache-tomcat-9.0.59.tar.gz
sudo mkdir /opt/tomcat
sudo tar xzvf apache-tomcat-9*tar.gz -C /opt/tomcat --strip-components=1
cd /opt/tomcat
sudo chown -RH tomcat: /opt/tomcat
sudo chmod -R g+r conf
sudo chmod g+x conf
sudo chown -R tomcat webapps/ work/ temp/ logs/

##creating syatemd file
sudo touch tomcat.service
    sudo chmod 777 tomcat.service
    echo "[Unit]" > tomcat.service
    echo "Description=Apache Tomcat Web Application Container" >> tomcat.service
    echo "After=network.target" >> tomcat.service

    echo "[Service]" >> tomcat.service
    echo "Type=forking" >> tomcat.service

    echo "Environment=JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64" >> tomcat.service
    echo "Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid" >> tomcat.service
    echo "Environment=CATALINA_HOME=/opt/tomcat" >> tomcat.service
    echo "Environment=CATALINA_BASE=/opt/tomcat" >> tomcat.service
    echo "Environment=CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC" >> tomcat.service
    echo "Environment=JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom" >> tomcat.service

    echo "ExecStart=/opt/tomcat/bin/startup.sh" >> tomcat.service
    echo "ExecStop=/opt/tomcat/bin/shutdown.sh" >> tomcat.service

    echo "User=tomcat" >> tomcat.service
    echo "Group=tomcat" >> tomcat.service
    echo "UMask=0007" >> tomcat.service
    echo "RestartSec=10" >> tomcat.service
    echo "Restart=always" >> tomcat.service

    echo "[Install]" >> tomcat.service
    echo "WantedBy=multi-user.target" >> tomcat.service

    sudo mv tomcat.service /etc/systemd/system/tomcat.service
    sudo chmod 755 /etc/systemd/system/tomcat.service
sudo systemctl daemon-reload
sudo systemctl start tomcat

##maven application
git clone https://github.com/khoubyari/spring-boot-rest-example.git
sudo apt install maven -y
mvn clean package


##telegraf installation and configuration
wget -qO- https://repos.influxdata.com/influxdb.key | sudo apt-key add -
source /etc/lsb-release
echo "deb https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
sudo apt update
sudo apt install telegraf
sudo systemctl enable --now telegraf

wget -qO- https://repos.influxdata.com/influxdb.key | sudo apt-key add -
source /etc/lsb-release
echo "deb https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
sudo apt update
sudo apt install telegraf
sudo systemctl enable --now telegraf
#sudo mv /etc/telegraf/telegraf.conf /etc/telegraf/telegraf.conf.backup
cd /etc
sudo chown -R ubuntu:ubuntu telegraf
cd telegraf
touch telegraf.conf
echo "[global_tags]" > telegraf.conf
echo "[agent]" >> telegraf.conf
echo '  interval = "10s"'>> telegraf.conf
echo "  round_interval = true" >> telegraf.conf
echo "  metric_batch_size = 1000" >> telegraf.conf
echo "  metric_buffer_limit = 10000 " >> telegraf.conf
echo '  collection_jitter = "0s"' >> telegraf.conf
echo '  flush_interval = "10s"' >> telegraf.conf
echo '  flush_jitter = "10s"' >> telegraf.conf
echo '  precision = ""' >> telegraf.conf
echo '  hostname = ""' >> telegraf.conf
echo '  omit_hostname = "false"' >> telegraf.conf
echo "[[outputs.influxdb]]" >> telegraf.conf
echo '  urls = ["http:// 10.0.3.2:8086"]' >> telegraf.conf
echo '  database = "telegraf"' >> telegraf.conf
echo '  username = "telegraf"' >> telegraf.conf
echo '  password = "influxpass"' >> telegraf.conf
echo "[[inputs.tomcat]]" >> telegraf.conf
echo '  url = "http://127.0.0.1:8080/manager/status/all?XML=true"' >> telegraf.conf
echo '  username = "tomcat"' >> telegraf.conf
echo '  password = "password"' >> telegraf.conf
echo "[[inputs.system]]" >> telegraf.conf
echo "[[inputs.cpu]]" >> telegraf.conf
echo "  percpu = true" >> telegraf.conf
echo "  totalcpu = true" >> telegraf.conf
echo "  collect_cpu_time = false" >> telegraf.conf
echo "  report_active = false" >> telegraf.conf

sudo systemctl restart telegraf


