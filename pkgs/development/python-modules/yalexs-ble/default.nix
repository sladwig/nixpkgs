{ lib
, async-timeout
, bleak
, bleak-retry-connector
, buildPythonPackage
, cryptography
, fetchFromGitHub
, poetry-core
, pytest-asyncio
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "yalexs-ble";
  version = "2.1.4";
  format = "pyproject";

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "bdraco";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-FvZ0U8aZNnGehDMt3+LWLYKU/CSPpifWE7STZkA+0iA=";
  };

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    async-timeout
    bleak
    bleak-retry-connector
    cryptography
  ];

  nativeCheckInputs = [
    pytest-asyncio
    pytestCheckHook
  ];

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace " --cov=yalexs_ble --cov-report=term-missing:skip-covered" ""
  '';

  pythonImportsCheck = [
    "yalexs_ble"
  ];

  meta = with lib; {
    description = "Library for Yale BLE devices";
    homepage = "https://github.com/bdraco/yalexs-ble";
    changelog = "https://github.com/bdraco/yalexs-ble/blob/v${version}/CHANGELOG.md";
    license = with licenses; [ gpl3Only ];
    maintainers = with maintainers; [ fab ];
  };
}
