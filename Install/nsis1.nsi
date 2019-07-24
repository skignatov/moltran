;��� ����ᠫ .silent
;���⠫���� � �ணࠬ�� ��������� 2.05
;--------------------------------
;����砥� ����室��� ���㫨

  !include "MUI.nsh"       ; - �� �����, ����室��� ��� �ᯮ�짮����� ������ ����䥩�
  !include "Sections.nsh"  ; - ����� ��� ࠡ��� � ᥪ�ﬨ ���⠫����

;--------------------------------
;���䨣����                     � �⮬ ࠧ���� ᮤ�ঠ��� ������ ����ன�� ���⠫����

  ;�������
  SetCompressor lzma          ; - ᦨ���� ���⠫���� �����⬮� Lzma
  SetDatablockOptimize on     ; - ��⨬����� ����� ������
  Name "��������� 2.05"      ; - �������� ���⠫����
  OutFile "Install.exe"       ; - ��室��� 䠩� � ���⠫���஬ ��᫥ �믮������ �������樨
  AllowRootDirInstall false   ; - �⬥�塞 ����������� ��⠭���� �ணࠬ�� � ��७�
  AutoCloseWindow false       ; - �⬥�� ��⮧������ ���⠫���� ��᫥ �믮������ ��� ����⢨�
  CRCCheck off                ; - �⬥�� �஢�ન ����஫쭮� �㬬� ���⠫����
  SetFont Tahoma 8            ; - �᭮���� ���� ���⠫���� - Tahoma ࠧ��஬ � 8pt
  WindowIcon off              ; - �몫�砥� ������ � ���� ���⠫����
  XPStyle on                  ; - ����砥� �ᯮ�짮����� �⨫� XP
  SetOverwrite on             ; - ����������� ��१���� 䠩��� ����祭�

  ;����� ��� ���⠫��樨 �� 㬮�砭��
  InstallDir "$PROGRAMFILES\Telemaster2"
  
  ;����娢��� � ॥��� ���� ��� ��⠭����
  InstallDirRegKey HKCU "Software\Telemaster2" ""

;--------------------------------
;����ன�� ����䥩�

  !define MUI_HEADERIMAGE_BITMAP_NOSTRETCH     ; - �� ������� ��㭮� � ���������
  !define MUI_HEADERIMAGE                      ; - ����������� �������� � ��������� ��㭮�;
  !define MUI_HEADERIMAGE_BITMAP "Header.bmp"  ; - ᠬ ��㭮� � ���������
  !define MUI_HEADERIMAGE_RIGHT                ; - ��㭮� � ��������� �㤥� ��室����� �ࠢ�
  !define MUI_ABORTWARNING                     ; - �뤠�� �।�०����� �� ����⨨ �� ������ �⬥��
  !define MUI_ICON "Install.ico"               ; - ������ 䠩�� - ���⠫����
  !define MUI_UNICON "UnInstall.ico"           ; - ������ 䠩�� - �����⠫����

;------------------- alpha-blending splash ---------
Function .onInit                               ; - �㭪��, ��� ���ன �㤥� �믮���� �� ���樠����樨
  SetOutPath $TEMP                             ;   ���⠫����. � ������ ��砥 ������ �����뢠�� ����室����
  File /oname=spl.bmp "Splash.bmp"             ;   ��� ���⨭�� ��। ����᪮� ���⠫����

  advsplash::show 1500 2500 250 -1 $TEMP\spl

  Pop $0          

  Delete $TEMP\spl.bmp

FunctionEnd                                    ; - ⠪ �����稢����� �� �㭪樨
;---------------------------------------------------

