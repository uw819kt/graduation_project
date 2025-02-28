class ChangeConditionDataTypeInAlcoholLogs < ActiveRecord::Migration[7.2]
  def change
    change_column_default :alcohol_logs, :condition, nil  
    change_column :alcohol_logs, :condition, :integer, using: 'condition::integer'
  end
end
