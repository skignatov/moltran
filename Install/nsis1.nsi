;Код написал .silent
;инсталлятор к программе Телемастер 2.05
;--------------------------------
;Включаем необходимые модули

  !include "MUI.nsh"       ; - это модуль, необходимый для использования нового интерфейса
  !include "Sections.nsh"  ; - модуль для работы с секциями инсталлятора

;--------------------------------
;Конфигурация                     в этом разделе содержатся главные настройки инсталлятора

  ;Главная
  SetCompressor lzma          ; - сжимаем инсталлятор алгоритмом Lzma
  SetDatablockOptimize on     ; - оптимизация блока данных
  Name "Телемастер 2.05"      ; - название инсталлятора
  OutFile "Install.exe"       ; - выходной файл с инсталлятором после выполнения компиляции
  AllowRootDirInstall false   ; - отменяем возможность установки программы в корень
  AutoCloseWindow false       ; - отмена автозакрытия инсталлятора после выполнения всех действий
  CRCCheck off                ; - отмена проверки контрольной суммы инсталлятора
  SetFont Tahoma 8            ; - основной шрифт инсталлятора - Tahoma размером в 8pt
  WindowIcon off              ; - выключаем иконку у окна инсталлятора
  XPStyle on                  ; - включаем использование стиля XP
  SetOverwrite on             ; - возможность перезаписи файлов включена

  ;Папка для инсталляции по умолчанию
  InstallDir "$PROGRAMFILES\Telemaster2"
  
  ;Запихиваем в реестр путь для установки
  InstallDirRegKey HKCU "Software\Telemaster2" ""

;--------------------------------
;Настройки интерфейса

  !define MUI_HEADERIMAGE_BITMAP_NOSTRETCH     ; - не растягивать рисунок в загаловке
  !define MUI_HEADERIMAGE                      ; - возможность запихнуть в заголовок рисунок;
  !define MUI_HEADERIMAGE_BITMAP "Header.bmp"  ; - сам рисунок в заголовке
  !define MUI_HEADERIMAGE_RIGHT                ; - рисунок в заголовке будет находиться справа
  !define MUI_ABORTWARNING                     ; - выдаем предупреждение при нажатии на кнопку отмена
  !define MUI_ICON "Install.ico"               ; - иконка файла - инсталлятора
  !define MUI_UNICON "UnInstall.ico"           ; - иконка файла - деинсталлятора

;------------------- alpha-blending splash ---------
Function .onInit                               ; - функция, код которой будет выполнен при инициализации
  SetOutPath $TEMP                             ;   инсталлятора. В данном случае плавно показывает необходимую
  File /oname=spl.bmp "Splash.bmp"             ;   мне картинку перед запуском инсталлятора

  advsplash::show 1500 2500 250 -1 $TEMP\spl

  Pop $0          

  Delete $TEMP\spl.bmp

FunctionEnd                                    ; - так заканчиваются все функции
;---------------------------------------------------

;--------------------------------
;Страницы, используемые в инсталляторе

  !insertmacro MUI_PAGE_LICENSE "License.txt"  ; - страница с лицензией на программу
  !insertmacro MUI_PAGE_COMPONENTS             ; - страница с выбором компонентов для установки
  !insertmacro MUI_PAGE_DIRECTORY              ; - страница с выбором папки для установки
  
  Var MUI_TEMP                                 ; - две переменные для хранения пути для ярлыков в меню Пуск
  Var STARTMENU_FOLDER

  !define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU" 
  !define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\Telemaster2" 
  !define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Ярлыки"
  !insertmacro MUI_PAGE_STARTMENU Application $STARTMENU_FOLDER   ; - страница с выбором группы ярлыков

  !insertmacro MUI_PAGE_INSTFILES              ; - страница с выводом подробностей установки
  
  !insertmacro MUI_UNPAGE_CONFIRM              ; - страница с подтверждением удаления (деинсталлятор)
  !insertmacro MUI_UNPAGE_INSTFILES            ; - страница с подробностями удаления (деинсталлятор)
  
;--------------------------------
;Языки
 
  !insertmacro MUI_LANGUAGE "Russian"      ; - задаем язык как "русский"

;--------------------------------
;Секции компонентов для установки

Section !Программа Program           ; секция "Программа". Знак "!" означает, что пункт жирным текстом
  SectionIn RO                       ; секция только для чтения (не отключить)
  SetOutPath "$INSTDIR"              ; папка для выполнения операций
; дальше описано, что будет выполнено при установке данного компонента установки
  CreateDirectory "$INSTDIR\BackUp"                    ; создаем папку BackUp
  File "d:\MyProgramms\TeleMaster2\Telemaster2.exe"    ; сохраняем нужные файлы
  File "d:\MyProgramms\TeleMaster2\Telemaster2.ini"
