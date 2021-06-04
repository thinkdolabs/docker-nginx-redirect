default: help


define HELP
	https://code.visualstudio.com/docs/containers/ssh

	unset DOCKER_HOST
	ssh-add ~/.ssh/id_rsa_jw_202106
	ssh-add -l

	docker context create 52walker-1 --docker "host=ssh://root@167.99.61.204"
	docker context use 52walker-1
	docker context ls

	docker run -d -e SERVER_REDIRECT=staging.52walker.com -p 80:80 schmunk42/nginx-redirect
	ssh 52walker-2 docker ps

	docker context create 52walker-2 --docker "host=ssh://root@167.99.55.219"
	docker context use 52walker-2
	docker context ls

	docker run -d -e SERVER_REDIRECT=staging.52walker.com -p 80:80 schmunk42/nginx-redirect
	ssh 52walker-2 docker ps
endef

export HELP
help:
	@echo "$$HELP"

