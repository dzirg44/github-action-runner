#!/bin/sh
./config.sh \
    --name $(hostname) \
    --token ${GITHUB_RUNNER_REGISTRATION_TOKEN} \
    --url https://github.com/${GITHUB_OWNER}/${GITHUB_REPOSITORY} \
    --work ${RUNNER_WORKDIR} \
    --labels ${GITHUB_RUNNER_EXTRA_LABELS} \
    --unattended \
    --replace
remove() {
    ./config.sh remove --unattended --token "${GITHUB_RUNNER_REGISTRATION_TOKEN}"
}
trap 'remove; exit 130' INT
trap 'remove; exit 143' TERM
./run.sh "$*" &
wait $!
