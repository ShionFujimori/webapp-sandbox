import pytest
from features.function import Function


@pytest.fixture
def function() -> Function:
    return Function()


def test_app(function: Function) -> None:
    response = function.add(2, 3)
    assert response == 5
