#!/bin/bash -eu

readonly BASE_DIR_PATH="$(cd $(dirname $(dirname ${BASH_SOURCE:-$0})); pwd)"
readonly FMT=$(cat<<EOF
source .envrc \
&& gcloud auth activate-service-account --key-file=/workspace/credentials/${GOOGLE_APPLICATION_CREDENTIALS_FILENAME} \
&& gcloud services enable --project=${CLOUDSDK_CORE_PROJECT} cloudkms.googleapis.com storage-api.googleapis.com storage-component.googleapis.com \
&& berglas bootstrap --project=${CLOUDSDK_CORE_PROJECT} --bucket=${BUCKET_ID}
EOF
)

cmd=$(printf "$FMT")
docker-compose run berglas bash -c "$cmd"
