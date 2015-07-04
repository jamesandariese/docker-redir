FROM busybox
#FROM debian:8
ADD start.sh /start.sh
#RUN apt-get update && apt-get install -y redir && rm -rf /var/lib/apt/lists

ENTRYPOINT ["/start.sh"]
