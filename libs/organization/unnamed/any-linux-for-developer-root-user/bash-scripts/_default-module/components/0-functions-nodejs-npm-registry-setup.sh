
function __unnamed_organization_docker_npm_registry_setup_ {
	npm config set registry http://12.34.56.78:4873/
	npm i -g nrm
	nrm add myCompany       http://12.34.56.78:4873/
}
