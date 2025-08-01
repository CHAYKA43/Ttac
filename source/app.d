import std.stdio;
import std.algorithm;
import std.file;
import std.path;
import std.algorithm;
import std.conv;
import std.array;
import mylib;
import std.format;
import std.string;

string name = "Ttac";
string tversion = "0.1-D";
string author = "CHAYKA43";

auto ttac_readfile(string file_name) {
	try {
		auto file = readText(file_name);
		string path = absolutePath(file_name);
		size_t charcou = file.length;
		size_t lineCount = file.count('\n') + 1;
		auto result = "Путь: " ~ path ~ "\n\n" ~ file ~ "\n\n" ~ "Кол-во символов: " ~ charcou.to!string ~ "\n" ~ "Кол-во строк: " ~ lineCount.to!string;
		return result;
	} catch (Exception e) {
		return e.msg;
	}
}

string[] elifdaer_catt(string eman_elif, int ofni) {
	try {
		if (ofni == 0) {
			auto lines = File(eman_elif).byLineCopy.array;
			return lines;
		} else {
			string path = absolutePath(eman_elif);
			auto lines = File(eman_elif).byLineCopy.array;
			auto file = readText(eman_elif);
			size_t charcou = file.length;
			size_t lineCount = file.count('\n') + 1;
			auto result = "\nПуть: " ~ path ~ lines ~ format("Кол-во символов: %d\n", charcou) ~ format("Кол-во строк: %d", lineCount);
			return result;
		}
		return [];
	} catch (Exception e) {
		return [e.msg];
	}
}

string input(string text) {
	write(text);
	string in1 = readln().strip();
	in1 = in1.to!string;
	return in1;
}

void ttactofile(string thefle, string data, string mode) {
	File file = File(thefle, mode);
	file.writeln(data);
	file.close();
}

