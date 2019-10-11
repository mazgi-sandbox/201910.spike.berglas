## Before you begin

See also https://github.com/GoogleCloudPlatform/berglas

### Required

- [docker & docker-compose](https://www.docker.com)

### Set up your environment

Edit the `.envrc` file like bellow:

```
# GCP
export CLOUDSDK_CORE_PROJECT='YOUR-GCP-PROJECT'
export GOOGLE_APPLICATION_CREDENTIALS_FILENAME='YOUR-GCP-KEY.json'
export GOOGLE_APPLICATION_CREDENTIALS="$(pwd)/credentials/${GOOGLE_APPLICATION_CREDENTIALS_FILENAME}"

# Berglas
export BUCKET_ID='YOUR-GCS-BUCKET'
```

### Create your GCP service account and generate private key

https://cloud.google.com/sdk/gcloud/reference/auth/activate-service-account

## Bootstrap

```shellsession
❯ scripts/bootstrap.sh                   
Activated service account credentials for: [NAME@YOUR-GCP-PROJECT.iam.gserviceaccount.com]
Operation "operations/acf.********" finished successfully.
Successfully created berglas environment:

  Bucket: YOUR-GCS-BUCKET
  KMS key: projects/CLOUDSDK_CORE_PROJECT/locations/global/keyRings/berglas/cryptoKeys/berglas-key

To create a secret:

  berglas create YOUR-GCS-BUCKET/my-secret abcd1234 \
    --key projects/CLOUDSDK_CORE_PROJECT/locations/global/keyRings/berglas/cryptoKeys/berglas-key

To grant access to that secret:

  berglas grant YOUR-GCS-BUCKET/my-secret \
    --member user:jane.doe@mycompany.com

For more help and examples, please run "berglas -h".
```

## Create and store your secret to Berglas

```shellsession
❯ scripts/operate.sh -o create -k key-foo -v value-foo
Activated service account credentials for: [NAME@YOUR-GCP-PROJECT.iam.gserviceaccount.com]
Successfully created secret [key-foo] with generation [1234567890123456]
```

## Access your secret from Berglas

```shellsession
❯ scripts/operate.sh -o access -k key-foo
Activated service account credentials for: [NAME@YOUR-GCP-PROJECT.iam.gserviceaccount.com]
value-foo%
```
