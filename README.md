# stepfunctions-ecs-batch

Reference implementation for passing StepFunctions input to ECS tasks (for Go and AWS resource configuration).

## StepFunctions state machine implementation

The values in the runtime input JSON are passed to the ECS task environment variables using `ContainerOverrides`.

- `batchType` → environment variable `BATCH_TYPE`.
- `batchInput` → environment variable `BATCH_INPUT`.

The value of `batchInput` is assumed to be JSON data. With `States.JsonToString()` referred in [Intrinsic functions](https://docs.aws.amazon.com/step-functions/latest/dg/amazon-states-language-intrinsic-functions.html), set it as a string to an environment variable.

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

## Explanation of processing within an ECS task

The following two simple batch processes are implemented.
The process to be executed in an ECS Task is determined by the value (`batchType` in the input JSON) passed from the StepFunctions input to the environment variable `BATCH_TYPE`.
When an ECS task is started, the environment variable `BATCH_INPUT` is passed the parameters (`batchInput` in the input JSON) used to execute the batch process.

See [main.go](main.go) for implementation details.

### `GetEnvVars`

Logs out the environment variables passed from the StepFunctions input.

#### Input

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

Logs out the time in the given time zone (and UTC time) based on the environment variables passed from the StepFunctions input.

#### Input

```json
{
    "batchType": "GetTime",
    "batchInput": {
        "Timezone": "Asia/Tokyo"
    }
}
```
