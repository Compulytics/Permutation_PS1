try{
	if (Test-Path RESULTS.TXT){
		Remove-Item RESULTS.TXT
	}
	$VARS = @()
	$INDEX = @()
	$VARSFILE = $args[0]
	$MIN_KEYSPACE = $args[1]
	$MAX_KEYSPACE = $args[2]
	if (Test-Path $VARSFILE){
		if ($MAX_KEYSPACE -ge $MIN_KEYSPACE){
			Get-Content $VARSFILE | Foreach-Object{
				$VARS += $_
			}
			$INDEXCAP = $MAX_KEYSPACE - 1
			$i = 0
			1..$MAX_KEYSPACE | % {
				if ($i -lt $MIN_KEYSPACE){
					$INDEX += 0
				}
				else{
					$INDEX += 999999999999999
				}
				$i += 1
			}
			$i -= 1
			While ($INDEX[$i] -ne $VARS.Length){
				$j=0
				While ($j -lt $i){
					$k=0
					$l=1
					$m=2
					While ($k -lt $i){
						if ($INDEX[$k] -eq $VARS.Length){
							if ($INDEX[$l] -gt $VARS.Length){
								$INDEX[$l] = 0
							}
							else{
								$INDEX[$l] += 1
							}
							$INDEX[$k] = 0
						}
						$k += 1
						$l += 1
						$m += 1
					}
					$n=$i
					While ($n -ge 0){
						if ($INDEX[$j] -ne $VARS.Length){
							if ($INDEX[$INDEXCAP] -ne $VARS.Length){
								Add-Content RESULTS.TXT $VARS[$INDEX[$n]] -NoNewLine
							}
						}
						$n -= 1
					}
					if ($INDEX[$INDEXCAP] -ne $VARS.Length){
						Add-Content RESULTS.TXT ""
					}
					$INDEX[0] += 1
					$j += 1
				}
			}
		}
	}
	else{
		Write-Host "Please provide a valid source file"
	}
}
catch{
	Write-Host "Usage: ./THISFILE <Input File> <Minimum Length> <Maximum Length>"
}