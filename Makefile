include .env
export

CLUSTER_NAME=tech-challenge-local

.PHONY: up down cluster deps deps-metrics deps-datadog deps-ingress

up: cluster deps
	@echo "✅ Cluster local pronto. Acesse os serviços em http://localhost/"

down:
	kind delete cluster --name $(CLUSTER_NAME)

cluster:
	kind create cluster --name $(CLUSTER_NAME) --config k8s/local/kind-config.yaml

deps: deps-metrics deps-datadog deps-ingress

deps-metrics:
	@echo "Installing Metrics Server..."
	kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
	kubectl patch -n kube-system deployment metrics-server --type=json \
	  -p '[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"}]'
	kubectl wait --namespace kube-system \
	  --for=condition=ready pod \
	  --selector=k8s-app=metrics-server \
	  --timeout=90s || true

deps-datadog:
	@echo "Installing Datadog Operator..."
	helm repo add datadog https://helm.datadoghq.com
	helm repo update
	helm install datadog-operator datadog/datadog-operator
	@echo "Applying Datadog secret..."
	@envsubst < k8s/datadog/base/datadog-secret.yaml | kubectl apply -f -
	@echo "Applying Datadog Agent..."
	kubectl apply -k k8s/datadog/overlays/dev

deps-ingress:
	@echo "Installing NGINX Ingress Controller..."
	kubectl apply -f k8s/ingress-nginx/ingress-nginx.yaml
	kubectl wait --namespace ingress-nginx \
	  --for=condition=ready pod \
	  --selector=app.kubernetes.io/component=controller \
	  --timeout=90s || true
