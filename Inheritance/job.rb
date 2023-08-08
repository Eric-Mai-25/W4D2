class Employee
    attr_reader :boss, :salary, :name
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

    def all_employees()
        all_emps = []
        @employees.each do |employee|
            all_emps << employee
            if employee.class.method_defined?(:employees)
                all_emps += employee.all_employees
            end
        end 
        all_emps

    end

    def bonus(multiplier)
        total_bonus = self.all_employees.sum{|emp| emp.salary}
        total_bonus * multiplier
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