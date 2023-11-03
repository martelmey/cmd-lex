$pinghosts = Get-Content "ping-hosts.txt"
$telnethosts = Get-Content "telnet-hosts.txt"
$telnetports = Get-Content "telnet-ports.txt"
$nslookuphosts = Get-Content "nslookup-hosts.txt"

$telnet = Import-Csv "telnet.csv"
$OutArray = @()
Import-Csv telnet.csv |`
ForEach-Object { 
    try {
        $rh = $_.remoteHost
        $p = $_.port
        $socket = new-object System.Net.Sockets.TcpClient($rh, $p)
    } catch [Exception] {
        $myobj = "" | Select "remoteHost", "port", "status"
        $myobj.remoteHost = $rh
        $myobj.port = $p
        $myobj.status = "failed"
        Write-Host $myobj
        $outarray += $myobj
        $myobj = $null
        return
    }
    $myobj = "" | Select "remoteHost", "port", "status"
    $myobj.remoteHost = $rh
    $myobj.port = $p
    $myobj.status = "success"
    Write-Host $myobj
    $outarray += $myobj
    $myobj = $null
    return
}
$outarray | export-csv -path "result.csv" -NoTypeInformation

foreach ($pinghost in $pinghosts) {
    if (Test-Connection -ComputerName $pinghost -Count 1 -ErrorAction SilentlyContinue) {
        Write-Host "$pinghost, up"
    }
    else {
        Write-Host "$pinghost, down"
    }
}

foreach ($telnethost in $telnethosts) {
    foreach ($telnetport in $telnetports) {
        $Socket = New-Object Net.Sockets.TcpClient
        $ErrorActionPreference = 'SilentlyContinue'
        $Socket.Connect($telnethost, $telnetport)
        $ErrorActionPreference = 'Continue'
        if ($Socket.Connected) {
            "${telnethost}: Port $telnetport is open"
            $Socket.Close()
        }
        else {
            "${telnethost}: Port $telnetport is closed or filtered"
        }
        #$Socket = $null
    }
}

foreach ($nslookuphost in $nslookuphosts) {
    Resolve-DnsName $nslookuphost -Type A
}