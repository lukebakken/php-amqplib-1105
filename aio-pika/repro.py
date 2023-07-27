async def tlspub() -> None:
    # Perform connection
    constr = "amqps://principal:principal@localhost:5671/?no_verify_ssl=1"
    connection = await connect(constr)

    async with connection:
        # Creating a channel
        channel = await connection.channel()

        logs_exchange = await channel.declare_exchange(
            "transaction", ExchangeType.FANOUT, durable=True
        )

        message_body = (
            b" ".join(arg.encode() for arg in sys.argv[2:]) or b"Hello World!"
        )

        message = Message(
            message_body,
            delivery_mode=DeliveryMode.PERSISTENT,
        )

        # Sending the message
        await logs_exchange.publish(message, routing_key="ignore")

        print(f" [x] Sent {message!r}")