void main(string[] args)
{
	if (args.length > 1) {
		if (!args[1].startsWith("-")) {
			try {
				auto file = readText(args[1]);
				writeln(file);
			} catch (Exception e) {
				writeln(e.msg);
			}
		} else if ((args[1] == "-r") || (args[1] == "--read") || (args[1] == "--readfile") || (args[1] == "--read-file")) {
			if (args.length > 2) {
				if (!(args.length > 3 && args[3] == "--no-detail-information")) {
					writeln(ttac_readfile(args[2]));
				} else {
					try {
						auto file = readText(args[2]);
						writeln(file);
					} catch (Exception e) {
						writeln(e.msg);
					}
				}
			} else {
				writeln("<> - Обязательный аргумент\n[] - Необязательный аргумент\nИспользование:\nttac -r/--read/--readfile/--read-file <файл> [--no-detail-information]");
			}
		} else if ((args[1] == "--reversion") || (args[1] == "--reverse") || (args[1] == "--rev")) {
			if (args.length > 2) {
				if (!(args.canFind("--info")) && !(args.canFind("-i"))) {
					writeln(byteprint(elifdaer_catt(args[2], 0), 1));
				} else {
					writeln(byteprint(elifdaer_catt(args[2], 1), 1));
				}
			} else {
				writeln("<> - Обязательный аргумент\n[] - Необязательный аргумент\nИспользование:\nttac --reversion/--reverse/--rev <файл> [--info/-i]");
			}
		} else if ((args[1] == "-w") || (args[1] == "--write") || (args[1] == "--write-to") || (args[1] == "--write-to-file")) {
			if (args.length > 3) {
				try {
					if (exists(args[2])) {
						if (!(args.length > 4 && args[4] == "--add")) {
							if (args.length > 4 && args[4] == "-y") {
								ttactofile(args[2], args[3], "w");
							} else {
								string result = input(format("Файл \"%s\" существует. Вы действительно хотите перезаписать его? (y or n): ", args[2]));
								if (result == "y") {
									ttactofile(args[2], args[3], "w");
								} else {
									writeln("Отменено.");
								}
							}
						} else if (args[4] == "--add") {
							ttactofile(args[2], args[3], "a");
						}
					} else {
						ttactofile(args[2], args[3], "w");
					}
				} catch (Exception e) {
					writeln(e.msg);
				}
			} else {
				writeln("<> - Обязательный аргумент\n[] - Необязательный аргумент\nИспользование:\nttac -w/--write/--write-to/--write-to-file <файл> <контент> [-y] [--add]");
			}
		} else if ((args[1] == "-d") || (args[1] == "--delete") || (args[1] == "--delete-file")) {
			if (args.length > 2) {
				if (exists(args[2])) {
					try {
						if (!(args.length > 3 && args[3] == "-y")) {
							string y_or_n = input(format("Вы действительно хотите удалить этот файл? (%s) (y or n): ", args[2]));
							if (y_or_n == "y") {
								remove(args[2]);
							} else {
								writeln("Отменено.");
							}
						} else {
							remove(args[2]);
						}
					} catch (Exception e) {
						writeln(e.msg);
					}
				} else {
					writeln(format("Файл \"%s\" не существует.", args[2]));
				}
			} else {
				writeln("<> - Обязательный аргумент\n[] - Необязательный аргумент\nИспользование:\nttac -d/--delete/--delete-file <файл> [-y]");
			}
		} else if ((args[1] == "-h") || (args[1] == "--help")) {
			writeln(format("%s. Версия: %s.\nАвтор: %s\n\n<> - Обязательный аргумент\n[] - Необязательный аргумент\nКоманды:\nttac -r/--read/--readfile/--read-file <файл> [--no-detail-information] - чтение файла\nttac --reversion/--reverse/--rev <файл> [--info/-i] - вывод файла в обратном порядке\nttac -w/--write/--write-to/--write-to-file <файл> <контент> [-y] [--add]\nttac -d/--delete/--delete-file <файл> [-y]\nttac <файл> - вывод файла без подробностей\nttac -h/--help - это меню.\nttac --guide - для подробной информации и примеров.", name, tversion, author));
		} else if (args[1] == "--guide") {
			writeln(format("Привет! Это подробная инструкция по использованиею команд в \"%s\"!\n\nВы зададитесь вопросом... \"А как вообще тут читать файлы, раз это аля \"аналог\" cat и других UNIX утилит?\"\nА я вам отвечу...\nТЫ ВООБЩЕ ЧИТАЛ БАЗОВУЮ СПРАВКУ?! ДЛЯ ЭТОГО ИСПОЛЬЗУЮТСЯ АРГУМЕНТЫ -r/--read/--readfile/--read-file ВСЁ!\nА... Точно... Это гайд для чайников... Я забыл... Извини...\n\n1. Чтение файлов\n Для этого как я уже сказал используются следующие аргументы и их синонимы... \"-r/--read/--readfile/--read-file\"\n Пример команды:\n ttac -r text.txt\n Вывод:\n\n Путь: /home/chayka43/ttac/text.txt\n\n МЕНЯ ЧАЙКА ДЕРЖИТ В ПОДВАЛЕ!! ПОМОГИТ-\n\n Кол-во символов: 68\n Кол-во строк: 1\n\n Тут у нас пишется путь... что написано в файлТАК СТОП Я ЗАБЫЛ SSH СЕРВЕР ВЫРУБИТЬ, количество символов и строк.\n Не нужна дополнительная информация?\n Тогда просто напиши ttac text.txt или ttac -r text.txt --no-detail-information\n Да я конченый, вопросы?\n\n2. Чтение файла в обратном порядке\n Представим такую ситуацию... КАКИМ ТО БОКОМ ВАМ ПОНАДОБИЛОСЬ ПРОЧИТАТЬ ФАЙЛ НАОБАРОТ! ЗАЧЕМ? ХЕР ЕГО ЗНАЕТ!\n Для того чтобы это сделать вам нужно написать один из этих аргументов: \"--reversion/--reverse/--rev\"\n Пример команды:\n ttac --rev text.txt\n Вывод:\n porno guys\n watch the\n today we\n hello guys\n ...\n КТО ЭТО НАПИСАЛ БЛЯТЬ?\n А теперь представим что вам нужно получить ПУТЬ, КОЛ-ВО СИМВОЛОВ И СТРОК! ОПЯТЬ ЖЕ СПРОШУ ТЕБЯ... ЗАЧЕМ?\n Для этого нам нужно добавить аргумент -i или --info\n Пример команды: ttac --rev text.txt --info\n Вывод: \n Кол-во строк: 4\n Кол-во символов: 40\n\n porno guys\n watch the\n today we\n hello guys\n\n Путь: /home/chayka43/ttac/text.txt\n\n Довольны?\n\n3. Запись в файл\n Представим что вы не умеете пользоватся nano и touch'ем...\n ТОГДА НАУЧИТЕСЬ ПОЛЬЗОВАТСЯ VIM'ОМ!\n Для того чтобы создать файл или его перезаписать используйте следующие аргументы: -w/--write/--write-to/--write-to-file\n Пример команды: ttac --write-to text.txt \"123\" \n Вывод:\n Файл \"text.txt\" существует. Вы действительно хотите перезаписать его? (y or n):\n Жмём y и enter.\n После этого файл перезапишется и содержимое его будет 123...\n Параметр -y отключает потверждение и сразу выполняет перезапись. Пример: ttac --write-to text.txt \"321\" -y. А параметр --add просто добавляет строку к файлу, тут уже не нужны потверждения и аргумент -y. Пример: ttac --write-to text.txt \"123\" --add.\n\n4.Удаление файлов\n У меня есть к вам вопрос... НАХУЯ ВАМ rm? ВЫ МОЖЕТЕ СДЕЛАТЬ ЭТО ЧЕРЕЗ НЕГО!\n Для удаления файлов используйте следующие аргументы: -d/--delete/--delete-file\n Пример команды:\n ttac -d text.txt\n Выскочет предупреждение:\n Вы действительно хотите удалить этот файл? (text.txt) (y or n): \n Нажимаем y и enter.\n Для того чтобы его убрать добавляем в конец -y. Пример: ttac -d text.txt -y\n\nВЫ ПРОШЛИ ОБУЧЕНИЕ!!! ПОЗДРАВЛЯЮ!!!\nЯ устал это писать...", name));
		} else {
			writeln(format("Неправильный аргумент \"%s\"", args[1]));
		}
	}
}