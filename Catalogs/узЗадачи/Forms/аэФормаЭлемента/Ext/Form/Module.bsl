﻿
&НаКлиенте
Процедура ПереключитьФорму(Команда)
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Ключ", Объект.Ссылка);
	
	ОткрытьФорму("Справочник.узЗадачи.Форма.ФормаЭлемента", ПараметрыФормы, Неопределено,,,,,РежимОткрытияОкнаФормы.Независимый);
	
	ЭтаФорма.Закрыть();
	
КонецПроцедуры
