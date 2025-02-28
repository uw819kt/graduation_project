class RemoveNotNullConstraintFromPartTimeInPaidLeaves < ActiveRecord::Migration[7.2]
  def change
    change_column_null :paid_leaves, :part_time, true
  end
end
