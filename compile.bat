rmdir ScopesThatScope /s /q
del ScopesThatScope.zip
mkdir ScopesThatScope\bin\x64\plugins\cyber_engine_tweaks\mods\ScopesThatScope
mkdir ScopesThatScope\bin\x64\plugins\cyber_engine_tweaks\mods\ScopesThatScope\app
mkdir ScopesThatScope\bin\x64\plugins\cyber_engine_tweaks\mods\ScopesThatScope\storage
copy init.lua ScopesThatScope\bin\x64\plugins\cyber_engine_tweaks\mods\ScopesThatScope
copy app\* ScopesThatScope\bin\x64\plugins\cyber_engine_tweaks\mods\ScopesThatScope\app
copy storage\* ScopesThatScope\bin\x64\plugins\cyber_engine_tweaks\mods\ScopesThatScope\storage
7z a ScopesThatScopeAT.zip ScopesThatScope
rem rmdir ScopesThatScope /s /q