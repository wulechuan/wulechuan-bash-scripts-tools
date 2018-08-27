function __unnamed_organization_SOMEPROJECT_auto_change_git_repo_user_name_ {
	echo
	echo -e "${darkline60}"
	local gitRepositoryOriginUrl="ssh://git@git.myCompanyDomainName/something.git"

	if [ ! -d "$pathSOMEPROJECT" ]; then
		return 1
	fi

	cd ${pathSOMEPROJECT}
	git remote set-url origin ${gitRepositoryOriginUrl}
	git config user.name ${myCompanyLDPAUserName}
	git config user.email ${myCompanyLDPAUserName}@myCompanyEmailDomainName

	if [ "$copywritingLanguage" = "zh_CN" ]; then
		echo -e "${green}  ${brown}SOMEPROJECT${green} 代码仓库的${pink} git 用户名${green}已改为${blue}${myCompanyLDPAUserName}${green}。${noColor}"
		echo -e "${green}  ${brown}SOMEPROJECT${green} 代码仓库的${pink} origin url ${green}已改为${blue}${gitRepositoryOriginUrl}${green}。${noColor}"
	fi
	if [ "$copywritingLanguage" = "en_US" ]; then
		echo -e "${green}  The ${pink}git user name${green} of ${brown}SOMEPROJECT${green} repository has been set to ${blue}${myCompanyLDPAUserName}${green} ${noColor}"
		echo -e "${green}  The ${pink}git repo origin url${green} of ${brown}SOMEPROJECT${green} repository has been set to ${blue}${gitRepositoryOriginUrl}${green} ${noColor}"
	fi

	echo -e "${darkline60}"
}

