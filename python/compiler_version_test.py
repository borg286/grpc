import os
import platform
import sys

import pytest


class TestPythonVersion:
    def test_version(self):
        assert(os.path.abspath(os.path.join(os.getcwd(),"..", "python_interpreter", "python_bin")) in sys.executable)
        assert(platform.python_version() == "3.8.3")


if __name__ == "__main__":
    import pytest
    raise SystemExit(pytest.main([__file__]))