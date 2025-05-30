-- Создание таблицы
CREATE TABLE IF NOT EXISTS questions (
    question_id BIGSERIAL PRIMARY KEY,
    topic VARCHAR(255),
    correct_answer VARCHAR(255),
    question TEXT,
    option1 TEXT,
    option2 TEXT,
    option3 TEXT,
    option4 TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO questions (topic, correct_answer, question, option1, option2, option3, option4, created_at) VALUES
('history', 'Великая Отечественная война', 'Какое событие началось 22 июня 1941 года?', 'Октябрьская революция', 'Первая мировая война', 'Крымская война', 'Великая Отечественная война', '2025-05-03 14:51:37'),
('nature', 'Панда', 'Какое животное питается почти исключительно бамбуком?', 'Обезьяна', 'Тигр', 'Слон', 'Панда', '2025-05-03 14:51:37'),
('culture', 'Шекспир', 'Кто автор трагедии "Гамлет"?', 'Пушкин', 'Данте', 'Шекспир', 'Гёте', '2025-05-03 14:51:37'),
('history', 'Петр I', 'Кто из русских царей основал Санкт-Петербург?', 'Иван IV', 'Николай II', 'Петр I', 'Александр I', '2025-05-03 14:51:37'),
('science', 'Эйнштейн', 'Кто разработал теорию относительности?', 'Эйнштейн', 'Галилей', 'Тесла', 'Ньютон', '2025-05-03 14:51:37'),
('nature', 'Амазонка', 'Какая река самая длинная в мире?', 'Миссисипи', 'Амазонка', 'Янцзы', 'Нил', '2025-05-03 14:51:37'),
('science', 'Клетка', 'Основная структурная единица живого организма?', 'Система', 'Орган', 'Клетка', 'Молекула', '2025-05-03 14:51:37'),
('nature', 'Фотосинтез', 'Как называется процесс, при котором растения получают энергию от солнца?', 'Трансляция', 'Клеточное дыхание', 'Фотосинтез', 'Испарение', '2025-05-03 14:51:37'),
('science', 'Эйнштейн', 'Кто разработал теорию относительности?', 'Эйнштейн', 'Галилей', 'Ньютон', 'Тесла', '2025-05-03 14:51:37'),
('nature', 'Амазонка', 'Какая река самая длинная в мире?', 'Амазонка', 'Янцзы', 'Миссисипи', 'Нил', '2025-05-03 14:51:37'),
('culture', 'Леонардо да Винчи', 'Кто написал "Мону Лизу"?', 'Тициан', 'Рафаэль', 'Микеланджело', 'Леонардо да Винчи', '2025-05-03 14:51:37'),
('science', 'Эйнштейн', 'Кто разработал теорию относительности?', 'Галилей', 'Эйнштейн', 'Ньютон', 'Тесла', '2025-05-03 14:51:37'),
('culture', 'Русский', 'На каком языке написан роман "Война и мир"?', 'Немецкий', 'Русский', 'Французский', 'Английский', '2025-05-03 14:51:37'),
('nature', 'Саванна', 'Как называется экосистема с редкими деревьями и высокой травой в Африке?', 'Пустыня', 'Тундра', 'Лес', 'Саванна', '2025-05-03 14:51:37'),
('science', 'Кислород', 'Какой газ необходим для дыхания человека?', 'Углекислый газ', 'Кислород', 'Азот', 'Водород', '2025-05-03 14:51:37'),
('nature', 'Саванна', 'Как называется экосистема с редкими деревьями и высокой травой в Африке?', 'Пустыня', 'Лес', 'Тундра', 'Саванна', '2025-05-03 14:51:37'),
('science', 'Кислород', 'Какой газ необходим для дыхания человека?', 'Углекислый газ', 'Азот', 'Водород', 'Кислород', '2025-05-03 14:51:37'),
('science', 'Эйнштейн', 'Кто разработал теорию относительности?', 'Галилей', 'Ньютон', 'Тесла', 'Эйнштейн', '2025-05-03 14:51:37'),
('nature', 'Фотосинтез', 'Как называется процесс, при котором растения получают энергию от солнца?', 'Трансляция', 'Клеточное дыхание', 'Испарение', 'Фотосинтез', '2025-05-03 14:51:37'),
('nature', 'Саванна', 'Как называется экосистема с редкими деревьями и высокой травой в Африке?', 'Лес', 'Саванна', 'Пустыня', 'Тундра', '2025-05-03 14:51:37'),
('science', 'Клетка', 'Основная структурная единица живого организма?', 'Клетка', 'Система', 'Молекула', 'Орган', '2025-05-03 14:51:37'),
('science', 'Гравитация', 'Какая сила удерживает планеты на орбите вокруг Солнца?', 'Центробежная', 'Гравитация', 'Сила трения', 'Электромагнитная', '2025-05-03 14:51:37'),
('culture', 'Пикассо', 'Кто считается основателем кубизма?', 'Ван Гог', 'Пикассо', 'Моне', 'Дали', '2025-05-03 14:51:37'),
('culture', 'Леонардо да Винчи', 'Кто написал "Мону Лизу"?', 'Рафаэль', 'Микеланджело', 'Леонардо да Винчи', 'Тициан', '2025-05-03 14:51:37'),
('culture', 'Пикассо', 'Кто считается основателем кубизма?', 'Дали', 'Ван Гог', 'Пикассо', 'Моне', '2025-05-03 14:51:37'),
('history', 'Петр I', 'Кто из русских царей основал Санкт-Петербург?', 'Александр I', 'Николай II', 'Петр I', 'Иван IV', '2025-05-03 14:51:37'),
('science', 'Вода', 'Что является универсальным растворителем?', 'Спирт', 'Бензин', 'Вода', 'Масло', '2025-05-03 14:51:37'),
('science', 'Клетка', 'Основная структурная единица живого организма?', 'Система', 'Молекула', 'Орган', 'Клетка', '2025-05-03 14:51:37'),
('nature', 'Фотосинтез', 'Как называется процесс, при котором растения получают энергию от солнца?', 'Фотосинтез', 'Клеточное дыхание', 'Испарение', 'Трансляция', '2025-05-03 14:51:37'),
('nature', 'Панда', 'Какое животное питается почти исключительно бамбуком?', 'Обезьяна', 'Слон', 'Тигр', 'Панда', '2025-05-03 14:51:37'),
('history', 'Петр I', 'Кто из русских царей основал Санкт-Петербург?', 'Петр I', 'Николай II', 'Александр I', 'Иван IV', '2025-05-03 14:51:37'),
('nature', 'Саванна', 'Как называется экосистема с редкими деревьями и высокой травой в Африке?', 'Пустыня', 'Тундра', 'Саванна', 'Лес', '2025-05-03 14:51:37'),
('science', 'Гравитация', 'Какая сила удерживает планеты на орбите вокруг Солнца?', 'Центробежная', 'Электромагнитная', 'Гравитация', 'Сила трения', '2025-05-03 14:51:37'),
('nature', 'Гималаи', 'Где находятся самые высокие горы?', 'Альпы', 'Анды', 'Гималаи', 'Урал', '2025-05-03 14:51:37'),
('culture', 'Леонардо да Винчи', 'Кто написал "Мону Лизу"?', 'Рафаэль', 'Леонардо да Винчи', 'Тициан', 'Микеланджело', '2025-05-03 14:51:37'),
('history', 'Юлий Цезарь', 'Кто был убит в Идах марта?', 'Цицерон', 'Юлий Цезарь', 'Нерон', 'Август', '2025-05-03 14:51:37'),
('culture', 'Леонардо да Винчи', 'Кто написал "Мону Лизу"?', 'Микеланджело', 'Тициан', 'Леонардо да Винчи', 'Рафаэль', '2025-05-03 14:51:37'),
('science', 'Клетка', 'Основная структурная единица живого организма?', 'Молекула', 'Орган', 'Система', 'Клетка', '2025-05-03 14:51:37'),
('nature', 'Амазонка', 'Какая река самая длинная в мире?', 'Нил', 'Амазонка', 'Миссисипи', 'Янцзы', '2025-05-03 14:51:37'),
('science', 'Клетка', 'Основная структурная единица живого организма?', 'Система', 'Клетка', 'Молекула', 'Орган', '2025-05-03 14:51:37'),
('culture', 'Пикассо', 'Кто считается основателем кубизма?', 'Ван Гог', 'Пикассо', 'Моне', 'Дали', '2025-05-03 14:51:37'),
('nature', 'Амазонка', 'Какая река самая длинная в мире?', 'Амазонка', 'Миссисипи', 'Нил', 'Янцзы', '2025-05-03 14:51:37'),
('nature', 'Амазонка', 'Какая река самая длинная в мире?', 'Янцзы', 'Амазонка', 'Нил', 'Миссисипи', '2025-05-03 14:51:37'),
('history', 'Юлий Цезарь', 'Кто был убит в Идах марта?', 'Юлий Цезарь', 'Нерон', 'Август', 'Цицерон', '2025-05-03 14:51:37'),
('history', '1812', 'В каком году началась Отечественная война против Наполеона?', '1805', '1812', '1825', '1799', '2025-05-03 14:51:37'),
('nature', 'Саванна', 'Как называется экосистема с редкими деревьями и высокой травой в Африке?', 'Лес', 'Тундра', 'Пустыня', 'Саванна', '2025-05-03 14:51:37'),
('science', 'Клетка', 'Основная структурная единица живого организма?', 'Молекула', 'Система', 'Орган', 'Клетка', '2025-05-03 14:51:37'),
('science', 'Эйнштейн', 'Кто разработал теорию относительности?', 'Тесла', 'Ньютон', 'Галилей', 'Эйнштейн', '2025-05-03 14:51:37'),
('science', 'Вода', 'Что является универсальным растворителем?', 'Бензин', 'Вода', 'Спирт', 'Масло', '2025-05-03 14:51:37'),
('history', 'Великая Отечественная война', 'Какое событие началось 22 июня 1941 года?', 'Первая мировая война', 'Крымская война', 'Октябрьская революция', 'Великая Отечественная война', '2025-05-03 14:51:37'),
('history', 'Холодная война', 'Как назывался период противостояния между СССР и США после Второй мировой?', 'Тихая война', 'Горячая война', 'Холодная война', 'Железная война', '2025-05-03 14:51:37'),
('nature', 'Саванна', 'Как называется экосистема с редкими деревьями и высокой травой в Африке?', 'Пустыня', 'Тундра', 'Саванна', 'Лес', '2025-05-03 14:51:37'),
('nature', 'Панда', 'Какое животное питается почти исключительно бамбуком?', 'Слон', 'Панда', 'Тигр', 'Обезьяна', '2025-05-03 14:51:37'),
('nature', 'Фотосинтез', 'Как называется процесс, при котором растения получают энергию от солнца?', 'Трансляция', 'Клеточное дыхание', 'Фотосинтез', 'Испарение', '2025-05-03 14:51:37'),
('culture', 'Пикассо', 'Кто считается основателем кубизма?', 'Ван Гог', 'Пикассо', 'Дали', 'Моне', '2025-05-03 14:51:37'),
('nature', 'Фотосинтез', 'Как называется процесс, при котором растения получают энергию от солнца?', 'Фотосинтез', 'Испарение', 'Клеточное дыхание', 'Трансляция', '2025-05-03 14:51:37'),
('science', 'Кислород', 'Какой газ необходим для дыхания человека?', 'Азот', 'Водород', 'Кислород', 'Углекислый газ', '2025-05-03 14:51:37'),
('culture', 'Чайковский', 'Кто написал балет "Лебединое озеро"?', 'Бетховен', 'Моцарт', 'Шопен', 'Чайковский', '2025-05-03 14:51:37'),
('nature', 'Амазонка', 'Какая река самая длинная в мире?', 'Янцзы', 'Миссисипи', 'Амазонка', 'Нил', '2025-05-03 14:51:37'),
('science', 'Вода', 'Что является универсальным растворителем?', 'Бензин', 'Спирт', 'Вода', 'Масло', '2025-05-03 14:51:37'),
('culture', 'Русский', 'На каком языке написан роман "Война и мир"?', 'Французский', 'Русский', 'Английский', 'Немецкий', '2025-05-03 14:51:37'),
('history', 'Великая Отечественная война', 'Какое событие началось 22 июня 1941 года?', 'Крымская война', 'Великая Отечественная война', 'Октябрьская революция', 'Первая мировая война', '2025-05-03 14:51:37'),
('culture', 'Шекспир', 'Кто автор трагедии "Гамлет"?', 'Шекспир', 'Пушкин', 'Данте', 'Гёте', '2025-05-03 14:51:37'),
('science', 'Эйнштейн', 'Кто разработал теорию относительности?', 'Эйнштейн', 'Тесла', 'Галилей', 'Ньютон', '2025-05-03 14:51:37'),
('science', 'Кислород', 'Какой газ необходим для дыхания человека?', 'Кислород', 'Углекислый газ', 'Водород', 'Азот', '2025-05-03 14:51:37'),
('nature', 'Фотосинтез', 'Как называется процесс, при котором растения получают энергию от солнца?', 'Фотосинтез', 'Трансляция', 'Клеточное дыхание', 'Испарение', '2025-05-03 14:51:37'),
('science', 'Эйнштейн', 'Кто разработал теорию относительности?', 'Ньютон', 'Тесла', 'Галилей', 'Эйнштейн', '2025-05-03 14:51:37'),
('history', '1812', 'В каком году началась Отечественная война против Наполеона?', '1799', '1825', '1805', '1812', '2025-05-03 14:51:37'),
('history', 'Холодная война', 'Как назывался период противостояния между СССР и США после Второй мировой?', 'Горячая война', 'Тихая война', 'Железная война', 'Холодная война', '2025-05-03 14:51:37'),
('culture', 'Шекспир', 'Кто автор трагедии "Гамлет"?', 'Гёте', 'Пушкин', 'Шекспир', 'Данте', '2025-05-03 14:51:37'),
('history', 'Юлий Цезарь', 'Кто был убит в Идах марта?', 'Цицерон', 'Нерон', 'Юлий Цезарь', 'Август', '2025-05-03 14:51:37'),
('history', 'Юлий Цезарь', 'Кто был убит в Идах марта?', 'Юлий Цезарь', 'Цицерон', 'Нерон', 'Август', '2025-05-03 14:51:37'),
('history', 'Великая Отечественная война', 'Какое событие началось 22 июня 1941 года?', 'Великая Отечественная война', 'Октябрьская революция', 'Первая мировая война', 'Крымская война', '2025-05-03 14:51:37'),
('culture', 'Леонардо да Винчи', 'Кто написал "Мону Лизу"?', 'Рафаэль', 'Микеланджело', 'Тициан', 'Леонардо да Винчи', '2025-05-03 14:51:37'),
('science', 'Вода', 'Что является универсальным растворителем?', 'Спирт', 'Бензин', 'Масло', 'Вода', '2025-05-03 14:51:37'),
('science', 'Клетка', 'Основная структурная единица живого организма?', 'Молекула', 'Клетка', 'Орган', 'Система', '2025-05-03 14:51:37'),
('history', 'Петр I', 'Кто из русских царей основал Санкт-Петербург?', 'Николай II', 'Петр I', 'Александр I', 'Иван IV', '2025-05-03 14:51:37'),
('nature', 'Гималаи', 'Где находятся самые высокие горы?', 'Анды', 'Урал', 'Альпы', 'Гималаи', '2025-05-03 14:51:37'),
('culture', 'Леонардо да Винчи', 'Кто написал "Мону Лизу"?', 'Рафаэль', 'Тициан', 'Микеланджело', 'Леонардо да Винчи', '2025-05-03 14:51:37'),
('nature', 'Гималаи', 'Где находятся самые высокие горы?', 'Анды', 'Альпы', 'Урал', 'Гималаи', '2025-05-03 14:51:37'),
('nature', 'Амазонка', 'Какая река самая длинная в мире?', 'Амазонка', 'Нил', 'Янцзы', 'Миссисипи', '2025-05-03 14:51:37'),
('history', 'Петр I', 'Кто из русских царей основал Санкт-Петербург?', 'Александр I', 'Николай II', 'Петр I', 'Иван IV', '2025-05-03 14:51:37'),
('history', 'Петр I', 'Кто из русских царей основал Санкт-Петербург?', 'Петр I', 'Александр I', 'Иван IV', 'Николай II', '2025-05-03 14:51:37'),
('culture', 'Леонардо да Винчи', 'Кто написал "Мону Лизу"?', 'Рафаэль', 'Леонардо да Винчи', 'Тициан', 'Микеланджело', '2025-05-03 14:51:37'),
('science', 'Эйнштейн', 'Кто разработал теорию относительности?', 'Галилей', 'Ньютон', 'Тесла', 'Эйнштейн', '2025-05-03 14:51:37'),
('history', 'Холодная война', 'Как назывался период противостояния между СССР и США после Второй мировой?', 'Холодная война', 'Железная война', 'Тихая война', 'Горячая война', '2025-05-03 14:51:37'),
('culture', 'Леонардо да Винчи', 'Кто написал "Мону Лизу"?', 'Тициан', 'Микеланджело', 'Леонардо да Винчи', 'Рафаэль', '2025-05-03 14:51:37'),
('science', 'Эйнштейн', 'Кто разработал теорию относительности?', 'Ньютон', 'Эйнштейн', 'Галилей', 'Тесла', '2025-05-03 14:51:37'),
('culture', 'Русский', 'На каком языке написан роман "Война и мир"?', 'Русский', 'Французский', 'Немецкий', 'Английский', '2025-05-03 14:51:37'),
('nature', 'Амазонка', 'Какая река самая длинная в мире?', 'Нил', 'Миссисипи', 'Амазонка', 'Янцзы', '2025-05-03 14:51:37'),
('science', 'Гравитация', 'Какая сила удерживает планеты на орбите вокруг Солнца?', 'Центробежная', 'Сила трения', 'Электромагнитная', 'Гравитация', '2025-05-03 14:51:37'),
('science', 'Эйнштейн', 'Кто разработал теорию относительности?', 'Эйнштейн', 'Тесла', 'Ньютон', 'Галилей', '2025-05-03 14:51:37'),
('culture', 'Леонардо да Винчи', 'Кто написал "Мону Лизу"?', 'Микеланджело', 'Тициан', 'Леонардо да Винчи', 'Рафаэль', '2025-05-03 14:51:37'),
('culture', 'Чайковский', 'Кто написал балет "Лебединое озеро"?', 'Моцарт', 'Бетховен', 'Чайковский', 'Шопен', '2025-05-03 14:51:37'),
('science', 'Вода', 'Что является универсальным растворителем?', 'Вода', 'Бензин', 'Масло', 'Спирт', '2025-05-03 14:51:37'),
('science', 'Гравитация', 'Какая сила удерживает планеты на орбите вокруг Солнца?', 'Центробежная', 'Сила трения', 'Гравитация', 'Электромагнитная', '2025-05-03 14:51:37'),
('culture', 'Леонардо да Винчи', 'Кто написал "Мону Лизу"?', 'Леонардо да Винчи', 'Рафаэль', 'Тициан', 'Микеланджело', '2025-05-03 14:51:37'),
('history', 'Холодная война', 'Как назывался период противостояния между СССР и США после Второй мировой?', 'Горячая война', 'Железная война', 'Холодная война', 'Тихая война', '2025-05-03 14:51:37'),
('nature', 'Саванна', 'Как называется экосистема с редкими деревьями и высокой травой в Африке?', 'Лес', 'Тундра', 'Пустыня', 'Саванна', '2025-05-03 14:51:37'),
('history', 'Великая Отечественная война', 'Какое событие началось 22 июня 1941 года?', 'Первая мировая война', 'Крымская война', 'Великая Отечественная война', 'Октябрьская революция', '2025-05-03 14:51:37')
