package main

import (
	"encoding/json"
	"fmt"
	"os"
	"time"
)

func getTime(input map[string]interface{}) {
	fmt.Println("getTime() start \n------------------")

	// 環境変数からタイムゾーンを取得
	tzName, ok := input["Timezone"].(string)
	if ok {
		fmt.Println("Timezone:", tzName)
	}

	// 指定されたタイムゾーンの時刻を出力
	tz, _ := time.LoadLocation(tzName)
	fmt.Println(tz.String())
	fmt.Println(time.Now().In(tz))

	// UTCの時刻を出力
	utc, _ := time.LoadLocation("UTC")
	fmt.Println(utc.String())
	fmt.Println(time.Now().In(utc))

	fmt.Println("getTime() end------------------")
}

func getEnvVars(input map[string]interface{}) {
	fmt.Println("getEnvVars() start \n------------------")

	// 渡された環境変数を出力
	for key, value := range input {
		fmt.Printf("%s: %v\n", key, value)
	}

	fmt.Println("getEnvVars() end \n------------------")
}

func main() {
	fmt.Printf("Task start\n")

	// 環境変数からJSONデータを取得
	// batchTypeによって異なる、以下のようなstringが格納されている
	// getEnvVars→ 任意のkey/value
	// getTime→ {"Timezone":"Asia/Tokyo"}
	batchInputData := os.Getenv("BATCH_INPUT")

	// JSONデータを map にパース
	var batchInput map[string]interface{}
	err := json.Unmarshal([]byte(batchInputData), &batchInput)
	if err != nil {
		fmt.Println("Error parsing JSON:", err)
		return
	}

	// batchTypeによって処理を分岐
	switch batchType := os.Getenv("BATCH_TYPE"); batchType {
	case "GetEnvVars":
		getEnvVars(batchInput)
	case "GetTime":
		getTime(batchInput)
	default:
		fmt.Println("Unknown batchType:", batchType)
	}

	fmt.Printf("Task end\n")
}
