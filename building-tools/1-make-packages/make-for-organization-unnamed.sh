source "$___here/clean" # clean existing distribution if any
___scopeFolder="$___here/building-tools/1-make-packages"


___currentStageFolder="$___scopeFolder/stage-1=before-making"
source "$___currentStageFolder/0-fill-variable-values-in-core-lib-templates.sh"   $*
source "$___currentStageFolder/1-fill-variable-values-in-lib-templates-unnamed-organization.sh"  $*


___currentStageFolder="$___scopeFolder/stage-2=make"
source "$___currentStageFolder/make-packages.sh" $*


___currentStageFolder="$___scopeFolder/stage-3=after-making"
source "$___currentStageFolder/0-rename-dot-filled-template-files.sh"                    $*
source "$___currentStageFolder/1-move-unnamed-organization-docker-dist-to-inside-local-machine-dist.sh" $*


unset ___currentStageFolder
unset ___scopeFolder