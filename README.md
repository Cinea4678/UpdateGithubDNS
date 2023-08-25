# GitHub DNS一键更新脚本

这个脚本的作用是帮助中国大陆的用户(和他们电脑上的工具)便捷、高效地访问GitHub。

脚本会从仓库[521xueweihan/GitHub520](https://github.com/521xueweihan/GitHub520)提供的源下载最新、最适合大陆用户的GitHub DNS，并将它一键添加到你的Hosts中。不要忘了也给他们一颗Star。

脚本运行需要管理员权限——不过别担心！你随时都可以审查脚本的内容，确保你的电脑安全无虞。

脚本目前只支持Windows系统。如果你愿意为其他系统适配，欢迎提出PR。

## 使用方法

### 下载本项目到你的本地文件夹

```powershell
git clone https://github.com/Cinea4678/UpdateGithubDNS.git
cd UpdateGithubDNS
```

如果你访问GitHub困难，也可以使用项目作者的私服来下载：

```powershell
git clone https://www.cinea.com.cn/git/UpdateGithubDNS.git
cd UpdateGithubDNS
```

### 单次使用

请以管理员身份启动Powershell，进入到存储脚本的文件夹中，然后复制这段代码到你的Powershell中：

```powershell
$policy = Get-ExecutionPolicy
Set-ExecutionPolicy RemoteSigned
.\UpdateGithubDNS.ps1
Set-ExecutionPolicy $policy
```

你也许注意到了，我们会短暂地打开名为RemoteSigned的执行权限。这是因为Powershell默认带有外部脚本的执行限制，我们需要RemoteSigned权限来让我们的脚本获得运行的权限。别担心！我们会在脚本运行结束后将权限恢复。

### 设置定时任务

你也可以将脚本设置到计划任务中，每天自动执行。以下是一个范例，它创建一个每天中午12:00执行的计划任务。

请注意，你只能使用经典的Windows Powershell来运行这段脚本，因为使用.Net Core实现的新版Powershell不提供PSScheduledJob模块的支持。如果你不理解这句话的含义，那就说明你不需要操心这个问题，直接使用`Win+X`中提供的Powershell或者终端即可。

```powershell
Copy-Item .\UpdateGithubDNS.ps1 ~
Import-Module PSScheduledJob
$scriptBlock = {
    $policy = Get-ExecutionPolicy
    Set-ExecutionPolicy RemoteSigned -Force
    ~\UpdateGithubDNS.ps1
    Set-ExecutionPolicy $policy -Force
}
$option = New-ScheduledJobOption -RunElevated -RequireNetwork 
$trigger = New-JobTrigger -Daily -At "12:00 PM"
Register-ScheduledJob -Name "Update-GitHub-DNS" -ScriptBlock $scriptBlock -ScheduledJobOption $option -Trigger $trigger
```

## 致谢

本项目中使用了[521xueweihan/GitHub520](https://github.com/521xueweihan/GitHub520)提供的GitHub DNS。


