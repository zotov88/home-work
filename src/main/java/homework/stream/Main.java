package homework.stream;

import java.util.List;

public class Main {

    public static void main(String[] args) {
        List<Person> list = init();

        list.stream()
                .filter(p -> p != null && p.getName() != null && p.getAge() >= 30 && p.getAge() <= 40)
                .map(Person::getName)
                .distinct()
                .sorted(String::compareTo)
                .limit(10)
                .forEach(System.out::println);
    }

    private static List<Person> init() {
        return List.of(
                new Person("Igor", 25),
                new Person("Svetlana", 24),
                new Person("Sergey", 40),
                new Person("Agata", 36),
                new Person("Petr", 35),
                new Person("Alexey", 44),
                new Person("Natalia", 40),
                new Person("Roman", 23),
                new Person("Ekaterina", 26),
                new Person("Sofia", 39),
                new Person("Dmitry", 27),
                new Person("Violetta", 31),
                new Person("Konstantin", 46),
                new Person("Petr", 33)
        );
    }
}
