<link rel="stylesheet" href="./docs/styles/markdown-styles-for-vscode-built-in-preview.min.css">

# 概述

本套脚本系统构建于【类Bash】环境之上。方便 Bash 用户快速配置环境。


# 安装

1.  按需【修订】已有的各种【库】。它们均位于 `lib`
    文件夹内，可以嵌套至深层文件夹。
    
    > 如果一个【库】位于嵌套文件夹中，
    > 则在之后引用该【库】时应注意填写完整的【子路径】。

    每一个【库】的文件夹代表着一个假想的 `~`
    文件夹。之后在【构建（拼装）】过程中，多个【库】中的内容会被复制、拼合到一起，并最终作为整体复制到真实的 `~` 文件夹下。

    例如，`lib/_anyone-_anywhere` 下包含：
    - `bash-scripts`
    - `.bashrc`
    
    在最终安装时，上述二者均会被复制到真实的 `~` 文件夹内。

1.  按需【修订】已有【场景】。

    所谓【场景】是由多个【库】的组合而成的配置包。
    
    所有【场景】配置文件夹均位于
    `senario-specific-configurations`
    文件夹内。凡是由【场景】配置文件夹内的 `_chosen-libs.sh`
    中的 `___allChosenLibsFolder` 指明的【库】，均会参与拼合，最终构成该【场景】。

    例如：已有的
    `senario-specific-configurations/local-machine-wulechuan`
    文件夹下，其 `_chosen-libs.sh` 中写道：

    ```sh
    ___allChosenLibsFolder="
        _anyone-_anywhere
        wulechuan/_anywhere
        wulechuan/windows
    "
    ```

    这意味着，`local-machine-wulechuan` 这一【场景】，在构建成功后将包含上述三个库。即，该【场景】由三个【库】拼装而得。

1.  按需【创建】更多【场景】。

    1.  在 `senario-specific-configurations`
        文件夹下，创建任意名称的文件夹，例如 `my-company-any-user`。
    2.  在刚才创建的文件夹（仍假定为 `my-company-any-user`）中，创建名为
        `_chosen-libs.sh` 的文件。在该文件中，创建名为 `___allChosenLibsFolder`
        的 bash 【变量】，并按需赋值。
        
        参见下例：
        ```sh
        ___allChosenLibsFolder="
            _anyone-_anywhere
            wulechuan/_anywhere
            wulechuan/windows
        "
        ```
    3.  如果有必要，在 `my-company-any-user` 文件夹中，创建名为
        `after-making-this-senario.sh` 文件。在该文件中随意撰写 bash 脚本。
        在之后的【构建（拼装）】过程中，当`dist/my-company-any-user`
        文件夹被创建，且其内容填充完全后，位于
        `senario-specific-configurations/my-company-any-user` 下的
        `after-making-this-senario.sh` 将会以 `source` 的方式被运行。

1.  运行【构建（拼装）】脚本和【安装】脚本。步骤如下：
    ```sh
    cd <this repository>
    ./install.sh
    ```
