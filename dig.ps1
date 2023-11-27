function Dig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$DomainName,

        [string]$RecordType = "A",

        [switch]$Trace,
        [switch]$Query,
        [switch]$Authority,
        [switch]$Additional,
        [switch]$Short,
        [switch]$All,
        [switch]$Help
    )

    if ($Help) {
        Write-Output "Usage: .\\dig.ps1 [-DomainName] <string> [-RecordType <string>] [+Trace] [+Query] [+Authority] [+Additional] [+Short] [+All] [-Help]"
        Write-Output ""
        Write-Output "Parameters:"
        Write-Output "  -DomainName   : Domain name to perform DNS lookup."
        Write-Output "  -RecordType   : Type of DNS record (default: A)."
        Write-Output "  +Trace        : Perform DNS trace."
        Write-Output "  +Query        : Perform DNS query."
        Write-Output "  +Authority    : Perform authority query."
        Write-Output "  +Additional   : Perform additional query."
        Write-Output "  +Short        : Perform short query."
        Write-Output "  +All          : Perform all query."
        Write-Output "  -Help         : Display this help information."
        exit 0
    }

    try {
        if (-not $DomainName) {
            throw "Please provide a domain name."
        }

        if ($Trace) {
            $traceResult = Resolve-DnsName -Name $DomainName -DnsOnly -Type NS
            if ($traceResult) {
                Write-Output "DNS trace results for $DomainName:"
                foreach ($nsRecord in $traceResult) {
                    Write-Output "NameServer: $($nsRecord.NameHost)"
                }
            } else {
                Write-Output "No DNS trace results found for $DomainName."
            }
        } elseif ($Query) {
            $queryResult = Resolve-DnsName -Name $DomainName -Type $RecordType
            if ($queryResult) {
                Write-Output "Query results for $DomainName ($RecordType):"
                foreach ($record in $queryResult) {
                    Write-Output "$($record.Name) $($record.Type) $($record.IPAddress)"
                }
            } else {
                Write-Output "No DNS records found for $DomainName."
            }
        } elseif ($Authority) {
            # Perform authority query
            # No direct equivalent to dig +authority in Resolve-DnsName
            Write-Output "Authority not supported by Resolve-DnsName."
        } elseif ($Additional) {
            # Perform additional query
            # No direct equivalent to dig +additional in Resolve-DnsName
            Write-Output "Additional not supported by Resolve-DnsName."
        } elseif ($Short) {
            # Perform short query
            # No direct equivalent to dig +short in Resolve-DnsName
            Write-Output "Short not supported by Resolve-DnsName."
        } elseif ($All) {
            # Perform all query
            # No direct equivalent to dig +all in Resolve-DnsName
            Write-Output "All not supported by Resolve-DnsName."
        }
    } catch {
        Write-Output "Error occurred: $_"
    }
}

# Parse command-line arguments
param (
    [string]$DomainName,
    [string]$RecordType = "A",
    [switch]$Trace,
    [switch]$Query,
    [switch]$Authority,
    [switch]$Additional,
    [switch]$Short,
    [switch]$All,
    [switch]$Help
)

Dig -DomainName $DomainName -RecordType $RecordType -Trace:$Trace -Query:$Query -Authority:$Authority -Additional:$Additional -Short:$Short -All:$All -Help:$Help
