.DEFAULT_GOAL := help
.PHONY: help

## Run tests on any file change
watch: test_deps
	while sleep 1; do \
		find defaults/ meta/ tasks/ templates/ tests/test.yml tests/vagrant/Vagrantfile \
		| entr -d make vagrant; \
	done

## Run test
test: test_deps vagrant

test_deps:
	rm -f tests/ansible-city.composer
	ln -s .. tests/ansible-city.composer

## Start and (re)provisiom Vagrant test box
vagrant:
	cd tests/vagrant && vagrant up --no-provision
	cd tests/vagrant && vagrant provision

## Execute simple Vagrant command
# Example: make vagrant_ssh
#          make vagrant_halt
vagrant_%:
	cd tests/vagrant && vagrant $(subst vagrant_,,$@)

## Lint role
# You need to install ansible-lint
lint:
	find defaults/ meta/ tasks/ templates/ -name "*.yml" | xargs -I{} ansible-lint {}

## Clean up
clean:
	rm -rf tests/ansible-city.*
	cd tests/vagrant && vagrant destroy

## Prints this help
help:
	@grep -h -E '^#' -A 1 $(MAKEFILE_LIST) | grep -v "-" | \
	awk 'BEGIN{ doc_mode=0; doc=""; doc_h=""; FS="#" } { \
		if (""!=$$3) { doc_mode=2 } \
		if (match($$1, /^[%.a-zA-Z_-]+:/) && doc_mode==1) { sub(/:.*/, "", $$1); printf "\033[34m%-30s\033[0m\033[1m%s\033[0m %s\n\n", $$1, doc_h, doc; doc_mode=0; doc="" } \
		if (doc_mode==1) { $$1=""; doc=doc "\n" $$0 } \
		if (doc_mode==2) { doc_mode=1; doc_h=$$3 } }'
