require_relative 'developer'

class JuniorDeveloper < Developer
  MAX_TASKS = 5

  def add_task(task)
    fail ArgumentError if task.length > 20
  rescue ArgumentError
    'Слишком сложно!'
  else
    super
  end

  def work!
    fail ArgumentError if @task_list.empty?
  rescue ArgumentError
    'Нечего делать!'
  else
    %(#{@name}: пытаюсь делать задачу "#{@task_list.shift}". Осталось задач: #{@task_list.size})
  end

  def group
    :juniors
  end
end