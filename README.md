# Steam
<img src="https://github.com/DanielSwift1992/Steam/blob/master/gitHubImages/darkMode.png" width="40%" align="left">    <img src="https://github.com/DanielSwift1992/Steam/blob/master/gitHubImages/lightMode.png" width="40%" align="right"> 


## Разработанные экраны

- Вход
- Авторизация steam (через webview для получения id)
- Профиль
- Статистика по игре
- Статистика по CS GO
- Статистика на основе ачивок (локальная)
- Список друзей
- Последние игры

## Дополнительные задачи

- Сбор статистики своей и друзей в background (так же, при закрытом приложении)
- Доп информация по уровню в профиле
- Адаптивная детализация по CS GO
- Поддержка темной темы (является рекомендуемой для использования)
- Модуляризация приложения
- Unit-тесты

## Библиотеки

* SwiftGen - используется для кодогенерации цветов, строк.  Будет удобна при локализации приложения.
* Alamofire - обертка для работы с сетью. Использовалась для написания core слоя.
* AlamofireImage - удобство преобразования url в UIImage, так же использовалась для изменения размера изображений. 
* RealmSwift - хранение данных. Использовалась для записи в background потоке.
* PinLayout - для manual layout. В основном для ячеек, улучшает производительность.
* SnapKit - обертка над autolayout, более читабельная и короткая запись.
* Charts - отрисовка графиков. Не смотря на сложность и баги, обладает высокими возможностями кастомизации.

## Другие ресурсы

* MLTontiatorView - импортированный файл. Содержит анимацию для индикации загрузки загрузки

## Нуждается в доработке

* Добавить transition анимации
* Сделать элементы более отзывчивыми
* Проработать навигацию более детально, например с игры возможность перейти на ее локальную статистику
* BackgroundWorkManager хорошо бы покрыть тестом, для этого предварительно сделать инверсию его зависимостей
* Так как запись в базу производится в background потоке, хорошо бы убрать передачу объектов реалма. Использовать их только как промежуточную модель записи (не везде так получилось)
* Очистка хранилища
* Тесты на утечку памяти
* Более точная обработка ошибок
