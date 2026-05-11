
cat <<'EOF' > trino-server-477/etc/config.properties
coordinator=true
node-scheduler.include-coordinator=true
http-server.http.port=8080
discovery.uri=http://0.0.0.0:8080
node.environment=${env}
EOF

cat <<'EOF' > trino-server-477/etc/jvm.config
-server
-Xmx${trino_xmx}
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

cp -rp trino-server-477 trino-server-477-worker-1
cp -rp trino-server-477 trino-server-477-worker-2
cp -rp trino-server-477 trino-server-477-worker-3

cat <<'EOF' > trino-server-477-worker-1/etc/config.properties
coordinator=false
http-server.http.port=8081
discovery.uri=http://0.0.0.0:8080
node.environment=${env}
EOF

cat <<'EOF' > trino-server-477-worker-1/etc/jvm.config
-server
-Xmx${trino_xmx}
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

cat <<'EOF' > trino-server-477-worker-2/etc/config.properties
coordinator=false
http-server.http.port=8082
discovery.uri=http://0.0.0.0:8080
node.environment=${env}
EOF

cat <<'EOF' > trino-server-477-worker-2/etc/jvm.config
-server
-Xmx${trino_xmx}
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

cat <<'EOF' > trino-server-477-worker-3/etc/config.properties
coordinator=false
http-server.http.port=8083
discovery.uri=http://0.0.0.0:8080
node.environment=${env}
EOF

cat <<'EOF' > trino-server-477-worker-3/etc/jvm.config
-server
-Xmx${trino_xmx}
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

# kill old trino process if exists
sudo pkill -f 'trino'


./trino-server-477/bin/launcher start
./trino-server-477-worker-1/bin/launcher start
./trino-server-477-worker-2/bin/launcher start
./trino-server-477-worker-3/bin/launcher start