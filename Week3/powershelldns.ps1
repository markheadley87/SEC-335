param(
    [string]$IPPrefix,
    [string]$DNSServer
)

2..254 | ForEach-Object {
    $currentIP = "${IPPrefix}$_"
    $result = nslookup $currentIP $DNSServer 2>&1

    # Check if nslookup was successful
    if ($result -notlike '*non-existent domain*' -and $result -notlike '*can't find*') {
        $nameLine = $result | Where-Object { $_ -match 'name = ' }
        if ($nameLine) {
            $hostname = $nameLine.Split('=')[-1].Trim()
            "$hostname ($currentIP)"
        }
    }
}
