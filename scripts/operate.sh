#!/bin/bash -eu

readonly BASE_DIR_PATH="$(cd $(dirname $(dirname ${BASH_SOURCE:-$0})); pwd)"
readonly BERGLAS_KEY_OPT="--key projects/${CLOUDSDK_CORE_PROJECT}/locations/global/keyRings/berglas/cryptoKeys/berglas-key"
readonly FMT=$(cat<<EOF
source .envrc \
&& gcloud auth activate-service-account --key-file=/workspace/credentials/${GOOGLE_APPLICATION_CREDENTIALS_FILENAME} \
&& berglas %s ${BUCKET_ID}/%s
EOF
)

usage_exit() {
  echo "Usage: $0 -o <create|access> -k <key> [-v <value>]" 1>&2
  exit 1
}

declare operation=''
declare key=''
declare value=''

while getopts o:k:v: OPT
do
  case $OPT in
    o) operation=$OPTARG
      ;;
    k) key=$OPTARG
      ;;
    v) value=$OPTARG
      ;;
    h) usage_exit
      ;;
    \?) usage_exit
      ;;
  esac
done

shift $((OPTIND - 1))

case $operation in
  create)
    cmd=$(printf "$FMT" $operation $key)
    cmd="${cmd} ${value} ${BERGLAS_KEY_OPT}"
    ;;
  access)
    cmd=$(printf "$FMT" $operation $key)
    ;;
  *) usage_exit
    ;;
esac

docker-compose run berglas bash -c "$cmd"
