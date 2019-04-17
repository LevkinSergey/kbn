﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	УстановитьВидимостьДоступность();
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьДоступность()
	Элементы.ГруппаWIPЛимит.Видимость = Ложь;
	Элементы.ГруппаWIPЛимит.ТолькоПросмотр = Истина;
	Элементы.ИспользоватьWIPЛимит.ТолькоПросмотр = Истина;
	Элементы.ДекорацияПояснение.Видимость = Ложь;
	
	Если Объект.ИспользоватьWIPЛимит Тогда
		Элементы.ГруппаWIPЛимит.Видимость = Истина;
	Конецесли;
	
	Если Объект.WIPЛимитУказываетсяВРодителе Тогда
		Элементы.ДекорацияПояснение.Видимость = Истина;
	Иначе
		Элементы.ГруппаWIPЛимит.ТолькоПросмотр = Ложь;
		Элементы.ИспользоватьWIPЛимит.ТолькоПросмотр = Ложь;
	Конецесли;
КонецПроцедуры 

&НаКлиенте
Процедура ИспользоватьWIPЛимитПриИзменении(Элемент)
	Если Объект.ИспользоватьWIPЛимит = Ложь Тогда
		Объект.ИспользоватьWIPЛимитНаИсполнителя = Ложь;
		Объект.WIPЛимитУказываетсяВРодителе = Ложь;
		Объект.WIPЛимит = 0;
	Конецесли;
	
	УстановитьВидимостьДоступность();
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	Оповестить("Справочник_узСтатусыЗадачи_Записан");
КонецПроцедуры
