UPSTREAM_POD_NAME=$(kubectl --namespace spegel -l app.kubernetes.io/name=spegel get pods -o custom-columns=:metadata.name --no-headers | shuf -n 1)
UPSTREAM_NODE_NAME=$(kubectl --namespace spegel get pod ${UPSTREAM_POD_NAME} -o jsonpath="{.spec.nodeName}")
kubectl --namespace default run upstream --image=ubuntu:22.04 --restart=Never --overrides="{\"spec\":{\"nodeName\":\"${UPSTREAM_NODE_NAME}\",\"containers\":[{\"name\":\"ubuntu\",\"image\":\"ubuntu:22.04\",\"imagePullPolicy\":\"Always\",\"command\":[\"true\"]}]}}"
MIRROR_POD_NAME=$(kubectl --namespace spegel -l app.kubernetes.io/name=spegel get pods -o custom-columns=:metadata.name --no-headers | grep -v "^${UPSTREAM_POD_NAME}$" | shuf -n 1)
MIRROR_NODE_NAME=$(kubectl --namespace spegel get pod ${MIRROR_POD_NAME} -o jsonpath="{.spec.nodeName}")
kubectl --namespace default run mirror --image=ubuntu:22.04 --restart=Never --overrides="{\"spec\":{\"nodeName\":\"${MIRROR_NODE_NAME}\",\"containers\":[{\"name\":\"ubuntu\",\"image\":\"ubuntu:22.04\",\"imagePullPolicy\":\"Always\",\"command\":[\"true\"]}]}}"