;--------------------------------
;��࠭���, �ᯮ��㥬� � ���⠫����

  !insertmacro MUI_PAGE_LICENSE "License.txt"  ; - ��࠭�� � ��業���� �� �ணࠬ��
  !insertmacro MUI_PAGE_COMPONENTS             ; - ��࠭�� � �롮஬ ��������⮢ ��� ��⠭����
  !insertmacro MUI_PAGE_DIRECTORY              ; - ��࠭�� � �롮஬ ����� ��� ��⠭����
  
  Var MUI_TEMP                                 ; - ��� ��६���� ��� �࠭���� ��� ��� ��몮� � ���� ���
  Var STARTMENU_FOLDER

  !define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU" 
  !define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\Telemaster2" 
  !define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "��모"
  !insertmacro MUI_PAGE_STARTMENU Application $STARTMENU_FOLDER   ; - ��࠭�� � �롮஬ ��㯯� ��몮�

  !insertmacro MUI_PAGE_INSTFILES              ; - ��࠭�� � �뢮��� ���஡���⥩ ��⠭����
  
  !insertmacro MUI_UNPAGE_CONFIRM              ; - ��࠭�� � ���⢥ত����� 㤠����� (�����⠫����)
  !insertmacro MUI_UNPAGE_INSTFILES            ; - ��࠭�� � ���஡����ﬨ 㤠����� (�����⠫����)
  
;--------------------------------
;��모
 
  !insertmacro MUI_LANGUAGE "Russian"      ; - ������ �� ��� "���᪨�"

;--------------------------------
;���樨 ��������⮢ ��� ��⠭����

Section !�ணࠬ�� Program           ; ᥪ�� "�ணࠬ��". ���� "!" ����砥�, �� �㭪� ���� ⥪�⮬
  SectionIn RO                       ; ᥪ�� ⮫쪮 ��� �⥭�� (�� �⪫����)
  SetOutPath "$INSTDIR"              ; ����� ��� �믮������ ����権
; ����� ���ᠭ�, �� �㤥� �믮����� �� ��⠭���� ������� ��������� ��⠭����
  CreateDirectory "$INSTDIR\BackUp"                    ; ᮧ���� ����� BackUp
  File "d:\MyProgramms\TeleMaster2\Telemaster2.exe"    ; ��࠭塞 �㦭� 䠩��
  File "d:\MyProgramms\TeleMaster2\Telemaster2.ini"
; ����� ࠡ�� � ⮫쪮 �� ��⠭������� INI-䠩���
  WriteINIStr  "$INSTDIR\Telemaster2.ini" "Main"    "BasePath"   ""
  WriteINIStr  "$INSTDIR\Telemaster2.ini" "Main"    "ToolTips"   "1"
  WriteINIStr  "$INSTDIR\Telemaster2.ini" "BackUp"  "BackupDir"  "$INSTDIR\Backup"
  File "d:\MyProgramms\TeleMaster2\Telemaster2.chm"    ; ��࠭塞 䠩� �ࠢ��

  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    ;�������� ��몮�
    CreateDirectory "$SMPROGRAMS\$STARTMENU_FOLDER"
    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\��������� 2.05.lnk" "$INSTDIR\Telemaster2.exe"
    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\�������.lnk" "$INSTDIR\Uninstall.exe"
  !insertmacro MUI_STARTMENU_WRITE_END
  
  ;���࠭塞 ���� � �ணࠬ�� � ॥���
  WriteRegStr HKCU "Software\���������2" "" $INSTDIR
  
  ;������� uninstall'��� � �����뢠�� ��� � �����, �㤠 ��⠭�������� �ணࠬ��
  WriteUninstaller "$INSTDIR\Uninstall.exe"
SectionEnd                            ; - ⠪ �����稢����� �� �� ᥪ権

Section !���� Base                    ; ����� "����" ����� �� ���� ���⮬
  SetOutPath "$INSTDIR"
  IfFileExists "$INSTDIR\Telemaster2.dat" 0 +2    ; �᫨ 䠩� �� ������� � �ய�᪠�� ᫥������ ��ப�
  Rename "$INSTDIR\Telemaster2.dat" "$INSTDIR\Telemaster2.bak"  ; ��२�����뢠�� �������騩 䠩�

  File "d:\MyProgramms\TeleMaster2\Telemaster2.dat";      ��࠭塞 �㦭� ��� 䠩�
SectionEnd

Section "������� ���⠭権" Documents    ; ����� "������� ���⠭権"
  SetOutPath "$INSTDIR\Documents"        ; ᮧ���� ����� ��� ��⠭���� 䠩��� ᥪ樨
  File "d:\MyProgramms\TeleMaster2\Documents\Attention.xlt"    ; ��࠭塞 䠩�� � �����
  File "d:\MyProgramms\TeleMaster2\Documents\Getting.xlt"
  File "d:\MyProgramms\TeleMaster2\Documents\Sending.xlt"
  File "d:\MyProgramms\TeleMaster2\Documents\Success.xlt"
