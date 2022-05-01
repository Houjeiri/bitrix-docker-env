FROM nginx:stable-alpine


ADD ./nginx/default.conf /etc/nginx/conf.d/default.conf
ADD ./nginx/certs /etc/nginx/certs/self-signed
COPY ./nginx/certs/mkcert_development_CA_184190932158314348491736270304619014522.crt /usr/local/share/ca-certificates
RUN update-ca-certificates
