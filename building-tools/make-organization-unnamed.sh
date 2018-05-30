source "$___here/senario-specific-configurations/fill-variable-values-for-netis-env.sh"
___build_variables_from_tempaltes_for_netis_env  $*

___netisInputReturnCode=$?

if [ $___netisInputReturnCode -eq 0 ]; then
    ___shouldPreventRMFromAsyncDeletingNewlyCreatedFilledTemplates=1

    source "$___here/clean" # clean existing distribution if any
    source "$___here/building-tools/before-building-packages.sh"
    source "$___here/building-tools/build-packages.sh"
    source "$___here/building-tools/after-building-packages.sh"
    source "$___here/senario-specific-configurations/after-making-all-senarios.sh"

    unset ___shouldPreventRMFromAsyncDeletingNewlyCreatedFilledTemplates=1
fi

# unset ___netisInputReturnCode # 此时还不能删除改变量