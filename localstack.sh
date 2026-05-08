#!/bin/bash
set -e

# Create SQS queues
awslocal sqs create-queue --queue-name local-periodic-tasks --attributes VisibilityTimeout=300
awslocal sqs create-queue --queue-name local-govuk-alerts --attributes VisibilityTimeout=300
awslocal sqs create-queue --queue-name local-broadcast-tasks --attributes VisibilityTimeout=300
awslocal sqs create-queue --queue-name local-high-priority-tasks --attributes VisibilityTimeout=300

# Create S3 buckets
awslocal s3 mb s3://local-govuk-alerts
awslocal s3 mb s3://local-govuk-alerts-blue
awslocal s3 mb s3://local-govuk-alerts-green
awslocal s3 mb s3://local-govuk-alerts-archive

# Enable static website hosting
awslocal s3 website s3://local-govuk-alerts/ \
  --index-document index.html \
  --error-document error.html
awslocal s3 website s3://local-govuk-alerts-blue/ \
  --index-document index.html \
  --error-document error.html
awslocal s3 website s3://local-govuk-alerts-green/ \
  --index-document index.html \
  --error-document error.html
# Upload a sample index.html
echo "<html><body><h1>This is Gov.UK</h1><p>Well, not really, but you're probably meaning to head to <a href='/alerts'>/alerts</a>.</body></html>" \
  > /tmp/index.html

awslocal s3 cp /tmp/index.html s3://local-govuk-alerts/index.html
awslocal s3 cp /tmp/index.html s3://local-govuk-alerts-blue/index.html
awslocal s3 cp /tmp/index.html s3://local-govuk-alerts-green/index.html
