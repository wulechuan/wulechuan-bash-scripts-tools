if [ true ]; then
    netis-docker-init
else
    clear

	if [ "$copywritingLanguage" = "zh_CN" ]; then
        colorful -n '该 docker 已事先初始化过了。' textMagenta
    fi
	if [ "$copywritingLanguage" = "en_US" ]; then
        colorful -n 'Cool! This docker has already been initialzied before.' textMagenta
    fi
fi