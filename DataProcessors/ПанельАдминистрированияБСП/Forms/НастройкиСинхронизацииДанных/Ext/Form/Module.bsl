﻿&НаКлиенте
Перем ОбновитьИнтерфейс;

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	// Значения реквизитов формы
	РежимРаботы = ОбщегоНазначенияПовтИсп.РежимРаботыПрограммы();
	РежимРаботы = Новый ФиксированнаяСтруктура(РежимРаботы);
	
	// Настройки видимости при запуске.
	Элементы.ГруппаВременныеКаталогиКластераСерверов.Видимость = РежимРаботы.КлиентСерверный И РежимРаботы.ЭтоАдминистраторСистемы;
	
	
	
	Если РежимРаботы.МодельСервиса Тогда
		
		Элементы.ОписаниеРаздела.Заголовок = НСтр("ru='Настройка синхронизации данных с моими приложениями.';en='Data synchronization setup with my applications.';ro='Configurare de sincronizare a datelor cu aplicațiile mele.'");
		Элементы.ПояснениеНастройкиСинхронизацииДанных.Заголовок = НСтр("ru='Настройка и выполнение синхронизации данных с моими приложениями.';en='Setup and data synchronization with my applications.';ro='De configurare și de sincronizare a datelor cu aplicații mele.'");
		Элементы.ИспользоватьДатыЗапретаЗагрузкиПояснение.Заголовок =
			НСтр("ru = 'Запрет загрузки данных прошлых периодов из других приложений.
			           |Не влияет на загрузку данных из автономных рабочих мест.'");
		
		Элементы.ГруппаИспользоватьСинхронизациюДанных.Видимость = Ложь;
		Элементы.ГруппаПрефиксУзлаРаспределеннойИнформационнойБазы.Видимость = Ложь;
		Элементы.ГруппаВременныеКаталогиКластераСерверов.Видимость = Ложь;
		
	КонецЕсли;
	
	// Обновление состояния элементов.
	УстановитьДоступность();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	ОбработчикОповещений(ИмяСобытия, Параметр, Источник);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	ОбновитьИнтерфейсПрограммы();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ИспользоватьСинхронизациюДанныхПриИзменении(Элемент)
	
	ОбновитьРазрешенияПрофилейБезопасности(Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура ПрефиксУзлаРаспределеннойИнформационнойБазыПриИзменении(Элемент)
	Подключаемый_ПриИзмененииРеквизита(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура КаталогСообщенийОбменаДаннымиДляWindowsПриИзменении(Элемент)
	
	ОбновитьРазрешенияПрофилейБезопасности(Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура КаталогСообщенийОбменаДаннымиДляLinuxПриИзменении(Элемент)
	
	ОбновитьРазрешенияПрофилейБезопасности(Элемент);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// Обработка оповещений от других открытых форм.
//
// Параметры:
//   ИмяСобытия - Строка - имя события. Может быть использовано для идентификации сообщений принимающими их формами.
//   Параметр - Произвольный - параметр сообщения. Могут быть переданы любые необходимые данные.
//   Источник - Произвольный - источник события. Например, в качестве источника может быть указана другая форма.
//
// Пример:
//   Если ИмяСобытия = "НаборКонстант.ПрефиксУзлаРаспределеннойИнформационнойБазы" Тогда
//     НаборКонстант.ПрефиксУзлаРаспределеннойИнформационнойБазы = Параметр;
//   КонецЕсли;
//
&НаКлиенте
Процедура ОбработчикОповещений(ИмяСобытия, Параметр, Источник)
	
	
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкиСинхронизацииДанных(Команда)
	
	Если РежимРаботы.МодельСервиса Тогда
		
		ИмяОткрываемойФормы = "ОбщаяФорма.СинхронизацияДанныхВМоделиСервиса";
		
	Иначе
		ИмяОткрываемойФормы = "ОбщаяФорма.СинхронизацияДанных";
		
	КонецЕсли;
	
	ОткрытьФорму(ИмяОткрываемойФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура РезультатыСинхронизацииДанных(Команда)
	ОткрытьФорму("РегистрСведений.РезультатыОбменаДанными.Форма.Форма");
КонецПроцедуры

// СтандартныеПодсистемы.ДатыЗапретаИзменения
&НаКлиенте
Процедура НастроитьДатыЗапретаЗагрузки(Команда)
	
	ПараметрыФормы = Новый Структура("ДатыЗапретаЗагрузкиДанных", Истина);
	ОткрытьФорму("РегистрСведений.ДатыЗапретаИзменения.Форма.ДатыЗапретаИзменения", ПараметрыФормы);
	
КонецПроцедуры
// Конец СтандартныеПодсистемы.ДатыЗапретаИзменения

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

////////////////////////////////////////////////////////////////////////////////
// Клиент

&НаКлиенте
Процедура Подключаемый_ПриИзмененииРеквизита(Элемент, ОбновлятьИнтерфейс = Истина)
	
	КонстантаИмя = ПриИзмененииРеквизитаСервер(Элемент.Имя);
	
	ОбновитьПовторноИспользуемыеЗначения();
	
	Если ОбновлятьИнтерфейс Тогда
		ОбновитьИнтерфейс = Истина;
		ПодключитьОбработчикОжидания("ОбновитьИнтерфейсПрограммы", 2, Истина);
	КонецЕсли;
	
	Если КонстантаИмя <> "" Тогда
		Оповестить("Запись_НаборКонстант", Новый Структура, КонстантаИмя);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИнтерфейсПрограммы()
	
	Если ОбновитьИнтерфейс = Истина Тогда
		ОбновитьИнтерфейс = Ложь;
		ОбщегоНазначенияКлиент.ОбновитьИнтерфейсПрограммы();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьРазрешенияПрофилейБезопасности(Элемент)
	
	ОповещениеОЗакрытии = Новый ОписаниеОповещения("ОбновитьРазрешенияПрофилейБезопасностиЗавершение", ЭтотОбъект, Элемент);
	
	МассивЗапросов = СоздатьЗапросНаИспользованиеВнешнихРесурсов(Элемент.Имя);
	
	Если МассивЗапросов = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	РаботаВБезопасномРежимеКлиент.ПрименитьЗапросыНаИспользованиеВнешнихРесурсов(
		МассивЗапросов, ЭтотОбъект, ОповещениеОЗакрытии);
	
КонецПроцедуры

&НаСервере
Функция СоздатьЗапросНаИспользованиеВнешнихРесурсов(ИмяКонстанты)
	
	КонстантаМенеджер = Константы[ИмяКонстанты];
	КонстантаЗначение = НаборКонстант[ИмяКонстанты];
	
	Если КонстантаМенеджер.Получить() = КонстантаЗначение Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Если ИмяКонстанты = "ИспользоватьСинхронизациюДанных" Тогда
		
		Если КонстантаЗначение Тогда
			
			Запрос = ОбменДаннымиСервер.ЗапросНаИспользованиеВнешнихРесурсовПриВключенииОбмена();
			
		Иначе
			
			Запрос = ОбменДаннымиСервер.ЗапросНаОчисткуРазрешенийИспользованияВнешнихРесурсов();
			
		КонецЕсли;
		
		Возврат Запрос;
		
	Иначе
		
		МенеджерЗначения = КонстантаМенеджер.СоздатьМенеджерЗначения();
		ИдентификаторКонстанты = ОбщегоНазначения.ИдентификаторОбъектаМетаданных(МенеджерЗначения.Метаданные());
		
		Если ПустаяСтрока(КонстантаЗначение) Тогда
			
			Запрос = РаботаВБезопасномРежиме.ЗапросНаОчисткуРазрешенийИспользованияВнешнихРесурсов(ИдентификаторКонстанты);
			
		Иначе
			
			Разрешения = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(
				РаботаВБезопасномРежиме.РазрешениеНаИспользованиеКаталогаФайловойСистемы(КонстантаЗначение, Истина, Истина));
			Запрос = РаботаВБезопасномРежиме.ЗапросНаИспользованиеВнешнихРесурсов(Разрешения, ИдентификаторКонстанты);
			
		КонецЕсли;
		
		Возврат ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Запрос);
		
	КонецЕсли;
	
КонецФункции

&НаКлиенте
Процедура ОбновитьРазрешенияПрофилейБезопасностиЗавершение(Результат, Элемент) Экспорт
	
	Если Результат = КодВозвратаДиалога.ОК Тогда
	
		Подключаемый_ПриИзмененииРеквизита(Элемент);
		
	Иначе
		
		ЭтотОбъект.Прочитать();
	
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Вызов сервера

&НаСервере
Функция ПриИзмененииРеквизитаСервер(ИмяЭлемента)
	
	РеквизитПутьКДанным = Элементы[ИмяЭлемента].ПутьКДанным;
	
	КонстантаИмя = СохранитьЗначениеРеквизита(РеквизитПутьКДанным);
	
	УстановитьДоступность(РеквизитПутьКДанным);
	
	ОбновитьПовторноИспользуемыеЗначения();
	
	Возврат КонстантаИмя;
	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// Сервер

&НаСервере
Функция СохранитьЗначениеРеквизита(РеквизитПутьКДанным)
	
	// Сохранение значений реквизитов, не связанных с константами напрямую (в отношении один-к-одному).
	Если РеквизитПутьКДанным = "" Тогда
		Возврат "";
	КонецЕсли;
	
	// Определение имени константы.
	КонстантаИмя = "";
	Если НРег(Лев(РеквизитПутьКДанным, 14)) = НРег("НаборКонстант.") Тогда
		// Если путь к данным реквизита указан через "НаборКонстант".
		КонстантаИмя = Сред(РеквизитПутьКДанным, 15);
	Иначе
		// Определение имени и запись значения реквизита в соответствующей константе из "НаборКонстант".
		// Используется для тех реквизитов формы, которые связаны с константами напрямую (в отношении один-к-одному).
	КонецЕсли;
	
	// Сохранения значения константы.
	Если КонстантаИмя <> "" Тогда
		КонстантаМенеджер = Константы[КонстантаИмя];
		КонстантаЗначение = НаборКонстант[КонстантаИмя];
		
		Если КонстантаМенеджер.Получить() <> КонстантаЗначение Тогда
			КонстантаМенеджер.Установить(КонстантаЗначение);
		КонецЕсли;
	КонецЕсли;
	
	Возврат КонстантаИмя;
	
КонецФункции

&НаСервере
Процедура УстановитьДоступность(РеквизитПутьКДанным = "")
	
	// СтандартныеПодсистемы.ДатыЗапретаИзменения
	Если РеквизитПутьКДанным = "НаборКонстант.ИспользоватьДатыЗапретаЗагрузки"
	 Или РеквизитПутьКДанным = "" Тогда
		
		Элементы.ГруппаДатыЗапретаЗагрузкиНастройка.Доступность =
			НаборКонстант.ИспользоватьДатыЗапретаЗагрузки;
	КонецЕсли;
	// Конец СтандартныеПодсистемы.ДатыЗапретаИзменения
	
	Если РеквизитПутьКДанным = "НаборКонстант.ИспользоватьСинхронизациюДанных" ИЛИ РеквизитПутьКДанным = "" Тогда
		
		Элементы.ПрефиксУзлаРаспределеннойИнформационнойБазы.Доступность = НаборКонстант.ИспользоватьСинхронизациюДанных;
		Элементы.НастройкиСинхронизацииДанных.Доступность = НаборКонстант.ИспользоватьСинхронизациюДанных;
		Элементы.ГруппаДатыЗапретаЗагрузки.Доступность    = НаборКонстант.ИспользоватьСинхронизациюДанных;
		Элементы.РезультатыСинхронизацииДанных.Доступность = НаборКонстант.ИспользоватьСинхронизациюДанных;
		Элементы.ГруппаВременныеКаталогиКластераСерверов.Доступность = НаборКонстант.ИспользоватьСинхронизациюДанных;
		
		
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЭкспортЛицензийНаСервере()
	
	Запрос = Новый Запрос;
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	аэЛицензирование.Ссылка КАК Ссылка,
	|	аэЛицензирование.Наименование КАК Наименование,
	|	аэЛицензирование.НомерЛицензии КАК НомерЛицензии,
	|	аэЛицензирование.ПинВведенный КАК ПинВведенный,
	|	аэЛицензирование.ПинРезервный КАК ПинРезервный,
	|	аэЛицензированиеДополнительныеПИНкоды.ПинРезервный КАК ПинРезервный2,
	|	аэЛицензирование.ТипЛицензии КАК ТипЛицензии,
	|	аэЛицензирование.ВидЛицензии КАК ВидЛицензии,
	|	ВЫРАЗИТЬ(аэЛицензирование.ИнформацияОЛицензии КАК СТРОКА(1000)) КАК Инфо
	|ИЗ
	|	Справочник.аэЛицензирование КАК аэЛицензирование
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.аэЛицензирование.ДополнительныеПИНкоды КАК аэЛицензированиеДополнительныеПИНкоды
	|		ПО аэЛицензирование.Ссылка = аэЛицензированиеДополнительныеПИНкоды.Ссылка
	|ГДЕ
	|	НЕ аэЛицензирование.Ссылка.ПометкаУдаления";
	
	ТЗ = Запрос.Выполнить().Выгрузить();
	
	ТабДок = Новый ТабличныйДокумент;
	Макет = Обработки.ПанельАдминистрированияБСП.ПолучитьМакет("МакетВыгрузки");
	
	
	Шапка = Макет.ПолучитьОбласть("Шапка");
	ТабДок.Вывести(Шапка);
	Для каждого СтрокаТЗ Из ТЗ Цикл
	
		СтрокаДанные = Макет.ПолучитьОбласть("Данные");
		ЗаполнитьЗначенияСвойств(СтрокаДанные.Параметры, СтрокаТЗ);
		ТабДок.Вывести(СтрокаДанные);
	
	КонецЦикла;
	
	КаталогСохранения = СокрЛП(Константы.аэКаталогЭкспортаЛицензий.Получить());
	
	Если ЗначениеЗаполнено(КаталогСохранения) Тогда
	
		ТабДок.Записать(КаталогСохранения + "\Лицензии.xlsx", ТипФайлаТабличногоДокумента.XLSX);
	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЭкспортЛицензий(Команда)
	ЭкспортЛицензийНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура аэКаталогЭкспортаЛицензийПриИзменении(Элемент)
	
	ОбновитьРазрешенияПрофилейБезопасности(Элемент);
	
КонецПроцедуры

#КонецОбласти
