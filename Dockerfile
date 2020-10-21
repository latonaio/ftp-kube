FROM ubuntu:18.04

RUN apt-get update && apt-get install -y vsftpd
EXPOSE 21
EXPOSE 40000

ARG FTP_USERNAME=toyota
ARG FTP_PASSWORD=Toyota2019!
RUN useradd -m ${FTP_USERNAME}
RUN echo ${FTP_USERNAME}:${FTP_PASSWORD} | chpasswd
RUN gpasswd -a ${FTP_USERNAME} sudo

#COPY vsftpd.conf /etc/vsftpd/
COPY run.sh  /usr/local/bin/
RUN mkdir -p /var/run/vsftpd/empty
RUN chmod 755 /usr/local/bin/run.sh

ENTRYPOINT ["/usr/local/bin/run.sh"]
