$models = @("gemma4:e4b")
$promptText = "Explique de forma técnica e objetiva o que é um container LXC, suas vantagens e um caso de uso prático."

foreach ($model in $models) {
    Write-Host "Benchmarking model: $model"

    $body = @{
        model  = $model
        prompt = $promptText
        stream = $false
    } | ConvertTo-Json

    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

    try {
        $response = Invoke-RestMethod -Uri "http://localhost:11434/api/generate" `
                                      -Method Post `
                                      -Body $body `
                                      -ContentType "application/json" `
                                      -ErrorAction Stop

        $stopwatch.Stop()
        $totalTime = $stopwatch.Elapsed.TotalSeconds

        if ($null -ne $response.eval_duration) {
            $evalDurationSec = $response.eval_duration / 1000000000
            $tokensPerSec = $response.eval_count / $evalDurationSec
            $tokens = $response.eval_count

            Write-Host "Elapsed Time: $([math]::Round($totalTime, 2))s"
            Write-Host "Speed: $([math]::Round($tokensPerSec, 2)) tokens/s"
            Write-Host "Generated Tokens: $tokens"
            Write-Host ""
            Write-Host "Response Sample:"

            $response.response -split "`n" | Select-Object -First 3 | ForEach-Object { Write-Host $_ }
        } else {
            Write-Host "Metrics not found in the response."
        }
    } catch {
        $stopwatch.Stop()
        Write-Host "Failed (out of memory, timeout ou falha de conexão HTTP)"
        Write-Host "Error details: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    Write-Host ""
}