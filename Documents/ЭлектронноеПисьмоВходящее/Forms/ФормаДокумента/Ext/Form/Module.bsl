﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	// Запретим создание новых
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	Взаимодействия.УстановитьЗаголовокФормыЭлектронногоПисьма(ЭтотОбъект);
	
	// Заполним список выбора для поля РассмотретьПосле.
	Взаимодействия.ЗаполнитьСписокВыбораДляРассмотретьПосле(Элементы.РассмотретьПосле.СписокВыбора);
	Если Рассмотрено Тогда
		Элементы.РассмотретьПосле.Доступность = Ложь;
	КонецЕсли;
	
	// СтандартныеПодсистемы.Свойства
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "СтраницаДополнительныеРеквизиты");
	ДополнительныеПараметры.Вставить("ОтложеннаяИнициализация", Истина);
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства
	
	Если Объект.Ссылка.Пустая() Тогда
		Элементы.СтраницаКомментарий.Картинка = ОбщегоНазначенияКлиентСервер.КартинкаКомментария(Объект.Комментарий);
	КонецЕсли;
	УстановитьУсловноеОформлениеДляДереваВзаимодействийПочта();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформлениеДляДереваВзаимодействийПочта()
	ШрифтЖирный = Новый Шрифт(,,Истина);
	
	//0.Выделение цветом текущего взаимодействия
	ЭлементУсловногоОформления = УсловноеОформление.Элементы.Добавить();
	ЭлементУсловногоОформления.Использование = Истина;
	ЭлементУсловногоОформления.Оформление.УстановитьЗначениеПараметра("ЦветФона", Новый Цвет(204, 255, 255));
	
	ЭлементУсловногоОформления = УсловноеОформление.Элементы.Добавить();
	ЭлементУсловногоОформления.Использование = Истина;
	ЭлементУсловногоОформления.Оформление.УстановитьЗначениеПараметра("Шрифт", ШрифтЖирный);
	
	ЭлементУсловия                = ЭлементУсловногоОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементУсловия.ЛевоеЗначение  = Новый ПолеКомпоновкиДанных("ДеревоВзаимодействий.ЭтоТекущееВзаимодействие");
	ЭлементУсловия.ВидСравнения   = ВидСравненияКомпоновкиДанных.Равно;
	ЭлементУсловия.ПравоеЗначение = Истина;
	ЭлементУсловия.Использование  = Истина;

	//1.Выделение цветом группировки по предмету
	ЭлементУсловногоОформления = УсловноеОформление.Элементы.Добавить();
	ЭлементУсловногоОформления.Использование = Истина;
	ЭлементУсловногоОформления.Оформление.УстановитьЗначениеПараметра("ЦветФона", Новый Цвет(248, 242, 216));
	
	ЭлементУсловия                = ЭлементУсловногоОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементУсловия.ЛевоеЗначение  = Новый ПолеКомпоновкиДанных("ДеревоПисем.ЭтоПредмет");
	ЭлементУсловия.ВидСравнения   = ВидСравненияКомпоновкиДанных.Равно;
	ЭлементУсловия.ПравоеЗначение = Истина;
	ЭлементУсловия.Использование  = Истина;

	ЗаполнитьСписокПолейОформленияДеревоВзаимодействияПочта(ЭлементУсловногоОформления);
	
	//2. Выделение задач своего пользователя
	ЭлементУсловногоОформления = УсловноеОформление.Элементы.Добавить();
	ЭлементУсловногоОформления.Использование = Истина;
	ЭлементУсловногоОформления.Оформление.УстановитьЗначениеПараметра("ЦветФона", Новый Цвет(224, 255, 255));
	
	ЭлементУсловия                = ЭлементУсловногоОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементУсловия.ЛевоеЗначение  = Новый ПолеКомпоновкиДанных("ДеревоПисем.ЭтоПредмет");
	ЭлементУсловия.ВидСравнения   = ВидСравненияКомпоновкиДанных.Равно;
	ЭлементУсловия.ПравоеЗначение = Ложь;
	ЭлементУсловия.Использование  = Истина;
	ЭлементУсловия                = ЭлементУсловногоОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементУсловия.ЛевоеЗначение  = Новый ПолеКомпоновкиДанных("ДеревоПисем.Ответственный");
	ЭлементУсловия.ВидСравнения   = ВидСравненияКомпоновкиДанных.Равно;
	ЭлементУсловия.ПравоеЗначение = ПараметрыСеанса.ТекущийПользователь;
	ЭлементУсловия.Использование  = Истина;

	ЗаполнитьСписокПолейОформленияДеревоВзаимодействияПочта(ЭлементУсловногоОформления);
	
	////3.Выделение жирным шрифтом группировки по предмету
	//ЭлементУсловногоОформления = УсловноеОформление.Элементы.Добавить();
	//ЭлементУсловногоОформления.Использование = Истина;
	//ЭлементУсловногоОформления.Оформление.УстановитьЗначениеПараметра("Шрифт", ШрифтЖирный);
	//
	//ЭлементУсловия                = ЭлементУсловногоОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	//ЭлементУсловия.ЛевоеЗначение  = Новый ПолеКомпоновкиДанных("ДеревоПисем.ЭтоПредмет");
	//ЭлементУсловия.ВидСравнения   = ВидСравненияКомпоновкиДанных.Равно;
	//ЭлементУсловия.ПравоеЗначение = Истина;
	//ЭлементУсловия.Использование  = Истина;

	//ЗаполнитьСписокПолейОформленияДеревоПочта(ЭлементУсловногоОформления);
	
	//4.Выделение отклоненных писем
	ЭлементУсловногоОформления = УсловноеОформление.Элементы.Добавить();
	ЭлементУсловногоОформления.Использование = Истина;
	ЭлементУсловногоОформления.Оформление.УстановитьЗначениеПараметра("ЦветФона", Новый Цвет(255, 140, 120));
	
	ЭлементУсловия                = ЭлементУсловногоОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементУсловия.ЛевоеЗначение  = Новый ПолеКомпоновкиДанных("ДеревоПисем.Отклонено");
	ЭлементУсловия.ВидСравнения   = ВидСравненияКомпоновкиДанных.Равно;
	ЭлементУсловия.ПравоеЗначение = Истина;
	ЭлементУсловия.Использование  = Истина;
	
	ЗаполнитьСписокПолейОформленияДеревоВзаимодействияПочта(ЭлементУсловногоОформления);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокПолейОформленияДеревоВзаимодействияПочта(ЭлементУсловногоОформления)
	
	Массив = Новый Массив();
	Массив.Добавить("ДеревоВзаимодействийВзаимодействие");
	Массив.Добавить("ДеревоВзаимодействийСтатусКартинкой");
	Массив.Добавить("ДеревоВзаимодействийДата");
	Массив.Добавить("ДеревоВзаимодействийОтветственный");
	Массив.Добавить("ДеревоВзаимодействийОтправительПредставление");
	Массив.Добавить("ДеревоВзаимодействийСтатус");
	Массив.Добавить("ДеревоВзаимодействийСрокИсполнения");
	
	Для Сч = 0 По Массив.Количество() - 1 Цикл
		ОформляемоеПоле      = ЭлементУсловногоОформления.Поля.Элементы.Добавить();
		ОформляемоеПоле.Поле = Новый ПолеКомпоновкиДанных(Массив[Сч]);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоВзаимодействийПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	Отказ = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ДеревоВзаимодействийПередНачаломИзменения(Элемент, Отказ)
	Отказ = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ДеревоВзаимодействийПередУдалением(Элемент, Отказ)
	Отказ = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ДеревоВзаимодействийВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	
	Если ЗначениеЗаполнено(Элемент.ТекущиеДанные.Взаимодействие) Тогда
		
		ПоказатьЗначение(, Элемент.ТекущиеДанные.Взаимодействие);
		
	КонецЕсли;
