default: help

define HELP
endef
export HELP
help:
	@echo "$$HELP"

status:
	docker context use 52walker-1
	docker ps
	docker context use 52walker-2
	docker ps

deploy-1:
	docker context use 52walker-1
	docker --context 52walker-1 compose -p 52w-redirect up --build -d

deploy-2:
	docker context use 52walker-2
	docker --context 52walker-2 compose -p 52w-redirect up -d

