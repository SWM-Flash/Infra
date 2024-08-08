WORKSPACE := $(shell terraform workspace show)
VARFILE := -var-file="environments/$(WORKSPACE)/$(WORKSPACE).tfvars"

init:
	@terraform init

plan:
	@make script
	@terraform plan $(VARFILE)

apply:
	@make script
	@terraform apply $(VARFILE)

dplan:
	@terraform plan -destroy $(VARFILE)

destroy:
	@terraform destroy $(VARFILE)

re:
	@make destroy
	@make clean
	@make apply

script:
	@sh scripts/lambda_zip.sh > /dev/null
	@sh scripts/create_problem_zip.sh > /dev/null

clean:
	@rm src/*.zip

.PHONY: init plan apply dplan destroy re script clean
