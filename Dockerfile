FROM tifayuki/java:7
MAINTAINER Feng Honglin <hfeng@tutum.co>

RUN apt-get update && \
    apt-get install -y wget unzip pwgen expect && \
    wget download.java.net/glassfish/4.1/release/glassfish-4.1.zip && \
    unzip glassfish-4.1.zip -d /opt && \
    rm glassfish-4.1.zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV PATH /opt/glassfish4/bin:$PATH

ADD run.sh /run.sh
#ADD setup.sh /setup.sh
ADD change_admin_password.sh /change_admin_password.sh
ADD change_admin_password_func.sh /change_admin_password_func.sh
ADD enable_secure_admin.sh /enable_secure_admin.sh
RUN chmod +x /*.sh
RUN mkdir /home/war \
    mkdir /home/web
VOLUME /home
# 4848 (administration), 8080 (HTTP listener), 8181 (HTTPS listener)
EXPOSE 4848 8080 80 8181
CMD ["/run.sh"]
