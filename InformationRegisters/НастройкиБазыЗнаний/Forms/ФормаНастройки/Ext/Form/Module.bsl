﻿////////////////////////////////////////////////////////////////////////////////
// УПРАВЛЕНИЕ ФОРМОЙ

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТКА СОБЫТИЙ ЭЛЕМЕНТОВ ФОРМЫ

&НаКлиенте
Процедура ЛокальныйКаталогПриИзменении(Элемент)
	ЛокальныйКаталог = СокрЛП(ЛокальныйКаталог);
	Если НЕ Лев(ЛокальныйКаталог, 2) = "\\" Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю("В качестве локального каталога может быть использован только сетевой каталог");
		ЛокальныйКаталог = "";
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ЛокальныйКаталогНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ДиалогВыбора = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
	Если ДиалогВыбора.Выбрать() Тогда
		ЗначКаталога = ДиалогВыбора.Каталог;
		Если НЕ Лев(ЗначКаталога, 2) = "\\" Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю("В качестве локального каталога может быть использован только сетевой каталог");
			Возврат;
		КонецЕсли;
		
		ЛокальныйКаталог = ЗначКаталога;
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТКА СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ПрочитатьНаСервере();
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТКА КОМАНД ФОРМЫ

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	Если ЭтаФорма.Модифицированность Тогда
		ЗаписатьНаСервере();
	КонецЕсли;
	
	ЭтотОбъект.Закрыть();
КонецПроцедуры

&НаКлиенте
Процедура Записать(Команда)
	ЗаписатьНаСервере();
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБЩИЕ МЕТОДЫ

&НаСервере
Процедура ПрочитатьНаСервере()
	ОбщиеНастройки = БазаЗнанийКлиентСерверПовтИсп.ПолучитьСтруктуруОбщихНастроекБазыЗнаний();
	
	// Общие настройки
	НаборЗаписей = РегистрыСведений.НастройкиБазыЗнаний.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Пользователь.Установить(Справочники.Пользователи.ПустаяСсылка());
	НаборЗаписей.Прочитать();
	Для Каждого ЗаписьРегистра Из НаборЗаписей Цикл
		ИмяНастройки = ЗаписьРегистра.ИмяНастройки;
		Если НЕ ОбщиеНастройки.Свойство(ИмяНастройки) Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю("Не найдены параметры настройки """ + СокрЛП(ИмяНастройки) + """ !!!");
			Продолжить;
		КонецЕсли;
		
		ПараметрыНастройки = ОбщиеНастройки[ИмяНастройки];
		ЭтотОбъект[ИмяНастройки] = ЗаписьРегистра[ПараметрыНастройки.ИмяРесурса];
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьНаСервере()
	Если НЕ ЭтотОбъект.Модифицированность Тогда
		Возврат;
	КонецЕсли;
	
	ОбщиеНастройки = БазаЗнанийКлиентСерверПовтИсп.ПолучитьСтруктуруОбщихНастроекБазыЗнаний();
	
	НаборЗаписей = РегистрыСведений.НастройкиБазыЗнаний.СоздатьНаборЗаписей();
	НаборЗаписей.Прочитать();
	НаборЗаписей.Очистить();
	Для Каждого КлючИЗначение Из ОбщиеНастройки Цикл
		ЗаписьРегистра = НаборЗаписей.Добавить();
		ЗаписьРегистра.ИмяНастройки = КлючИЗначение.Ключ;
		ЗаписьРегистра.Пользователь	= Справочники.Пользователи.ПустаяСсылка();
		ЗаписьРегистра.ИмяРесурса	= КлючИЗначение.Значение.ИмяРесурса;
		ЗаписьРегистра[КлючИЗначение.Значение.ИмяРесурса] = ЭтотОбъект[КлючИЗначение.Ключ];
	КонецЦикла;
	НаборЗаписей.Записать(Истина);
	
	ЭтотОбъект.Модифицированность = Ложь;
КонецПроцедуры
