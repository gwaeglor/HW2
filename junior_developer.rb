require_relative 'developer'

class JuniorDeveloper < Developer
  MAX_TASKS = 5
  GROUP = :juniors

  def add_task(task)
    begin
      raise ArgumentError if task.length > 20
    rescue ArgumentError
      'Слишком сложно!'
    else
      super
    end
  end

  def work!
    begin
      raise ArgumentError if @task_list.empty?
    rescue ArgumentError
      'Нечего делать!'
    else
      %Q{#{@name}: пытаюсь делать задачу "#{@task_list.shift}". Осталось задач: #{@task_list.size}}
    end
  end
end
