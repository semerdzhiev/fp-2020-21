### Windows Setup
---
##### Инсталирайте:
- [stack](https://docs.haskellstack.org/en/stable/install_and_upgrade/)
- Текстов редактор ([Visual Studio Code](https://code.visualstudio.com/))

Сега би трябвало да можете да пуснете `stack ghci` през command prompt или powershell.

##### Алтернатива на cmd и powershell
Можете да използвате bash вместо това. Инсталирайте [git](https://git-scm.com/downloads).  
Той идва с нещо което емулира shell - git bash.  
Не работи перфектно но е доста по-добре от command line интерфейсите на Windows.

##### За да използвате Git Bash през VSCode:
- Пуснете git bash и напишете вътре `which bash`.
- Резултата ще е абсолютен път, който много вероятно ще изглежда така `/usr/bin/bash`.
- Отворете VSCode и натиснете `Ctrl+Shift+P`.
- Отворете `Open Settings (JSON)`
- Добавете полето `"terminal.integrated.shell.linux": "<path>"`, където `<path>` е пътят който получихте от `which` командата.
- Сложете запетая накрая на горния ред ако там има друго поле.
- Отворете терминал с `` Ctrl+` `` (символа под `Esc`)
- През падащото меню вдясно, където пише текущия ви shell изберете `Select Default Shell` и изберете Git Bash.
- Готово! Вече всеки нов отворен терминал във VSCode ще използва Git Bash.
