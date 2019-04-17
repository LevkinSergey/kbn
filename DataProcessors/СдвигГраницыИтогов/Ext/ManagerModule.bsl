﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

// Выполняет сдвиг границы итогов.
Процедура ВыполнитьКоманду(ПараметрыКоманды, АдресХранилища) Экспорт
	УстановитьПривилегированныйРежим(Истина);
	УправлениеИтогамиИАгрегатамиСлужебный.РассчитатьИтоги();
	Результат = Новый Структура;
	СтандартныеПодсистемыКлиентСервер.ВывестиОповещение(
		Результат,
		НСтр("ru = 'Оптимизация успешно завершена'"),
		,
		БиблиотекаКартинок.Успешно32);
	ПоместитьВоВременноеХранилище(Результат, АдресХранилища);
КонецПроцедуры

#КонецОбласти

#КонецЕсли
