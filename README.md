# helm-runner
Docker image with helm and kubectl command-line tool.

## Environment Variables

### `BITBUCKET_PROJECT_CLONE_URL`

Helm charts are stored in separate project (```bln-cluster-kube```). We need to clone this project into our docker image to run helm command. This value is base64 encoded.
```
echo "BITBUCKET_PROJECT_CLONE_URL"| base64 | pbcopy
```

### `CLUSTER_CONTEXT`

We have few clusters on AWS. We need to specify which cluster Tiller is going to talk to helm client.

### `HELM_COMMAND`

This is the command we are running.

### `KUBECTL_CONFIG`

This is Cluster configuration file from ```~/.kube/config ```. Helm needs configuration file to connect kubernetes cluster. configuration file is taring and base64 encoding as bellow.
```
cat $HOME/.kube/config | gzip | base64 | pbcopy
```

## Codeship Usage

### `BITBUCKET_PROJECT_CLONE_URL` and `KUBECTL_CONFIG`

Append the encoded environment variable value to the environment variable name with ` =`. For an example `KUBECTL_CONFIG=BASE64_ENCODED_VALUE_SEE_INSTRUCTIONS_ABOVE`. Copy the whole key value pair as a string and use the following to encrypt it.

```
pbpaste > raw.tmp && jet encrypt raw.tmp crypt.tmp && cat crypt.tmp | pbcopy && rm raw.tmp crypt.tmp
```
The value can now be added an array item to a `encrypted_environment` in `codeship-services.yml`.

### `HELM_COMMAND` and `KUBECTL_CONFIG`

Add values as array of environment variables in `codeship-services.yml`.
