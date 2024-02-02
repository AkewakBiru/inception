FROM debian:bullseye

ARG CERTS_KEY CERTS_CRT

RUN set -eu; \
	apt-get update \
	&& apt-get install -y nginx procps \
	&& mkdir -p /etc/nginx/ssl \
	&& touch /run/nginx.pid \
	&& echo "${CERTS_CRT}" > /etc/nginx/ssl/abiru.42.fr.crt \
	&& echo "${CERTS_KEY}" > /etc/nginx/ssl/abiru.42.fr.key \
	&& chown -R www-data:www-data /etc/nginx \
				/var/lib/nginx/ \
				/run/nginx.pid \
				/var/log/nginx/ \
	&& chmod 600 /etc/nginx/ssl/abiru.42.fr.crt \
				/etc/nginx/ssl/abiru.42.fr.key \
	&& chmod -R 755 /var/lib/nginx/ \
			/var/log/nginx/ \
	&& rm -rf /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/

EXPOSE 443

USER www-data

CMD ["nginx", "-g", "daemon off;"]