SectionEnd

Section /o "���� � ���� ������" Patch    ; ����� "����", �� 㬮�砭�� �⪫�祭�
  SetOutPath "$INSTDIR"
  File "d:\MyProgramms\TeleMaster2\Patches\PatchBaseTo2-05\Patch.exe"
SectionEnd

;--------------------------------
;Descriptions

; � �⮩ ᥪ樨 ����ᠭ� ������, ����� ��������� �� ��������� �� ��������� ��� ��⠭���� �����뢠�� ���
; ���ᠭ��

  LangString DESC_Program ${LANG_RUSSIAN} "����室��� 䠩�� ��� ����᪠ �ணࠬ��."
  LangString DESC_Documents ${LANG_RUSSIAN} "������� ���㬥�⮢, ����室���� �ணࠬ��."
  LangString DESC_Base ${LANG_RUSSIAN} "���� ���� ������."
  LangString DESC_Patch ${LANG_RUSSIAN} "�������஢���� ���� ������ �� ���ᨨ 2.0 � ����� 2.05."

  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${Program} $(DESC_Program)
    !insertmacro MUI_DESCRIPTION_TEXT ${Documents} $(DESC_Documents)
    !insertmacro MUI_DESCRIPTION_TEXT ${Base} $(DESC_Base)
    !insertmacro MUI_DESCRIPTION_TEXT ${Patch} $(DESC_Patch)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END
 
;--------------------------------
;Uninstaller Section

Section "Uninstall"  ; ������ ᥪ�� ����室��� ��� ���ᠭ�� �����⠫����

  Delete "$INSTDIR\Uninstall.exe"          ; 㤠����� 䠩���
  Delete "$INSTDIR\Telemaster2.exe"
  
; ᫥����� ������� �뢮��� ���������� ���� ����� ���짮��⥫� � �᫨ ���짮��⥫� ������ ���, � �ய�᪠����
; ���� ��ப�...
  MessageBox MB_YESNO|MB_ICONQUESTION "���� �� �� ����⢨⥫쭮 㤠���� ���� ������ �ணࠬ��?" 0 +1
  Delete "$INSTDIR\Telemaster2.dat"        ; ����� �� 㤠�����
  Delete "$INSTDIR\Telemaster2.ini"
  Delete "$INSTDIR\Telemaster2.chm"

  MessageBox MB_YESNO|MB_ICONQUESTION "���� �� �� 㤠���� ��� ࠡ�稥 蠡����?" 0 +3
  Delete "$INSTDIR\Documents\Attention.xlt"
  Delete "$INSTDIR\Documents\Getting.xlt"
  Delete "$INSTDIR\Documents\Sending.xlt"
  Delete "$INSTDIR\Documents\Success.xlt"

  !insertmacro MUI_STARTMENU_GETFOLDER Application $MUI_TEMP    ; �뤨ࠥ� �� ॥��� ���� � ���窠�
  Delete "$SMPROGRAMS\$MUI_TEMP\��������� 2.05.lnk"            ; � 㤠�塞 ��
  Delete "$SMPROGRAMS\$MUI_TEMP\�������.lnk"
  
  ;����塞 ���㦭� �㭪�� ���� ���
  StrCpy $MUI_TEMP "$SMPROGRAMS\$MUI_TEMP"
 
  startMenuDeleteLoop:
    RMDir $MUI_TEMP
    GetFullPathName $MUI_TEMP "$MUI_TEMP\.."
    
    IfErrors startMenuDeleteLoopDone
  
    StrCmp $MUI_TEMP $SMPROGRAMS startMenuDeleteLoopDone startMenuDeleteLoop
  startMenuDeleteLoopDone:

  RMDir "$SMPROGRAMS\��������� 2"        ; 㤠�塞 ���㦭� �����
  RMDir "$INSTDIR\Documents"
  RMDir "$INSTDIR\BackUp"
  RMDir "$INSTDIR"

  DeleteRegKey /ifempty HKCU "Software\Telemaster2"     ; 㤠�塞 ���� �� ॥���...

SectionEnd

