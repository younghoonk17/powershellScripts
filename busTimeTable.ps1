
function busAPI {
    
    $url = "https://api.at.govt.nz/v2/public-restricted/departures/1090?subscription-key=323741614c1c4b9083299adefe100aa6&hours=1&rowCount=1&isMobile=false&mobileRowCount=15&_=1537610771739"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    $result = Invoke-WebRequest $url -Method Get | ConvertFrom-Json

    $busNumber = $args[0]


    if ( ([string]::IsNullOrEmpty($busNumber))){
        $result.response.movements | Select scheduledArrivalTime, expectedArrivalTime, route_short_name, destinationDisplay
    }
    else{
        $result.response.movements | Select scheduledArrivalTime, expectedArrivalTime, route_short_name, destinationDisplay | Where {$_.route_short_name -eq $busNumber};
    }


    if ( $args[1] -gt 0){
        Start-Sleep 30
    }

    
}

function repeat {
    $counter = 0

    For(;;){
        busAPI $args[0] $counter
        $counter++
    }
}

repeat 875

