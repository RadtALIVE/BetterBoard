; BetterBoard installer script (Inno Setup)
; Builds a normal Windows "Setup.exe" — Next -> Next -> Install -> Finish.
;
; The app source lives in a separate private repo and is checked out by the GitHub
; Actions workflow into "source/BetterBoardApp" at the root of this repo, then
; published to:
;   source\BetterBoardApp\bin\Release\net8.0-windows\win-x64\publish\
; (the workflow does the checkout + publish automatically before running ISCC)

#define MyAppName "BetterBoard"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Better Co."
#define MyAppExeName "BetterBoard.exe"

[Setup]
AppId={{2C6C6C0A-6B1D-4C7B-9C8F-BETTERBOARD01}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
OutputBaseFilename=BetterBoard-Setup
OutputDir=dist
Compression=lzma2
SolidCompression=yes
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
UninstallDisplayIcon={app}\{#MyAppExeName}
SetupIconFile=..\source\BetterBoardApp\Assets\icon.ico
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "Create a &desktop shortcut"; GroupDescription: "Additional shortcuts:"

[Files]
Source: "..\source\BetterBoardApp\bin\Release\net8.0-windows\win-x64\publish\*"; DestDir: "{app}"; Flags: recursesubdirs createallsubdirs ignoreversion

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Launch {#MyAppName}"; Flags: nowait postinstall skipifsilent