КонецПроцедуры


&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	//ЗаполнитьДеревоНаКлиенте();
	ПодключитьОбработчикОжидания("Подключаемый_Отобразить_ДервоВзаимодействий_Почта", 1, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_Отобразить_ДервоВзаимодействий_Почта()
	ЗаполнитьДеревоНаКлиенте();
	ОтключитьОбработчикОжидания("Подключаемый_Отобразить_ДервоВзаимодействий_Почта");
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	Взаимодействия.УстановитьРеквизитыФормыВзаимодействияПоДаннымРегистра(ЭтотОбъект);
	
	Вложения.Очистить();
	ТаблицаВложения = УправлениеЭлектроннойПочтой.ПолучитьВложенияЭлектронногоПисьма(Объект.Ссылка, Истина);
	
	Если ТаблицаВложения.Количество() > 0 Тогда
		
		НайденныеСтроки = ТаблицаВложения.НайтиСтроки(Новый Структура("ИДФайлаЭлектронногоПисьма", ""));
		ОбщегоНазначенияКлиентСервер.ДополнитьТаблицу(НайденныеСтроки, Вложения);
		
	КонецЕсли;
	
	Для Каждого УдаленноеВложение Из ТекущийОбъект.НепринятыеВложения Цикл
		
		НовоеВложение = Вложения.Добавить();
		НовоеВложение.ИмяФайла = УдаленноеВложение.ИмяВложение;
		НовоеВложение.ИндексКартинки = ФайловыеФункцииСлужебныйКлиентСервер.ПолучитьИндексПиктограммыФайла(".msg") + 1;
		
	КонецЦикла;
	
	Если Вложения.Количество() = 0 Тогда
		
		Элементы.Вложения.Видимость = Ложь;
		
	КонецЕсли;
	
	// Установим текст и вид текста.
	Если Объект.ТипТекста = Перечисления.ТипыТекстовЭлектронныхПисем.HTML Тогда
		ТекстПисьма = Взаимодействия.ОбработатьТекстHTML(Объект.Ссылка);
		Элементы.ТекстПисьма.Вид = ВидПоляФормы.ПолеHTMLДокумента;
		Элементы.ТекстПисьма.ТолькоПросмотр = Ложь;
	Иначе
		ТекстПисьма = Объект.Текст;
		Элементы.ТекстПисьма.Вид = ВидПоляФормы.ПолеТекстовогоДокумента;
	КонецЕсли;
	
	// Сформируем представление отправителя.
	ОтправительПредставление = ВзаимодействияКлиентСервер.ПолучитьПредставлениеАдресата(
		Объект.ОтправительПредставление, Объект.ОтправительАдрес,"");
	
	// Сформируем представление Кому и Копии.
	ПолучателиПредставление =
		ВзаимодействияКлиентСервер.ПолучитьПредставлениеСпискаАдресатов(Объект.ПолучателиПисьма, Ложь);
	ПолучателиКопийПредставление =
		ВзаимодействияКлиентСервер.ПолучитьПредставлениеСпискаАдресатов(Объект.ПолучателиКопий, Ложь);
	ПолучателиОтветаПредставление = 
		ВзаимодействияКлиентСервер.ПолучитьПредставлениеСпискаАдресатов(Объект.ПолучателиОтвета, Ложь);

	ЗаполнитьДополнительнуюИнформацию();
	
	ОбработатьНеобходимостьУведомленияОПрочтении();
	
	ВзаимодействияКлиентСервер.ПроверитьЗаполнениеКонтактов(Объект, ЭтотОбъект, "ЭлектронноеПисьмоВходящее");
	Элементы.СтраницаКомментарий.Картинка = ОбщегоНазначенияКлиентСервер.КартинкаКомментария(Объект.Комментарий);
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// СтандартныеПодсистемы.Свойства
	Если УправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтотОбъект, ИмяСобытия, Параметр) Тогда
		ОбновитьЭлементыДополнительныхРеквизитов();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
	ВзаимодействияКлиент.ОтработатьОповещение(ЭтотОбъект, ИмяСобытия, Параметр, Источник);
	Если ИмяСобытия = "СправочникЗадачаЗаписана" Тогда
		ЗаполнитьДеревоНаКлиенте();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	Если ВРег(ИсточникВыбора.ИмяФормы) = ВРег("ОбщаяФорма.УточнениеКонтактов") Тогда
		
		Если ТипЗнч(ВыбранноеЗначение) <> Тип("Массив") Тогда
			Возврат;
		КонецЕсли;
		
		ЗаполнитьУточненныеКонтакты(ВыбранноеЗначение);
		ИзменилисьКонтакты = Истина;
		Модифицированность = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, РежимЗаписи, РежимПроведения)
	
	Взаимодействия.ПередЗаписьюВзаимодействияИзФормы(ЭтотОбъект, ТекущийОбъект, ИзменилисьКонтакты);
	
	Если Рассмотрено И ТребуетсяУстановкаФлагаОтправкиУведомления Тогда
		УстановитьПризнакОтправкиУведомления(Объект.Ссылка, Истина);
	КонецЕсли;
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Взаимодействия.ПриЗаписиВзаимодействияИзФормы(ТекущийОбъект, ЭтотОбъект);
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	Элементы.СтраницаКомментарий.Картинка = ОбщегоНазначенияКлиентСервер.КартинкаКомментария(Объект.Комментарий);
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СтраницыОписаниеДополнительноПриСменеСтраницы(Элемент, ТекущаяСтраница)
	
	// СтандартныеПодсистемы.Свойства
	Если ТекущаяСтраница.Имя = "СтраницаДополнительныеРеквизиты"
		И Не ЭтотОбъект.ПараметрыСвойств.ВыполненаОтложеннаяИнициализация Тогда
		
		СвойстваВыполнитьОтложеннуюИнициализацию();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура РассмотретьПослеОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	ВзаимодействияКлиент.ОбработатьВыборВПолеРассмотретьПосле(РассмотретьПосле,
	                                                          ВыбранноеЗначение,
	                                                          СтандартнаяОбработка,
	                                                          Модифицированность);
	
