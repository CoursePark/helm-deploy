#!/bin/sh

export KUBECTL_PATH=$HOME/.kube
mkdir -p $KUBECTL_PATH

# Extract kubectl config from KUBECTL_CONFIG and create configure
if [ ! -z "$KUBECTL_CONFIG" ]; then
echo $KUBECTL_CONFIG | base64 -d | gzip -d > $KUBECTL_PATH/config
fi

# Extract cluster context and set to current-context
if [ ! -z "$CLUSTER_CONTEXT" ]; then
	kubectl config use-context CLUSTER_CONTEXT
	echo "Helm is using ${CLUSTER_CONTEXT} cluster context"
fi

# Extract the bitbucket project url
if [[ ! -z "$BITBUCKET_PROJECT_CLONE_URL" ]]; then
	BITBUCKET_PROJECT_CLONE_URL="$(base64 -d <<< $BITBUCKET_PROJECT_CLONE_URL)"
	echo "Bitbucket project is downloading..."
	git clone ${BITBUCKET_PROJECT_CLONE_URL}
	echo "Downloaded successful."
else
	echo "Bitbucket project url not provided"
fi

# Run helm command
if [[ ! -z "$HELM_COMMAND" ]]; then
	echo "Starting to run ${HELM_COMMAND}"
	HELM_COMMAND
else
	echo "Helm command not found. Please provide a helm command"
fi
