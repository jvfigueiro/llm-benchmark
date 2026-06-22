for model in phi4-mini:3.8b; do
  echo "Benchmarking model: $model"

  start=$(date +%s.%N)

  response=$(curl -s http://localhost:11434/api/generate -d "{
    \"model\": \"$model\",
    \"prompt\": \"Explique de forma técnica e objetiva o que é um container LXC, suas vantagens e um caso de uso prático.\",
    \"stream\": false
  }")

  end=$(date +%s.%N)
  total_time=$(echo "$end - $start" | bc)

  echo "$response" | jq -e '.eval_duration' >/dev/null 2>&1

  if [ $? -eq 0 ]; then
    tokens_per_sec=$(echo "$response" | jq -r '.eval_count / (.eval_duration / 1000000000)')
    tokens=$(echo "$response" | jq -r '.eval_count')

    echo "Elapsed Time: ${total_time}s"
    echo "Speed: ${tokens_per_sec} tokens/s"
    echo "Generated Tokens: ${tokens}"

    echo ""
    echo "Response Sample:"
    echo "$response" | jq -r '.response' | head -n 3
  else
    echo "Failed (out of memory/timeout)"
  fi

  echo ""
done