___unnamed_organization_docker_dists_old_location___="$___here/$___wlcBashScriptsBuildingOutputFolderName"

___unnamed_organization_docker_dists_new_location___="$___unnamed_organization_docker_dists_old_location___/_local-machine-wulechuan/$wlcLocalMachineFolderNameOfBashScriptsForDockers"
mkdir "$___unnamed_organization_docker_dists_new_location___"


___unnamed_organization_docker_dist_path___="$___unnamed_organization_docker_dists_old_location___/unnamed-docker-for-developer-non-root-user"
if [ -d "$___unnamed_organization_docker_dist_path___" ]; then
    mv "$___unnamed_organization_docker_dist_path___" "$___unnamed_organization_docker_dists_new_location___"
fi


___unnamed_organization_docker_dist_path___="$___unnamed_organization_docker_dists_old_location___/unnamed-docker-for-developer-root-user"
if [ -d "$___unnamed_organization_docker_dist_path___" ]; then
    mv "$___unnamed_organization_docker_dist_path___" "$___unnamed_organization_docker_dists_new_location___"
fi



___unnamed_organization_docker_dist_path___="$___unnamed_organization_docker_dists_old_location___/unnamed-docker-for-supporter-root-user"
if [ -d "$___unnamed_organization_docker_dist_path___" ]; then
    mv "$___unnamed_organization_docker_dist_path___" "$___unnamed_organization_docker_dists_new_location___"
fi



unset ___unnamed_organization_docker_dist_path___
unset ___unnamed_organization_docker_dists_old_location___
unset ___unnamed_organization_docker_dists_new_location___