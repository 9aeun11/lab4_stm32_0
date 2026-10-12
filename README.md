# LAB4 FPGA/MCU · STM32_0 (10/12)

수업 저장소 `Glaysia/ece2_474`의 **v1.1.0**을 기준으로 준비한 실습 파일입니다. 구현·검증 범위는 STM32_0이며, STM32_1 이후 실습과 기말 프로젝트는 수행하지 않았습니다. VS Code 프로젝트의 원본 참고 문서는 버전 보존을 위해 함께 있습니다.

## VS Code · MCU

`vscode/ece2_474/ece2_474.code-workspace`를 엽니다. `STM32CubeIDE for Visual Studio Code` 확장을 설치하고 CMake `Configure > Debug`, `Build`를 실행합니다. 현재 `Core/Src/ece2_474_routine.c`는 수업 `v1.1.0`의 기본 실습 템플릿입니다. 예제나 과제를 실행할 때만 이 파일을 교체합니다. `vscode/ece2_474/evidence/example_1`과 `example_2`에는 각각 교안 예제를 교체한 전체 파일이 있습니다. `vscode/variants`에는 과제 1·2의 **전체 파일**만 있습니다. 제공 예제 1·2는 위 `evidence` 폴더에서 확인합니다. 각 단계를 실행할 때 `Core/Src/ece2_474_routine.c`를 해당 파일 내용으로 교체하고 다시 빌드합니다. 같은 이름의 함수를 중복 추가하지 않습니다.

이 컴퓨터의 `.vscode/settings.json`은 설치된 Arm GNU Toolchain 경로를 가리킵니다. 이 설정 파일은 컴퓨터별 경로 때문에 Git에 올리지 않습니다. GitHub에서 다시 받을 때는 VS Code 확장의 도구 번들을 설치하거나 로컬 설정에서 자신의 컴파일러 경로를 지정하면 됩니다. 수업 기본 워크스페이스는 그대로 포함했습니다.

보드에서는 JP5=`5V_STLK`, ST-LINK USB 연결 후 `STM32Cube: Launch ST-Link GDB Server`에서 F5를 누릅니다. `main`에서 멈추면 F5로 실행합니다. 과제 2의 외부 LED는 PB0 → 330Ω~1kΩ 저항 → LED 긴 다리(+), LED 짧은 다리(-) → GND로 배선합니다. 실제 보드 동작은 연결 후 확인해야 합니다.

## Vivado · FPGA

`vivado/mult_4bit/mult_4bit.xpr`와 `vivado/bcd_conv/bcd_conv.xpr`를 **하나씩** 엽니다. 설계 top은 각각 `mult_4bit`, `bcd_conv`이며 시뮬레이션 top은 각각 `tb`입니다. 두 TB를 한 프로젝트에 동시에 넣지 않았습니다. `Run Behavioral Simulation`에서 PASS와 파형을 확인합니다. 보드 구현 시에는 TB를 제외하고 설계 top을 선택합니다.

XDC의 기본 핀은 장비 제공 ZIP의 동일 이름 프로젝트에서 추출했습니다. BCD의 `valid` 출력은 수업 추가 자료 기능이므로 원본 XDC에 없으며, 장비 ZIP과 기존 S75 보드 핀맵에서 미사용 LED 핀 `N5`를 확인해 연결했습니다. 실제 장비가 Combo II-DLD S75(`xc7s75fgga484-1`)인지 확인한 뒤 보드에 다운로드합니다. 보드 시연은 아직 완료되지 않았습니다.

두 TB는 Vivado XSim에서 각각 256개 입력 조합 검증을 통과했습니다. `vivado/*/evidence`에 콘솔 기록을 남겼습니다. 두 설계 모두 합성·구현·DRC를 통과했고 같은 폴더에 보드용 `.bit` 파일을 생성했습니다. XDC는 원본 예제처럼 클록 제약이 없는 조합회로 설정이며, 실제 보드 연결·시연은 장비에서 확인해야 합니다.

## VS Code · FPGA 시뮬레이션

실습 1은 `vscode/fpga_1_mult_4bit.code-workspace`, 실습 2는 `vscode/fpga_2_bcd_conv.code-workspace`를 VS Code에서 **각각 따로** 엽니다. 각 작업 공간은 해당 Vivado 프로젝트 하나만 표시합니다. 메뉴 `Terminal > Run Task`에서 해당 실습 작업을 실행하면 이 컴퓨터에 설치된 Vivado 2026.1의 XSim이 실행됩니다. 출력 창에서 실습 1은 `PASS multiplier: 256 input pairs`, 실습 2는 `PASS BCD: 100 valid and 156 invalid inputs`를 확인합니다. 다른 컴퓨터에서는 `vscode/run_fpga_sim.cmd`의 Vivado 실행 파일 경로를 설치 경로에 맞게 수정해야 합니다. VS Code 작업은 `vscode/run_fpga_sim.cmd`가 임시 영문 드라이브 경로로 같은 프로젝트를 열어 한글 폴더명이 XSim 로그에서 깨지는 문제를 피합니다. 작업 종료 후 임시 드라이브 연결은 해제됩니다. 깨끗한 로그 사본은 각 프로젝트의 `evidence/vscode_simulation_log.txt`에 있습니다. 파형 확인과 FPGA 보드 다운로드는 각 Vivado 프로젝트에서 진행합니다. STM32 CMake `Build` 버튼은 FPGA 시뮬레이션용이 아닙니다.
