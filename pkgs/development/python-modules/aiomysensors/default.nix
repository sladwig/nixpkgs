{ lib
, aiofiles
, asyncio-mqtt
, awesomeversion
, buildPythonPackage
, click
, fetchFromGitHub
, marshmallow
, poetry-core
, pyserial-asyncio
, pytest-asyncio
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "aiomysensors";
  version = "0.3.6";
  format = "pyproject";

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "MartinHjelmare";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-oYYr7LuTvw7e99930vF7odl2dWA/QPOTEW02l8cqXlc=";
  };

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    aiofiles
    asyncio-mqtt
    awesomeversion
    click
    marshmallow
    pyserial-asyncio
  ];

  nativeCheckInputs = [
    pytest-asyncio
    pytestCheckHook
  ];

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace " --cov=src --cov-report=term-missing:skip-covered" "" \
      --replace 'marshmallow = "^3.17"' 'marshmallow = "*"'
  '';

  pythonImportsCheck = [
    "aiomysensors"
  ];

  meta = with lib; {
    description = "Library to connect to MySensors gateways";
    homepage = "https://github.com/MartinHjelmare/aiomysensors";
    license = with licenses; [ asl20 ];
    maintainers = with maintainers; [ fab ];
  };
}
