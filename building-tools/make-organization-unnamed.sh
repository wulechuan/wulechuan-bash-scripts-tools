source "$___here/senario-specific-configurations/fill-variable-values-for-unnamed-organization-env.sh"
___build_variables_from_tempaltes_for_unnamedOrg_env  $*

___unnamedOrgInputReturnCode=$?

if [ $___unnamedOrgInputReturnCode -eq 0 ]; then
    source "$___here/clean" # clean existing distribution if any
    source "$___here/building-tools/build-packages.sh"
    source "$___here/building-tools/after-building-packages.sh"
    source "$___here/senario-specific-configurations/after-making-all-senarios.sh"
fi
