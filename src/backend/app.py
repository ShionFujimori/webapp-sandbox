import json
from http import HTTPStatus

from aws_lambda_powertools.utilities.typing import LambdaContext


def make_response(statusCode: int, message: str, body: dict = {}) -> dict:
    return {
        "statusCode": statusCode,
        "headers": {
            "Access-Control-Allow-Headers": "Content-Type",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "*",
        },
        "message": message,
        "body": json.dumps(body),
    }


def lambda_handler(event: dict, context: LambdaContext) -> dict:
    try:
        return make_response(HTTPStatus.OK, "Successful", {"response": "Hello World!"})
    except Exception as e:
        print(e)
        return make_response(HTTPStatus.INTERNAL_SERVER_ERROR, "failed to get context")
