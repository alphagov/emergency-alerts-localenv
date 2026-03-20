#!/bin/bash
set -ex

# Create SQS queues
DLQ_URL=$(awslocal sqs create-queue --queue-name local-dramatiq-dlq --attributes VisibilityTimeout=300 --query 'QueueUrl' --output text)
DLQ_ARN=$(awslocal sqs get-queue-attributes --queue-url "$DLQ_URL" --attribute-names QueueArn --query 'Attributes.QueueArn' --output text)

awslocal sqs create-queue --queue-name local-dramatiq-periodic-tasks --attributes "VisibilityTimeout=300,RedrivePolicy='{\"deadLetterTargetArn\":\"$DLQ_ARN\",\"maxReceiveCount\":\"3\"}'"
awslocal sqs create-queue --queue-name local-dramatiq-govuk-alerts --attributes "VisibilityTimeout=300,RedrivePolicy='{\"deadLetterTargetArn\":\"$DLQ_ARN\",\"maxReceiveCount\":\"3\"}'"
awslocal sqs create-queue --queue-name local-dramatiq-broadcast-tasks --attributes "VisibilityTimeout=300,RedrivePolicy='{\"deadLetterTargetArn\":\"$DLQ_ARN\",\"maxReceiveCount\":\"3\"}'"
awslocal sqs create-queue --queue-name local-dramatiq-high-priority-tasks --attributes "VisibilityTimeout=300,RedrivePolicy='{\"deadLetterTargetArn\":\"$DLQ_ARN\",\"maxReceiveCount\":\"3\"}'"

# Create S3 bucket
awslocal s3 mb s3://local-govuk-alerts

# Enable static website hosting
awslocal s3 website s3://local-govuk-alerts/ \
  --index-document index.html \
  --error-document error.html

# Upload a sample index.html
echo "<html><body><h1>This is Gov.UK</h1><p>Well, not really, but you're probably meaning to head to <a href='/alerts'>/alerts</a>.</body></html>" \
  > /tmp/index.html

awslocal s3 cp /tmp/index.html s3://local-govuk-alerts/index.html
