;Код написал SKI
;инсталлятор к программе MOLTRAN
;--------------------------------
;Включаем необходимые модули

  !include "Sections.nsh"  ; - модуль для работы с секциями инсталлятора

;--------------------------------
;Конфигурация                     в этом разделе содержатся главные настройки инсталлятора

  ;Главная
  SetCompressor lzma          ; - сжимаем инсталлятор алгоритмом Lzma
;  SetDatablockOptimize on     ; - оптимизация блока данных
  Name "Moltran 2.5"      ; - название инсталлятора
  OutFile "MoltranSetup.exe"       ; - выходной файл с инсталлятором после выполнения компиляции
  AllowRootDirInstall false   ; - отменяем возможность установки программы в корень
  AutoCloseWindow false       ; - отмена автозакрытия инсталлятора после выполнения всех действий
  CRCCheck off                ; - отмена проверки контрольной суммы инсталлятора
  SetFont Tahoma 8            ; - основной шрифт инсталлятора - Tahoma размером в 8pt
  WindowIcon off              ; - выключаем иконку у окна инсталлятора
  XPStyle on                  ; - включаем использование стиля XP
  SetOverwrite on             ; - возможность перезаписи файлов включена

  ;Папка для инсталляции по умолчанию
  InstallDir "$PROGRAMFILES\Moltran"
  
  ;Запихиваем в реестр путь для установки
  InstallDirRegKey HKCU "Software\Moltran" ""

;--------------------------------
;Настройки интерфейса


;--------------------------------
;Страницы, используемые в инсталляторе

Var VARPATH
VAR x

Page DIRECTORY
Page INSTFILES "" "" RebootFunc
Uninstpage uninstconfirm 
Uninstpage instfiles
  
;--------------------------------
;Языки
 
;  !insertmacro MUI_LANGUAGE "English"      ; - задаем язык как "русский"

;--------------------------------
;Секции компонентов для установки

Section !Программа Program           ; секция "Программа". Знак "!" означает, что пункт жирным текстом
  SectionIn RO                       ; секция только для чтения (не отключить)
  SetOutPath "$INSTDIR"              ; папка для выполнения операций
  CreateDirectory "$INSTDIR"                    ; создаем папку 
  File "Moltran.exe"    ; сохраняем нужные файлы
  File "Moltran.cfg"
  File "Moltran.fdb"
  File "Moltran.hlp"
  File "Moltran.pdf"
  File "Mndod.dat"

; Создание ярлыков
    CreateDirectory "$SMPROGRAMS\Moltran"
    CreateShortCut "$SMPROGRAMS\Moltran\Moltran.lnk" "$INSTDIR\Moltran.exe"
    CreateShortCut "$SMPROGRAMS\Moltran\Moltran manual.lnk" "$INSTDIR\Moltran.pdf"
    CreateShortCut "$SMPROGRAMS\Moltran\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
    CreateShortCut "$Desktop\Moltran.lnk" "$INSTDIR\Moltran.exe"

; Сохраняем путь к программе в реестре
  WriteRegStr HKCU "Software\Moltran" "" $INSTDIR
 
; Setting of Path and environment variables
  ReadRegStr $VARPATH HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "Path"
  StrCpy $x $VARPATH
  StrCpy $VARPATH $x;$INSTDIR;
  WriteRegStr HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "Path" $VARPATH
  WriteRegStr HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "Moltran" $INSTDIR

 
; Создаем uninstall'ятор и записываем его в папку, куда устанавливаем программу
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd                            ; - так заканчивается любая из секций

 
;--------------------------------
;Uninstaller Section

Section "Uninstall"  ; данная секция необходима для описания деинсталлятора

;  MessageBox MB_YESNO|MB_ICONQUESTION "Do you really want to remove Moltran from your computer?" 0 +1

  Delete "$INSTDIR\Uninstall.exe"          ; удаление файлов
  Delete "$INSTDIR\Moltran.exe"
  Delete "$INSTDIR\Moltran.cfg"
  Delete "$INSTDIR\Moltran.fdb"
  Delete "$INSTDIR\Moltran.hlp"
  Delete "$INSTDIR\Moltran.pdf"
  Delete "$INSTDIR\Mndod.dat"
  Delete "$INSTDIR\*.*"
  RMDir "$INSTDIR"
  
  ;Удаляем ненужные пункты меню Пуск
 
  Delete "$SMPROGRAMS\Moltran\Moltran.lnk"
  Delete "$SMPROGRAMS\Moltran\Moltran manual.lnk"
  Delete "$SMPROGRAMS\Moltran\Uninstall.lnk"
  RMDIR "$SMPROGRAMS\Moltran"
  Delete "$Desktop\Moltran.lnk" 
   
; Remove the registry keys
  DeleteRegKey /ifempty HKCU "Software\Moltran"     ; удаляем ключ из реестра...
  DeleteRegValue HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "Moltran" 
  DeleteRegKey HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment\Moltran"

SectionEnd


Function RebootFunc

MessageBox MB_YESNO|MB_ICONQUESTION "You have to restart your computer. Restart now?" IDNO +2
reboot
MessageBox MB_OK "OK, then you need to do that later..." 
FunctionEnd
