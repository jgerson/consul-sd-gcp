#! /bin/bash

CREDS=$1
PROJ=$2
REGION=$3

echo "Building western server image..."
#GCP_ACCOUNT_FILE_JSON=$CREDS GCP_PROJECT_ID=$PROJ \
GCP_ACCOUNT_FILE_JSON=$CREDS GCP_PROJECT_ID=$PROJ \
 GCP_ZONE=$REGION DC_NAME=west NODE_TYPE=server \
 packer build -force server.json

echo "Building eastern server image..."
GCP_ACCOUNT_FILE_JSON=$CREDS GCP_PROJECT_ID=$PROJ \
 GCP_ZONE=$REGION DC_NAME=east NODE_TYPE=server \
 packer build -force server.json

echo "Building western client image..."
GCP_ACCOUNT_FILE_JSON=$CREDS GCP_PROJECT_ID=$PROJ \
 GCP_ZONE=$REGION DC_NAME=west NODE_TYPE=client \
 packer build -force client.json

echo "Building eastern client image..."
GCP_ACCOUNT_FILE_JSON=$CREDS GCP_PROJECT_ID=$PROJ \
 GCP_ZONE=$REGION DC_NAME=east NODE_TYPE=client \
 packer build -force client.json