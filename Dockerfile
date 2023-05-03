FROM alpine:3.8

EXPOSE 8080

RUN addgroup -S app && adduser -S -G app app

# Copy python requirements file
COPY requirements.txt /tmp/requirements.txt


RUN apk add --no-cache \
    alpine-sdk \
    python2 \
    python2-dev \
    libffi-dev \
    openssl-dev \
    gcc \
    make \
    g++ \
    nginx \
    uwsgi \
    uwsgi-python \
    supervisor && \
    python2 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip2 install --upgrade pip setuptools && \
    pip2 install -r /tmp/requirements.txt && \
    rm /etc/nginx/conf.d/default.conf && \
    rm -r /root/.cache

# Copy the Nginx global conf
COPY nginx.conf /etc/nginx/
# Copy the Flask Nginx site conf
COPY app-nginx.conf /etc/nginx/conf.d/
# Copy the base uWSGI ini file to enable default dynamic uwsgi process number
COPY uwsgi.ini /etc/uwsgi/
# Custom Supervisord config
COPY supervisord.conf /etc/supervisord.conf

ADD . /opt/app
RUN chown -R app /etc/nginx /etc/uwsgi /var/tmp /var/log/nginx /var/lib/nginx /opt/app
USER app
WORKDIR /opt/app

CMD ["/usr/bin/supervisord"]