КонецПроцедуры

&НаКлиенте
Процедура РассмотреноПриИзменении(Элемент)
	
	Элементы.РассмотретьПосле.Доступность = НЕ Рассмотрено;
	Если Рассмотрено И ТребуетсяЗапросУведомленияОПрочтении Тогда
		
		ОбработчикОповещенияОЗакрытии = Новый ОписаниеОповещения("ВопросОНеобходимостиОтправкиУведомленияОПрочтенииПослеЗавершения", ЭтотОбъект);
		ПоказатьВопрос(ОбработчикОповещенияОЗакрытии,
		       НСтр("ru='Отправитель запросил уведомление о прочтении. Отправить?'"),
		       РежимДиалогаВопрос.ДаНет,
		       ,
		       КодВозвратаДиалога.Да,
		       НСтр("ru='Запрос уведомления'"));
		
	КонецЕсли;
	
	УстановитьОтветсвтенного();
КонецПроцедуры

&НаСервере
Процедура УстановитьОтветсвтенного()
	
	Если Рассмотрено Тогда
		Объект.Ответственный = ПараметрыСеанса.ТекущийПользователь;
	Иначе
		Объект.Ответственный = Справочники.Пользователи.ПустаяСсылка();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура РедактироватьПолучателей()
	
	// Получим список адресатов
	МассивОтправителей = Новый Массив;
	МассивОтправителей.Добавить(Новый Структура("Адрес,Представление,Контакт",
		Объект.ОтправительАдрес,
		Объект.ОтправительПредставление, 
		Объект.ОтправительКонтакт));
	
	СписокПолучателей = Новый СписокЗначений;
	СписокПолучателей.Добавить(МассивОтправителей, "Отправитель");
	СписокПолучателей.Добавить(
		УправлениеЭлектроннойПочтойКлиент.ТаблицуКонтактовВМассив(Объект.ПолучателиПисьма), "Получатели");
	СписокПолучателей.Добавить(
		УправлениеЭлектроннойПочтойКлиент.ТаблицуКонтактовВМассив(Объект.ПолучателиКопий),  "Копии");
	СписокПолучателей.Добавить(
		УправлениеЭлектроннойПочтойКлиент.ТаблицуКонтактовВМассив(Объект.ПолучателиОтвета), "Ответ");
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("УчетнаяЗапись", Объект.УчетнаяЗапись);
	ПараметрыФормы.Вставить("СписокВыбранных", СписокПолучателей);
	ПараметрыФормы.Вставить("Предмет", Предмет);
	ПараметрыФормы.Вставить("Письмо", Объект.Ссылка);
	
	// Откроем форму для редактирования списка адресатов.
	ОткрытьФорму("ОбщаяФорма.УточнениеКонтактов", ПараметрыФормы, ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьУточненныеКонтакты(Результат)
	
	Объект.ПолучателиКопий.Очистить();
	Объект.ПолучателиОтвета.Очистить();
	Объект.ПолучателиПисьма.Очистить();
	
	Для каждого ЭлементМассива Из Результат Цикл
	
		Если ЭлементМассива.Группа = "Получатели" Тогда
			ТаблицаПолучателей = Объект.ПолучателиПисьма;
		ИначеЕсли ЭлементМассива.Группа = "Копии" Тогда
			ТаблицаПолучателей = Объект.ПолучателиКопий;
		ИначеЕсли ЭлементМассива.Группа = "Ответ" Тогда
			ТаблицаПолучателей = Объект.ПолучателиОтвета;
		ИначеЕсли ЭлементМассива.Группа = "Отправитель" Тогда
			Объект.ОтправительАдрес = ЭлементМассива.Адрес;
			Объект.ОтправительКонтакт = ЭлементМассива.Контакт;
			Продолжить;
		Иначе
			Продолжить;
		КонецЕсли;
		
		СтрокаПолучатели = ТаблицаПолучателей.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаПолучатели,ЭлементМассива);
	
	КонецЦикла;
	
	// Сформируем представление отправителя.
	ОтправительПредставление = ВзаимодействияКлиентСервер.ПолучитьПредставлениеАдресата(
		Объект.ОтправительПредставление, Объект.ОтправительАдрес, "");
	
	// Сформируем представление Кому и Копии.
	ПолучателиПредставление       =
		ВзаимодействияКлиентСервер.ПолучитьПредставлениеСпискаАдресатов(Объект.ПолучателиПисьма, Ложь);
	ПолучателиКопийПредставление  =
		ВзаимодействияКлиентСервер.ПолучитьПредставлениеСпискаАдресатов(Объект.ПолучателиКопий, Ложь);
	ПолучателиОтветаПредставление = 
		ВзаимодействияКлиентСервер.ПолучитьПредставлениеСпискаАдресатов(Объект.ПолучателиОтвета, Ложь);
	
	ВзаимодействияКлиентСервер.ПроверитьЗаполнениеКонтактов(Объект, ЭтотОбъект, "ЭлектронноеПисьмоВходящее");

