#!/bin/bash
#########################################################################
# © Ronan LE MEILLAT 2023
# released under the GPLv3 terms
#########################################################################
echo "NAMESPACE=$NAMESPACE"
kubectl create namespace $NAMESPACE
tar -cv --exclude "node_modules" --exclude "dkim.rsa" --exclude "private" --exclude "k8s" --exclude ".git" --exclude ".github" --exclude-vcs --exclude ".docker" --exclude "_sensitive_datas" -f - . | gzip -9 | kubectl run -n $NAMESPACE kaniko \
  --rm --stdin=true \
  --image=highcanfly/kaniko:latest --restart=Never \
  --overrides='{
  "apiVersion": "v1",
  "spec": {
    "containers": [
      {
        "name": "kaniko",
        "image": "highcanfly/kaniko:latest",
        "stdin": true,
        "stdinOnce": true,
        "args": [
          "-v","info",
          "--cache=true",
          "--dockerfile=Dockerfile",
          "--context=tar://stdin",
          "--skip-tls-verify",
          "--destination='$EXPECTED_REF'",
          "--image-fs-extract-retry=3",
          "--push-retry=3",
          "--use-new-run"
        ]
      }
    ],
    "restartPolicy": "Never"
  }
}'

#kubectl delete -n $NAMESPACE secret/registry-credentials
