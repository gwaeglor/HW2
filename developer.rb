class Developer
  MAX_TASKS = 10
  GROUP = :developers

  attr_reader :name, :task_list, :group

  def initialize(name)
    @name = name
    @task_list = []
    @group = self.class::GROUP
  end

  def add_task(task)
    begin
    raise ArgumentError unless @task_list.size < max_tasks
    rescue ArgumentError
      'Слишком много работы!'
    else
      @task_list.push task
      %Q{#{@name}: добавлена задача "#{task}". Всего в списке задач: #{@task_list.size}}
    end
  end

  def tasks
    @task_list.map.each_with_index { |v, i| "#{i + 1}. #{v}" }
  end

  def work!
    begin
      raise ArgumentError if @task_list.empty?
    rescue ArgumentError
      'Нечего делать!'
    else
      %Q{#{@name}: выполнена задача "#{@task_list.shift}". Осталось задач: #{@task_list.size}}
    end
  end

  def can_add_task?
    @task_list.size < max_tasks
  end

  def can_work?
    !@task_list.empty?
  end

  def status
    case
      when !can_work?
        'свободен'
      when can_add_task? && can_work?
        'работаю'
      else
        'занят'
    end
  end

  private
  def max_tasks
    self.class::MAX_TASKS
  end

end
