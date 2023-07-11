# Easyappointments
This is a simple custom docker image and an helm chart for deploying https://github.com/alextselegidis/easyappointments made by Alex Tselegidis.

# Installation
```sh
helm repo add highcanfly https://helm-repo.highcanfly.club/
helm repo update
helm install --namespace easyappointments --create-namespace easyappointments-1.50 highcanfly/easyappointments --values _values.yaml
```

You need to customize values.yaml for your requirements, for exemple ours is:
```yaml
deploymentEasyappointment:
  image: highcanfly/easyappointments
  language: french
  resources:
    limits:
      cpu: '2'
      memory: 1Gi

ingressEasyappointments:
  ingressClassName: haproxy            # see https://www.haproxy.com/documentation/kubernetes/
  host: easyappointments.example.org
  clusterIssuer: our-ca-issuer         # see https://cert-manager.io/
secretMysql:
  root: cGFzc3dvcmQ=                   # echo -n "password" | openssl enc -a

mysql:
  resources:
    limits:
      cpu: '1'
      memory: 2Gi

smtpd:
  smtpd:
    resources:
      limits:
        cpu: 900m
        memory: "322122547"
```