КонецПроцедуры

&НаКлиенте
Процедура ОтправительПредставлениеОткрытие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Если ЗначениеЗаполнено(Объект.ОтправительКонтакт) Тогда
		ПоказатьЗначение(, Объект.ОтправительКонтакт);
	Иначе
		РедактироватьПолучателей();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ТекстПисьмаПриНажатии(Элемент, ДанныеСобытия, СтандартнаяОбработка)
	
	ВзаимодействияКлиент.ПолеHTMLПриНажатии(Элемент, ДанныеСобытия, СтандартнаяОбработка);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыВложения

&НаКлиенте
Процедура ВложенияВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ОткрытьВложение();
	
КонецПроцедуры

&НаКлиенте
Процедура ВложенияПриАктивизацииСтроки(Элемент)
	
	ТекущиеДанные = Элементы.Вложения.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ВложениеСуществует = ЗначениеЗаполнено(ТекущиеДанные.Ссылка);
	Элементы.ВложенияКонтекстноеМенюСвойстваВложения.Доступность = ВложениеСуществует;
	Элементы.ОткрытьВложение.Доступность = ВложениеСуществует;
	Элементы.СохранитьВложение.Доступность = ВложениеСуществует;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОткрытьВложениеВыполнить()
	
	ОткрытьВложение();
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьВложениеВыполнить()
	
	ТекущиеДанные = Элементы.Вложения.ТекущиеДанные;
	
	Если ТекущиеДанные <> Неопределено Тогда
		
		Если НЕ ЗначениеЗаполнено(ТекущиеДанные.Ссылка) Тогда
			Возврат;
		КонецЕсли;
		
		ДанныеФайла = ПрисоединенныеФайлыКлиент.ПолучитьДанныеФайла(
			ТекущиеДанные.Ссылка, УникальныйИдентификатор);
		
		ПрисоединенныеФайлыКлиент.СохранитьФайлКак(ДанныеФайла);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УточнитьКонтакты(Команда)
	
	РедактироватьПолучателей();
	
