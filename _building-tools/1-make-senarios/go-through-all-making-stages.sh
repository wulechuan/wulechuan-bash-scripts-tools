# clean existing distribution if any

function wlc_bash_tools--building--make {
	local pathOfBuildingToolsForMaking="$___here/_building-tools/1-make-senarios"
	local pathOfCurrentMakingStage




	pathOfCurrentMakingStage="$pathOfBuildingToolsForMaking/stage-1=before-making"
	source "$pathOfCurrentMakingStage/0-fill-variable-values-in-templates-for-core-component.sh"    $*
	source "$pathOfCurrentMakingStage/1-fill-variable-values-in-templates-for-netis-components.sh"  $*




	pathOfCurrentMakingStage="$pathOfBuildingToolsForMaking/stage-2=make"
	source "$pathOfCurrentMakingStage/make-all-senarios.sh" $*




	pathOfCurrentMakingStage="$pathOfBuildingToolsForMaking/stage-3=after-making"
	source "$pathOfCurrentMakingStage/0-rename-dot-filled-template-files.sh"                    $*




	unset -f wlc_bash_tools--building--make
}




wlc_bash_tools--building--make