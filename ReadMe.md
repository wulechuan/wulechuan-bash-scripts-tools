<link rel="stylesheet" href="./docs/styles/markdown-styles-for-vscode-built-in-preview.min.css">

# 乐川的 Bash 工具集


## English Version of this ReadMe

It's [here](./docs/ReadMe.en-US.md).



## 综述

本套脚本系统构建于【类 Bash】环境（含 Cygwin 和 git-bash ）之上。旨在方便 Bash 用户快速配置环境。


## 术语

### 单纯配置集

所谓【单纯配置集】是一些拥有共同特点的脚本和资源文件的集和。这些共同特点可以任意设计和安排。

例如，可以任何计算机环境都通用的功能和资源收集在一起，形成一个所谓【单纯配置集】。
又如，可以将所有适用于 Cygwin 环境的功能和资源收集在一起，形成另一个所谓【单纯配置集】。
还可将针对于特定项目研发的功能和资源收集在一起，形成第三个所谓【单纯配置集】。
甚至可以将个人偏好的配置做成一个【单纯配置集】，供选用。

【单纯配置集】不可直接使用。可将一个或多个【单纯配置集】组合成一个所谓【场景配置集】。【场景配置集】可以直接部署并使用。


### 场景配置集

所谓【场景配置集】是由多个【单纯配置集】的组合而成的复合配置集。【场景配置集】可以直接部署并使用。
每个【场景配置集】可以根据需求任意选配一个或多个【单纯】配置集。

本工具集的构建工具运行批量定义和构建多个【场景配置集】。每个【场景配置集】各自用于不同的计算机环境，或者说【场景】。

同一个计算机环境，不可以同时采用多个【场景配置集】，至多一个【场景配置集】能起作用。

### 拼合

将一个或多个【单纯配置集】组合成一个【场景配置集】的过程叫做【拼合】。


## 配置、拼合与安装

1.  按需【修订】已有的各种【单纯配置集】。它们均位于 `source/components/optional`
    文件夹内，可以嵌套至深层文件夹。
    
    > 如果一个【单纯配置集】位于嵌套文件夹中，
    > 则在之后引用该【单纯配置集】时应注意填写完整的【子路径】。

    每一个【单纯配置集】的文件夹代表着一个假想的 `~`
    文件夹。之后在【拼合】过程中，多个【单纯配置集】中的内容会被复制到一起，并最终作为整体复制到一台计算机真实的 `~` 文件夹下。

    例如，`source/components/optional/_anyone-_anywhere` 下包含：
    - `.mintty/`
    - `wlc-bash-tools/`
    - `.bashrc`
    - `.minttyrc`
    
    在最终部署时，上述四者作为一个【场景配置集】的一部分，连同该【场景配置集】中其余一切内容，均会被复制到一台计算机真实的 `~` 文件夹内。




1.  按需【修订】已有【场景配置集】。
    
    所有【场景配置集】的配置文件夹均位于
    `source/senarios-are-combinations-of-components`
    文件夹内。凡是由【场景配置集】的配置文件夹内的 `chosen-optional-components.sh`
    中的 `___allChosenOptionalComponentsSubPath` 这一变量指明的【单纯配置集】，均会参与【拼合】，最终构成该【场景配置集】。

    > 例如：已有的
    > `source/senarios-are-combinations-of-components/local-machine-wulechuan`
    > 文件夹下，其 `chosen-optional-components.sh` 中写道：
    >
    > ```sh
    > ___allChosenOptionalComponentsSubPath="
    >     _anyone-_anywhere
    >     personal/wulechuan/_anywhere
    >     personal/wulechuan/windows
    > "
    > ```
    >
    >  这意味着，`local-machine-wulechuan`
    > 这一【场景配置集】，在【拼合】成功后将包含上述三个【单纯配置集】。即，该【场景配置集】将由三个【单纯配置集】【拼合】而得。




1.  按需【创建】更多【场景配置集】。**很显然，该步骤并非必须。**

    1.  在 `source/senarios-are-combinations-of-components`
        文件夹下，创建任意名称的文件夹，例如 `my-company-any-user`。

    2.  在刚才创建的文件夹（仍假定为 `my-company-any-user`）中，创建名为
        `chosen-optional-components.sh` 的文件。在该文件中，创建名为 `___allChosenOptionalComponentsSubPath`
        的 bash 【变量】，并按需赋值。
        
        > 参见下例：
        > ```sh
        > ___allChosenOptionalComponentsSubPath="
        >     _anyone-_anywhere
        >     organization/the-greatest-company/_any-linux
        >     personal/wulechuan/_anywhere
        >     personal/wulechuan/windows
        > "
        > ```

    3.  如果有必要，可在 `my-company-any-user` 文件夹中，创建名为
        `after-making-this-senario.sh` 文件。在该文件中随意撰写 bash 脚本。
        在之后的【拼合】过程中，当 `built-senarios/my-company-any-user`
        文件夹被创建，且其内容填充完全后，位于
        `source/senarios-are-combinations-of-components/my-company-any-user` 下的
        `after-making-this-senario.sh` 将会以 `source` 的方式被运行。

    4.  如果有必要，还可在 `my-company-any-user` 文件夹中，创建名为
        `deploy.sh` 文件。在该文件中随意撰写 bash 脚本。
        在之后的【拼合】过程中，当 `built-senarios/my-company-any-user`
        文件夹被创建，且其内容填充完全后，位于
        `source/senarios-are-combinations-of-components/my-company-any-user` 下的
        `deploy.sh` 将会以 `source` 的方式被运行。



1.  运行【拼合】脚本和【安装】脚本。步骤如下：
    ```sh
    cd    <this repository>
    ./to-build.sh
    ```


## 清理构建带来的临时文件

构建过程这里是指【拼合】与【安装】过程。

构建过程会生成一些临时文件。可以借助以下命令清除。

```sh
cd    <this repository>
./to-clear-built-files.sh
```

> 不必担心构建产生的临时文件会被 Git 跟踪。它们均借助 .gitignore 文件排除在
> Git 的跟踪视野之外。