КонецПроцедуры

&НаКлиенте
Процедура ПараметрыПисьма(Команда)
	
	ТекстЗаголовкиИнтернета = Новый ТекстовыйДокумент;
	ТекстЗаголовкиИнтернета.ДобавитьСтроку(Объект.ВнутреннийЗаголовок);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Создано", Объект.Дата);
	ПараметрыФормы.Вставить("Получено", Объект.ДатаПолучения);
	ПараметрыФормы.Вставить("УведомитьОДоставке", Объект.УведомитьОДоставке);
	ПараметрыФормы.Вставить("УведомитьОПрочтении", Объект.УведомитьОПрочтении);
	ПараметрыФормы.Вставить("ЗаголовкиИнтернета", ТекстЗаголовкиИнтернета);
	ПараметрыФормы.Вставить("Письмо", Объект.Ссылка);
	ПараметрыФормы.Вставить("ТипПисьма", "ЭлектронноеПисьмоВходящее");
	ПараметрыФормы.Вставить("Кодировка", Объект.Кодировка);
	ПараметрыФормы.Вставить("ВнутреннийНомер", Объект.Номер);
	ПараметрыФормы.Вставить("УчетнаяЗапись", Объект.УчетнаяЗапись);
	
	ОткрытьФорму("ЖурналДокументов.Взаимодействия.Форма.ПараметрыЭлектронногоПисьма", ПараметрыФормы, ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура СвязанныеВзаимодействияВыполнить()
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ОбъектОтбора", Объект.Предмет);
	
	ОткрытьФорму("ЖурналДокументов.Взаимодействия.ФормаСписка", ПараметрыФормы, ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьКодировку(Команда)
	
	СписокКодировок = ВзаимодействияКлиентСервер.ПолучитьСписокКодировок();

	ОбработчикОповещенияОЗакрытии = Новый ОписаниеОповещения("ВыборКодировкиПослеЗавершения", ЭтотОбъект);
	
	СписокКодировок.ПоказатьВыборЭлемента(ОбработчикОповещенияОЗакрытии,
	                                      НСтр("ru = 'Выберите кодировку'"), 
	                                      СписокКодировок.НайтиПоЗначению(НРег(Объект.Кодировка)));
	
КонецПроцедуры 

&НаКлиенте
Процедура СвойстваВложения(Команда)
	
	ТекущиеДанные = Элементы.Вложения.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(ТекущиеДанные.Ссылка) Тогда
			Возврат;
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура("ПрисоединенныйФайл, ТолькоПросмотр", ТекущиеДанные.Ссылка,Истина);
	ОткрытьФорму("ОбщаяФорма.ПрисоединенныйФайл", ПараметрыФормы,, ТекущиеДанные.Ссылка);
	
КонецПроцедуры

// СтандартныеПодсистемы.Свойства

&НаКлиенте
Процедура Подключаемый_РедактироватьСоставСвойств()
	
	УправлениеСвойствамиКлиент.РедактироватьСоставСвойств(ЭтотОбъект, Объект.Ссылка);
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.Свойства

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОткрытьВложение()
	
	ТекущиеДанные = Элементы.Вложения.ТекущиеДанные;
	
	Если ТекущиеДанные <> Неопределено Тогда
		
		Если НЕ ЗначениеЗаполнено(ТекущиеДанные.Ссылка) Тогда
			Возврат;
		КонецЕсли;
		УправлениеЭлектроннойПочтойКлиент.ОткрытьВложение(ТекущиеДанные.Ссылка,УникальныйИдентификатор);
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПреобразоватьКодировкуПисьма(ВыбраннаяКодировка)
	
	ИмяВременногоФайла = ПолучитьИмяВременногоФайла();
	ЗаписьТекста = Новый ЗаписьТекста(ИмяВременногоФайла, Объект.Кодировка);
	ЗаписьТекста.Записать(
		?(Объект.ТипТекста = Перечисления.ТипыТекстовЭлектронныхПисем.HTML, Объект.ТекстHTML, Объект.Текст));
	ЗаписьТекста.Закрыть();
	
	ЧтениеТекста = Новый ЧтениеТекста(ИмяВременногоФайла, ВыбраннаяКодировка);
	Если Объект.ТипТекста = Перечисления.ТипыТекстовЭлектронныхПисем.HTML Тогда
		Объект.ТекстHTML = ЧтениеТекста.Прочитать();
		ТекстПисьма = Объект.ТекстHTML;
	Иначе
		Объект.Текст = ЧтениеТекста.Прочитать();
		ТекстПисьма = Объект.Текст;
	КонецЕсли;
	ЧтениеТекста.Закрыть();
	
	ИмяВременногоФайла = ПолучитьИмяВременногоФайла();
	ЗаписьТекста = Новый ЗаписьТекста(ИмяВременногоФайла, Объект.Кодировка);
	ЗаписьТекста.ЗаписатьСтроку(ОтправительПредставление);
	ЗаписьТекста.ЗаписатьСтроку(ПолучателиКопийПредставление);
	ЗаписьТекста.ЗаписатьСтроку(ПолучателиОтветаПредставление);
	ЗаписьТекста.ЗаписатьСтроку(ПолучателиПредставление);
	ЗаписьТекста.ЗаписатьСтроку(Объект.Тема);
	ЗаписьТекста.Закрыть();
	
	ЧтениеТекста = Новый ЧтениеТекста(ИмяВременногоФайла, ВыбраннаяКодировка);
	ОтправительПредставление = ЧтениеТекста.ПрочитатьСтроку();
	ПолучателиКопийПредставление = ЧтениеТекста.ПрочитатьСтроку();
	ПолучателиОтветаПредставление = ЧтениеТекста.ПрочитатьСтроку();
	ПолучателиПредставление = ЧтениеТекста.ПрочитатьСтроку();
	Объект.Тема = ЧтениеТекста.ПрочитатьСтроку();
	ЧтениеТекста.Закрыть();
	
	Объект.Кодировка = ВыбраннаяКодировка;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДополнительнуюИнформацию()
	
	ДополнительнаяИнформацияОПисьме = НСтр("ru = 'Создано:'") + "   " + Объект.Дата 
	+ Символы.ПС + НСтр("ru = 'Получено'") + ":  " + Объект.ДатаПолучения 
	+ Символы.ПС + НСтр("ru = 'Важность'") + ":  " + Объект.Важность
	+ Символы.ПС + НСтр("ru = 'Кодировка'") + ": " + Объект.Кодировка;
	
КонецПроцедуры

&НаСервере
Процедура ОбработатьНеобходимостьУведомленияОПрочтении()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	УведомленияОПрочтении.Письмо
	|ИЗ
	|	РегистрСведений.УведомленияОПрочтении КАК УведомленияОПрочтении
	|ГДЕ
	|	УведомленияОПрочтении.Письмо = &Письмо
	|	И (НЕ УведомленияОПрочтении.ТребуетсяОтправка)";
	
	Запрос.УстановитьПараметр("Письмо",Объект.Ссылка);
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат;
	КонецЕсли;
	
	НеобходимоеДействие = Взаимодействия.ПолучитьПараметрыРаботыПользователяДляВходящегоЭлектронногоПисьма();
	
	Если НеобходимоеДействие = Перечисления.ПорядокОтветовНаЗапросыУведомленийОПрочтении.ВсегдаОтправлятьУведомление Тогда
		
		ТребуетсяУстановкаФлагаОтправкиУведомления = Истина;
		
	ИначеЕсли НеобходимоеДействие = 
		Перечисления.ПорядокОтветовНаЗапросыУведомленийОПрочтении.НикогдаНеОтправлятьУведомление Тогда
		
		УправлениеЭлектроннойПочтой.УстановитьПризнакОтправкиУведомления(Объект.Ссылка,Ложь);
		
	ИначеЕсли НеобходимоеДействие = 
		Перечисления.ПорядокОтветовНаЗапросыУведомленийОПрочтении.ЗапрашиватьПередТемКакОтправитьУведомление Тогда
		
		ТребуетсяЗапросУведомленияОПрочтении = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура УстановитьПризнакОтправкиУведомления(Ссылка, Флаг)

	УправлениеЭлектроннойПочтой.УстановитьПризнакОтправкиУведомления(Ссылка, Флаг)

КонецПроцедуры

&НаКлиенте
Процедура ВопросОНеобходимостиОтправкиУведомленияОПрочтенииПослеЗавершения(РезультатВопроса, ДополнительныеПараметры) Экспорт

	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		УстановитьПризнакОтправкиУведомления(Объект.Ссылка, Истина);
	ИначеЕсли РезультатВопроса = КодВозвратаДиалога.Нет Тогда
		УстановитьПризнакОтправкиУведомления(Объект.Ссылка, Ложь);
	КонецЕсли;
	ТребуетсяЗапросУведомленияОПрочтении = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыборКодировкиПослеЗавершения(ВыбранныйЭлемент, ДополнительныеПараметры) Экспорт

	Если ВыбранныйЭлемент <> Неопределено Тогда
		ПреобразоватьКодировкуПисьма(ВыбранныйЭлемент.Значение);
	КонецЕсли;

КонецПроцедуры

// СтандартныеПодсистемы.Свойства

&НаСервере
Процедура СвойстваВыполнитьОтложеннуюИнициализацию()
	УправлениеСвойствами.ЗаполнитьДополнительныеРеквизитыВФорме(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЗависимостиДополнительныхРеквизитов()
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПриИзмененииДополнительногоРеквизита(Элемент)
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаСервере
Процедура ОбновитьЭлементыДополнительныхРеквизитов()
	
	УправлениеСвойствами.ОбновитьЭлементыДополнительныхРеквизитов(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриПовторномОткрытии()
	ЗаполнитьДеревоНаКлиенте();
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьДеревоНаКлиенте()
	
	ЗаполнитьДеревоВзаимодействий();
	Для каждого ЭлементДерева Из ДеревоВзаимодействий.ПолучитьЭлементы() Цикл
		Элементы.ДеревоВзаимодействий.Развернуть(ЭлементДерева.ПолучитьИдентификатор(), Истина);
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДеревоВзаимодействий()
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		Возврат;
	КонецЕсли;
	
	ИспользуетсяНоваяВерсияСпискаПисем = аэОбщийМодульСервер.ИспользуетсяНоваяВерсияСпискаПисем();
	
	Если ИспользуетсяНоваяВерсияСпискаПисем Тогда
		ВремДерево = Новый ДеревоЗначений;
		ВремДерево.Колонки.Добавить("Взаимодействие");
		ВремДерево.Колонки.Добавить("Предмет");
		ВремДерево.Колонки.Добавить("Дата");
		ВремДерево.Колонки.Добавить("Ответственный");
		ВремДерево.Колонки.Добавить("НомерКартинки");
		ВремДерево.Колонки.Добавить("ОтправительПредставление");
		ВремДерево.Колонки.Добавить("Рассмотрено");
		ВремДерево.Колонки.Добавить("РассмотретьПосле");
		ВремДерево.Колонки.Добавить("ЭтоПредмет");
		ВремДерево.Колонки.Добавить("Отклонено");
		ВремДерево.Колонки.Добавить("ПредметВзаимодействие");
		ВремДерево.Колонки.Добавить("СрокИсполнения");
		ВремДерево.Колонки.Добавить("Статус");
		ВремДерево.Колонки.Добавить("СтатусКартинкой");
		ВремДерево.Колонки.Добавить("Содержание");
		ВремДерево.Колонки.Добавить("ЭтоТекущееВзаимодействие");
	
		МассивПисем = Новый Массив;
		МассивПисем.Добавить(Объект.Ссылка);
		
		МассивВзяли = Новый Массив;
		
		аэОбщийМодульСервер.ПодготовитьДеревоВзаимодействий(МассивПисем, МассивВзяли, ВремДерево);
		
	Иначе

		ВремДерево = аэОбщийМодульСервер.ЗаполнитьДеревоВзаимодействий(Объект.Ссылка);
		
	КонецЕсли;
	
	ЗначениеВРеквизитФормы(ВремДерево, "ДеревоВзаимодействий");

КонецПроцедуры

// Конец СтандартныеПодсистемы.Свойства

#КонецОбласти
