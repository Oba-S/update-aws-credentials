param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$MFAToken
)

#各自設定が必要な項目(環境変数から呼び出すでも可)
[string]$arnOfTheMfaDevice = "arn:aws:iam::123456789101:mfa/tanaka_iphone"
[string]$profileLocation = "C:\Users\UserName\.aws\credentials"
[string]$ProfileName = "MyProfile"
[string]$StoreAsProfile = "default"

Import-Module AWSPowerShell

$sts = Get-STSSessionToken -SerialNumber $arnOfTheMfaDevice -TokenCode $MFAToken -DurationSeconds 3600 -ProfileName $ProfileName
Set-AWSCredential -AccessKey $sts.AccessKeyId -SecretKey $sts.SecretAccessKey -SessionToken $sts.SessionToken -StoreAs $StoreAsProfile -ProfileLocation $profileLocation

Write-Host "セッショントークンが更新されました。"