# Update Github DNS

# DNS源来自https://github.com/521xueweihan/GitHub520
# 如果这个项目对你有帮助，不要忘了也前往那个项目点一个star
$url = "https://raw.hellogithub.com/hosts"

$response = Invoke-WebRequest -Uri $url -UseBasicParsing
$downloadedContent = [System.Text.Encoding]::UTF8.GetString($response.Content)

# 插入hosts的内容
$insertContent = @"
# UpdateGithubDNS Start
$($downloadedContent)
# Powershell Script by 
# UpdateGithubDNS End
"@

# 系统的hosts文件路径
$hostsFilePath = "$env:windir\System32\drivers\etc\hosts"

# 读取hosts文件内容
$hostsContent = Get-Content $hostsFilePath -Raw

# 检查是否已经存在我们的hosts内容，如果存在，进行替换
if ($hostsContent -match "# UpdateGithubDNS Start(?:.|\n)*# UpdateGithubDNS End") {
    $hostsContent = $hostsContent -replace "# UpdateGithubDNS Start(?:.|\n)*# UpdateGithubDNS End", $insertContent
}
else {
    $hostsContent += $insertContent
}

# 写回内容到hosts文件，需要管理员权限
Set-Content -Path $hostsFilePath -Value $hostsContent

Write-Output "[UpdateGithubDNS] 已更新hosts文件"
