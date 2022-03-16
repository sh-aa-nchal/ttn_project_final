#!/bin/bash

#elasticsearch
curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt update -y
sudo apt install elasticsearch -y
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch.service
sudo systemctl start elasticsearch
sudo chown -R ubuntu:ubuntu /etc/elasticsearch
echo "http.port:9200" >> /etc/elasticsearch/elasticsearch.yml
sudo chown -R root:elasticsearch /etc/elasticsearch

#installing influxdb
echo "deb https://repos.influxdata.com/ubuntu focal stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
sudo curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
sudo apt-get update -y
sudo apt-get install influxdb -y
sudo systemctl enable --now influxdb
sudo systemctl start influxdb

#grafana
sudo apt update -y
sudo apt-get install -y gnupg2 curl software-properties-common
curl https://packages.grafana.com/gpg.key | sudo apt-key add -
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
sudo apt-get update -y
sudo apt-get -y install grafana
sudo systemctl enable --now grafana-server

#kibana
echo "deb http://packages.elastic.co/kibana/4.5/debian stable main" | sudo tee -a /etc/apt/sources.list.d/kibana-4.5.x.list
sudo apt-get update -y
sudo apt-get -y install kibana

