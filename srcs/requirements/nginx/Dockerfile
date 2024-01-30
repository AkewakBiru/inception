FROM debian:bullseye

#SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ARG UID=101 GID=101

RUN set -eu; apt-get update \
	&& apt-get install -y nginx openssl procps \
	&& groupadd --system --gid $GID nginx \
	&& useradd --system --uid $UID nginx --gid nginx --no-create-home \
		--home /nonexistent --shell /usr/sbin/nologin \
	&& mkdir -p /etc/nginx/ssl \
	&& touch /run/nginx.pid \
	&& openssl req -x509 -nodes -out /etc/nginx/ssl/abiru.42.fr.crt -keyout \
		/etc/nginx/ssl/abiru.42.fr.key -subj "/CN=login.42.fr/C=AE/L=Abu Dhabi" \
	&& chown -R nginx:nginx /etc/nginx \
				/var/lib/nginx/ \
				/run/nginx.pid \
				/var/log/nginx/ \
	&& chmod 600 /etc/nginx/ssl/abiru.42.fr.crt \
			/etc/nginx/ssl/abiru.42.fr.key \
	&& chmod -R 755 /var/lib/nginx/ \
			/var/log/nginx/ \
	&& apt-get remove --purge --auto-remove -y openssl \ 
	&& rm -rf /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/

EXPOSE 80 443

USER $UID

ENTRYPOINT ["nginx", "-g", "daemon off;"]
