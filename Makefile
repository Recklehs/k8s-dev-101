.PHONY: check cluster-create cluster-delete status

check:
	./scripts/check-env.sh

cluster-create:
	./scripts/create-cluster.sh

cluster-delete:
	./scripts/delete-cluster.sh

status:
	./scripts/status.sh
