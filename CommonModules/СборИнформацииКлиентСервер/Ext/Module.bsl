﻿Процедура ЗначенияКлючейРеестра(ЗапрашиваемыеКлючи, СообщениеОбОшибке) Экспорт 
	
	СоответствиеРазделов = Новый Соответствие;
	СоответствиеРазделов.Вставить("HKEY_CLASSES_ROOT", "2147483648"); 
	СоответствиеРазделов.Вставить("HKEY_CURRENT_USER", "2147483649"); 
	СоответствиеРазделов.Вставить("HKEY_LOCAL_MACHINE", "2147483650"); 
	СоответствиеРазделов.Вставить("HKEY_USERS", "2147483651"); 
	СоответствиеРазделов.Вставить("HKEY_CURRENT_CONFIG", "2147483653");
	
	ВызываемыеМетоды = Новый Соответствие;
	ВызываемыеМетоды.Вставить("DWORD","GetDWORDValue");
	ВызываемыеМетоды.Вставить("String","GetStringValue");
	ВызываемыеМетоды.Вставить("Binary","GetBinaryValue");
	ВызываемыеМетоды.Вставить("ExpandedString","GetExpandedStringValue");
	ВызываемыеМетоды.Вставить("MultiString","GetMultiStringValue");
	
	Попытка 	
		
		RegProv=ПолучитьCOMОбъект("winmgmts:{impersonationLevel=impersonate}!\\.\root\default:StdRegProv");
		
		Если ТипЗнч(ЗапрашиваемыеКлючи) = Тип("Структура") Тогда
			
			Попытка
				Значение = Неопределено;
				Выполнить("RegProv." + ВызываемыеМетоды[ЗапрашиваемыеКлючи.ТипПараметра] + "(СоответствиеРазделов[ЗапрашиваемыеКлючи.ИмяРаздела]
					|,ЗапрашиваемыеКлючи.Ветка
					|,ЗапрашиваемыеКлючи.ИмяКлюча
					|,Значение);");
					
				ЗапрашиваемыеКлючи.Вставить("Значение", Значение);
			Исключение
				ЗапрашиваемыеКлючи.Вставить("СообщениеОбОшибке", "" + ОписаниеОшибки());
			КонецПопытки;
			
		ИначеЕсли ТипЗнч(ЗапрашиваемыеКлючи) = Тип("Массив") Тогда
			
			Для Каждого ОписаниеКлюча из ЗапрашиваемыеКлючи Цикл
				
				Попытка
					Значение = Неопределено;
					Выполнить("RegProv." + ВызываемыеМетоды[ОписаниеКлюча.ТипПараметра] + "(СоответствиеРазделов[ОписаниеКлюча.ИмяРаздела] 
						|,ОписаниеКлюча.Ветка
						|,ОписаниеКлюча.ИмяКлюча
						|,Значение);");
						
					ОписаниеКлюча.Вставить("Значение", Значение);
				Исключение
					ОписаниеКлюча.Вставить("СообщениеОбОшибке", "" + ОписаниеОшибки());
				КонецПопытки;
				
			КонецЦикла;			
			
		КонецЕсли;
		
	Исключение
		СообщениеОбОшибке = "" + ОписаниеОшибки();
	КонецПопытки;
	
КонецПроцедуры

