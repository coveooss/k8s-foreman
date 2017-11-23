set -e

mkdir /prometheus && cd /prometheus
git clone -b custom https://github.com/tdegiacinto/prometheus-json-exporter.git
cd prometheus-json-exporter
./gow get .
./gow build -o json_exporter .