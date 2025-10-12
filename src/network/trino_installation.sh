
mkdir trino
cd trino/
wget https://download.java.net/java/GA/jdk24.0.2/fdc5d0102fe0414db21410ad5834341f/12/GPL/openjdk-24.0.2_linux-x64_bin.tar.gz
wget https://github.com/trinodb/trino/releases/download/477/trino-server-477.tar.gz
wget https://s3.us-east-2.amazonaws.com/software.starburstdata.net/476e/476-e.1/trino-cli-476-e.1-executable.jar

sudo mkdir -p /usr/lib/jvm

tar -zxvf openjdk-24.0.2_linux-x64_bin.tar.gz -C /usr/lib/jvm/

sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-24.0.2/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-24.0.2/bin/javac 1
sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk-24.0.2/bin/jar 1

tar -zxvf trino-server-477.tar.gz
pwd
#chmod 777 -R starburst-enterprise-476-e.1-x86_64/
mkdir -p trino-server-477/etc

cat <<'EOF' > trino-server-477/etc/config.properties
coordinator=true
node-scheduler.include-coordinator=true
http-server.http.port=8080
discovery.uri=http://0.0.0.0:8080
node.environment=dev
EOF
cat <<'EOF' > trino-server-477/etc/jvm.config
-server
-Xmx4G
-XX:InitialRAMPercentage=80
-XX:MaxRAMPercentage=80
-XX:G1HeapRegionSize=32M
-XX:+ExplicitGCInvokesConcurrent
-XX:+ExitOnOutOfMemoryError
-XX:+HeapDumpOnOutOfMemoryError
-XX:-OmitStackTraceInFastThrow
-XX:ReservedCodeCacheSize=512M
-XX:PerMethodRecompilationCutoff=10000
-XX:PerBytecodeRecompilationCutoff=10000
-Djdk.attach.allowAttachSelf=true
-Djdk.nio.maxCachedBufferSize=2000000
-Dfile.encoding=UTF-8
# Allow loading dynamic agent used by JOL
-XX:+EnableDynamicAgentLoading
EOF

