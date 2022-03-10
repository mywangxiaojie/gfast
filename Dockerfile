FROM golang:1.16 as go-compile
LABEL author="auth(auth@mail.com)"

ENV WORKDIR=/root/go/src \
    GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64 \
	GOPROXY="https://goproxy.cn,direct"
ADD . .

RUN export GOPATH=/root/go \
    && go mod download \
    && go build -o /usr/bin/gfast_server
    # && rm -rf /root/go

FROM loads/alpine:3.8

LABEL maintainer="john@goframe.org"
###############################################################################
#                                INSTALLATION
###############################################################################

# 设置固定的项目路径
ENV WORKDIR /var/www/server
# 添加应用可执行文件，并设置执行权限
COPY --from=go-compile /usr/bin/qrcode_platform /var/www/server/gfast_server

# 添加I18N多语言文件、静态文件、配置文件、模板文件
ADD public   $WORKDIR/public
# ADD config   $WORKDIR/config
ADD template $WORKDIR/template
ADD document $WORKDIR/document

# 使用国内alpine源
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
  && apk update \
  && apk add tzdata ca-certificates bash \
  && rm -rf /etc/localtime \
  && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && echo "Asia/Shanghai" > /etc/timezone \
  && chmod +x $WORKDIR/gfast_server

###############################################################################
#                                   START
###############################################################################
WORKDIR $WORKDIR
CMD ./gfast_server