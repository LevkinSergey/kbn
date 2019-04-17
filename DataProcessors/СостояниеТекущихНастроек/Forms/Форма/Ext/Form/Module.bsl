﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
		
	ПроверитьТекущиеНастройки();
	
КонецПроцедуры

&НаСервере
Процедура ПроверитьТекущиеНастройки()
	СрезПоследнихТЗ = РегистрыСведений.Настройки.СрезПоследних();
	Если СрезПоследнихТЗ.Количество() = 0 Тогда
		Элементы.ГруппаНастроекНет.Видимость = Истина;
		Элементы.ГруппаТекущиеНастройки.Видимость = Ложь;
		Элементы.ГруппаНастройкиСбораДолгихЗапросов.Видимость = Ложь;
		ПериодТекущихНастроек = '00010101'
	Иначе
		Элементы.ГруппаНастроекНет.Видимость = Ложь;
		Элементы.ГруппаТекущиеНастройки.Видимость = Истина;
		Элементы.ГруппаНастройкиСбораДолгихЗапросов.Видимость = Истина;
		ПериодТекущихНастроек = СрезПоследнихТЗ[0].Период;
		
		Элементы.ДекорацияНеУказанаУчетнаяЗапись.Видимость = НЕ ЗначениеЗаполнено(СрезПоследнихТЗ[0].ИденификаторБазы);
		
		Каталог = Новый Файл(СрезПоследнихТЗ[0].ПутьККонфигурационномуФайлу);
		Элементы.ДекорацияНеЗаданПутьКФайлуНастроек.Видимость = НЕ Каталог.Существует(); 
		
		Каталог = Новый Файл(СрезПоследнихТЗ[0].ПутьКФайламЛоговТЖ);
		Элементы.ДекорацияНеЗаданПутьКФайламЛогов.Видимость = НЕ Каталог.Существует(); 
		
		Элементы.ДекорацияНизкийПорогДлительности.Видимость = (СрезПоследнихТЗ[0].ДлительностьЗапросовПорог1 < 1);
	
	КонецЕсли;	
КонецПроцедуры


&НаКлиенте
Процедура Декорация1Нажатие(Элемент)
	ОткрытьФорму("РегистрСведений.Настройки.ФормаЗаписи");
КонецПроцедуры

&НаКлиенте
Процедура Декорация2Нажатие(Элемент)
	
	СтруктураКлючЗаписи = Новый Структура;
	СтруктураКлючЗаписи.Вставить("Период",ПериодТекущихНастроек);
	
	ПараметрыМассив = Новый Массив;
	ПараметрыМассив.Добавить(СтруктураКлючЗаписи);
	
	КлючЗаписиРегистра = Новый("РегистрСведенийКлючЗаписи.Настройки", ПараметрыМассив); 
	
	ОткрытьФорму("РегистрСведений.Настройки.ФормаЗаписи",Новый Структура("Ключ",КлючЗаписиРегистра));
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ЗаписьНастроек" Тогда
		
		ПроверитьТекущиеНастройки();
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ПодключитьОбработчикОжидания("ПроверитьТекущиеНастройкиКлиент",60);
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьТекущиеНастройкиКлиент()
	ПроверитьТекущиеНастройки();
КонецПроцедуры

