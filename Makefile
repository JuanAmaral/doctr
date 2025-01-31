.PHONY: quality style test test-common test-tf test-torch docs-single-version docs
# this target runs checks on all files
quality:
	isort . -c
	ruff check .
	black --check .
	mypy doctr/
	pydocstyle doctr/

# this target runs checks on all files and potentially modifies some of them
style:
	isort .
	black .
	ruff --fix .

# Run tests for the library
test:
	coverage run -m pytest tests/common/
	USE_TF='1' SLOW='1' coverage run -m pytest tests/tensorflow/
	USE_TORCH='1' SLOW='1' coverage run -m pytest tests/pytorch/

test-common:
	coverage run -m pytest tests/common/

test-tf:
	USE_TF='1' SLOW='1' coverage run -m pytest tests/tensorflow/

test-torch:
	USE_TORCH='1' SLOW='1' coverage run -m pytest tests/pytorch/

# Check that docs can build
docs-single-version:
	sphinx-build docs/source docs/_build -a

# Check that docs can build
docs:
	cd docs && bash build.sh
