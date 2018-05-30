source "$___here/clean" # clean existing distribution if any
___scopeFolder="$___here/building-tools/1-make-packages"


___currentStageFolder="$___scopeFolder/stage-1=before-making"
source "$___currentStageFolder/0-fill-variable-values-in-lib-templates-common.sh" $*


___currentStageFolder="$___scopeFolder/stage-2=make"
source "$___currentStageFolder/make-packages.sh" $*


___currentStageFolder="$___scopeFolder/stage-3=after-making"
source "$___currentStageFolder/0-rename-dot-filled-template-files.sh" $*


unset ___currentStageFolder
unset ___scopeFolder