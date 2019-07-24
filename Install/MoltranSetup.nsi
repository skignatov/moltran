;��� ����ᠫ SKI
;���⠫���� � �ணࠬ�� MOLTRAN
;--------------------------------
;����砥� ����室��� ���㫨

  !include "Sections.nsh"  ; - ����� ��� ࠡ��� � ᥪ�ﬨ ���⠫����

;--------------------------------
;���䨣����                     � �⮬ ࠧ���� ᮤ�ঠ��� ������ ����ன�� ���⠫����

  ;�������
  SetCompressor lzma          ; - ᦨ���� ���⠫���� �����⬮� Lzma
;  SetDatablockOptimize on     ; - ��⨬����� ����� ������
  Name "Moltran 2.5"      ; - �������� ���⠫����
  OutFile "MoltranSetup.exe"       ; - ��室��� 䠩� � ���⠫���஬ ��᫥ �믮������ �������樨
  AllowRootDirInstall false   ; - �⬥�塞 ����������� ��⠭���� �ணࠬ�� � ��७�
  AutoCloseWindow false       ; - �⬥�� ��⮧������ ���⠫���� ��᫥ �믮������ ��� ����⢨�
  CRCCheck off                ; - �⬥�� �஢�ન ����஫쭮� �㬬� ���⠫����
  SetFont Tahoma 8            ; - �᭮���� ���� ���⠫���� - Tahoma ࠧ��஬ � 8pt
  WindowIcon off              ; - �몫�砥� ������ � ���� ���⠫����
  XPStyle on                  ; - ����砥� �ᯮ�짮����� �⨫� XP
  SetOverwrite on             ; - ����������� ��१���� 䠩��� ����祭�

  ;����� ��� ���⠫��樨 �� 㬮�砭��
  InstallDir "$PROGRAMFILES\Moltran"
  
  ;����娢��� � ॥��� ���� ��� ��⠭����
  InstallDirRegKey HKCU "Software\Moltran" ""

;--------------------------------
;����ன�� ����䥩�


;--------------------------------
;��࠭���, �ᯮ��㥬� � ���⠫����

Var VARPATH
VAR x

Page DIRECTORY
Page INSTFILES "" "" RebootFunc
Uninstpage uninstconfirm 
Uninstpage instfiles
  
;--------------------------------
;��모
 
;  !insertmacro MUI_LANGUAGE "English"      ; - ������ �� ��� "���᪨�"

;--------------------------------
;���樨 ��������⮢ ��� ��⠭����

Section !�ணࠬ�� Program           ; ᥪ�� "�ணࠬ��". ���� "!" ����砥�, �� �㭪� ���� ⥪�⮬
  SectionIn RO                       ; ᥪ�� ⮫쪮 ��� �⥭�� (�� �⪫����)
  SetOutPath "$INSTDIR"              ; ����� ��� �믮������ ����権
  CreateDirectory "$INSTDIR"                    ; ᮧ���� ����� 
  File "Moltran.exe"    ; ��࠭塞 �㦭� 䠩��
  File "Moltran.cfg"
  File "Moltran.fdb"
  File "Moltran.hlp"
  File "Moltran.pdf"
  File "Mndod.dat"

; �������� ��몮�
    CreateDirectory "$SMPROGRAMS\Moltran"
    CreateShortCut "$SMPROGRAMS\Moltran\Moltran.lnk" "$INSTDIR\Moltran.exe"
    CreateShortCut "$SMPROGRAMS\Moltran\Moltran manual.lnk" "$INSTDIR\Moltran.pdf"
    CreateShortCut "$SMPROGRAMS\Moltran\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
    CreateShortCut "$Desktop\Moltran.lnk" "$INSTDIR\Moltran.exe"

; ���࠭塞 ���� � �ணࠬ�� � ॥���
  WriteRegStr HKCU "Software\Moltran" "" $INSTDIR
 
; Setting of Path and environment variables
  ReadRegStr $VARPATH HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "Path"
  StrCpy $x $VARPATH
  StrCpy $VARPATH $x;$INSTDIR;
  WriteRegStr HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "Path" $VARPATH
  WriteRegStr HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "Moltran" $INSTDIR

 
; ������� uninstall'��� � �����뢠�� ��� � �����, �㤠 ��⠭�������� �ணࠬ��
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd                            ; - ⠪ �����稢����� �� �� ᥪ権

 
;--------------------------------
;Uninstaller Section

Section "Uninstall"  ; ������ ᥪ�� ����室��� ��� ���ᠭ�� �����⠫����

;  MessageBox MB_YESNO|MB_ICONQUESTION "Do you really want to remove Moltran from your computer?" 0 +1

  Delete "$INSTDIR\Uninstall.exe"          ; 㤠����� 䠩���
  Delete "$INSTDIR\Moltran.exe"
  Delete "$INSTDIR\Moltran.cfg"
  Delete "$INSTDIR\Moltran.fdb"
  Delete "$INSTDIR\Moltran.hlp"
  Delete "$INSTDIR\Moltran.pdf"
  Delete "$INSTDIR\Mndod.dat"
  Delete "$INSTDIR\*.*"
  RMDir "$INSTDIR"
  
  ;����塞 ���㦭� �㭪�� ���� ���
 
  Delete "$SMPROGRAMS\Moltran\Moltran.lnk"
  Delete "$SMPROGRAMS\Moltran\Moltran manual.lnk"
  Delete "$SMPROGRAMS\Moltran\Uninstall.lnk"
  RMDIR "$SMPROGRAMS\Moltran"
  Delete "$Desktop\Moltran.lnk" 
   
; Remove the registry keys
  DeleteRegKey /ifempty HKCU "Software\Moltran"     ; 㤠�塞 ���� �� ॥���...
  DeleteRegValue HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "Moltran" 
  DeleteRegKey HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment\Moltran"

SectionEnd


Function RebootFunc

MessageBox MB_YESNO|MB_ICONQUESTION "You have to restart your computer. Restart now?" IDNO +2
reboot
MessageBox MB_OK "OK, then you need to do that later..." 
FunctionEnd
