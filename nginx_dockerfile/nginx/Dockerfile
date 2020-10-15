FROM centos:6.9

MAINTAINER vfast
ENV TIME_ZONE Asia/Shanghai
COPY ./nginx-1.9.0.tar.gz /usr/src
RUN echo "192.168.10.140 vfast.registry.com" >>/etc/hosts
RUN curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-6.repo
RUN yum -y install gcc pcre pcre-devel zlib zlib-devel openssl-devel

RUN tar zxf /usr/src/nginx-1.9.0.tar.gz -C /usr/src/ && rm -rf /usr/src/nginx-1.9.0.tar.gz

RUN echo "${TIME_ZONE}" > /etc/timezone && ln -sf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime


WORKDIR /usr/src/nginx-1.9.0

RUN /usr/src/nginx-1.9.0/configure \
--prefix=/usr/local/nginx \
--with-http_stub_status_module \
--with-http_realip_module \
--with-pcre \
--with-http_ssl_module \
--with-stream
RUN make && make install
COPY ./nginx.conf /usr/local/nginx/conf
RUN mkdir /usr/local/nginx/conf/vhosts
COPY ./vfast.registry.com.conf /usr/local/nginx/conf/vhosts
COPY ./htpasswd /usr/local/nginx/conf
COPY ./server.crt /usr/local/nginx/conf
COPY ./server.key /usr/local/nginx/conf
WORKDIR /usr/local/nginx
ENV PATH /usr/local/nginx/sbin:$PATH
RUN rm -rf /usr/src/nginx-1.9.0
EXPOSE 80
EXPOSE 443
ENTRYPOINT ["nginx"]
CMD ["-g","daemon off;"]
