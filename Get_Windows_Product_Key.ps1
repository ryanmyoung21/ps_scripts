$key = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -Name 'DigitalProductId').DigitalProductId
$productKey = ""

for ($i = 24; $i -ge 16; $i--) {
    $char = [char][byte](($key[$i] -shr 4) + 97)
    $productKey = $char.ToString() + $productKey

    $char = [char][byte](($key[$i] -band 15) + 97)
    if ($i -eq 19 -or $i -eq 15) {
        $char = $char.ToString().ToUpper()
    }
    $productKey = $char.ToString() + $productKey
}

$length = $productKey.Length
$productKey = $productKey.Substring(0, 5) + "-" + $productKey.Substring(5, $length - 5)

$length = $productKey.Length
$productKey = $productKey.Substring(0, $length - 9) + "-" + $productKey.Substring($length - 9, 5) + "-" + $productKey.Substring($length - 5)

$productKey