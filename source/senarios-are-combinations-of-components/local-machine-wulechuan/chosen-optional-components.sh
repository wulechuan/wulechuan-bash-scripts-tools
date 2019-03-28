___allChosenOptionalComponentsSubPath="
    _anyone-_anywhere
    personal/wulechuan/_anywhere
    personal/wulechuan/windows-_common
"

if [[ `hostname` =~ home ]]; then
    ___allChosenOptionalComponentsSubPath=$___allChosenOptionalComponentsSubPath"
        personal/wulechuan/windows-full-hd-screen
    "
else
    ___allChosenOptionalComponentsSubPath=$___allChosenOptionalComponentsSubPath"
        personal/wulechuan/windows-4k-screen
    "
fi