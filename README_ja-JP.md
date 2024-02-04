# stepfunctions-ecs-batch

StepFunctionsの入力をECSタスクに受け渡す(GoおよびAWSリソース設定のための)参考実装です。

## StepFunctions ステートマシンの実装

実行時の入力JSONに含まれる値を `ContainerOverrides` を利用してECSタスクの環境変数に渡します。

- `batchType` → 環境変数 `BATCH_TYPE`
- `batchInput` → 環境変数 `BATCH_INPUT`

`batchInput`の値はJSONデータであることを前提として、[組み込み関数](https://docs.aws.amazon.com/step-functions/latest/dg/amazon-states-language-intrinsic-functions.html)の`States.JsonToString()`を利用し、文字列として環境変数にセットします。

[ASL](terraform/statemachine/asl.json)

```json
                "Overrides": {
                    "ContainerOverrides": [
                        {
                            "Name": "${ECS_CONTAINER_NAME}",
                            "Environment": [
                                {
                                    "Name": "BATCH_TYPE",
                                    "Value.$": "$.batchType"
                                },
                                {
                                    "Name": "BATCH_INPUT",
                                    "Value.$": "States.JsonToString($.batchInput)"
                                }
                            ]
                        }
                    ]
                }
```

## ECSタスク内での処理についての説明(アプリケーション実装者向け)

StepFunctions ステートマシンの定義をもとに、以下の2つの単純なバッチ処理を実装しています。
環境変数 `BATCH_TYPE` にStepFunctionsの入力から渡される値(入力JSONにおける `batchType` )により、ECSタスクが起動した際に実行される処理が決定されます。
また、環境変数 `BATCH_INPUT` にバッチ処理の実行に用いるパラメータ(入力JSONの `batchInput`)が渡されます。

実装の詳細については、[main.go](main.go)を参照してください。

### `GetEnvVars`

StepFunctionsの入力から渡された環境変数をログ出力します。

#### 入力

```json
{
    "batchType": "GetEnvVars",
    "batchInput": {
        "Foo": "foo",
        "Bar": "bar",
        "Baz": "baz"
    }
}
```

### `GetTime`

StepFunctionsの入力から渡された環境変数をもとに、指定されたタイムゾーンの時刻(とUTCの時刻)をログ出力します。

#### 入力

```json
{
    "batchType": "GetTime",
    "batchInput": {
        "Timezone": "Asia/Tokyo"
    }
}
```
