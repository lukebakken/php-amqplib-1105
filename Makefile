RMQ_VERSION ?= 3.12.2

.PHONY: clean
clean:
	git clean -xffd

rabbitmq.conf:
	sed -e 's|@@PWD@@|$(CURDIR)|' rabbitmq.conf.in > rabbitmq.conf
config: rabbitmq.conf

$(CURDIR)/tls-gen/basic/result/ca_certificate.pem:
	$(MAKE) -C tls-gen/basic CN=localhost
certs: $(CURDIR)/tls-gen/basic/result/ca_certificate.pem

.PHONY: start-rabbitmq
start-rabbitmq: config certs
	[ -f "$(CURDIR)/rabbitmq-server-generic-unix-$(RMQ_VERSION).tar.xz" ] || curl -LO https://github.com/rabbitmq/rabbitmq-server/releases/download/v$(RMQ_VERSION)/rabbitmq-server-generic-unix-$(RMQ_VERSION).tar.xz
	[ -d "$(CURDIR)/rabbitmq_server-$(RMQ_VERSION)" ] || tar xf "$(CURDIR)/rabbitmq-server-generic-unix-$(RMQ_VERSION).tar.xz"
	RABBITMQ_CONFIG_FILE="$(CURDIR)/rabbitmq.conf" "$(CURDIR)/rabbitmq_server-$(RMQ_VERSION)/sbin/rabbitmq-server" -detached
	sleep 10 && $(CURDIR)/rabbitmq_server-$(RMQ_VERSION)/sbin/rabbitmqctl await_startup

.PHONY: stop-rabbitmq
stop-rabbitmq:
	$(CURDIR)/rabbitmq_server-$(RMQ_VERSION)/sbin/rabbitmqctl shutdown

.PHONY: openssl-connect
openssl-connect:
	openssl s_client -connect localhost:5671 -no_tls1 -no_tls1_1 -CAfile "$(CURDIR)/tls-gen/basic/result/ca_certificate.pem"

.PHONY: run-aio-pika
run-aio-pika:
	cd $(CURDIR)/aio-pika && pipenv install --dev && pipenv run repro

.PHONY: run-php-repro
run-php-repro:
	cd $(CURDIR)/php-repro && composer install && php repro.php