; дальше работа с только что установленным INI-файлом
  WriteINIStr  "$INSTDIR\Telemaster2.ini" "Main"    "BasePath"   ""
  WriteINIStr  "$INSTDIR\Telemaster2.ini" "Main"    "ToolTips"   "1"
  WriteINIStr  "$INSTDIR\Telemaster2.ini" "BackUp"  "BackupDir"  "$INSTDIR\Backup"
  File "d:\MyProgramms\TeleMaster2\Telemaster2.chm"    ; сохраняем файл справки

  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    ;Создание ярлыков
    CreateDirectory "$SMPROGRAMS\$STARTMENU_FOLDER"
    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Телемастер 2.05.lnk" "$INSTDIR\Telemaster2.exe"
    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Удалить.lnk" "$INSTDIR\Uninstall.exe"
  !insertmacro MUI_STARTMENU_WRITE_END
  
  ;Сохраняем путь к программе в реестре
  WriteRegStr HKCU "Software\Телемастер2" "" $INSTDIR
  
  ;Создаем uninstall'ятор и записываем его в папку, куда устанавливаем программу
  WriteUninstaller "$INSTDIR\Uninstall.exe"
SectionEnd                            ; - так заканчивается любая из секций

Section !База Base                    ; Секция "база" опять же жирным шрифтом
  SetOutPath "$INSTDIR"
  IfFileExists "$INSTDIR\Telemaster2.dat" 0 +2    ; если файл не существует то пропускаем следующую строку
  Rename "$INSTDIR\Telemaster2.dat" "$INSTDIR\Telemaster2.bak"  ; переименовываем существующий файл

  File "d:\MyProgramms\TeleMaster2\Telemaster2.dat";      сохраняем нужный нам файл
SectionEnd

Section "Шаблоны квитанций" Documents    ; Секция "Шаблоны квитанций"
  SetOutPath "$INSTDIR\Documents"        ; создаем папку для установки файлов секции
  File "d:\MyProgramms\TeleMaster2\Documents\Attention.xlt"    ; сохраняем файлы в папку
  File "d:\MyProgramms\TeleMaster2\Documents\Getting.xlt"
  File "d:\MyProgramms\TeleMaster2\Documents\Sending.xlt"
  File "d:\MyProgramms\TeleMaster2\Documents\Success.xlt"
SectionEnd

Section /o "Патч к базе данных" Patch    ; Секция "Патч", по умолчанию отключена
  SetOutPath "$INSTDIR"
  File "d:\MyProgramms\TeleMaster2\Patches\PatchBaseTo2-05\Patch.exe"
SectionEnd

;--------------------------------
;Descriptions

; в этой секции написаны макросы, которые позволяют при наведении на компонент для установки показывать его
; описание

  LangString DESC_Program ${LANG_RUSSIAN} "Необходимые файлы для запуска программы."
  LangString DESC_Documents ${LANG_RUSSIAN} "Шаблоны документов, необходимых программе."
  LangString DESC_Base ${LANG_RUSSIAN} "Файл база данных."
  LangString DESC_Patch ${LANG_RUSSIAN} "Конвертирование базы данных из версии 2.0 в версию 2.05."

  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${Program} $(DESC_Program)
    !insertmacro MUI_DESCRIPTION_TEXT ${Documents} $(DESC_Documents)
    !insertmacro MUI_DESCRIPTION_TEXT ${Base} $(DESC_Base)
    !insertmacro MUI_DESCRIPTION_TEXT ${Patch} $(DESC_Patch)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END
 
;--------------------------------
;Uninstaller Section

Section "Uninstall"  ; данная секция необходима для описания деинсталлятора

  Delete "$INSTDIR\Uninstall.exe"          ; удаление файлов
  Delete "$INSTDIR\Telemaster2.exe"
  
; следующая команда выводит диалоговое окно ДаНет пользователю и если пользователь нажмет нет, то пропускается
; одна строка...
  MessageBox MB_YESNO|MB_ICONQUESTION "Хотите ли Вы действительно удалить базу данных программы?" 0 +1
  Delete "$INSTDIR\Telemaster2.dat"        ; опять же удаление
  Delete "$INSTDIR\Telemaster2.ini"
  Delete "$INSTDIR\Telemaster2.chm"

  MessageBox MB_YESNO|MB_ICONQUESTION "Хотите ли Вы удалить Ваши рабочие шаблоны?" 0 +3
  Delete "$INSTDIR\Documents\Attention.xlt"
  Delete "$INSTDIR\Documents\Getting.xlt"
  Delete "$INSTDIR\Documents\Sending.xlt"
  Delete "$INSTDIR\Documents\Success.xlt"

  !insertmacro MUI_STARTMENU_GETFOLDER Application $MUI_TEMP    ; выдираем из реестра путь к значкам
  Delete "$SMPROGRAMS\$MUI_TEMP\Телемастер 2.05.lnk"            ; и удаляем их
  Delete "$SMPROGRAMS\$MUI_TEMP\Удалить.lnk"
  
  ;Удаляем ненужные пункты меню Пуск
  StrCpy $MUI_TEMP "$SMPROGRAMS\$MUI_TEMP"
 
  startMenuDeleteLoop:
    RMDir $MUI_TEMP
    GetFullPathName $MUI_TEMP "$MUI_TEMP\.."
    
    IfErrors startMenuDeleteLoopDone
  
    StrCmp $MUI_TEMP $SMPROGRAMS startMenuDeleteLoopDone startMenuDeleteLoop
  startMenuDeleteLoopDone:

  RMDir "$SMPROGRAMS\Телемастер 2"        ; удаляем ненужные папки
  RMDir "$INSTDIR\Documents"
  RMDir "$INSTDIR\BackUp"
  RMDir "$INSTDIR"

  DeleteRegKey /ifempty HKCU "Software\Telemaster2"     ; удаляем ключ из реестра...

SectionEnd

