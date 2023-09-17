#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -oue pipefail

echo "Setting up container signing in policy.json and cosign.yaml for $IMAGE_NAME"
echo "Registry to write: $IMAGE_REGISTRY"

mkdir -p /usr/etc/pki/containers/
mkdir -p /usr/etc/containers/

cp /usr/share/ublue-os/cosign.pub /usr/etc/pki/containers/"$IMAGE_NAME".pub

FILE=/usr/etc/containers/policy.json

yq -i -o=j '.transports.docker |= 
    {"'"$IMAGE_REGISTRY"'": [
            {
                "type": "sigstoreSigned",
                "keyPath": "/usr/etc/pki/containers/'"$IMAGE_NAME"'.pub",
                "signedIdentity": {
                    "type": "matchRepository"
                }
            }
        ]
    }
+ .' "$FILE"

cp /usr/etc/containers/registries.d/ublue-os.yaml /usr/etc/containers/registries.d/"$IMAGE_NAME".yaml
sed -i "s ghcr.io/ublue-os $IMAGE_REGISTRY g" /usr/etc/containers/registries.d/"$IMAGE_NAME".yaml
