#!/usr/bin/env bash
set -euf -o pipefail

KUBECONFIG_BASE="$HOME/.config/k8s"
KUBECONFIG_AGG="$HOME/.config/k8s/configs/main.yaml"

get_login() {
    for CFG in $(gcloud config configurations list --format json | jq -r '.[].name'); do
        gcloud config configurations activate "${CFG}"
        gcloud auth login
    done

}

get_creds() {
    mkdir -p "${KUBECONFIG_BASE}"
    mkdir -p $(dirname $KUBECONFIG_AGG)
    touch $KUBECONFIG_AGG

    for CFG in $(gcloud config configurations list --format json | jq -r '.[].name'); do
        gcloud config configurations activate "${CFG}" >/dev/null 2>&1
        for PRJ in $(gcloud projects list 2>/dev/null | tail -n +2 | awk '{print $1}'); do
            CLUSTERS=$(gcloud container clusters list --format json --project ${PRJ} | jq -c -r '[.[] | {name,location}]')
            COUNT=$(echo $CLUSTERS | jq '. | length')
            for IDX in $(seq 0 $(($COUNT))); do
                CLSTR=$(echo ${CLUSTERS} | jq -r '.['$IDX'].name')
                if [[ ! $CLSTR = 'null' ]]; then
                    RGN=$(echo ${CLUSTERS} | jq -r '.['$IDX'].location')
                    K8S_CFG_NAME="${CFG}.${PRJ}.${RGN}.${CLSTR}.yaml"
                    K8S_CFG_PATH="${KUBECONFIG_BASE}/configs/clusters/${K8S_CFG_NAME}"
                    mkdir -p $(dirname $K8S_CFG_PATH)
                    touch $K8S_CFG_PATH
                    KUBECONFIG=${K8S_CFG_PATH} gcloud container clusters get-credentials --region "${RGN}" --project "${PRJ}" "${CLSTR}" >/dev/null 2>&1
                fi
            done
        done
    done
}

aggregate() {
    KUBECONFIG=~/.kube/config:$(find $HOME/.config/k8s/configs/clusters -type f -iname '*.yaml' | tr '\n' ':') kubectl config view --flatten >"$HOME/.config/k8s/configs/main.yaml"
}

get_creds

aggregate
