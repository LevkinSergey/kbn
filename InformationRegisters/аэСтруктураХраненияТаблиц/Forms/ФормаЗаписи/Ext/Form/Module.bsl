﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	СтруктураХранения = РеквизитФормыВЗначение("Запись").СтруктураХранения.Получить();
	
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	//РеквизитФормыВЗначение("Запись").СтруктураХранения = Новый ХранилищеЗначения(СтруктураХранения, Новый СжатиеДанных(9));
	
КонецПроцедуры
