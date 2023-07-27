$amqpConfig = new AMQPConnectionConfig();
$amqpConfig->setHost("localhost");
$amqpConfig->setPort(5671);
$amqpConfig->setUser("principal");
$amqpConfig->setPassword("principal");
$amqpConfig->setIsSecure(true);
$amqpConfig->setSslVerify(false);
$amqpConfig->setSslVerifyName(false);
$amqpConfig->setIoType(AMQPConnectionConfig::IO_TYPE_STREAM);
$amqpConfig->setVhost("/");

$connection = AMQPConnectionFactory::create($amqpConfig);
