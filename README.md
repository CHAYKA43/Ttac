# Ttac
[![AUR](https://img.shields.io/aur/version/ttac)](https://aur.archlinux.org/packages/ttac)

Аналог cat и других UNIX утилит. ~~НЕ ИСПОЛЬЗУЙТЕ ЭТО ДЕРЬМО ПОЖАЛУйСТА~~
# Установка
## Arch Linux
### AUR
* ```yay -Sy ttac``` - пакет скомпилируется из исходников и установится автоматически
## Другие дистрибутивы
### Ручная установка
1. Вам потребуются следующие пакеты: **dub** и **dmd**. Установите их через свой пакетный менеджер
2. Склонируйте репозиторий: 
```bash
git clone https://github.com/CHAYKA43/Ttac
```
3. Заходим в папку Ttac и выполняем компиляцию:
```bash
cd Ttac
dub build
```
4. Перемещаем в ```/usr/bin```:
```bash
sudo mv ttac /usr/bin/
```
Универсальный вариант:
```bash
su - -c "mv ttac /usr/bin/"
```
<h1><details>
<summary>Примеры команд</summary>
Ты думал тут будут примеры? Пф... Наивный дурачек) Читай ttac --help или ttac --guide)</h1>