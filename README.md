# 🚀 CryptoLab


## 🏗 Архитектура
- **MVVM + Координаторы**:
  - Координаторы используются для управления навигацией между экранами.
  - Вынесена логика переходов и поведения в зависимости от авторизации пользователя.

## 🌐 Сетевой слой
- Используется **async/await** для упрощения обработки асинхронных операций.
- Вместо `DispatchGroup` применён **TaskGroup** из-за лучшей совместимости с `async/await`.
- Требование одновременного запроса информации о монетах выполнено.

## 🎨 Работа со шрифтами
- Импортирован шрифт **Poppins** в соответствии с макетом.
- Добавлено **расширение `UIFont`** для удобного использования кастомных шрифтов.
- **Кириллического варианта Poppins нет**, поэтому в меню (единственное место с кириллицей) используется `.systemFont`.

## 📐 Отступы и UI-адаптация
- Изменены отступы, так как макет не учитывает **Dynamic Island** и **шторку уведомлений**.

## 🛠 Проблемы
- На 4 экране необходимо переключаться между статистикой рынка за сутки, неделю, год, все время и произвольную дату. API не предоставляет информацию обо всем, поэтому показываю одинаковую информацию для первых четырех, для последней - N/A

💡 **Примечание:** если у вас есть вопросы по проекту, создавайте `Issue` или отправляйте PR. 

