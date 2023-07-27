# php-amqplib-1105
https://github.com/php-amqplib/php-amqplib/discussions/1105#discussioncomment-6556838

# Reproduction Steps

## Start RabbitMQ

Note: this requires Erlang 26 to be in your `PATH`. If you do not have that
version available, adjust the `RMQ_VERSION` variable to a version of RabbitMQ
that supports your version of Erlang.

This `make` target will also generate X509 certs and create a `rabbitmq.conf` file.

```
make start-rabbitmq
```

## Test RabbitMQ TLS Port

```
make openssl-connect
```

## Run `aio-pika` repro program


```
make run-aio-pika-repro
```

## Run PHP repro program


```
make run-php-repro
```

## Stop RabbitMQ

```
make stop-rabbitmq
```
