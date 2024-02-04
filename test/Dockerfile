# 使用CentOS官方镜像作为基础镜像
FROM centos:latest
 
# 安装Go语言编译器和标准库
ENV GO_VERSION 1.15.6
 
# 下载并安装Go
RUN curl -SLO "https://dl.google.com/go/go$GO_VERSION.linux-arm64.tar.gz" \
    && tar -C /usr/local -xzf "go$GO_VERSION.linux-arm64.tar.gz" \
    && rm "go$GO_VERSION.linux-arm64.tar.gz"
 
# 设置Go语言环境变量
ENV PATH="/usr/local/go/bin:${PATH}"
 
# 设置工作目录
WORKDIR /
 
# 复制源代码
COPY ./c-sleep-nosig.c ./
COPY ./c-sleep-sig.c ./
COPY ./go-sleep.go ./
COPY ./sleep.sh ./

# 编译Go代码
RUN go build -o /go-sleep.go
 
# 编译C代码（假设有一个名为myapp.c的C源文件）
RUN gcc /c-sleep-nosig.c -o /c-sleep-nosig
RUN gcc /c-sleep-sig.c -o /c-sleep-sig
 
# 设置容器启动时执行的命令
CMD ["/bin/bash"]
