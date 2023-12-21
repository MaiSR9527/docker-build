#!/usr/bin/env bash

checkVersion() {
    echo "Version = $1"
	echo $1 |grep -E "^[0-9]+\.[0-9]+\.[0-9]+" > /dev/null
    if [ $? = 0 ]; then
        return 1
    fi

	echo "Version $1 illegal, it should be X.X.X format(e.g. 2.3.0), please check released versions in 'https://seatunnel.apache.org/download/'"
    exit -1
}

SEATUNNEL_VERSION=$1

checkVersion $SEATUNNEL_VERSION

wget https://archive.apache.org/dist/seatunnel/${SEATUNNEL_VERSION}/apache-seatunnel-${SEATUNNEL_VERSION}-bin.tar.gz
wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.30/mysql-connector-java-8.0.30.jar
tar -xzvf apache-seatunnel-${SEATUNNEL_VERSION}-bin.tar.gz && rm -f apache-seatunnel-${SEATUNNEL_VERSION}-bin.tar.gz
# 需要进入到seatunnel目录里执行
cd apache-seatunnel-${SEATUNNEL_VERSION} && mkdir logs
# 注意一定要修改 config 目录下的 plugin_config，默认是会有很多connector，导致安装很慢因为要下载很多jar包
cat>config/plugin_config<<EOF
--connectors-v2--
connector-assert
connector-cdc-mysql
connector-jdbc
connector-redis
connector-socket
--end--
EOF

sh bin/install-plugin.sh ${SEATUNNEL_VERSION}
# Dockerfile放在seatunnel目录同一级
cd ../
mv mysql-connector-java-8.0.30.jar apache-seatunnel-${SEATUNNEL_VERSION}/lib
# Build image
docker build --no-cache -t apache/seatunnel:${SEATUNNEL_VERSION} --build-arg version=${SEATUNNEL_VERSION} .
