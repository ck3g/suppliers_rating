module TasksHelper
  def task_supplier_and_service(task)
    "#{task.supplier_name} [#{task.service_name}]"
  end
end