Функция ПараметрыКомпьютера(ЭтоСервер = Ложь) Экспорт
	
	// вместо ТЗ массив структур
	тзПараметры = Новый Массив;
	ПоляСтруктуры = "Параметр,Значение,Клиент1С";
	
	ЗапрашиваемыеКлючи = Новый Массив;
	
	// 0 Имя Компьютера
	ОписаниеКлюча = Новый Структура;
	ОписаниеКлюча.Вставить("ИмяРаздела","HKEY_LOCAL_MACHINE");
	ОписаниеКлюча.Вставить("Ветка","SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName");
	ОписаниеКлюча.Вставить("ИмяКлюча","ComputerName");
	ОписаниеКлюча.Вставить("ТипПараметра","String");
	ОписаниеКлюча.Вставить("ИмяПараметраДляСервиса","Имя компьютера");
	ЗапрашиваемыеКлючи.Добавить(ОписаниеКлюча);
	
	// 1  Процессор
	ОписаниеКлюча = Новый Структура;
	ОписаниеКлюча.Вставить("ИмяРаздела","HKEY_LOCAL_MACHINE");
	ОписаниеКлюча.Вставить("Ветка","HARDWARE\DESCRIPTION\System\CentralProcessor\0");
	ОписаниеКлюча.Вставить("ИмяКлюча","ProcessorNameString");
	ОписаниеКлюча.Вставить("ТипПараметра","String");
	ОписаниеКлюча.Вставить("ИмяПараметраДляСервиса","Процессор");
	ЗапрашиваемыеКлючи.Добавить(ОписаниеКлюча);
	
	// 2 Контроль учетных записей и применение политики UAC
	ОписаниеКлюча = Новый Структура;
	ОписаниеКлюча.Вставить("ИмяРаздела","HKEY_LOCAL_MACHINE");
	ОписаниеКлюча.Вставить("Ветка","SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System");
	ОписаниеКлюча.Вставить("ИмяКлюча","EnableLUA");
	ОписаниеКлюча.Вставить("ТипПараметра","DWORD");
	ОписаниеКлюча.Вставить("ИмяПараметраДляСервиса","EnableLUA");
	ЗапрашиваемыеКлючи.Добавить(ОписаниеКлюча);
	
	// 3 DFSS EnableCpuQuota
	ОписаниеКлюча = Новый Структура;
	ОписаниеКлюча.Вставить("ИмяРаздела","HKEY_LOCAL_MACHINE");
	ОписаниеКлюча.Вставить("Ветка","SYSTEM\CurrentControlSet\Control\Session Manager\Quota System");
	ОписаниеКлюча.Вставить("ИмяКлюча","EnableCpuQuota");
	ОписаниеКлюча.Вставить("ТипПараметра","DWORD");
	ОписаниеКлюча.Вставить("ИмяПараметраДляСервиса","DFSS EnableCpuQuota");
	ЗапрашиваемыеКлючи.Добавить(ОписаниеКлюча);
	
	// 4 DFSS EnableFairShare
	ОписаниеКлюча = Новый Структура;
	ОписаниеКлюча.Вставить("ИмяРаздела","HKEY_LOCAL_MACHINE");
	ОписаниеКлюча.Вставить("Ветка","SYSTEM\CurrentControlSet\Services\TSFairShare\Disk");
	ОписаниеКлюча.Вставить("ИмяКлюча","EnableFairShare");
	ОписаниеКлюча.Вставить("ТипПараметра","DWORD");
	ОписаниеКлюча.Вставить("ИмяПараметраДляСервиса","DFSS EnableFairShare");
	ЗапрашиваемыеКлючи.Добавить(ОписаниеКлюча);
	
	// 5 Режим производительности
	ОписаниеКлюча = Новый Структура;
	ОписаниеКлюча.Вставить("ИмяРаздела","HKEY_LOCAL_MACHINE");
	ОписаниеКлюча.Вставить("Ветка","SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes");
	ОписаниеКлюча.Вставить("ИмяКлюча","ActivePowerScheme");
	ОписаниеКлюча.Вставить("ТипПараметра","String");
	ОписаниеКлюча.Вставить("ИмяПараметраДляСервиса","Режим производительности");
	ЗапрашиваемыеКлючи.Добавить(ОписаниеКлюча);
	//|--Power Scheme GUID: 381b4222-f694-41f0-9685-ff5bb260df2e (Balanced) *
	//|--Power Scheme GUID: c37e3d38-5e78-41ec-bebe-ab664c826ea0
	// ИЛИ
	//|--Power Scheme GUID: 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c (High performance)
	//|--Power Scheme GUID: a1841308-3541-4fab-bc81-f71556f20b4a (Power saver
	
	СообщениеОбОшибке = "";
	ЗначенияКлючейРеестра(ЗапрашиваемыеКлючи, СообщениеОбОшибке);
	
	Значение = Неопределено;
	ТекстОшибки = Неопределено;
	ИмяКомпьютера = "";  // должен идти первым параметром
	
	Для Каждого ОписаниеКлюча из ЗапрашиваемыеКлючи Цикл
		
		НоваяСтрока = Новый Структура(ПоляСтруктуры); 
		НоваяСтрока.Параметр = ОписаниеКлюча.ИмяПараметраДляСервиса;
		
		ОписаниеКлюча.Свойство("Значение",Значение);
		Значение = "" + Формат(Значение, "ЧН=0"); // приведем к строке

		Если ОписаниеКлюча.ИмяКлюча = "ComputerName" Тогда
			ИмяКомпьютера = Значение;
		ИначеЕсли ОписаниеКлюча.ИмяКлюча = "ActivePowerScheme" Тогда
			Если Значение = "381b4222-f694-41f0-9685-ff5bb260df2e" Тогда
				Значение = "Balanced"; 	
			ИначеЕсли Значение = "8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c"
				или Значение = "c37e3d38-5e78-41ec-bebe-ab664c826ea0" Тогда
				Значение = "High performance"; 	
			ИначеЕсли Значение = "a1841308-3541-4fab-bc81-f71556f20b4a" Тогда
				Значение = "Power saver";
			Иначе
				Значение = "Неопределено";
			КонецЕсли;
		КонецЕсли;
		
		НоваяСтрока.Значение = Значение;
		НоваяСтрока.Клиент1С = ИмяКомпьютера;
		
		тзПараметры.Добавить(НоваяСтрока);
		
	КонецЦикла;
	
	Если ЭтоСервер Тогда
		
		мВерсияПлатформы = "";
		мПамять = 0;
		Попытка
			СисИнфо = Новый СистемнаяИнформация;
			мВерсияПлатформы = СисИнфо.ВерсияПриложения;
			мПамять = СисИнфо.ОперативнаяПамять;
		Исключение
			ОбщегоНазначения.СообщитьОбОшибке("Ошибка при получении информации.", ОписаниеОшибки(), Ложь);
		КонецПопытки;
		
		Если ЗначениеЗаполнено(мВерсияПлатформы) Тогда
			НоваяСтрока = Новый Структура(ПоляСтруктуры); 
			НоваяСтрока.Параметр = "Версия платформы 1С";
			НоваяСтрока.Значение = мВерсияПлатформы;
			НоваяСтрока.Клиент1С = ИмяКомпьютера;
			тзПараметры.Добавить(НоваяСтрока);
		КонецЕсли;
		
		Если ЗначениеЗаполнено(мПамять) Тогда
			НоваяСтрока = Новый Структура(ПоляСтруктуры); 
			НоваяСтрока.Параметр = "Оперативная память, МБ";
			НоваяСтрока.Значение = мПамять;
			НоваяСтрока.Клиент1С = ИмяКомпьютера;
			тзПараметры.Добавить(НоваяСтрока);
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат тзПараметры;	
	
КонецФункции
