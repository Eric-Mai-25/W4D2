class Employee
    attr_reader :boss, :salary
    def initialize (name, title, salary, boss)
        @name = name
        @title = title
        @salary = salary
        @boss = boss
    end

    def bonus(multiplier)
        return @salary * multiplier
    end
end

class Manager < Employee

    attr_accessor :employees
    def initialize(name, title, salary, boss, employees)
        super(name, title, salary, boss)
        @employees = employees
    end

    def bonus(multiplier)
        total_bonus = 0
        @employees.each do |employee|
            if employee.class.method_defined?(:employees)
                total_bonus += employee.bonus(multiplier)
            else
                total_bonus += employee.salary
            end
        end 
        total_bonus
    end
    
end
ned = Manager.new('Ned', 'Founder', 1000000, nil, [])
darren = Manager.new('Darren', 'TA Manager', 78000, ned , [])
shawna = Employee.new('Shawna', 'TA', 12000, darren )
david = Employee.new('David', 'TA', 10000, darren )
darren.employees += [shawna, david]
ned.employees += [darren]

p ned.bonus(5)
p darren.bonus(4)
p david.bonus(3)