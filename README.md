# full-stack-network

kafka-topics --create --topic my-first-topic --bootstrap-server 127.0.0.1:9094
kafka-topics --list --bootstrap-server 127.0.0.1:9094


# SEND SQS MESSAGE
awslocal sqs send-message --queue-url http://sqs.us-west-2.localhost.localstack.cloud:4566/000000000000/sqs-default --message-body "Hello World"
{
    "MD5OfMessageBody": "b10a8db164e0754105b7a99be72e3fe5",
    "MessageId": "74ade954-7fee-410f-b47b-dc10ad38accc"
}

# RECEIVE SQS MESSAGE
awslocal sqs receive-message --queue-url http://sqs.us-west-2.localhost.localstack.cloud:4566/000000000000/sqs-default
{
    "Messages": [
        {
            "MessageId": "74ade954-7fee-410f-b47b-dc10ad38accc",
            "ReceiptHandle": "MTYwZWQ0YWItYjAwYy00NTY0LThjYjgtOTA5OGMyZGE1NzVlIGFybjphd3M6c3FzOnVzLXdlc3QtMjowMDAwMDAwMDAwMDA6c3FzLWRlZmF1bHQgNzRhZGU5NTQtN2ZlZS00MTBmLWI0N2ItZGMxMGFkMzhhY2NjIDE3MTkxODgzMDMuNjE1NTQ1",
            "MD5OfBody": "b10a8db164e0754105b7a99be72e3fe5",
            "Body": "Hello World"
        }
    ]
}
