
mkdir trino
cd trino/
wget https://download.java.net/java/GA/jdk24.0.2/fdc5d0102fe0414db21410ad5834341f/12/GPL/openjdk-24.0.2_linux-x64_bin.tar.gz
wget https://github.com/trinodb/trino/releases/download/477/trino-server-477.tar.gz
wget https://github.com/trinodb/trino/releases/download/477/trino-cli-477

sudo mv trino-cli-477 trinocli
sudo chmod +x trinocli
sudo mkdir -p /usr/lib/jvm

tar -zxvf openjdk-24.0.2_linux-x64_bin.tar.gz -C /usr/lib/jvm/

sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-24.0.2/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-24.0.2/bin/javac 1
sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk-24.0.2/bin/jar 1

tar -zxvf trino-server-477.tar.gz
pwd
