@echo off
setlocal enabledelayedexpansion

rem --------------------------------------------------------
rem Esconder tela de limpeza
rem --------------------------------------------------------


rem --------------------------------------------------------
rem Obtém o diretório temporário do sistema operacional
rem --------------------------------------------------------
set temp_dir=%TEMP%
echo Limpando arquivos temporários na pasta: %temp_dir%

rem --------------------------------------------------------
rem Variáveis para acumular o total de dados removidos
rem --------------------------------------------------------
set /a total_bytes_removidos=0

rem --------------------------------------------------------
rem Itera sobre os arquivos e subpastas dentro do diretório temporário
rem --------------------------------------------------------
for /r "%temp_dir%" %%f in (*) do (
    rem Verifica se é um arquivo
    if exist "%%f" (
        rem Obtém o tamanho do arquivo em bytes
        for %%A in ("%%f") do set file_size=%%~zA
        set /a total_bytes_removidos+=file_size
        rem echo Arquivo removido: %%f (Tamanho: !file_size! bytes)
        del "%%f"
    )
)

rem --------------------------------------------------------
rem Limpando outra pasta temporária do sistema operacional
rem --------------------------------------------------------
set temp=%TEMP%
echo Limpando arquivos temporários na pasta: %temp%

rem --------------------------------------------------------
rem Variáveis para acumular o total de dados removidos
rem --------------------------------------------------------
set /a total_limpo=0

rem --------------------------------------------------------
rem Itera sobre os arquivos e subpastas dentro do diretório temporário
rem --------------------------------------------------------
for /r "%temp%" %%f in (*) do (
    rem Verifica se é um arquivo
    if exist "%%f" (
        rem Obtém o tamanho do arquivo em bytes
        for %%A in ("%%f") do set file_siz=%%~zA
        set /a total_bytes_removidos+=file_siz
        rem echo Arquivo removido: %%f (Tamanho: !file_siz! bytes)
        del "%%f"
    )
)

rem --------------------------------------------------------
rem Calcula o total de dados removidos
rem --------------------------------------------------------
set /a total=total_limpo + total_bytes_removidos
set /a total_mb= total / 1048576
set /a total_gb= total / 1073741824

rem --------------------------------------------------------
rem Exibe o total de dados removidos
rem --------------------------------------------------------
echo Limpeza concluída.
echo Total de dados temporarios removidos: !total! bytes
echo Total de dados temporarios removidos: !total_mb! MB
echo Total de dados temporarios removidos: !total_gb! GB

echo Limpando a Lixeira do sistema...

rem Chama o PowerShell para esvaziar a Lixeira
powershell.exe -command "Clear-RecycleBin -Confirm:$false"

echo Lixeira limpa com sucesso!

@echo off
setlocal enabledelayedexpansion

echo Calculando o tamanho da Lixeira...

rem Obtém o tamanho total da Lixeira usando PowerShell
for /f "tokens=*" %%a in ('powershell -command "Get-ChildItem 'C:\$Recycle.Bin' -Recurse | Measure-Object -Property Length -Sum"') do set total_size=%%a

rem Exibe o tamanho da Lixeira antes de limpar
echo Tamanho da Lixeira antes de limpar: %total_size%

rem Limpa a Lixeira usando PowerShell
powershell.exe -command "Clear-RecycleBin -Confirm:$false"

echo Lixeira limpa com sucesso!

rem Recalcula o tamanho da Lixeira após a limpeza
for /f "tokens=*" %%a in ('powershell -command "Get-ChildItem 'C:\$Recycle.Bin' -Recurse | Measure-Object -Property Length -Sum"') do set total_size_after=%%a

rem Exibe o tamanho da Lixeira após a limpeza
echo Tamanho da Lixeira após a limpeza: %total_size_after%


@echo off
setlocal enabledelayedexpansion

rem --------------------------------------------------------
rem Contar o Tamanho do Cache do Microsoft Edge
rem --------------------------------------------------------
echo Contando o tamanho do Cache do Microsoft Edge...

rem Definir o caminho da pasta de cache do Microsoft Edge
set "edge_cache_dir=C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\Default\Cache\Cache_Data"

rem Verifica se a pasta de cache existe
if exist "%edge_cache_dir%" (
    rem Calcula o tamanho total dos arquivos dentro da pasta Cache
    set /a total_edge_size=0
    for /r "%edge_cache_dir%" %%f in (*) do (
        rem Adiciona o tamanho de cada arquivo ao total
        set /a total_edge_size+=%%~zf
    )

    rem Converte o total de bytes para megabytes
    set /a total_edge_mb=!total_edge_size! / 1048576

    rem Exibe o total de bytes e megabytes
    echo Tamanho total do Cache do Edge: !total_edge_mb! MB
) else (
    echo A pasta de cache do Edge não foi encontrada.
)

rem Exibe confirmação de limpeza
echo Cache do Edge limpo com sucesso.
echo Deseja limpar o Cache do Google Chrome? (S/N)
set /p choice=

if /i "%choice%"=="N" exit
pause

rem --------------------------------------------------------
rem Limpando Cache do Microsoft Edge
rem --------------------------------------------------------
echo Limpando o Cache do Microsoft Edge...

rem Apaga todos os arquivos da pasta Cache
del /q /f /s "%edge_cache_dir%\*.*"

rem Exibe confirmação de limpeza
echo Cache do Edge limpo com sucesso.

rem --------------------------------------------------------
rem Verificando tamanho do Cache do Google Chrome...
rem --------------------------------------------------------

rem Contar o Tamanho do Cache do Google Chrome
rem --------------------------------------------------------
echo Contando o tamanho do Cache do Google Chrome...

rem Definir o caminho da pasta de cache do Google Chrome
set "chrome_cache_dir=C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data\Default\Cache\Cache_Data"

rem Verifica se a pasta de cache existe
if exist "%chrome_cache_dir%" (
    rem Calcula o tamanho total dos arquivos dentro da pasta Cache
    set /a total_chrome_size=0
    for /r "%chrome_cache_dir%" %%f in (*) do (
        rem Adiciona o tamanho de cada arquivo ao total
        set /a total_chrome_size+=%%~zf
    )

    rem Converte o total de bytes para megabytes
    set /a total_chrome_mb=!total_chrome_size! / 1048576

    rem Exibe o total de bytes e megabytes
    echo Tamanho total do Cache do Chrome: !total_chrome_mb! MB
) else (
    echo A pasta de cache do Chrome não foi encontrada.
)

rem Exibe confirmação de limpeza
echo Deseja limpar o Cache do Google Chrome? (S/N)
set /p choice=
pause
if /i "%choice%"=="N" exit

rem --------------------------------------------------------
rem Limpar Cache do Google Chrome
rem --------------------------------------------------------
echo Limpando o Cache do Google Chrome...

rem Apaga todos os arquivos da pasta Cache
del /q /f /s "%chrome_cache_dir%\*.*"

rem Exibe confirmação de limpeza
echo Cache do Chrome limpo com sucesso.

rem --------------------------------------------------------
rem Processo concluído
rem --------------------------------------------------------
echo Processo concluído.
pause


