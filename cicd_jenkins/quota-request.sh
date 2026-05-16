#!/bin/bash

echo "Requesting vCPU quota increase..."

aws service-quotas request-service-quota-increase \
  --service-code ec2 \
  --quota-code L-1216C47A \
  --desired-value 16 \
  --region us-east-1

echo "Waiting for approval..."

while true; do
  STATUS=$(aws service-quotas list-requested-service-quota-change-history \
    --service-code ec2 \
    --region us-east-1 \
    --query "RequestedQuotas[0].Status" \
    --output text)

  echo "Current status: $STATUS"

  if [ "$STATUS" == "APPROVED" ]; then
    echo "Quota approved! Running terraform..."
    terraform apply -auto-approve
    break
  elif [ "$STATUS" == "DENIED" ]; then
    echo "Quota request denied. Raise a support ticket."
    break
  fi

  sleep 60  # check every 60 seconds
done