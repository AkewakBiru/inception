FROM debian:bullseye

RUN set -eu; apt-get update \
	&& apt-get install -y curl iputils-ping mariadb-client

CMD ["tail", "-f"]