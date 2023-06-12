#########################################################################
# © Ronan LE MEILLAT 2023
# released under the GPLv3 terms
#########################################################################
FROM php:8.2-apache
LABEL org.opencontainers.image.authors="ronan@highcanfly.club"
ENV VERSION 1.5.0-dev.3
ENV PORT 8888
ENV BASE_URL=http://localhost:8888
ENV LANGUAGE=english
ENV DEBUG=TRUE
ENV DB_HOST=mysql
ENV DB_NAME=easyappointments
ENV DB_USERNAME=root
ENV DB_PASSWORD=hellodocker
ENV GOOGLE_SYNC_FEATURE=FALSE
ENV GOOGLE_PRODUCT_NAME=""
ENV GOOGLE_CLIENT_ID=""
ENV GOOGLE_CLIENT_SECRET=""
ENV GOOGLE_API_KEY=""
ENV TZ="UTC"
WORKDIR /var/www/html
ADD https://github.com/alextselegidis/easyappointments/releases/download/${VERSION}/easyappointments-${VERSION}.zip /var/www/html
RUN apt update && apt install -y --no-install-recommends unzip default-mysql-client
RUN unzip -o /var/www/html/easyappointments-${VERSION}.zip && \
    rm easyappointments-${VERSION}.zip
RUN sed -i "s/Listen 80/Listen ${PORT}/" /etc/apache2/ports.conf
RUN docker-php-ext-install -j$(nproc) mysqli 
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod ugo+x /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
EXPOSE ${PORT}