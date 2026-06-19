.PHONY: check cluster-create cluster-delete status deploy app-status app-describe app-logs port-forward clean

CLUSTER_NAME=k8s-dev-101
APP_PATH=apps/hello-k8s/overlays/local
APP_NAME=hello-k8s

check:
	./scripts/check-env.sh

cluster-create:
	./scripts/create-cluster.sh

cluster-delete:
	./scripts/delete-cluster.sh

status:
	./scripts/status.sh

deploy:
	kubectl apply -k $(APP_PATH)
	kubectl rollout status deployment/$(APP_NAME) --timeout=120s

app-status:
	kubectl get deployment,pods,service -l app=$(APP_NAME)

app-describe:
	kubectl describe deployment $(APP_NAME)

app-logs:
	kubectl logs -l app=$(APP_NAME)

port-forward:
	kubectl port-forward service/$(APP_NAME) 8080:80

clean:
	kubectl delete -k $(APP_PATH) --ignore-not-found=true
